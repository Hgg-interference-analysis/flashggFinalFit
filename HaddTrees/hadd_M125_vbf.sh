source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL${1}/
mkdir hadded
hadd -f hadded/output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8.root output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8_*.root
