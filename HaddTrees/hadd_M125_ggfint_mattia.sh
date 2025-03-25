source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_${1}
mkdir hadded_ggf_plus_int
hadd -f hadded_ggf_plus_int/ggf_plus_intgg_plus_intqg_M125.root out*_Glu*_int_*M125_*.root out*_Glu*_intqg_M125_*.root output_GluGluHToGG_M125*.root
