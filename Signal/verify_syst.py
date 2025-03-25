import pickle

years = ["2016preVFP", "2016postVFP", "2017", "2018"]

file = "/afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/outdir_dcb-newcat-2024-05-02_year%s/calcPhotonSyst/pkl/%s.pkl"

cats = [f"UntaggedTag_{i}" for i in range(10)]
cats += ["VBFTag_0"]

for year in years:
  for cat in cats:
    tab = pickle.load(open(file%(year,cat), "rb"))

    sigmas = [c for c in tab.columns if "sigma"  in c]

    t_sigma = tab[sigmas]
    probs = t_sigma.loc[:, (t_sigma > 0.05).any()]
    if len(probs.columns) > 0:
      print(cat, year)
      print(probs)

    a1s = [c for c in tab.columns if "a1"  in c]

    t_a1 = tab[a1s]
    probs = t_a1.loc[:, (t_a1 > 0.1).any()]
    if len(probs.columns) > 0:
      print(cat, year)
      print(probs)

    n1s = [c for c in tab.columns if "n1"  in c]

    t_n1 = tab[n1s]
    probs = t_n1.loc[:, (t_n1 > 1).any()]
    if len(probs.columns) > 0:
      print(cat, year)
      print(probs)
