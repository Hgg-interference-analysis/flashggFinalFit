source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_${1}
mkdir hadded
hadd -f hadded/output_GluGluHToGG_int_M130_13TeV-sherpa.root output_GluGluHToGG_int_M130_13TeV-sherpa_*.root

