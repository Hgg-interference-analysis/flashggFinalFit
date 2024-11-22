#/cvmfs/sft.cern.ch/lcg/views/LCG_104/x86_64-el9-gcc11-opt/setup.sh

import uproot
from sklearn.preprocessing import StandardScaler
import pandas as pd
from sklearn.decomposition import PCA
import numpy as np
import matplotlib.pyplot as plt
import sys

files = {
  "int": "/eos/user/r/rgargiul/dataHggWidth/trees/trees_postVBFcat_int/output_GluGluHToGG_int_M125_13TeV-sherpa_*.root",
  "ggh": "/eos/user/r/rgargiul/dataHggWidth/trees/sample_ggH_for_pdfweights_studies.root",
  "vbf": "/eos/user/r/rgargiul/dataHggWidth/trees/sample_VBF_for_pdfweights_studies.root"
}

processes = list(files.keys())

nweights = {"int": 111, "ggh": 60, "vbf": 60} #only int is OK
npdfweights = {"int": 100, "ggh": 60, "vbf": 60} #only int is OK

branchname = {"int": "genweight", "ggh": "pdfWeights", "vbf": "pdfWeights", "vh": "pdfWeights"}

cats = [f"UntaggedTag_{i}" for i in range(10)] + ["VBFTag_0"]

for proc in ["int"]:
  trees = []

  for cat in cats:
    if proc != "int":
      trees.append(f"{files[proc]}:tagsDumper/trees/MC_13TeV_{cat}")
    else:
      trees.append(f"{files[proc]}:tagsDumper/trees/ggh_125_13TeV_{cat}")

  print("starting to concatenate")

  array = uproot.concatenate([trees], filter_name=branchname[proc], library="pd").to_numpy()

  mass_weight = uproot.concatenate([trees], ["CMS_hgg_mass", "weight"], library="np")

  mass = mass_weight["CMS_hgg_mass"]
  weight = mass_weight["weight"]

  array = array.flatten()

  if len(array) % nweights[proc] != 0: raise ValueError("Something wrong in array sizes")

  array = array.reshape(int(len(array)/nweights[proc]), nweights[proc])

  print(array.shape)

  print("starting to sample")
  if len(array) > 1000000:
    indices = np.random.choice(len(array), 100000)
    array = array[indices]

  pca = PCA(n_components=1)
  array = array[:, -npdfweights[proc]:]

  means = array.mean(axis=1)

  centered_data = array/np.repeat(means[:, np.newaxis], npdfweights[proc], axis=1) - 1

  print(centered_data)
  print(centered_data.mean(axis=0))

  f = uproot.recreate(f"out_{proc}.root")
  f["nopca"] = {"nopca": centered_data}
  f.close()

  pca.fit(centered_data)

  sample = np.array(centered_data[0])
  print("sample shape", sample.shape)

  print("starting to transform")

  print("pca comp shape", pca.components_.shape)

  my_transformed = pca.components_ @ sample

  outf = open(f"{proc}_pcamatrix.dat", "w")
  for i in range(1):
    for j in range(npdfweights[proc]):
      outf.write(f"{pca.components_[i, j]} ")
    outf.write("\n")
  outf.close()

  pca_transformed = pca.transform(sample.reshape(1, npdfweights[proc]))[0]

  print("comparison", my_transformed, pca_transformed)

  if np.sqrt(((my_transformed-pca_transformed)**2).sum()) > 1e-1:
    raise ValueError("Transformation badly defined")

  my_transformed = pca.transform(centered_data)[:, 0]
  print(my_transformed)

  f = uproot.recreate(f"pca_out_{proc}.root")
  f["pca"] = {"pdf_weight_var": (my_transformed + 1)*means, "central_pdf_weight": means, "mass": mass, "weight": weight}
  f.close()

  print(my_transformed.mean(axis=0))
  print(my_transformed.std(axis=0))

  break
