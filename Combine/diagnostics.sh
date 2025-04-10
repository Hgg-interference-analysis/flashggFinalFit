combine -M FitDiagnostics Datacard_all_xsec.root -n 'diagnostics' --saveShapes --saveNormalization --redefineSignalPOIs gamma,mu,mu_V --preFitValue 1 \
 -t -1 --saveOverall -m 125.38 -v 1 \
 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1,CMS_hgg_nuisance_HighR9EBRho_13TeVsmear_2016postVFP=0 \
 --setParameterRanges gamma=0.1,10 \
 --freezeParameters MH,allConstrainedNuisances \
 --cminDefaultMinimizerStrategy 0 \
 --skipBOnlyFit \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
 --X-rtd MINIMIZER_multiMin_hideConstants \
 --X-rtd MINIMIZER_multiMin_maskConstraints \
 --X-rtd MINIMIZER_multiMin_maskChannels=2 \
# --robustFit=1 --stepSize 0.01 \
# --robustFit=1 \
