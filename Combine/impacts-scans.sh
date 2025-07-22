#!/bin/sh                                                                                                                                                                                                
cd /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src
cmsenv
echo "cmsenv done!"
source /cvmfs/cms.cern.ch/cmsset_default.sh
cd /afs/cern.ch/user/a/amkrishn/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine
echo "in Combine"
if [ $1 -eq 0 ]; then
echo "Running combineTool.py..."
combineTool.py -v 0 -M Impacts -d Datacard_Voigt.root \
-m 125.38 --setParameters GammaH=0.004,MH=125.38,r_ggH=1.0,r_VBF=1.0,r_VH=1.0 --setParameterRanges GammaH=0.0,0.8 \
--redefineSignalPOIs GammaH \
 -t -1 \
 --saveSpecifiedNuis all \
 --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_freezeDisassociatedParams \
                         --X-rtd MINIMIZER_multiMin_hideConstants \
                         --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_multiMin_maskChannels=2 \
			 --exclude 'rgx{env.*}' --parallel 12 \
--doFits
fi
echo "Job finished"
