source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_${1}
mkdir hadded
hadd -f hadded/output_VBFHToGG_M130_TuneCP5_13TeV-amcatnlo-pythia8.root output_VBFHToGG_M130_TuneCP5_13TeV-amcatnlo-pythia8_*.root
