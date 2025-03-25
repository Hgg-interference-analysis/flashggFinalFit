#!/usr/bin/env python3
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-o","--outfile",help="Outputfile")
parser.add_argument("--nointfile",type=str)
parser.add_argument("--withintfile",type=str)
parser.add_argument("-S","--sqrts",type=int,default=-1,help="Sqrt(S) COM energy for finding strings etc (default picked up from workspace)")
parser.add_argument("-C","--cat",type=str)
parser.add_argument("-Y","--year",type=str)

options = parser.parse_args()

import sys
import ROOT

ROOT.gSystem.Load("libHiggsAnalysisCombinedLimit")
ROOT.gROOT.LoadMacro("scripts/roofit_iterate.h+")
workspace = ROOT.RooWorkspace("multipdf","multipdf")

f   = ROOT.TFile.Open(options.nointfile)
win = f.Get("multipdf")
sQr  = win.var("SqrtS")
intL = win.var("IntLumi")

print(sQr, intL)

if options.sqrts>0: sqrts=options.sqrts
else: sqrts = int(sQr.getVal())

ext = "%dTeV"%(sqrts)

catname = options.cat+f"_{options.year}"

print("pdfindex_%s_%s"%(catname,ext))

cat = win.cat("pdfindex_%s_%s"%(catname,ext))

cat.Print()

print("Merging Category ",catname)

multipdf_noint   = win.pdf("CMS_hgg_%s_%s_bkgshape"%(catname,ext))
norm  = win.var("CMS_hgg_%s_%s_bkgshape_norm"%(catname,ext))
data = win.data("roohist_data_mass_%s"%(options.cat))
print("roohist_data_mass_%s"%(catname))
print("data: ", data)
data.Print()


f_i   = ROOT.TFile.Open(options.withintfile)
win_i = f_i.Get("multipdf")
multipdf_i = win_i.pdf("CMS_hgg_%s_%s_bkgshape"%(catname,ext))


allpdfs = ROOT.RooArgList()
for i in range(multipdf_noint.getNumPdfs()):
  print(i, "multipdf_noint")
  allpdfs.add(multipdf_noint.getPdf(i))
for i in range(multipdf_i.getNumPdfs()):
  print(i, "multipdf_wint")
  allpdfs.add(multipdf_i.getPdf(i))

print(allpdfs)

print("creating multipdf")
multipdf = ROOT.RooMultiPdf("CMS_hgg_%s_%s_bkgshape"%(catname,ext),"All Pdfs",cat,allpdfs);

print("getattr(workspace,'import')(cat)")
getattr(workspace,'import')(cat)
print("getattr(workspace,'import')(multipdf)")
getattr(workspace,'import')(multipdf)
print("getattr(workspace,'import')(norm)")
getattr(workspace,'import')(norm)
print("getattr(workspace,'import')(data)")
getattr(workspace,'import')(data)


if i==0:
  getattr(workspace,'import')(sQr)
  getattr(workspace,'import')(intL)

outfile = ROOT.TFile(options.outfile,"RECREATE")
workspace.Write()
outfile.Close()
