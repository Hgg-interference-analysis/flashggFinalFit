import pickle
import glob
import sys
import pandas as pd


procs = sys.argv[1].split(",") # GGF,GGFPLUSINT,VBF
files = glob.glob("*.pkl")

d = {}

for f in files: d[f.replace(".pkl", "")] = list(pickle.load(open(f, "rb"))["nominal_yield"])[:len(procs)]

cats = [item for item in list(d.keys()) for i in range(len(procs))]

yields = sum(list(d.values()), [])

proc_lst = procs*len(d.keys())

print(cats,yields,procs)
print(len(cats), len(yields), len(proc_lst))

df = pd.DataFrame({"cat": cats, "yields": sum(list(d.values()), []), "proc": proc_lst})

df.to_csv("yields.csv", index=None)

for p in procs:
  print(df[df.proc == p].yields.sum())
