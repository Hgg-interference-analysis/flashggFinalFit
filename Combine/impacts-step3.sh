_excluded=$(cat unchosen_bkg_pdfs_out_${1}.txt | grep "env_" | tr -d "\n")
excluded=${_excluded::-1}

echo $excluded

combineTool.py -v 1 -M Impacts -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_${1}_xsec.root \
 -m 125.38 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1 -n _${1}_prova \
-P gamma  --floatOtherPOIs 1 \
 -t -1 --setParameterRanges gamma=0,50 \
 --saveSpecifiedNuis all --setRobustFitAlgo=Minuit2,Migrad \
                          --cminDefaultMinimizerStrategy 0 \
                         --X-rtd MINIMIZER_freezeDisassociatedParams \
                         --X-rtd MINIMIZER_multiMin_hideConstants \
                         --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_multiMin_maskChannels=2 \
 --exclude ${excluded} \
--output impacts_${1}.json
