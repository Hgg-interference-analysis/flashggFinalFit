import ROOT
import sys
import numpy as np
from optparse import OptionParser
from collections import OrderedDict as od

ROOT.gStyle.SetOptStat(0)
ROOT.gROOT.SetBatch(ROOT.kTRUE)

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

MH = w.var("MH")
#GammaH = ROOT.RooRealVar("GammaH", "GammaH", 0.0)
GammaH = w.var("GammaH")
#print(GammaH.getMin(),GammaH.getMax())

# alpha dictionary -- shift mass peak only if the proc is GG2H
alpha_dict = {}
alpha_sigma_dict = {}
if opt.cat == "VBFTag_0":
  txtname = f"./alpha_values/alpha_values_{opt.year}_simultaneousfits_cat10.txt"
else:
  txtname = f"./alpha_values/alpha_values_{opt.year}_simultaneousfits_cat{opt.cat.split('_')[1]}.txt"
with open(txtname) as txtfile:
  for line in txtfile:
    values = [float(i.strip()) for i in line.split(',')]
    if opt.proc == "GG2H":
      alpha_dict[opt.cat] = (values[0], values[1])
      alpha_sigma_dict[opt.cat] = (values[2], values[3])
    else:
      alpha_dict[opt.cat] = (0.0, 0.0)
      alpha_sigma_dict[opt.cat] = (0.0, 0.0)
  
# create spline for GammaH dependence
mh = np.linspace(120.,130.,101)
alpha = np.array(alpha_dict['%s'%(opt.cat)][0] + (mh-125.0)*(alpha_dict['%s'%(opt.cat)][1]))
alpha_sigma_ = np.array(np.sqrt(alpha_sigma_dict['%s'%(opt.cat)][0]**2 + (mh-125.0)**2 * alpha_sigma_dict['%s'%(opt.cat)][1]**2))
#add int norm unc to alpha
alpha_sigma = np.sqrt(alpha_sigma_**2 + (0.07*alpha)**2)
#define alpha splines
alpha_spline = ROOT.RooSpline1D("alpha_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"alpha_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),MH,len(mh),mh,alpha)
alphaerr_spline = ROOT.RooSpline1D("alphaerr_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"alphaerr_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),MH,len(mh),mh,alpha_sigma)
eta = ROOT.RooRealVar(f"CMS_hgg_nuisance_alpha_{opt.proc}_{opt.year}_{opt.cat}", f"CMS_hgg_nuisance_alpha_{opt.proc}_{opt.year}_{opt.cat}", 0, -5, 5)
eta.setConstant(True)
#mass_shift = 0.001 * (alpha + alpha_sigma * eta.getVal()) * np.sqrt(width_ratio)  # factor of 10e-3 to convert alpha from MeV to GeV
mass_shift = ROOT.RooFormulaVar("mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"((@0/0.00407)**0.5)*(@1+@2*@3)", ROOT.RooArgList(GammaH,alpha_spline,alphaerr_spline,eta))

# create new dm shift which is MH + GammaH dependence
voigt_count = 0
for obj in w.allPdfs():
    if obj.IsA().GetName() == "RooVoigtian":
        voigt_count += 1
#print(f"Voigt count = {voigt_count}")

original_model_name = "hggpdfsmrel_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
new_model_name = "hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)

# change the norm function name
original_norm_func = w.function("hggpdfsmrel_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
new_norm_func = original_norm_func.Clone("hggpdfsmrel_shift_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
original_normThisLumi = w.function("hggpdfsmrel_%s_%s_%s_13TeV_normThisLumi"%(opt.proc, opt.year, opt.cat))
new_normThisLumi = original_normThisLumi.Clone("hggpdfsmrel_shift_%s_%s_%s_13TeV_normThisLumi"%(opt.proc, opt.year, opt.cat))
imp = getattr(w,"import")
imp(new_norm_func, ROOT.RooFit.RecycleConflictNodes())
imp(new_normThisLumi, ROOT.RooFit.RecycleConflictNodes())

edit_subs = []

for i in range(voigt_count):
  original_dm_name = "dm_g%d_%s_%s_%s_13TeV"%(i,opt.proc, opt.year, opt.cat)
  dm_original = w.function(original_dm_name)
  dm_shift_name = "dm_shift_g%d_%s_%s_%s_13TeV"%(i, opt.proc, opt.year, opt.cat)
  dm_shift = ROOT.RooFormulaVar(dm_shift_name, dm_shift_name, "@0 + @1", ROOT.RooArgList(dm_original, mass_shift))
  imp = getattr(w, "import")
  imp(dm_shift, ROOT.RooFit.RecycleConflictNodes())

  edit_subs.append(f"{original_dm_name}={dm_shift_name}")

subs_str = ", ".join(edit_subs)
factory_string = f"EDIT::{new_model_name}({original_model_name}, {subs_str})"
#factory_string = "EDIT::%s(%s, %s=%s)"%(new_model_name, original_model_name, original_dm_name, new_dm_name)
print(factory_string)
w.factory(factory_string)

extPdf = ROOT.RooExtendPdf("extend%sThisLumi"%new_model_name,"extend%sThisLumi"%new_model_name,w.pdf(new_model_name),new_normThisLumi)
imp(extPdf, ROOT.RooFit.RecycleConflictNodes())

w.writeToFile("CMS-HGG_sigfit_%s_%s_%s_%s.root"%(opt.ext,opt.proc,opt.year,opt.cat))

# the new dcb mean is called "mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"
# how does that change as a function of GammaH?
w.var("MH").setVal(125.0)
w.var("GammaH").setVal(0.00)
print("no_int: ", w.function("mean_g0_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)).getVal())
w.var("GammaH").setVal(0.004)
print("g_ratio = 1: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())
w.var("GammaH").setVal(0.04)
print("g_ratio = 10: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())
w.var("GammaH").setVal(0.4)
print("g_ratio = 100: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())

