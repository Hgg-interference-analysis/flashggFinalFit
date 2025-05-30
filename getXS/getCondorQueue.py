import os
import sys

if len(sys.argv) != 5:
        print("Usage: python getCondorQueue.py <dataset> <proc> <mass> <year>")
        sys.exit(1)


##gg M125
#datasets = [
#    "/GluGluHToGG_int_M125_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9_ext1-v3/MINIAODSIM",
#    "/GluGluHToGG_int_M125_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1_ext1-v3/MINIAODSIM",
#    "/GluGluHToGG_int_M125_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17_ext1-v3/MINIAODSIM",
#    "/GluGluHToGG_int_M125_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11_ext1-v3/MINIAODSIM"
#]

##gg M120
#datasets = [
#    "/GluGluHToGG_int_M120_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11-v2/MINIAODSIM",
#    "/GluGluHToGG_int_M120_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM",
#   "/GluGluHToGG_int_M120_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9-v2/MINIAODSIM",
#    "/GluGluHToGG_int_M120_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM"
#]

##gg M130
#datasets = [
#    "/GluGluHToGG_int_M130_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11-v2/MINIAODSIM",
#    "/GluGluHToGG_int_M130_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM",
#   "/GluGluHToGG_int_M130_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9-v2/MINIAODSIM",
#    "/GluGluHToGG_int_M130_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM"
#]

##qg M125
#datasets = [
#    "/GluGluHToGG_intqg_M125_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M125_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M125_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M125_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM"
#]

##qg M120
#datasets = [
#    "/GluGluHToGG_intqg_M120_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M120_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM",
#   "/GluGluHToGG_intqg_M120_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M120_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM"
#]

##qg M130
#datasets = [
#    "/GluGluHToGG_intqg_M130_13TeV-sherpa/RunIISummer20UL16MiniAODAPVv2-106X_mcRun2_asymptotic_preVFP_v11-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M130_13TeV-sherpa/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM",
#   "/GluGluHToGG_intqg_M130_13TeV-sherpa/RunIISummer20UL17MiniAODv2-106X_mc2017_realistic_v9-v2/MINIAODSIM",
#    "/GluGluHToGG_intqg_M130_13TeV-sherpa/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM"
#]

with open(f"./queueArgs/queue_args_{sys.argv[2]}_m{sys.argv[3]}_{sys.argv[4]}.txt", "w") as f:
    print(f"Querying DAS for {sys.argv[1]}...")
    cmd = f'dasgoclient -query="file dataset={sys.argv[1]}"'
    _files = os.popen(cmd).read().strip().split('\n')
    for i,f_ in enumerate(_files):
        f.write(f'{f_} {i} {sys.argv[2]} {sys.argv[3]} {sys.argv[4]}\n')
