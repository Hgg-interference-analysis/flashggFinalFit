source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL${1}/
mkdir hadded
hadd -f hadded/output_GluGluHToGG_M130_TuneCP5_13TeV-amcatnloFXFX-pythia8.root output_GluGluHToGG_M130_TuneCP5_13TeV-amcatnloFXFX-pythia8_*.root
