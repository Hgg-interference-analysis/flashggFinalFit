#/cvmfs/sft.cern.ch/lcg/views/LCG_104/x86_64-el9-gcc11-opt/setup.sh

import pandas as pd
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
  "vh": "/eos/user/r/rgargiul/dataHggWidth/trees/trees_postVBFcat_sig/output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root",
  "vbf": "/eos/user/r/rgargiul/dataHggWidth/trees/trees_postVBFcat_sig/output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8.root"
}

processes = list(files.keys())

ngenweights = {"int": 111, "ggh": 60, "vh": 60, "vbf": 60} #only int is OK
npdfweights = {"int": 100, "ggh": 60, "vh": 60, "vbf": 60} #only int is OK

branchname = {"int": "genweight", "ggh": "pdfWeights", "vbf": "pdfWeights", "vh": "pdfWeights"}

cats = [f"UntaggedTag_{i}" for i in range(10)] + ["VBFTag_0"]

for proc in ["ggh"]:
  trees = []

  for cat in cats[-1:]:
    if proc != "int":
      trees.append(f"{files[proc]}:tagsDumper/trees/MC_13TeV_{cat}")
    else:
      trees.append(f"{files[proc]}:tagsDumper/trees/ggh_125_13TeV_{cat}")

  print("starting to concatenate")

  array = uproot.concatenate([trees], filter_name=branchname[proc], library="pd").to_numpy()

  array = array.flatten()

  if len(array) % ngenweights[proc] != 0: raise ValueError("Something wrong in array sizes")

  array = array.reshape(int(len(array)/ngenweights[proc]), ngenweights[proc])

  print(array)

  print("starting to sample")
  if len(array) > 1000000:
    indices = np.random.choice(len(array), 100000)
    array = array[indices]

  print(array.shape)

  pca = PCA(n_components=5)
  array = array[:, -npdfweights[proc]:]

  print(array.shape)

  centered_data = array - array.mean(axis=0)

  print("starting to fit")

  pca.fit(centered_data)


  sample = np.array(centered_data[0])
  print("sample shape", sample.shape)

  print("starting to transform")

  print("pca comp shape", pca.components_.shape)

  my_transformed = pca.components_ @ sample

  outf = open(f"{proc}_pcamatrix.dat", "w")
  for i in range(5):
    for j in range(npdfweights[proc]):
      outf.write(f"{pca.components_[i, j]} ")
    outf.write("\n")
  outf.close()

  pca_transformed = pca.transform(sample.reshape(1, npdfweights[proc]))[0]

  print(my_transformed, pca_transformed)

  if np.sqrt(((my_transformed-pca_transformed)**2).sum()) > 1e-3:
    raise ValueError("Transformation badly defined")

  break
