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

df.yields = df.yields.round(4)

dd = {"cat": df.cat[df.proc==procs[0]]}
for proc in procs:
  proc_name = f"{proc}"
  if proc == "GGF": proc_name = "ggF"
  if proc == "GGFPLUSINT": proc_name = "ggF+int."
  proc_name += " ev. / fb$^{-1}$"
  dd[proc_name] = df.yields[df.proc==proc].values

print(dd)

df = pd.DataFrame(dd)

df.to_csv("yields.csv", index=None)

#for p in procs:
#  print(df[df.proc == p].yields.sum())
