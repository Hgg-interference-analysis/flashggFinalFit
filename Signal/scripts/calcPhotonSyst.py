

# Script to calculate photon systematics
# * Run script once per category, loops over signal processes
# * Output is pandas dataframe 

print(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HGG PHOTON SYST CALCULATOR ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ")
import ROOT
import pandas as pd
import pickle
import os, sys
from optparse import OptionParser
import glob
import re
import numpy as np

# From tools
from plottingTools import * #getEffSigma function
from commonTools import *
from commonObjects import *

def leave():
  print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HGG PHOTON SYST CALCULATOR (END) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ")
  sys.exit(1)

def get_options():
  parser = OptionParser()
  parser.add_option("--xvar", dest='xvar', default='CMS_hgg_mass', help="Observable")
  parser.add_option("--year", dest='year', default='2018', help="year")
  parser.add_option("--cat", dest='cat', default='', help="RECO category")
  parser.add_option("--procs", dest='procs', default='', help="Signal processes")
  parser.add_option("--ext", dest='ext', default='', help="Extension")
  parser.add_option("--inputWSDir", dest='inputWSDir', default='', help="Input flashgg WS directory")
  parser.add_option("--scales", dest='scales', default='', help="Photon shape systematics: scales")
  parser.add_option("--scalesCorr", dest='scalesCorr', default='', help='Photon shape systematics: scalesCorr')
  parser.add_option("--scalesGlobal", dest='scalesGlobal', default='', help='Photon shape systematics: scalesGlobal')
  parser.add_option("--smears", dest='smears', default='', help='Photon shape systematics: smears')
  parser.add_option("--nBins", dest='nBins', default=40, type='int', help='Number of bins in histograms')
  return parser.parse_args()
(opt,args) = get_options()

# RooRealVar to fill histograms
mgg = ROOT.RooRealVar(opt.xvar,opt.xvar,125)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Function to extact histograms from WS
def getHistograms( _ws, _nominalDataName, _sname, takeRealNominal=False):
  _hists = {}
  # Define histograms
  for htype in ['nominal','up','down']:
    if htype == 'nominal': _hists[htype] = ROOT.TH1F(htype,htype,opt.nBins,115,135)
    else: _hists[htype] = ROOT.TH1F("%s_%s"%(_sname,htype),"%s_%s"%(_sname,htype),opt.nBins,115,135)
  # Extract nominal RooDataSet and syst RooDataHists
  #_ws.Print()
  if takeRealNominal: rds_nominal = _ws.data(f"{_nominalDataName}")
  else: rds_nominal = _ws.data(f"{_nominalDataName}_MCScaleGain6EBUp01sigma")
  rds_nominal.Print()
  rdh_up = _ws.data("%s_%sUp01sigma"%(_nominalDataName,_sname))
  rdh_down = _ws.data("%s_%sDown01sigma"%(_nominalDataName,_sname))
  # Check if not NONE type and fill histograms
  if rds_nominal: rds_nominal.fillHistogram(_hists['nominal'],ROOT.RooArgList(mgg))
  else:
    print(" --> [ERROR] Could not extract nominal RooDataSet: %s. Leaving"%_nominalDataName)
    sys,exit(1)
  if rdh_up: rdh_up.fillHistogram(_hists['up'],ROOT.RooArgList(mgg))
  else:
    print(" --> [ERROR] Could not extract RooDataHist (%s,up) for %s. Leaving"%(_sname,_nominalDataName))
    sys,exit(1)
  if rdh_down: rdh_down.fillHistogram(_hists['down'],ROOT.RooArgList(mgg))
  else:
    print(" --> [ERROR] Could not extract RooDataHist (%s,down) for %s. Leaving"%(_sname,_nominalDataName))
    sys,exit(1) 
  return _hists


def fit(proc, year, cat, _hists, sname):
  # //a1, a2, n1, n2, mean, sigma, rate


  print("Starting to fit: ", proc, sname, file=sys.stderr)

  f = ROOT.TF1("f", ROOT.DoubleSidedCrystalballFunction, 118, 128, 7);

  fit_not_ok = 0

  init_par = json.load(open(f"{swd__}/fits_{proc}_{year}.json", "r"))

  '''
  for i, par in enumerate(["a1", "a2", "n1", "n2", "dm", "sigma"]): f.SetParameter(i, init_par[cat][par])
  f.SetParLimits(0, 0.1, 4);
  f.SetParLimits(2, 1, 50);
  f.SetParLimits(5, 0.5, 3);
  f.SetParameter(4, 125+f.GetParameter(4))
  f.SetParameter(6, _hists["up"].GetMaximum())
  f.FixParameter(1, f.GetParameter(1))
  f.FixParameter(3, f.GetParameter(3))
  '''

  f.SetParameters(0.78629,1.6,6.7246, 40, 124.8, 0.95, _hists["up"].GetMaximum());
  f.SetParLimits(0, 0.1, 4);
  f.SetParLimits(1, 0.1, 4);
  f.SetParLimits(2, 1, 50);
  f.SetParLimits(3, 1, 50);
  f.SetParLimits(5, 0.5, 3);
  f.FixParameter(1, 1.6);
  f.FixParameter(3, 50);


  _hists["up"].Fit(f, "R");

  print("probability up: ", f.GetProb(), file=sys.stderr)
  if f.GetProb() < 0.05: fit_not_ok = 1

  a1_up = f.GetParameter(0)
  a2_up = f.GetParameter(1)
  n1_up = f.GetParameter(2)
  n2_up = f.GetParameter(3)
  mean_up = f.GetParameter(4)
  sigma_up = f.GetParameter(5)
  rate_up = _hists["up"].Integral()

  f.SetParameters(0.78629,1.6,6.7246, 40, 124.8, 0.95, _hists["down"].GetMaximum());
  f.SetParLimits(0, 0.1, 4);
  f.SetParLimits(1, 0.1, 4);
  f.SetParLimits(2, 1, 50);
  f.SetParLimits(3, 1, 50);
  f.SetParLimits(5, 0.5, 3);
  f.FixParameter(1, 1.6);
  f.FixParameter(3, 50);

  _hists["down"].Fit(f, "R");

  print("probability down: ", f.GetProb(), file=sys.stderr)
  if f.GetProb() < 0.05: fit_not_ok = 1

  a1_down = f.GetParameter(0)
  a2_down = f.GetParameter(1)
  n1_down = f.GetParameter(2)
  n2_down = f.GetParameter(3)
  mean_down = f.GetParameter(4)
  sigma_down = f.GetParameter(5)
  rate_down = _hists["down"].Integral()


  if _hists["up"].GetRMS() != 0 and _hists["down"].GetRMS() !=0 : #RMS calculation can fail because of negative events
    _hists["up"].GetXaxis().SetRangeUser(122, 128)
    _hists["down"].GetXaxis().SetRangeUser(122, 128)
    mean_up = _hists["up"].GetMean()
    mean_down = _hists["down"].GetMean()
    sigma_up = _hists["up"].GetRMS()
    sigma_down = _hists["down"].GetRMS()


  print("sigma_up, sigma_down: ", sigma_up, sigma_down, file=sys.stderr)
  print("rate_up, rate_down: ", rate_up, rate_down, file=sys.stderr)

  mean_scale = abs(mean_down - mean_up)/2 / ( 0.5*mean_down + 0.5*mean_up)
  sigma_scale = abs(sigma_down - sigma_up)/2 / ( 0.5*sigma_down + 0.5*sigma_up)
  a1_scale = abs(a1_down - a1_up)/2 / ( 0.5*a1_down + 0.5*a1_up)
  n1_scale = abs(n1_down - n1_up)/2 / ( 0.5*n1_down + 0.5*n1_up)
  rate_scale = abs(rate_down - rate_up)/2 / ( 0.5*rate_down + 0.5*rate_up)

  #_hists["nominal"].SaveAs(f"{proc}.{cat}.{sname}_nominal.root")
  #_hists["up"].SaveAs(f"{proc}.{cat}.{sname}_up.root")
  #_hists["down"].SaveAs(f"{proc}.{cat}.{sname}_down.root")

  return {"mean": mean_scale, "sigma": sigma_scale, "rate": rate_scale, "a1": a1_scale, "n1": n1_scale}


ROOT.gROOT.LoadMacro(f"{swd__}/dcb.cxx")


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Define dataFrame
columns_data = ['proc','cat','inputWSFile','nominalDataName']
for stype in ['scales','scalesCorr','smears']:
  systs = getattr( opt, stype )
  for s in systs.split(","):
    if s == '': continue
    for x in ['mean','sigma','rate']: columns_data.append("%s_%s_%s"%(s,outputNuisanceExtMap[stype],x))
data = pd.DataFrame( columns=columns_data )

# Loop over processes and add row to dataframe
for _proc in opt.procs.split(","):
  # Glob M125 filename
  print("%s/output*M125*%s.root"%(opt.inputWSDir,_proc))
  _WSFileName = glob.glob("%s/output*M125*%s.root"%(opt.inputWSDir,_proc))[0]
  _nominalDataName = "%s_125_%s_%s"%(procToData(_proc),sqrts__,opt.cat)
  data = pd.concat([data, pd.DataFrame.from_records([{'proc':_proc,'cat':opt.cat,'inputWSFile':_WSFileName,'nominalDataName':_nominalDataName}])])


# Loop over rows in dataFrame and open ws
for ir,r in data.iterrows():

  print(" --> Processing (%s,%s)"%(r['proc'],opt.cat))

  # Open ROOT file and extract workspace
  f = ROOT.TFile(r['inputWSFile'])
  inputWS = f.Get(inputWSName__)

  # Loop over scale and smear systematics
  for stype in ['scales','scalesCorr','smears']:
    for s in getattr(opt,stype).split(","):
      if "IntNorm" in s: continue
      if s == '': continue
      sname = "%s%s"%(inputNuisanceExtMap[stype],s)
      #print("    * Systematic = %s (%s)"%(sname,stype)
      hists = getHistograms(inputWS,r['nominalDataName'],sname)

      # If nominal yield = 0:
      if "MCSmear" in sname and "EB" in sname and "Rho" in sname:
          r9_flag = "high" if "High" in sname else "low"
          for direction in ["up", "down"]:
            tail = "up_smeared7permille_pt_gt_50" if direction == "up" else "down_nosmear"
            filename = f"{cwd__}/HistoMaker/{opt.cat}_{opt.year}_{r['proc']}_{r9_flag}r9EBsmear{tail}.root"
            print(filename)
            file = ROOT.TFile(filename)
            ROOT.gROOT.cd()
            print(f"{opt.cat}_{r9_flag}r9EBsmear{tail}")
            hists[direction] = file.Get(f"{opt.cat}_{r9_flag}r9EBsmear{tail}").Clone()
            file.Close()

      fit_res = fit(r["proc"], opt.year, opt.cat, hists, sname)
      print(r["proc"], opt.cat, s, fit_res, "\n\n")

      # Add values to dataFrame
      data.loc[data.proc == r['proc'], '%s_%s_mean'%(s,outputNuisanceExtMap[stype])] = fit_res["mean"]
      data.loc[data.proc == r['proc'], '%s_%s_sigma'%(s,outputNuisanceExtMap[stype])] = fit_res["sigma"]
      data.loc[data.proc == r['proc'], '%s_%s_rate'%(s,outputNuisanceExtMap[stype])] = fit_res["rate"]
      data.loc[data.proc == r['proc'], '%s_%s_a1'%(s,outputNuisanceExtMap[stype])] = fit_res["a1"]
      data.loc[data.proc == r['proc'], '%s_%s_n1'%(s,outputNuisanceExtMap[stype])] = fit_res["n1"]

      # Delete histograms
      for h in hists.values(): h.Delete()

  # Delete ws and close file
  inputWS.Delete()
  f.Close()

ggh_plus_int_row = data[data.proc == "GG2HPLUSINT"]
ggh_row = data[data.proc == "GG2H"]
ggh_plus_int_file = ROOT.TFile(ggh_plus_int_row.inputWSFile.iloc[0])
ggh_plus_int_ws = ggh_plus_int_file.Get(inputWSName__)
ggh_file = ROOT.TFile(ggh_row.inputWSFile.iloc[0])
ggh_ws = ggh_file.Get(inputWSName__)

ggh_plus_int_nominal = getHistograms(ggh_plus_int_ws, ggh_plus_int_row['nominalDataName'].iloc[0], "SigmaEOverEShift", takeRealNominal=True)["nominal"] # is a random systematic - every one would do the work
ggh_plus_int_nominal.SetName("ggh_plus_int_nominal")
ggh_nominal = getHistograms(ggh_ws, ggh_row['nominalDataName'].iloc[0], "SigmaEOverEShift", takeRealNominal=True)["nominal"]
ggh_nominal.SetName("ggh_nominal")

int_nominal = ggh_plus_int_nominal.Clone()
int_nominal.SetName("int_nominal")
int_nominal.Add(ggh_nominal, -1)

ggh_plus_int_up = ggh_plus_int_nominal.Clone()
ggh_plus_int_up.SetName("ggh_plus_int_up_nominal")
ggh_plus_int_up.Add(int_nominal, 0.3)

ggh_plus_int_down = ggh_plus_int_nominal.Clone()
ggh_plus_int_down.SetName("ggh_plus_int_down_nominal")
ggh_plus_int_down.Add(int_nominal, -0.3)

hists = {"nominal": ggh_plus_int_nominal, "up": ggh_plus_int_up, "down": ggh_plus_int_down}

ggh_plus_int_nominal.SaveAs("ggh_plus_int_nominal.root")
ggh_nominal.SaveAs("ggh_nominal.root")
int_nominal.SaveAs("int_nominal.root")
ggh_plus_int_up.SaveAs("ggh_plus_int_up.root")
ggh_plus_int_down.SaveAs("ggh_plus_int_down.root")


fit_res = fit("GG2HPLUSINT", opt.year, opt.cat, hists, "IntNorm")


for ir,r in data.iterrows():
  stype = "scalesCorr"
  s = "IntNorm"
  if r.proc != "GG2HPLUSINT":
    # Add values to dataFrame
    data.loc[data.proc == r['proc'], '%s_%s_mean'%(s,outputNuisanceExtMap[stype])] = 0
    data.loc[data.proc == r['proc'], '%s_%s_sigma'%(s,outputNuisanceExtMap[stype])] = 0
    data.loc[data.proc == r['proc'], '%s_%s_rate'%(s,outputNuisanceExtMap[stype])] = 0
    data.loc[data.proc == r['proc'], '%s_%s_a1'%(s,outputNuisanceExtMap[stype])] = 0
    data.loc[data.proc == r['proc'], '%s_%s_n1'%(s,outputNuisanceExtMap[stype])] = 0
  else:
    # Add values to dataFrame
    data.loc[data.proc == r['proc'], '%s_%s_mean'%(s,outputNuisanceExtMap[stype])] = fit_res["mean"]
    data.loc[data.proc == r['proc'], '%s_%s_sigma'%(s,outputNuisanceExtMap[stype])] = fit_res["sigma"]
    data.loc[data.proc == r['proc'], '%s_%s_rate'%(s,outputNuisanceExtMap[stype])] = fit_res["rate"]
    data.loc[data.proc == r['proc'], '%s_%s_a1'%(s,outputNuisanceExtMap[stype])] = fit_res["a1"]
    data.loc[data.proc == r['proc'], '%s_%s_n1'%(s,outputNuisanceExtMap[stype])] = fit_res["n1"]


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Output dataFrame as pickle file to be read in by signalFit.py
if not os.path.isdir("%s/outdir_%s"%(swd__,opt.ext)): os.system("mkdir %s/outdir_%s"%(swd__,opt.ext))
if not os.path.isdir("%s/outdir_%s/calcPhotonSyst"%(swd__,opt.ext)): os.system("mkdir %s/outdir_%s/calcPhotonSyst"%(swd__,opt.ext))
if not os.path.isdir("%s/outdir_%s/calcPhotonSyst/pkl"%(swd__,opt.ext)): os.system("mkdir %s/outdir_%s/calcPhotonSyst/pkl"%(swd__,opt.ext))
with open("%s/outdir_%s/calcPhotonSyst/pkl/%s.pkl"%(swd__,opt.ext,opt.cat),"wb") as f: pickle.dump(data,f)
print(" --> Successfully saved photon systematics as pkl file: %s/outdir_%s/calcPhotonSyst/pkl/%s.pkl"%(swd__,opt.ext,opt.cat))
