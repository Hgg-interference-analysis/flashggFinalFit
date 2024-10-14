import ROOT
import pickle
import pandas as pd
import numpy as np

columns = ["nominal_yield",  'THU_ggH_Mu_up_yield', 'THU_ggH_Mu_down_yield',
       'THU_ggH_Res_up_yield', 'THU_ggH_Res_down_yield',
       'THU_ggH_Mig01_up_yield', 'THU_ggH_Mig01_down_yield',
       'THU_ggH_Mig12_up_yield', 'THU_ggH_Mig12_down_yield',
       'THU_ggH_VBF2j_up_yield', 'THU_ggH_VBF2j_down_yield',
       'THU_ggH_VBF3j_up_yield', 'THU_ggH_VBF3j_down_yield',
       'THU_ggH_PT60_up_yield', 'THU_ggH_PT60_down_yield',
       'THU_ggH_PT120_up_yield', 'THU_ggH_PT120_down_yield',
       'THU_ggH_qmtop_up_yield', 'THU_ggH_qmtop_down_yield',
]

d = {col: [] for col in columns}

for i in range(9):
  df = pickle.load(open(f"yields_2023-03-02_xsec/UntaggedTag_{i}.pkl", "rb"))
  for col in columns:
    d[col].append(df[df.procOriginal == "GG2H"][col].iloc[0])

for col in columns:
  if col == "nominal_yield": continue
  c = ROOT.TCanvas()
  gn = ROOT.TGraph(10, np.linspace(0, 9, 10).astype(float), np.asarray(d["nominal_yield"]).astype(float))
  gc = ROOT.TGraph(10, np.linspace(0, 9, 10).astype(float), np.asarray(d[col]).astype(float))
  gn.Draw("AP")
  gc.Draw("P")
  gn.SetMarkerStyle(21)
  gc.SetMarkerStyle(21)
  gc.SetLineColor(ROOT.kRed)
  gc.SetMarkerColor(ROOT.kRed)
  gn.GetXaxis().SetTitle("Category number")
  gn.GetYaxis().SetTitle("Yield")
  c.SaveAs(f"/eos/user/r/rgargiul/www/yields_check_THU/{col}.pdf")
  dd = ROOT.TCanvas()
  gr = ROOT.TGraph(10, np.linspace(0, 9, 10).astype(float),np.asarray(d[col]).astype(float)/ np.asarray(d["nominal_yield"]).astype(float))
  gr.Draw("AP")
  gr.SetMarkerStyle(21)
  gr.GetXaxis().SetTitle("Category number")
  gr.GetYaxis().SetTitle("Yield ratio syst/nominal")
  dd.SaveAs(f"/eos/user/r/rgargiul/www/yields_check_THU/{col}_ratio.pdf")

