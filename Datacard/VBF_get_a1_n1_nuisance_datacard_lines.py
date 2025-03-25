import pandas as pd
import ROOT
import sys

year = sys.argv[1]

a1_n1_err = pd.read_csv(f"VBF_a1_n1_err_{year}.csv")
a1_n1_mean = pd.read_csv(f"VBF_a1_n1_centralvalues_20{year}.csv")

for cat in a1_n1_err.cat:
  a1_err = a1_n1_err[a1_n1_err.cat == cat].a1_err.values[0]
  n1_err = a1_n1_err[a1_n1_err.cat == cat].n1_err.values[0]
  a1_mean = a1_n1_mean[a1_n1_mean.cat == cat].a1.values[0]
  n1_mean = a1_n1_mean[a1_n1_mean.cat == cat].n1.values[0]
  print(f"a1_dcb_VBF_20{year}_{cat}_13TeV param {a1_mean} {max(0.1, a1_err)}")
  print(f"n1_dcb_VBF_20{year}_{cat}_13TeV param {n1_mean} {max(1, n1_err)}")
