models = {
  "mu_inclusive":"",

  "mu":"-P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel \
  --PO \"map=.*/ggH.*:r_ggH[1,0,2]\" \
  --PO \"map=.*/bbH.*:r_ggH[1,0,2]\" \
  --PO \"map=.*/qqH.*:r_VBF[1,0,3]\" \
  --PO \"map=.*/WH_had.*:r_VH[1,0,3]\" \
  --PO \"map=.*/ZH_had.*:r_VH[1,0,3]\" \
  --PO \"map=.*/vh.*:r_VH[1,0,3]\" \
  --PO \"map=.*/ggZH_had.*:r_VH[1,0,3]\" \
  --PO \"map=.*/WH_lep.*:r_VH[1,0,3]\" \
  --PO \"map=.*/ZH_lep.*:r_VH[1,0,3]\"",
  
"MH":"-P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel \
--PO \"map=.*/qqH_hgg:RV[1,-5,5]\" \
--PO \"map=.*/ggH_hgg:RF[1,-5,5]\" \
-L $CMSSW_BASE/lib/$SCRAM_ARCH/libHiggsAnalysisGBRLikelihood.so -m 125.38 higgsMassRange=122,128",

}
