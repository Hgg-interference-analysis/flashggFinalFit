#!/usr/bin/env python3
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-o","--outfile",help="Outputfile")
parser.add_argument("--infile",type=str)
parser.add_argument("-S","--sqrts",type=int,default=-1,help="Sqrt(S) COM energy for finding strings etc (default picked up from workspace)")
parser.add_argument("-C","--cat",type=str)
parser.add_argument("-Y","--year",type=str)

options = parser.parse_args()

import sys
import ROOT

ROOT.gSystem.Load("libHiggsAnalysisCombinedLimit")
ROOT.gROOT.LoadMacro("scripts/roofit_iterate.h+")


new_workspace = ROOT.RooWorkspace("multipdf","multipdf")

f   = ROOT.TFile.Open(options.infile)
win = f.Get("multipdf")
sQr  = win.var("SqrtS")
intL = win.var("IntLumi")

if options.sqrts>0: sqrts=options.sqrts
else: sqrts = int(sQr.getVal())

ext = "%dTeV"%(sqrts)

catname = options.cat+f"_{options.year}"

cat = win.cat("pdfindex_%s_%s"%(catname,ext))

cat.Print()

multipdf   = win.pdf("CMS_hgg_%s_%s_bkgshape"%(catname,ext))
norm  = win.var("CMS_hgg_%s_%s_bkgshape_norm"%(catname,ext))

data = win.data("roohist_data_mass_%s"%(options.cat))

print("roohist_data_mass_%s"%(catname))

data.Print()

print("getattr(new_workspace,'import')(cat)")
getattr(new_workspace,'import')(cat)
print("getattr(new_workspace,'import')(multipdf)")
getattr(new_workspace,'import')(multipdf)
print("getattr(new_workspace,'import')(norm)")
getattr(new_workspace,'import')(norm)
print("getattr(new_workspace,'import')(data)")
getattr(new_workspace,'import')(data)

print("data imported")

getattr(new_workspace,'import')(sQr)
getattr(new_workspace,'import')(intL)

outfile = ROOT.TFile(options.outfile,"RECREATE")
new_workspace.Write()
outfile.Close()
