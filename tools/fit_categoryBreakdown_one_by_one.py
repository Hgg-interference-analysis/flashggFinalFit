import os
import sys

plot_folder = sys.argv[1]
VBFcatOn = int(sys.argv[2])
combinerootfilename = sys.argv[3]
year = sys.argv[4]

categories = [f"UntaggedTag_{i}_{year}" for i in range(10)]
if VBFcatOn: categories += [f"VBFTag_0_{year}"]

print(categories)

#os.system(f"cp ../Datacard/Datacard_{year}_xsec.txt ../Datacard/Datacard_{year}_xsec_orig.txt")

for i, cat in enumerate(categories):
  os.system(f"cd ../Datacard; ./removecats.sh \"{cat}\" {year}")
  os.system(f"cd ../Combine; ./run_sequence.sh -s t2w --year {year}; ./singlepar.sh {year} gamma; root {combinerootfilename} -e 'limit->SetName(\"fit_upto{i}\"); limit->SaveAs(\"{plot_folder}/fit_upto{i}.root\"); exit(0);'")
