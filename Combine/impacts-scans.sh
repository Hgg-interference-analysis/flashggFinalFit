if [ $1 == "all" ]; then
  years=(2016preVFP 2016postVFP 2017 2018)
else
  years=($1)
fi

indexes="pdfindex_UntaggedTag_0_${years[0]}_13TeV"
for year in "${years[@]}"; do
  for i in $(seq 0 9); do indexes=$(echo $indexes","pdfindex_UntaggedTag_${i}_${year}_13TeV); done
  indexes=$(echo $indexes","pdfindex_VBFTag_0_${year}_13TeV);
done

combine -M MultiDimFit Datacard_${1}_xsec.root -n _scan_singles_${1} \
 --floatOtherPOIs 1 -t -1 -m 125.38 -v 1 --points 50 -P gamma \
 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1 \
 --setParameterRanges gamma=-0.1,9.9 \
 --cminDefaultMinimizerStrategy 0 \
 --saveSpecifiedIndex=$indexes \
 --algo singles \
 --X-rtd MINIMIZER_freezeDisassociatedParams \
 --X-rtd MINIMIZER_multiMin_hideConstants \
 --X-rtd MINIMIZER_multiMin_maskConstraints \
 --X-rtd MINIMIZER_multiMin_maskChannels=2 \

source get_unchosen_bkg_pdfs.sh ${1} higgsCombine_scan_singles_${1}.MultiDimFit.mH125.38.root > unchosen_bkg_pdfs_out.txt

_excluded=$(cat unchosen_bkg_pdfs_out.txt | grep "env_" | tr -d "\n")
excluded=${_excluded::-1}

combineTool.py -M Impacts -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_${1}_xsec.root \
 -m 125.38 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1 -n _${1}_prova  \
 -t -1 \
 --saveSpecifiedNuis all  --setRobustFitAlgo=Minuit2,Migrad \
                          --cminDefaultMinimizerStrategy 0 \
                         --exclude $excluded \
                         --X-rtd MINIMIZER_freezeDisassociatedParams \
                         --X-rtd MINIMIZER_multiMin_hideConstants \
                         --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_multiMin_maskChannels=2 \
--doFits --parallel 12

#,CMS_hgg_nuisance_NonLinearity_13TeVscale,CMS_hgg_nuisance_IntNorm_13TeVscaleCorr,CMS_hgg_nuisance_HighR9EBPhi_13TeVsmear_2018,CMS_hgg_nuisance_ShowerShapeHighR9EB_13TeVscaleCorr \
