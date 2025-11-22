#!/bin/bash
ulimit -s unlimited
set -e
cd /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src
export SCRAM_ARCH=el9_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal
export PYTHONPATH=$PYTHONPATH:/afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/tools:/afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/tools

if [ $1 -eq 0 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_0 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 1 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_1 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 2 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_2 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 3 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_3 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 4 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_4 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 5 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_5 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 6 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_6 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 7 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_7 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 8 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_8 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 9 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat UntaggedTag_9 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
if [ $1 -eq 10 ]; then
  python3 /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Signal/scripts/calcPhotonSyst.py --cat VBFTag_0 --procs GG2H,VBF,vh --ext final2017 --inputWSDir /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/ --scales 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB' --scalesCorr 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB' --scalesGlobal 'NonLinearity,Geant4' --smears 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho' 
fi
