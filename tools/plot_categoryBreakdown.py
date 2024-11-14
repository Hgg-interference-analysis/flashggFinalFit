import ROOT
import glob
import sys
import os

plot_folder = sys.argv[1]

files = glob.glob(f"{plot_folder}/fit_upto*.root")

print(files)

fnames = [f.split("/")[-1].replace(".root", "") for f in files]

os.system(f"hadd -f {plot_folder}/fit_all.root {plot_folder}/fit_upto*.root")

rfile = ROOT.TFile(f"{plot_folder}/fit_all.root")
c = ROOT.TCanvas("c", "c")
graph_list = []

outf = ROOT.TFile(f"{plot_folder}/plot_all.root", "recreate")

colors = [1, 2, 3, 4, 6, 7, 8, 9, 12, 28, 46]

for i in range(len(fnames)):
  f = f"fit_upto{i}"
  t = rfile.Get(f)
  print(f)
  t.Draw("gamma:2*deltaNLL", "", "goff")
  g = ROOT.TGraph(t.GetSelectedRows(), t.GetV1(), t.GetV2())
  graph_list.append(g)
  if i==0:
    g.Draw("AP")
    g.GetYaxis().SetRangeUser(0, 8)
  else: g.Draw("P")
  g.SetMarkerStyle(21)
  g.SetMarkerColor(colors[i])
  g.SetTitle(f)
  g.SetName(f)
  outf.cd()
  g.Write()

c.BuildLegend()
outf.cd()
c.Write()
outf.Close()
c.SaveAs(f"{plot_folder}/plot_all.pdf")
