source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL${1}/
mkdir hadded
hadd -f hadded/output_VHToGG_M120_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root output_VHToGG_M120_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8_*.root
