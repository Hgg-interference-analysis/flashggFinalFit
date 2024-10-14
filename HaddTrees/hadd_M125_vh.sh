source /cvmfs/cms.cern.ch/cmsset_default.sh


cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddSignalAndInterference/

cmsenv

cd /eos/user/r/rgargiul/amrutha_ws/signal_trees/untaggedTag_UL18_sigMC_vbfcat/VH_125

hadd -f output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8_*.root

