import pickle

years = ["2016preVFP", "2016postVFP", "2017", "2018"]

file = "/afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/outdir_dcb-newcat-2024-05-02_year%s/calcPhotonSyst/pkl/%s.pkl"

cats = [f"UntaggedTag_{i}" for i in range(10)]
cats += ["VBFTag_0"]

for year in years:
  for cat in cats:
    tab = pickle.load(open(file%(year,cat), "rb"))

    sigmas = [c for c in tab.columns if "sigma" in c and "smear" in c and "EB" in c and "Rho" in c]+["proc"]

    print(year, cat)
    df = tab[sigmas]
    print(df[df["proc"] == "GG2H"])
