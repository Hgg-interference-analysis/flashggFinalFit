# Config file: options for signal fitting

backgroundScriptCfg = {
  
    # Setup
    'inputWSDir':'/eos/user/a/amkrishn/hggWidth/mcNtuples/condor_output/2018/UL18_data_newFNUF_VBFTag0/ws', # location of 'allData.root' file
    'cats':'auto', # auto: automatically inferred from input ws
    'catOffset':0, # add offset to category numbers (useful for categories from different allData.root files)  
    'ext':'newFNUF_VBFTag0', # extension to add to output directory
    'year':'2018', # Use combined when merging all years in category (for plots)
    'xvar': 'CMS_hgg_mass', # not yet used, should be passed to the C++ macros
    'plotdir': '/eos/user/a/amkrishn/www/hggWidth/finalfit/bkg/bkg_newFNUF_VBFTag0/',

    # Job submission options
    'batch':'local', # [condor,SGE,IC,Rome,local]
    'queue':'cmsan' # for condor e.g. espresso
  
}
