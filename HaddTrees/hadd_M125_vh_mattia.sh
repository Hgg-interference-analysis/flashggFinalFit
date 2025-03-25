source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_${1}
mkdir hadded
hadd -f hadded/output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8_*.root
