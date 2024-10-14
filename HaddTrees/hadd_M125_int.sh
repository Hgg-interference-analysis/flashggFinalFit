source /cvmfs/cms.cern.ch/cmsset_default.sh


cd /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/HaddSignalAndInterference/

cmsenv

cd /eos/user/r/rgargiul/amrutha_ws/signal_trees/untaggedTag_UL18_intMC_vbfcat/INT_125

hadd -f output_GluGluHToGG_int_M125_13TeV-sherpa.root output_GluGluHToGG_int_M125_13TeV-sherpa_*.root

