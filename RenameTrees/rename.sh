folder="/eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_ggf_plus_intgg_plus_intqg_UL17/"

#python3 rename_trees.py $folder/ggf_plus_intgg_plus_intqg_M120.root ggh_13TeV ggh_120_13TeV
#python3 rename_trees.py $folder/ggf_plus_intgg_plus_intqg_M125.root ggh_13TeV ggh_125_13TeV
python3 rename_trees.py $folder/ggf_plus_intgg_plus_intqg_M130.root ggh_13TeV ggh_130_13TeV > log_mix_130 2>&1 &

folder="/eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_int_UL17/hadded/"

python3 rename_trees.py $folder/output_GluGluHToGG_int_M120_13TeV-sherpa.root ggh_13TeV ggh_120_13TeV > log_int_120 2>&1 &
python3 rename_trees.py $folder/output_GluGluHToGG_int_M125_13TeV-sherpa.root ggh_13TeV ggh_125_13TeV > log_int_125 2>&1 &
python3 rename_trees.py $folder/output_GluGluHToGG_int_M130_13TeV-sherpa.root ggh_13TeV ggh_130_13TeV > log_int_130 2>&1 &

folder="/eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_intqg_UL17/hadded/"

python3 rename_trees.py $folder/output_GluGluHToGG_intqg_M120_13TeV-sherpa.root ggh_13TeV ggh_120_13TeV > log_intqg_120 2>&1 &
python3 rename_trees.py $folder/output_GluGluHToGG_intqg_M125_13TeV-sherpa.root ggh_13TeV ggh_125_13TeV > log_intqg_125 2>&1 &
python3 rename_trees.py $folder/output_GluGluHToGG_intqg_M130_13TeV-sherpa.root ggh_13TeV ggh_130_13TeV > log_intqg_130 2>&1 &
