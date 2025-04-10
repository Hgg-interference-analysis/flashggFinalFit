#!/bin/bash

combine -M MultiDimFit -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_2016preVFP_xsec.root \
--floatOtherPOIs 0 -t -0 -n _profile1D_syst_xsec_mass --algo singles -P MH  -m 125.38 \
--setParameters MH=125.38,mu=1 \
--setParameterRanges MH=123,127 --X-rtd FITTER_NEW_CROSSING_ALGO --X-rtd FITTER_BOUND --saveSpecifiedNuis all \
--saveInactivePOI 1 --cminDefaultMinimizerStrategy 0  \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
--X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2
