import pandas as pd
import ROOT


a1_n1_err  = pd.read_csv("a1_n1_err.csv")
a1_n1_mean = pd.read_csv("a1_n1_centralvalues.csv")

for cat in a1_n1_err.cat:
  a1_err = a1_n1_err[a1_n1_err.cat == cat].a1_err.values[0]
  n1_err = a1_n1_err[a1_n1_err.cat == cat].n1_err.values[0]
  a1_mean = a1_n1_mean[a1_n1_mean.cat == cat].a1.values[0]
  n1_mean = a1_n1_mean[a1_n1_mean.cat == cat].n1.values[0]
  print(f"a1_dcb_GG2HPLUSINT_2018_{cat}_13TeV param {a1_mean} {a1_err}")
  print(f"n1_dcb_GG2HPLUSINT_2018_{cat}_13TeV param {n1_mean} {n1_err}")
