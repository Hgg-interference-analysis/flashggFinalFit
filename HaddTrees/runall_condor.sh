#!/bin/bash

# 4 7 8 12 13 14 15 16 17 18
if [ $1 -eq 0 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_data.sh $2
fi
if [ $1 -eq 1 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_ggf.sh $2
fi
if [ $1 -eq 2 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_vbf.sh $2
fi
if [ $1 -eq 3 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_vh.sh $2
fi
if [ $1 -eq 4 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_ggfint.sh $2
fi
if [ $1 -eq 5 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_ggf.sh $2
fi
if [ $1 -eq 6 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_vbf.sh $2
fi
if [ $1 -eq 7 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_vh.sh $2
fi
if [ $1 -eq 8 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_ggfint.sh $2
fi
if [ $1 -eq 9 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_ggf.sh $2
fi
if [ $1 -eq 10 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_vbf.sh $2
fi
if [ $1 -eq 11 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_vh.sh $2
fi
if [ $1 -eq 12 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_ggfint.sh $2
fi
if [ $1 -eq 13 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_intgg.sh $2
fi
if [ $1 -eq 14 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_intgg.sh $2
fi
if [ $1 -eq 15 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_intgg.sh $2
fi
if [ $1 -eq 16 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M120_intqg.sh $2
fi
if [ $1 -eq 17 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M125_intqg.sh $2
fi
if [ $1 -eq 18 ]; then
  source /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddTrees/hadd_M130_intqg.sh $2
fi
