source /cvmfs/cms.cern.ch/cmsset_default.sh
/eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/data_${1}
mkdir hadded

hadd -f hadded/allData20${1}.root output*.root
