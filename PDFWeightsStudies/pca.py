#/cvmfs/sft.cern.ch/lcg/views/LCG_104/x86_64-el9-gcc11-opt/setup.sh

import uproot
from sklearn.preprocessing import StandardScaler
import pandas as pd
from sklearn.decomposition import PCA
import numpy as np
import matplotlib.pyplot as plt
import sys

files = {
  "ggh_sherpa": "/eos/user/r/rgargiul/dataHggWidth/trees/sample_ggH_sherpa_for_pdfweights_studies.root",
  "int": "/eos/user/r/rgargiul/dataHggWidth/trees/trees_postVBFcat_int/output_GluGluHToGG_int_M125_13TeV-sherpa_*.root",
  "ggh": "/eos/user/r/rgargiul/dataHggWidth/trees/sample_ggH_for_pdfweights_studies.root",
  "vbf": "/eos/user/r/rgargiul/dataHggWidth/trees/sample_VBF_for_pdfweights_studies.root"
}

processes = list(files.keys())

nweights = {"ggh_sherpa": 100, "int": 111, "ggh": 60, "vbf": 60} #only int is OK
npdfweights = {"ggh_sherpa": 100, "int": 100, "ggh": 60, "vbf": 60} #only int is OK

branchname = {"ggh_sherpa": "pdfWeights", "int": "genweight", "ggh": "pdfWeights", "vbf": "pdfWeights", "vh": "pdfWeights"}

treename = {"ggh_sherpa": "ggh", "int": "ggh_125", "ggh": "MC", "vbf": "vbf"}

cats = [f"UntaggedTag_{i}" for i in range(10)] + ["VBFTag_0"]

for proc in ["ggh_sherpa"]:
  trees = []

  for cat in cats:
      trees.append(f"{files[proc]}:tagsDumper/trees/{treename[proc]}_13TeV_{cat}")

  array = uproot.concatenate([trees], filter_name=branchname[proc], library="pd").to_numpy()

  mass_weight = uproot.concatenate([trees], ["CMS_hgg_mass", "weight"], library="np")

  mass = mass_weight["CMS_hgg_mass"]
  weight = mass_weight["weight"]

  array = array.flatten()

  if len(array) % nweights[proc] != 0: raise ValueError("Something wrong in array sizes")

  array = array.reshape(int(len(array)/nweights[proc]), nweights[proc])

  if len(array) > 300000:
    indices = np.random.choice(len(array), 300000)
    array = array[indices]
    mass = mass[indices]
    weight = weight[indices]

  pca = PCA(n_components=1)
  array = array[:, -npdfweights[proc]:]

  print(array.shape)

  means_axis1 = array.mean(axis=1)

  centered_data = array/np.repeat(means_axis1[:, np.newaxis], npdfweights[proc], axis=1) - 1

  means_axis0 = centered_data.mean(axis=0)
  centered_data -= np.repeat(means_axis0[np.newaxis, :], len(centered_data), axis=0)

  outf = open(f"{proc}_offset.dat", "w")
  for j in range(npdfweights[proc]):
      outf.write(f"{means_axis0[j]} ")
  outf.close()

  f = uproot.recreate(f"out_{proc}.root")
  f["nopca"] = {"nopca": centered_data}
  f.close()

  pca.fit(centered_data)

  sample = np.array(centered_data[0])

  my_transformed = pca.components_ @ sample

  outf = open(f"{proc}_pcamatrix.dat", "w")
  for i in range(1):
    for j in range(npdfweights[proc]):
      outf.write(f"{pca.components_[i, j]} ")
    outf.write("\n")
  outf.close()

  pca_transformed = pca.transform(sample.reshape(1, npdfweights[proc]))[0]

  if np.sqrt(((my_transformed-pca_transformed)**2).sum()) > 1e-3:
    raise ValueError("Transformation badly defined")

  my_transformed = pca.transform(centered_data)[:, 0]

  f = uproot.recreate(f"pca_out_{proc}.root")
  f["pca"] = {
    "pdf_weight_var": (my_transformed + 1)*means_axis1,
     "central_pdf_weight": means_axis1, "mass": mass, "weight": weight
  }
  f.close()

