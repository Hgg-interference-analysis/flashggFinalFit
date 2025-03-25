#!/bin/bash

cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine

eval `scramv1 runtime -sh`

export PYTHONPATH=$PYTHONPATH:/afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0/src/flashggFinalFit/Combine
text2workspace.py Datacard_all.txt -o Datacard_all.root -m 125.38 higgsMassRange=122,128 -P IntYield:intyield     --PO int
