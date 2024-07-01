# Config file: options for signal fitting

backgroundScriptCfg = {
  
    # Setup
    'inputWSDir':'/eos/user/a/amkrishn/hggWidth/mcNtuples/condor_output/forRuben/ws', # location of 'allData.root' file
    'cats':'auto', # auto: automatically inferred from input ws
    'catOffset':0, # add offset to category numbers (useful for categories from different allData.root files)  
    'ext':'2023-05-02', # extension to add to output directory
    'year':'combined', # Use combined when merging all years in category (for plots)
    'xvar': 'CMS_hgg_mass', # not yet used, should be passed to the C++ macros
    'plotdir': '/eos/user/r/rgargiul/www/index.php /eos/user/r/rgargiul/www/width_pdf/plots/',

    # Job submission options
    'batch':'local', # [condor,SGE,IC,Rome,local]
    'queue':'cmsan' # for condor e.g. espresso
  
}
