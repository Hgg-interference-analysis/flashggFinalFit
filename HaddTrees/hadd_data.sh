source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_data_UL${1}/
mkdir hadded

hadd -f hadded/allData20${1}.root output*.root
