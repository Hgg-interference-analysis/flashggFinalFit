import ROOT
import sys
import numpy as np
from optparse import OptionParser

def get_options():
  parser = OptionParser()
  parser.add_option('--inputWS', dest='inputWS', default='', help='root file containing no-interference signal WS')
  parser.add_option('--cat', dest='cat', default='', help='category (eg: UntaggedTag_0)')
  parser.add_option('--year', dest='year', default='2018', help='Year')
  parser.add_option('--proc', dest='proc', default='GG2H', help='production process: GG2H, VBF or vh')
  parser.add_option('--ext', dest='ext', default='', help='output extension')
  return parser.parse_args()

(opt,args) = get_options()

f=ROOT.TFile(opt.inputWS, "read")
w = f.Get("wsig_13TeV")
#w.Print()

#dm_original = w.function("dm_dcb_HHggTauTaukl1_2016_SR1_13TeV")
dm_original_name = "dm_dcb_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
dm_original = w.function(dm_original_name)

GammaH = ROOT.RooRealVar("GammaH", "GammaH", 0.0)

# alpha dictionary -- shift mass peak only if the proc is GG2H
#if opt.proc == "GG2H":                    ##2018 scaled to full Run2
#  alpha_dict = {
#    'UntaggedTag_0': -14.8277,
#    'UntaggedTag_1': -45.1868,
#    'UntaggedTag_2': -64.5959,
#    'UntaggedTag_3': -88.7952,
#    'UntaggedTag_4': -154.4650,
#    'UntaggedTag_5': -103.2503,
#    'UntaggedTag_6': -30.5687,
#    'UntaggedTag_7': -88.2608,
#    'UntaggedTag_8': -66.6614,
#    'UntaggedTag_9': -112.5426,
#    'VBFTag_0': -4.13099
#  }

if opt.proc == "GG2H":
  alpha_dict = {
    'UntaggedTag_0': -4.7797,
    'UntaggedTag_1': -37.3291,
    'UntaggedTag_2': -80.0706,
    'UntaggedTag_3': -67.9080,
    'UntaggedTag_4': -111.2923,
    'UntaggedTag_5': -80.5140,
    'UntaggedTag_6': -62.3639,
    'UntaggedTag_7': -31.6039,
    'UntaggedTag_8': -54.7650,
    'UntaggedTag_9': -76.2340,
    'VBFTag_0': -1.3827
  }
  alpha_sigma_dict = {
    'UntaggedTag_0': 9.8972,
    'UntaggedTag_1': 4.5164,
    'UntaggedTag_2': 8.0617,
    'UntaggedTag_3': 18.1670,
    'UntaggedTag_4': 7.1062,
    'UntaggedTag_5': 11.3442,
    'UntaggedTag_6': 7.7228,
    'UntaggedTag_7': 11.1936,
    'UntaggedTag_8': 6.7372,
    'UntaggedTag_9': 4.9536,
    'VBFTag_0':	3.2155
  }

else:
  alpha_dict = {
    'UntaggedTag_0': 0.0,
    'UntaggedTag_1': 0.0,
    'UntaggedTag_2': 0.0,
    'UntaggedTag_3': 0.0,
    'UntaggedTag_4': 0.0,
    'UntaggedTag_5': 0.0,
    'UntaggedTag_6': 0.0,
    'UntaggedTag_7': 0.0,
    'UntaggedTag_8': 0.0,
    'UntaggedTag_9': 0.0,
    'VBFTag_0': 0.0
  }

  alpha_sigma_dict = {
    'UntaggedTag_0': 0.0,
    'UntaggedTag_1': 0.0,
    'UntaggedTag_2': 0.0,
    'UntaggedTag_3': 0.0,
    'UntaggedTag_4': 0.0,
    'UntaggedTag_5': 0.0,
    'UntaggedTag_6': 0.0,
    'UntaggedTag_7': 0.0,
    'UntaggedTag_8': 0.0,
    'UntaggedTag_9': 0.0,
    'VBFTag_0': 0.0
  }

  
# create spline for GammaH dependence
width_ratio = np.linspace(0, 100, 1000)
alpha = alpha_dict['%s'%(opt.cat)]
alpha_sigma = alpha_sigma_dict['%s'%(opt.cat)]
eta = ROOT.RooRealVar("nuisance_alpha", "nuisance_alpha", 0, -5, 5)
eta.setConstant(True)
print("eta value = ", eta.getVal())
mass_shift = 0.001 * (alpha + alpha_sigma * eta) * np.sqrt(width_ratio)  # factor of 10e-3 to convert alpha from MeV to GeV
width_spline = ROOT.RooSpline1D("width_spline", "width_spline", GammaH, len(width_ratio), width_ratio, mass_shift)

# just test the spline works
for xi in width_ratio:
 GammaH.setVal(xi)
 #width_spline.Print()

# create new dm shift which is MH + GammaH dependence
#dm_shift = ROOT.RooFormulaVar("dm_shift_dcb_HHggTauTaukl1_2016_SR1_13TeV", "dm_shift_HHggTauTaukl1_2016_SR1_13TeV", "@0 + @1", ROOT.RooArgList(dm_original, width_spline))
dm_shift_name = "dm_shift_dcb_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
#print(dm_shift_name)
dm_shift = ROOT.RooFormulaVar(dm_shift_name, dm_shift_name, "@0 + @1", ROOT.RooArgList(dm_original, width_spline))
imp = getattr(w, "import")
imp(dm_shift, ROOT.RooFit.RecycleConflictNodes())

# change also the norm function name 
original_norm_func = w.function("dcb_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
new_norm_func = original_norm_func.Clone("dcb_shift_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
imp = getattr(w,"import")
imp(new_norm_func, ROOT.RooFit.RecycleConflictNodes())

# use w.factory to create a new signal model with GammaH dependence included
#original_model_name = "hggpdfsmrel_HHggTauTaukl1_2016_SR1_13TeV"
#new_model_name = "hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"

#original_dm_name = "dm_dcb_HHggTauTaukl1_2016_SR1_13TeV"
#new_dm_name = "dm_shift_dcb_HHggTauTaukl1_2016_SR1_13TeV"

original_model_name = "dcb_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
new_model_name = "dcb_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)

original_dm_name = "dm_dcb_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
new_dm_name = "dm_shift_dcb_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)

factory_string = "EDIT::%s(%s, %s=%s )"%(new_model_name, original_model_name, original_dm_name, new_dm_name)
(factory_string)
w.factory(factory_string)

# print out workspace again
#w.Print()

# the new dcb mean is called "mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"
# how does that change as a function of GammaH?
for i,xi in enumerate(width_ratio):
  #w.var("GammaH").setVal(xi)
  #print(xi, w.function("mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV").getVal())
  if i % 100 == 0:
    w.var("GammaH").setVal(xi)
    print(xi, w.function("mean_dcb_%s_%s_%s_13TeV_dcb_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())
  
w.writeToFile("CMS-HGG_sigfit_%s_%s_%s_%s.root"%(opt.ext,opt.proc,opt.year,opt.cat))
