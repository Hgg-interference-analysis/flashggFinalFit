# Config file: options for signal fitting

_year = '2018'

signalScriptCfg = {
    # Setup
    'inputWSDir': '/eos/user/a/amkrishn/hggWidth/mcNtuples/condor_output/2018/UL18_sigMC_newFNUF_VBFTag0/hadded_trees/ws_sig',
    #'procs':'auto',
    'procs':'GG2H,VBF,vh',
    'cats':'auto',
    'ext':'newFNUF_VBFTag0_%s'%_year,
    'analysis':'example', # To specify which replacement dataset mapping (defined in ./python/replacementMap.py)
    'year':'%s'%_year, # Use 'combined' if merging all years: not recommended
    #'massPoints':'120,125,130',
    'massPoints':'125',
    'xvar': 'CMS_hgg_mass',
    #'outdir': '/eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/postVBFcat', #condor does not transfer output files to eos

    #Photon shape systematics
    'scales': 'HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain1EB,Gain6EB', # separate nuisance per year
    'scalesCorr': 'MaterialCentralBarrel,MaterialOuterBarrel,MaterialForward,FNUFInnerEB,FNUFOuterEB,FNUFEE,ShowerShapeHighR9EE,ShowerShapeHighR9EB,ShowerShapeLowR9EE,ShowerShapeLowR9EB', # correlated across years
    'scalesGlobal': 'NonLinearity,Geant4', # affect all processes equally, correlated across years
    'smears': 'HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho', # separate nuisance per year

    # Job submission options
    'batch':'condor', # ['condor','SGE','IC','Rome','local']
    'queue':'espresso'
}
