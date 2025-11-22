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
#GammaH = w.var("GammaH")
l = w.var("lambda")

# alpha dictionary -- shift mass peak only if the proc is GG2H
alpha_dict = {}
alpha_sigma_dict = {}
mh = np.linspace(120.,130.,101)

if opt.proc == "GG2H":
  if opt.cat == "VBFTag_0":
    txtname = f"./alpha_values/alpha_values_{opt.year}_simultaneousfits_cat10.txt"
  else:
    txtname = f"./alpha_values/alpha_values_{opt.year}_simultaneousfits_cat{opt.cat.split('_')[1]}.txt"
  with open(txtname) as txtfile:
    for line in txtfile:
      values = [float(i.strip()) for i in line.split(',')]
      alpha_dict[opt.cat] = (values[0], values[1])
      alpha_sigma_dict[opt.cat] = (values[2], values[3])
      #  alpha_dict[opt.cat] = (0.0, 0.0)
    # alpha_sigma_dict[opt.cat] = (0.0, 0.0)
  
  # create spline for GammaH dependence
 
  alpha = np.array(alpha_dict['%s'%(opt.cat)][0] + (mh-125.0)*(alpha_dict['%s'%(opt.cat)][1]))
  #alpha = alpha_i + alpha_i*0.133  #scale factor from Asimov closure test
  #print(alpha_i)
  #print("******************************")
  #print(alpha)
  alpha_sigma_ = np.array(np.sqrt(alpha_sigma_dict['%s'%(opt.cat)][0]**2 + (mh-125.0)**2 * alpha_sigma_dict['%s'%(opt.cat)][1]**2))
  alpha_sigma = np.sqrt(alpha_sigma_**2 + (0.08*alpha)**2) #add int norm unc to alpha

  #define alpha splines
  alpha_spline = ROOT.RooSpline1D("alpha_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"alpha_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),MH,len(mh),mh,alpha)
  alphaerr_spline = ROOT.RooSpline1D("alphaerr_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"alphaerr_spline_%s_%s_%s"%(opt.proc, opt.year, opt.cat),MH,len(mh),mh,alpha_sigma)
  eta = ROOT.RooRealVar(f"CMS_hgg_nuisance_alpha_{opt.proc}_{opt.year}_{opt.cat}", f"CMS_hgg_nuisance_alpha_{opt.proc}_{opt.year}_{opt.cat}", 0, -5, 5)
  eta.setConstant(True)
  #mass_shift = 0.001 * (alpha + alpha_sigma * eta.getVal()) * np.sqrt(width_ratio)  # factor of 10e-3 to convert alpha from MeV to GeV
  mass_shift = ROOT.RooFormulaVar("mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"@0*(@1+@2*@3)", ROOT.RooArgList(l,alpha_spline,alphaerr_spline,eta))
  #mass_shift = ROOT.RooFormulaVar(
  #  f"mass_shift_{opt.proc}_{opt.year}_{opt.cat}",
  #  f"mass_shift_{opt.proc}_{opt.year}_{opt.cat}",
  #  "@0 * (@1 + @2*@3) * ( ((108.1-@0)/100) + ((108.1-@0) > 1 ? 0.1 : ((108.1-@0) < 1 ? -0.1 : 0)) )",
  #  ROOT.RooArgList(l, alpha_spline, alphaerr_spline, eta))
  #mass_shift = ROOT.RooFormulaVar("mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"mass_shift_%s_%s_%s"%(opt.proc, opt.year, opt.cat),"((@0/0.00407)**0.5)*(@1+@2*@3)", ROOT.RooArgList(GammaH,alpha_spline,alphaerr_spline,eta))

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

  #plot splines
  canv = ROOT.TCanvas()
  colorMap = {'xs':ROOT.kRed-4,'br':ROOT.kAzure+1,'alpha':ROOT.kGreen+1}
  grs = od()
  grs['alpha'] = ROOT.TGraph()
  #gr_alpha = ROOT.TGraphAsymmErrors()
  # Get value at nominal mass
  xnom = od()
  MH.setVal(125.0)
  xnom['alpha'] = alpha_dict['%s'%(opt.cat)][0]
  # Loop over mass points
  p = 0
  xmax, xmin = 0,0.5
  for m in range(len(mh)):
    MH.setVal(mh[m])
    x = alpha_dict['%s'%(opt.cat)][0] + (mh[m]-125.0)*(alpha_dict['%s'%(opt.cat)][1])
    #if xnom[sp] == 0.: r = 1.
    r = x/xnom['alpha']
    #xerr = np.sqrt(alpha_sigma_dict['%s'%(opt.cat)][0]**2 + (mh[m]-125.0)**2 * alpha_sigma_dict['%s'%(opt.cat)][1]**2)
    #xnomerr = alpha_sigma_dict['%s'%(opt.cat)][0]
    #rerr = r*(np.sqrt((xerr/x)**2 + (xnomerr/xnom['alpha'])**2))
    #print("********error********",xerr, xnomerr, rerr)
    grs['alpha'].SetPoint(p,mh[m],r)
    #grs['alpha'].SetPointError(p,0.0,rerr)
    #gr_alpha.SetPoint(p,mh[m],r)
    #gr_alpha.SetPointError(p, 0.0, 0.0, rerr, rerr)
    if r > xmax: xmax = r
    if r < xmin: xmin = r
    p += 1
  # Draw axes
  haxes = ROOT.TH1F("h_axes_spl","h_axes_spl",10,120,130)
  haxes.SetTitle("")
  haxes.GetXaxis().SetTitle("m_{H} [GeV]")
  haxes.GetXaxis().SetTitleSize(0.05)
  haxes.GetXaxis().SetTitleOffset(0.85)
  haxes.GetXaxis().SetLabelSize(0.035)
  haxes.GetYaxis().SetTitle("X/X(m_{H}=125)")
  haxes.GetYaxis().SetTitleOffset(0.85)
  haxes.GetYaxis().SetTitleSize(0.05)
  haxes.SetMaximum(1.2*xmax)
  haxes.SetMinimum(xmin)
  haxes.Draw()
  # Define legend
  leg = ROOT.TLegend(0.15,0.15,0.4,0.4)
  leg.SetFillStyle(0)
  leg.SetLineColor(0)
  leg.SetTextSize(0.04)
  # Draw graphs
  grs['alpha'].SetLineColor(ROOT.kMagenta-6)
  grs['alpha'].SetLineWidth(2)
  grs['alpha'].SetMarkerColor(ROOT.kMagenta-6)
  grs['alpha'].SetMarkerStyle(20)
  grs['alpha'].SetMarkerSize(0.8)
  #gr_alpha.SetFillColorAlpha(ROOT.kMagenta-6, 0.35)
  grs['alpha'].Draw("Same P")
  #gr_alpha.Draw("3 SAME")
  leg.AddEntry(grs['alpha'],"#alpha @%s = %.2e GeV"%(125,xnom['alpha']))
  '''
  m_dict = {
      #120.0:(52.22, 0.002218, 1.482e-03, 1.35, -2.168e-04),
      #125.0:(48.58, 0.00227, 1.608e-03, 1.26, -2.051e-04),
      120.0:(52.22, 0.002218, 0.391e-03, 1.35, -2.168e-04),
      125.0:(48.58, 0.00227, 0.517e-03, 1.26, -2.051e-04),
      130.0:(45.31, 0.002238, 0.544e-03, 1.14, -2.067e-04)
      #130.0:(45.31, 0.002238, 1.82e-03, 1.14, -2.067e-04)
      }
  xs_ratio = []
  #xs_int = []
  for m_ in m_dict.keys():
    mref = m_dict[125.0]
    xs_ratio.append(((m_dict[m_][2]*m_dict[m_][3])/(m_dict[m_][0]*m_dict[m_][1])) / ((mref[2]*mref[3])/(mref[0]*mref[1])))

  gr_xs_ratio = ROOT.TGraph()
  xs_int_x = [120.0, 125.0, 130.0]
  for ix in range(len(xs_ratio)):
    gr_xs_ratio.SetPoint(ix, xs_int_x[ix], xs_ratio[ix])
  gr_xs_ratio.SetLineWidth(2)
  gr_xs_ratio.SetLineStyle(9)
  gr_xs_ratio.SetLineColor(ROOT.kGreen+1)
  gr_xs_ratio.Draw("Same L")  
  leg.AddEntry(gr_xs_ratio,"#sigma_{int}/#sigma_{sig}")
  '''
  leg.Draw("Same")
  
  # Add Latex
  lat = ROOT.TLatex()
  lat.SetTextFont(42)
  lat.SetTextAlign(31)
  lat.SetNDC()
  lat.SetTextSize(0.03)
  lat.DrawLatex(0.9,0.92,f'{opt.proc}_{opt.year}_{opt.cat}_13TeV')
  canv.Update()
  canv.SaveAs(f"/eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/alphaSplines/{opt.year}_{opt.cat}.png")
  canv.SaveAs(f"/eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/alphaSplines/{opt.year}_{opt.cat}.pdf")


else:
  original_model_name = "hggpdfsmrel_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
  new_model_name = "hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)
  pdf = w.pdf(original_model_name)
  new_pdf = pdf.clone(new_model_name)   # clone with new name
  getattr(w, "import")(new_pdf)

  # change the norm function name
  original_norm_func = w.function("hggpdfsmrel_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
  new_norm_func = original_norm_func.Clone("hggpdfsmrel_shift_%s_%s_%s_13TeV_norm"%(opt.proc, opt.year, opt.cat))
  original_normThisLumi = w.function("hggpdfsmrel_%s_%s_%s_13TeV_normThisLumi"%(opt.proc, opt.year, opt.cat))
  new_normThisLumi = original_normThisLumi.Clone("hggpdfsmrel_shift_%s_%s_%s_13TeV_normThisLumi"%(opt.proc, opt.year, opt.cat))
  imp = getattr(w,"import")
  imp(new_norm_func, ROOT.RooFit.RecycleConflictNodes())
  imp(new_normThisLumi, ROOT.RooFit.RecycleConflictNodes())
  
  w.writeToFile("CMS-HGG_sigfit_%s_%s_%s_%s.root"%(opt.ext,opt.proc,opt.year,opt.cat))

# the new dcb mean is called "mean_dcb_HHggTauTaukl1_2016_SR1_13TeV_hggpdfsmrel_shift_HHggTauTaukl1_2016_SR1_13TeV"
# how does that change as a function of GammaH?
#MH.setVal(125.0)
#GammaH.setVal(0.00)
#print("no_int: ", w.function("mean_g0_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat)).getVal())
#GammaH.setVal(0.004)
#print("g_ratio = 1: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())
#GammaH.setVal(0.04)
#print("g_ratio = 10: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())
#GammaH.setVal(0.4)
#print("g_ratio = 100: ", w.function("mean_g0_%s_%s_%s_13TeV_hggpdfsmrel_shift_%s_%s_%s_13TeV"%(opt.proc, opt.year, opt.cat, opt.proc, opt.year, opt.cat)).getVal())

