python3 RunBackgroundScripts.py --inputConfig config_test_2018.py --mode fTestParallel --addInt 0 > log_2018_noint 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2017.py --mode fTestParallel --addInt 0 > log_2017_noint 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2016postVFP.py --mode fTestParallel --addInt 0 > log_2016postVFP_noint 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2016preVFP.py --mode fTestParallel --addInt 0 > log_2016preVFP_noint 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2018.py --mode fTestParallel --addInt 1 --intFile /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2018/output_GluGluHToGG_int_M125_13TeV-sherpa_INT.root > log_2018_int 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2017.py --mode fTestParallel --addInt 1 --intFile /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2017/output_GluGluHToGG_int_M125_13TeV-sherpa_INT.root > log_2017_int 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2016preVFP.py --mode fTestParallel --addInt 1 --intFile /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2016preVFP/output_GluGluHToGG_int_M125_13TeV-sherpa_INT.root > log_2016preVFP_int 2>&1

python3 RunBackgroundScripts.py --inputConfig config_test_2016postVFP.py --mode fTestParallel --addInt 1 --intFile /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_2016postVFP/output_GluGluHToGG_int_M125_13TeV-sherpa_INT.root > log_2016postVFP_int 2>&1
