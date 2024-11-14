#!/bin/bash

cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine

eval `scramv1 runtime -sh`

export PYTHONPATH=$PYTHONPATH:/afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Combine
text2workspace.py Datacard_xsec.txt -o Datacard_xsec.root -m 125 higgsMassRange=122,128 -P HiggsWidth:higgswidth     --PO int
