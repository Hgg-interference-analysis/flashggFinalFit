#!/usr/bin/env python3
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-o","--outfile",help="Outputfile")
parser.add_option("-S","--sqrts",type='int',default=-1,help="Sqrt(S) COM energy for finding strings etc (default picked up from workspace)")
parser.add_option("-C","--cat",type='str')

(options,args) = parser.parse_args()

files = args[:]

import sys
import ROOT

ROOT.gSystem.Load("libHiggsAnalysisCombinedLimit")
ROOT.gROOT.LoadMacro("scripts/roofit_iterate.h+")
workspace = ROOT.RooWorkspace("multipdf","multipdf")

for i,fi in enumerate(files):

  f   = ROOT.TFile.Open(fi)
  win = f.Get("multipdf")
  sQr  = win.var("SqrtS")
  intL = win.var("IntLumi")

  print(sQr, intL)

  if options.sqrts>0: sqrts=options.sqrts
  else: sqrts = int(sQr.getVal())

  ext = "%dTeV"%(sqrts)

  print("ext: ", ext)

  catname = options.cat

  print("pdfindex_%s_%s"%(catname,ext))

  cat = win.cat("pdfindex_%s_%s"%(catname,ext))

  cat.Print()

  print("Merging Category ",catname)

  pdf   = win.pdf("CMS_hgg_%s_%s_bkgshape"%(catname,ext))
  norm  = win.var("CMS_hgg_%s_%s_bkgshape_norm"%(catname,ext))
  data = win.data("roohist_data_mass_%s"%(catname))

  getattr(workspace,'import')(cat)
  getattr(workspace,'import')(pdf)
  getattr(workspace,'import')(norm)
  getattr(workspace,'import')(data)

  print("SURVIVED1")

  if i==0:
    getattr(workspace,'import')(sQr)
    getattr(workspace,'import')(intL)
  print("SURVIVED2")

outfile = ROOT.TFile(options.outfile,"RECREATE")
workspace.Write()
outfile.Close()
