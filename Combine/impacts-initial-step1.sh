combineTool.py -v 1 -M Impacts -d /afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Combine/Datacard_xsec.root \
-m 125.38 --setParameters gamma=1 -n prova \
--redefineSignalPOIs gamma \
--floatOtherPOIs 0 --saveInactivePOI 1 -t -1  \
 --saveSpecifiedNuis all --setRobustFitAlgo=Minuit2,Migrad \
                          --cminDefaultMinimizerStrategy 0 \
                         --X-rtd MINIMIZER_freezeDisassociatedParams \
                         --X-rtd MINIMIZER_multiMin_hideConstants \
                         --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_multiMin_maskChannels=2 \
--doInitialFit

