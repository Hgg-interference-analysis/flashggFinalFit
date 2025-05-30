#!/usr/bin/env python3
import sys
import ROOT
import os

def main(root_file, out_file):
    f = ROOT.TFile.Open(root_file)
    if not f or f.IsZombie():
        print(f"Error: cannot open {root_file}")
        return 1

    tree = f.Get("Events")

    tree.Draw("1>>sumW", "GenEventInfoProduct_generator__GEN.obj.weights_[0]", "goff")
    #tree.Draw("1>>sumW2", "GenEventInfoProduct_generator__GEN.obj.weights_[0]**2", "goff")
    tree.Draw("1>>sumNtrials", "GenEventInfoProduct_generator__GEN.obj.weights_[3]", "goff")
    sumW = ROOT.gDirectory.Get("sumW")
    sumNtrials = ROOT.gDirectory.Get("sumNtrials")

    procid = os.getenv("ProcId", "0")
    output_file = f"/eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/amkrishn/xsec/{out_file}"

    fout = ROOT.TFile(output_file, "RECREATE")
    sumW.Write()
    #sumW2.Write()
    sumNtrials.Write()
    fout.Close()
    f.Close()

    print(f"Saved {output_file}")
    return 0

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python extract_weights.py <root_file> <output.root>")
        sys.exit(1)
    sys.exit(main(sys.argv[1],sys.argv[2]))
