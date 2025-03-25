combine -M FitDiagnostics Datacard_2018_xsec.root -n 'diagnostics' --saveShapes --saveNormalization --redefineSignalPOIs gamma,mu,mu_V --preFitValue 1 \
 -t -1 --saveOverall -m 125.38 -v 4 --minos all \
 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1,pdfindex_UntaggedTag_0_2018_13TeV=4 \
 --setParameterRanges gamma=0.1,10 \
 --freezeParameters mu,mu_V,MH,allConstrainedNuisances,,pdfindex_UntaggedTag_0_2018_13TeV,env_pdf_0_2018_13TeV_exp3_f1,env_pdf_0_2018_13TeV_exp3_p1,env_pdf_0_2018_13TeV_exp3_p2,\
env_pdf_0_2018_13TeV_bern2_p0,env_pdf_0_2018_13TeV_bern2_p1,env_pdf_0_2018_13TeV_bern3_p0,env_pdf_0_2018_13TeV_bern3_p1,env_pdf_0_2018_13TeV_bern3_p2,env_pdf_0_2018_13TeV_bern4_p0,\
env_pdf_0_2018_13TeV_bern4_p1,env_pdf_0_2018_13TeV_bern4_p2,env_pdf_0_2018_13TeV_bern4_p3,env_pdf_0_2018_13TeV_exp1_p1,env_pdf_0_2018_13TeV_lau1_l1,env_pdf_0_2018_13TeV_pow1_p1,\
shapeBkg_bkg_mass_UntaggedTag_0_2018__norm \
 --cminDefaultMinimizerStrategy 0 \
 --skipBOnlyFit \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
 --X-rtd MINIMIZER_multiMin_hideConstants \
 --X-rtd MINIMIZER_multiMin_maskConstraints \
 --X-rtd MINIMIZER_multiMin_maskChannels=2 \
# --robustFit=1 --stepSize 0.01 \
# --robustFit=1 \
