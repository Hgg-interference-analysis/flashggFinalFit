for year in pre post; do
  source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL16${year}VFP/hadded/output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8.root 2016${year}VFP GG2H ggh &
  source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL16${year}VFP/hadded_ggf_plus_int/ggf_plus_intgg_plus_intqg_M125.root 2016${year}VFP GG2HPLUSINT ggh &
  source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL16${year}VFP/hadded/output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8.root 2016${year}VFP VBF vbf &
  source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/tree_UL16${year}VFP/hadded/output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root 2016${year}VFP vh vh &
done


source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL17/hadded/output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8_corr.root 2017 GG2H ggh &
source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_ggf_plus_intgg_plus_intqg_UL17/ggf_plus_intgg_plus_intqg_M125_corr.root 2017 GG2HPLUSINT ggh &
source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL17/hadded/output_VBFHToGG_M125_TuneCP5_13TeV-amcatnlo-pythia8_corr.root 2017 VBF vbf &
source single_proc_oversmearing.sh /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig_UL17/hadded/output_VHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8.root 2017 vh vh &



