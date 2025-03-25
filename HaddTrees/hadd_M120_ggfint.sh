source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/
hadd -f trees_ggf_plus_intgg_plus_intqg_UL${1}/ggf_plus_intgg_plus_intqg_M120.root trees_int_UL${1}/out*_Glu*_M120_*.root  trees_intqg_UL${1}/out*_Glu*_M120_*.root trees_sig_UL${1}/out*_Glu*_M120_*.root
