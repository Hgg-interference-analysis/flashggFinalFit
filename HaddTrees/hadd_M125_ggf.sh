source /cvmfs/cms.cern.ch/cmsset_default.sh


cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddSignalAndInterference/

cmsenv

cd /eos/user/r/rgargiul/amrutha_ws/signal_trees/untaggedTag_UL18_sigMC_vbfcat/GGF_125

hadd -f output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8.root output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8_*.root

