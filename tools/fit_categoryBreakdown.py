import os
import sys

plot_folder = sys.argv[1]
VBFcatOn = int(sys.argv[2])
combinerootfilename = sys.argv[3]

categories = [f"UntaggedTag_{i}" for i in range(10)]
if VBFcatOn: categories += ["VBFTag_0"]

print(categories)

os.system("cp ../Datacard/Datacard_xsec.txt ../Datacard/Datacard_xsec_orig.txt")

for i in range(len(categories)):
  cat_string = "|".join(categories[:i+1])
  os.system(f"cd ../Datacard; ./removecats.sh \"{cat_string}\"")
  os.system(f"cd ../Combine; ./run_sequence.sh -s t2w; ./run_sequence.sh -s fit; root higgsCombine_profile1D_syst_xsec_gamma.MultiDimFit.mH125.38.root -e 'limit->SetName(\"fit_upto{i}\"); limit->SaveAs(\"{plot_folder}/fit_upto{i}.root\"); exit(0);'")
