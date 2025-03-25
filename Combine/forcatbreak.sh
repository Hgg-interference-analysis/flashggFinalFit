#!/bin/bash

combine -M MultiDimFit -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_${1}_xsec.root \
--floatOtherPOIs 1 -t -1 -n _profile1D_syst_xsec_gamma --algo grid -P gamma --points 200 -m 125.38 \
--setParameters MH=125.38 \
--setParameterRanges gamma=0,4 --X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all \
--saveInactivePOI 1 --cminDefaultMinimizerStrategy 0  \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
--X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2
