combineTool.py -M Impacts -d /afs/cern.ch/work/r/rgargiul/CMSSW_14_1_0_pre4/src/flashggFinalFit/Combine/Datacard_${1}_xsec.root \
 --freezeParameters MH -m 125.38 --setParameters gamma=1,MH=125.38,mu=1,mu_V=1 -n _${1}_prova  \
 -t -1 \
 --saveSpecifiedNuis all  --setRobustFitAlgo=Minuit2,Migrad \
                          --cminDefaultMinimizerStrategy 0 \
                         --X-rtd MINIMIZER_freezeDisassociatedParams \
                         --X-rtd MINIMIZER_multiMin_hideConstants \
                         --X-rtd MINIMIZER_multiMin_maskConstraints \
                         --X-rtd MINIMIZER_multiMin_maskChannels=2 \
--named THU_ggH_Mu_inorm,THU_ggH_Res_inorm,THU_ggH_Mig01_inorm,THU_ggH_Mig12_inorm,THU_ggH_PT60_inorm,THU_ggH_PT120_inorm,THU_ggH_qmtop_inorm,CMS_hgg_scale_gr0_shape,CMS_hgg_scale_gr1_shape,CMS_hgg_scale_gr2_shape,CMS_hgg_alphaSWeight_gr0_shape,CMS_hgg_pdfWeight_0_shape \
--doFits --parallel 12

#THU_ggH_Mu_inorm,THU_ggH_Res_inorm,THU_ggH_Mig01_inorm,THU_ggH_Mig12_inorm,THU_ggH_VBF2j_inorm,THU_ggH_VBF3j_inorm,THU_ggH_PT60_inorm,THU_ggH_PT120_inorm,THU_ggH_qmtop_inorm,CMS_hgg_scale_gr0_shape,CMS_hgg_scale_gr1_shape,CMS_hgg_scale_gr2_shape,CMS_hgg_alphaSWeight_gr0_shape,CMS_hgg_pdfWeight_0_shape
