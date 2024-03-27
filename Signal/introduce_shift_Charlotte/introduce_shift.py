import ROOT
import sys
import numpy as np
from optparse import OptionParser

def get_options():
  parser = OptionParser()
  parser.add_option('--inputWS', dest='inputWS', default='', help='root file containing no-interference signal WS')
  parser.add_option('--cat', dest='cat', default='', help='category (eg: UntaggedTag_0)')
  parser.add_option('--year', dest='year', default='2016', help='Year')
  return parser.parse_args()

(opt,args) = get_options()

f=ROOT.TFile(opt.inputWS, "read")
w = f.Get("wsig_13TeV")
w.Print()

dm_original = w.function("dm_dcb_HHggTauTaukl1_2016_SR1_13TeV")

GammaH = ROOT.RooRealVar("GammaH", "GammaH", 0.0)

# alpha dictionary
alpha_dict = {
  'UntaggedTag_0': -25.0,
  'UntaggedTag_1': -35.0,
  'UntaggedTag_2': -45.0,
  'UntaggedTag_3': -55.0,
  'UntaggedTag_4': -65.0,
  'UntaggedTag_5': -75.0,
  'UntaggedTag_6': -85.0,
  'UntaggedTag_7': -95.0,
  'UntaggedTag_8': -105.0,
  'UntaggedTag_9': -115.0,
  'VBFTag_0': 0.0,
  'VBFTag_1': 0.0,
  'VBFTag_2': 0.0,
  'VBFTag_3': 0.0
}

# create spline for GammaH dependence
width_ratio = np.linspace(0, 30, 300)
alpha = alpha_dict['%s'%(opt.cat)]
mass_shift = 0.001 * alpha * np.sqrt(width_ratio)  # factor of 10e-3 to convert MeV to GeV
width_spline = ROOT.RooSpline1D("width_spline", "width_spline", GammaH, len(width_ratio), width_ratio, mass_shift)

# just test the spline works
for xi in width_ratio:
 GammaH.setVal(xi)
 width_spline.Print()

# create new dm shift which is MH + GammaH dependence
dm_shift = ROOT.RooFormulaVar("dm_shift_dcb_HHggTauTaukl1_2016_SR1_13TeV", "dm_shift_HHggTauTaukl1_2016_SR1_13TeV", "@0 + @1", ROOT.RooArgList(dm_original, width_spline))
imp = getattr(w, "import")
imp(dm_shift, ROOT.RooFit.RecycleConflictNodes())

# use w.factory to create a new signal model with GammaH dependence included
original_model_name = "hggpdfsmrel_HHggTauTaukl1_2016_SR1_13TeV"
new_model_name = "hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"

original_dm_name = "dm_dcb_HHggTauTaukl1_2016_SR1_13TeV"
new_dm_name = "dm_shift_dcb_HHggTauTaukl1_2016_SR1_13TeV"

factory_string = "EDIT::%s(%s, %s=%s )"%(new_model_name, original_model_name, original_dm_name, new_dm_name)
print(factory_string)
w.factory(factory_string)

# print out workspace again
w.Print()

# the new dcb mean is called "mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"
# how does that change as a function of GammaH?
for xi in width_ratio:
  w.var("GammaH").setVal(xi)
  print(xi, w.function("mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV").getVal())

w.writeToFile("new_model.root")
