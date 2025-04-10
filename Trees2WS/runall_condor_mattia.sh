#!/bin/bash

cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/

#0-11

source /cvmfs/cms.cern.ch/cmsset_default.sh

cmsenv

source setup.sh

cd Trees2WS

if [ $1 -eq 0 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_M120_TuneCP5_13TeV-amcatnloFXFX-pythia8.root \ --productionMode ggh --year 20${2} --inputMass 120 --doSystematics
fi
if [ $1 -eq 1 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8.root \  --productionMode ggh --year 20${2} --inputMass 125 --doSystematics
fi
if [ $1 -eq 2 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_M130_TuneCP5_13TeV-amcatnloFXFX-pythia8.root \  --productionMode ggh --year 20${2} --inputMass 130 --doSystematics
fi
if [ $1 -eq 3 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VBFHToGG_M120_TuneCP5_13TeV-amcatnlo-pythia8.root \
  --productionMode vbf --year 20${2} --inputMass 120 --doSystematics
fi
if [ $1 -eq 4 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8.root \
  --productionMode vbf --year 20${2} --inputMass 125 --doSystematics
fi
if [ $1 -eq 5 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VBFHToGG_M130_TuneCP5_13TeV-amcatnlo-pythia8.root \
  --productionMode vbf --year 20${2} --inputMass 130 --doSystematics
fi
if [ $1 -eq 6 ]; then
python3 trees2ws.py --inputConfig config.py \
  --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VHToGG_M120_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root \
  --productionMode vh --year 20${2} --inputMass 120 --doSystematics
fi
if [ $1 -eq 7 ]; then
python3 trees2ws.py --inputConfig config.py \
  --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root \
  --productionMode vh --year 20${2} --inputMass 125 --doSystematics
fi
if [ $1 -eq 8 ]; then
python3 trees2ws.py --inputConfig config.py \
  --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_VHToGG_M130_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root \
  --productionMode vh --year 20${2} --inputMass 130 --doSystematics
fi
if [ $1 -eq 9 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded_ggf_plus_int/ggf_plus_intgg_plus_intqg_M125.root \
  --productionMode ggh --year 20${2} --inputMass 125 --doSystematics
fi
if [ $1 -eq 10 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded_ggf_plus_int/ggf_plus_intgg_plus_intqg_M120.root \
  --productionMode ggh --year 20${2} --inputMass 120 --doSystematics
fi
if [ $1 -eq 11 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded_ggf_plus_int/ggf_plus_intgg_plus_intqg_M130.root \
  --productionMode ggh --year 20${2} --inputMass 130 --doSystematics
fi
if [ $1 -eq 12 ]; then
python3 trees2ws_data.py \
  --inputConfig config.py --inputTreeFile  /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/data_UL${2}/allData20${2}.root
fi
if [ $1 -eq 13 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_int_M120_13TeV-sherpa.root \
  --productionMode ggh --year 20${2} --inputMass 120 --doSystematics
fi
if [ $1 -eq 14 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_int_M125_13TeV-sherpa.root \
  --productionMode ggh --year 20${2} --inputMass 125 --doSystematics
fi
if [ $1 -eq 15 ]; then
python3 trees2ws.py \
  --inputConfig config.py --inputTreeFile /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL${2}/hadded/output_GluGluHToGG_int_M130_13TeV-sherpa.root \
  --productionMode ggh --year 20${2} --inputMass 130 --doSystematics
fi
