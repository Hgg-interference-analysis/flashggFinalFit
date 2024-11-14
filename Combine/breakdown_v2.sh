#https://cms-analysis.github.io/HiggsAnalysis-CombinedLimit/latest/part3/nonstandard/?h=impacts#breakdown-of-uncertainties

#step2
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_xsec.root \
--floatOtherPOIs 1 -t -1 -n _width.postfit -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 --X-rtd FITTER_NEW_CROSSING_ALGO \
--X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   --cminDefaultMinimizerStrategy 0 \
--X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --saveWorkspace

#step3
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -n _width.total -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 --setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 \
--setParameterRanges gamma=0,25 --X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1 \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit

#freezing
combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU -n _width.freeze_thu

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,jet -n _width.freeze_thu_jet

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,jet,phoid -n _width.freeze_thu_jet_phoid

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --freezeParameters MH --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeNuisanceGroups THU,jet,phoid,resoshift -n _width.freeze_thu_jet_phoid_resoshift

combine -M MultiDimFit -m 125.38 \
-d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/higgsCombine_width.postfit.MultiDimFit.mH125.38.root \
--floatOtherPOIs 1 -t -1 -P gamma --algo grid --points 26 --alignEdges 1 -v 1 \
--setParameters gamma=1,MH=125.38,pdfindex_UntaggedTag_9_13TeV=2 --setParameterRanges gamma=0,25 \
--X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all --saveInactivePOI 1   \
--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants \
--X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2  --snapshotName MultiDimFit \
--freezeParameters MH,allConstrainedNuisances -n _width.freeze_all

