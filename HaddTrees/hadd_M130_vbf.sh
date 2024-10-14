source /cvmfs/cms.cern.ch/cmsset_default.sh


cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddSignalAndInterference/

cmsenv

cd /eos/user/r/rgargiul/amrutha_ws/signal_trees/untaggedTag_UL18_sigMC_vbfcat/VBF_130

hadd -f output_VBFHToGG_M130_TuneCP5_13TeV-amcatnlo-pythia8.root output_VBFHToGG_M130_TuneCP5_13TeV-amcatnlo-pythia8_*.root

