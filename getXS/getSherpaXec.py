import sys
import ROOT
import numpy as np

if len(sys.argv) !=4 :
    print("Usage: python3 getSherpaXec.py <proc> <mass> <year>")
    sys.exit(1)

filename =f'/eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/amkrishn/xsec/{sys.argv[1]}/m{sys.argv[2]}/{sys.argv[3]}/weights.root'
#print(filename)

# Open the ROOT file
f = ROOT.TFile.Open(filename, "READ")
if not f or f.IsZombie():
    print(f"Error: could not open file {filename}")
    sys.exit(1)

# Get histograms
#sumW_ = f.Get("sumW")
sumW = ROOT.TH1F(f.Get("sumW").Clone())
#sumW = ROOT.TH1F(sumW_)
#sumW2 = f.Get("sumW2")
#sumNtrials_ = f.Get("sumNtrials")
sumNtrials = ROOT.TH1F(f.Get("sumNtrials").Clone())

# Compute integrals
int_W = sumW.Integral()
##int_W2 = sumW2.Integral()
int_Ntrials = sumNtrials.Integral()

# Compute and print ratio
xs = int_W / int_Ntrials

with open(f"./results/{sys.argv[1]}_m{sys.argv[2]}_{sys.argv[3]}.txt", "w") as f:
    f.write(f'Integral(sumW) = {int_W}\n')
    f.write(f'Integral(sumNtrials) = {int_Ntrials}\n')
    f.write(f'Total cross-section = {xs}\n')
    
