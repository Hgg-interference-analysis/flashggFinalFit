#https://cms-analysis.github.io/HiggsAnalysis-CombinedLimit/latest/part3/nonstandard/?h=impacts#breakdown-of-uncertainties

#step2
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_all_xsec.root \
--floatOtherPOIs 1 -t -1 -n _width.postfit -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,mu=1,mu_V=1,MH=125.38 --setParameterRanges gamma=0.2,10.21 \
--saveSpecifiedNuis all --saveInactivePOI 1   --cminDefaultMinimizerStrategy 0 \
--X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --saveWorkspace

#step3
combine -M MultiDimFit -m 125.38 \
 -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
 --floatOtherPOIs 1 -t -1 -n _width.total -P gamma --algo grid --points 25 --alignEdges 1 -v 1 --setParameters gamma=1,MH=125.38 \
 --setParameterRanges gamma=0.2,10.2 \
 --saveSpecifiedNuis all --saveInactivePOI 1 \
 --cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
 --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm -n _width.freeze_intnorm &


combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm,HighR9Smear -n _width.freeze_intnorm_highr9smear &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm,HighR9Smear,LowR9Smear -n _width.freeze_intnorm_highr9smear_lowr9smear &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm,HighR9Smear,LowR9Smear,FNUF -n _width.freeze_intnorm_highr9smear_lowr9smear_fnuf &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm,HighR9Smear,LowR9Smear,FNUF,Material -n _width.freeze_intnorm_highr9smear_lowr9smear_fnuf_material &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid  --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups IntNorm,HighR9Smear,LowR9Smear,FNUF,Material,ShowerShape -n _width.freeze_intnorm_highr9smear_lowr9smear_fnuf_material_ss &

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 25 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0.2,10.2:CMS_hgg_nuisance_IntNorm_13TeVscaleCorr=-1,1 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeParameters allConstrainedNuisances -n _width.freeze_all &
