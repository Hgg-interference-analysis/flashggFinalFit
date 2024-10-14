#https://cms-analysis.github.io/HiggsAnalysis-CombinedLimit/latest/part3/nonstandard/?h=impacts#breakdown-of-uncertainties

#step2
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_xsec.root \
--floatOtherPOIs 1 -t -1 -n _width.postfit -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 --X-rtd FITTER_NEW_CROSSING_ALGO \
--X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   --cminDefaultMinimizerStrategy 0 \
--X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--freezeNuisanceGroups THU --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --saveWorkspace

#step3
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -n _width.total -P gamma --algo grid --points 51 --alignEdges 1 -v 1 --setParameters gamma=1,MH=125.38 \
--setParameterRanges gamma=0,50 --X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1 \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--freezeNuisanceGroups THU --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit

#freezing
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid -n _width.freeze_phoid

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg -n _width.freeze_phoid_brhgg

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi -n _width.freeze_phoid_brhgg_lumi

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi,sf -n _width.freeze_phoid_brhgg_lumi_sf

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi,sf,resoshift -n _width.freeze_phoid_brhgg_lumi_sf_resoshift

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi,sf,resoshift,trigger -n _width.freeze_phoid_brhgg_lumi_sf_resoshift_trigger

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi,sf,resoshift,trigger,scale -n _width.freeze_phoid_brhgg_lumi_sf_resoshift_trigger_scale

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,phoid,brhgg,lumi,sf,resoshift,trigger,scale,smear -n _width.freeze_phoid_brhgg_lumi_sf_resoshift_trigger_scale_smear

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 51 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38 --setParameterRanges gamma=0,50 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeParameters allConstrainedNuisances -n _width.freeze_all
