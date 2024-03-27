# Introduce mass shift

Basic script which reads in a signal model workspace that finalfits produces and adds a shift to the mean of the signal PDF based on GammaH (template provided by Charlotte).

[Notes](https://seasoned-aries-371.notion.site/ggH-Interference-Width-d0765a41d27e40b59141cd806617333b?pvs=4) by Charlotte. 

Example command to run the script: `python introduce_shift.py --inputWS CMS-HGG_sigfit_SplitUncert_TauID_fix_2016_HHggTauTaukl1_2016_SR1.root --cat UntaggedTag_0`