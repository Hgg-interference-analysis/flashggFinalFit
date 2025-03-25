#!/bin/bash

combine -M MultiDimFit -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_${1}_xsec.root -v 3 \
--floatOtherPOIs 0 -t 0 -n _paramFit_prova_${2} --algo none --redefineSignalPOIs gamma,mu,mu_V -P ${2} --points 20 -m 125.38 \
--setParameters MH=125.38,gamma=1,mu=1,mu_V=1 --setParameterRanges gamma=0.15,2.15 \
--robustFit=1 \
--saveSpecifiedNuis all --saveInactivePOI 1 \
 --freezeParameters allConstrainedNuisances \
 --cminDefaultMinimizerStrategy 0
# --X-rtd MINIMIZER_freezeDisassociatedParams \
#--X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 \
# --freezeParameters MH,allConstrainedNuisances
