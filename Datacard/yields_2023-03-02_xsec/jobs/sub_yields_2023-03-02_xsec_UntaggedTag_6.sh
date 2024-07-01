#!/bin/bash
ulimit -s unlimited
set -e
cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src
export SCRAM_ARCH=el9_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Datacard
export PYTHONPATH=$PYTHONPATH:/afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/tools:/afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Datacard/tools

python3 /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Datacard/makeYields.py --cat UntaggedTag_6 --procs GG2H,VBF,GG2HPLUSINT --ext 2023-03-02_xsec --mass 125 --inputWSDirMap 2018=/eos/user/r/rgargiul/amrutha_ws/ --sigModelWSDir ./Models/signal --sigModelExt packaged --bkgModelWSDir ./Models/background --bkgModelExt multipdf  --mergeYears --skipZeroes --doSystematics
