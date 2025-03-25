combine -M FastScan Datacard_2018_xsec.root -n 'scan' --redefineSignalPOIs gamma,mu,mu_V \
 --floatOtherPOIs 0 -t -1 -m 125.38 -v 4 --points 10 -P gamma \
 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1,pdfindex_UntaggedTag_0_2018_13TeV=4 \
 --setParameterRanges gamma=0.5,1.5 \
 --freezeParameters mu,mu_V,MH,allConstrainedNuisances,pdfindex_UntaggedTag_0_2018_13TeV,env_pdf_0_2018_13TeV_exp3_f1,env_pdf_0_2018_13TeV_exp3_p1,env_pdf_0_2018_13TeV_exp3_p2,\
env_pdf_0_2018_13TeV_bern2_p0,env_pdf_0_2018_13TeV_bern2_p1,env_pdf_0_2018_13TeV_bern3_p0,env_pdf_0_2018_13TeV_bern3_p1,env_pdf_0_2018_13TeV_bern3_p2,env_pdf_0_2018_13TeV_bern4_p0,\
env_pdf_0_2018_13TeV_bern4_p1,env_pdf_0_2018_13TeV_bern4_p2,env_pdf_0_2018_13TeV_bern4_p3,env_pdf_0_2018_13TeV_exp1_p1,env_pdf_0_2018_13TeV_lau1_l1,env_pdf_0_2018_13TeV_pow1_p1,\
shapeBkg_bkg_mass_UntaggedTag_0_2018__norm \
 --robustFit=1 --stepSize 0.01 \
 --cminDefaultMinimizerStrategy 2 \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
 --X-rtd MINIMIZER_multiMin_hideConstants \
 --X-rtd MINIMIZER_multiMin_maskConstraints \
 --X-rtd MINIMIZER_multiMin_maskChannels=2 \
 --algo grid
# --robustFit=1 \
