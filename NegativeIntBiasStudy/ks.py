import ROOT

year = 18

categories = [f"UntaggedTag_{i}" for i in range(10)] + [f"VBFTag_0"]

intfile = ROOT.TFile(f"/eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_int_UL{year}/hadded/output_GluGluHToGG_int_M125_13TeV-sherpa.root")


bkg_hist_orig_total = ROOT.TH1F(f"bkg_total", "bgk", 100, 130, 180)
bkg_plus_int_gamma50_total = ROOT.TH1F(f"bkg_plus_int_gamma50", "bgk", 100, 130, 180)

for cat in categories:
  ks_hist = ROOT.TH1F(f"ks_{cat}", "ks", 1000, 0, 1)
  bkgfile = ROOT.TFile(f"../Combine/Models/background/CMS-HGG_multipdf_{cat}_20{year}.root")
  bkg_hist = bkgfile.Get("multipdf").data(f"roohist_data_mass_{cat}").createHistogram("CMS_hgg_mass")
  bkg_hist.Rebin(2)
  ROOT.gROOT.cd()
  bkg_hist_cropped = ROOT.TH1F(f"bkg_{cat}", "bgk", 100, 130, 180)
  for i in range(61, 1+160):
     bkg_hist_cropped.SetBinContent(i-60, bkg_hist.GetBinContent(i))
     bkg_hist_cropped.SetBinError(i-60, bkg_hist.GetBinError(i))
  bkg_hist_orig = bkg_hist_cropped.Clone()
  bkg_hist_orig.SetName(f"bkg_orig_{cat}")
  toy = bkg_hist_cropped.Clone()
  toy.SetName(f"toy_{cat}")

  bkg_hist_orig_total.Add(bkg_hist_orig)

  bkg_plus_int_gamma50_hist = bkg_hist_cropped.Clone()
  bkg_plus_int_gamma50_hist.SetName(f"bkg_plus_int_gamma50_{cat}")
  int_hist = ROOT.TH1F(f"int_{cat}", "int", 100, 130, 180)
  intfile.Get(f"tagsDumper/trees/ggh_125_13TeV_{cat}").Draw(f"mass>>int_{cat}", "weight * 67 * sqrt(500)", "goff")
  int_res = int_hist.Clone()
  bkg_hist_orig.Draw()
  for i in range(1, 201):
    int_res.SetBinContent(i, int_hist.GetBinContent(i)/ROOT.TMath.Sqrt(bkg_hist_orig.GetBinContent(i)+1))
  int_res.SetName(f"int_res_{cat}_20{year}")
  int_res.SaveAs(f"int_res_{cat}_20{year}.root")

  bkg_plus_int_gamma50_hist.Add(int_hist)

  bkg_plus_int_gamma50_total.Add(bkg_plus_int_gamma50_hist)

  for j in range(1000):
    print(f"{cat} toy n.{j}")
    for i in range(1, 201):
      toy.SetBinContent(i, ROOT.gRandom.Poisson(bkg_plus_int_gamma50_hist.GetBinContent(i)))
      toy.SetBinError(i, ROOT.TMath.Sqrt(toy.GetBinContent(i)))
    ks_hist.Fill(toy.AndersonDarlingTest(bkg_hist_orig))
  ks_hist.SaveAs(f"ks_hist_{cat}_20{year}.root")


toy = bkg_hist_orig_total.Clone()
toy.SetName(f"toy_total")

ks_hist = ROOT.TH1F(f"ks_total", "ks", 1000, 0, 1)
for j in range(1000):
  print(f"{cat} toy n.{j}")
  for i in range(1, 201):
    toy.SetBinContent(i, ROOT.gRandom.Poisson(bkg_plus_int_gamma50_total.GetBinContent(i)))
    toy.SetBinError(i, ROOT.TMath.Sqrt(toy.GetBinContent(i)))
  ks_hist.Fill(toy.AndersonDarlingTest(bkg_hist_orig_total))
ks_hist.SaveAs(f"ks_hist_total_20{year}.root")

ks_hist.Draw()
input()
