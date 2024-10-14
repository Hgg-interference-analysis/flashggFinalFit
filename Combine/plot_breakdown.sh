
plot1DScan.py higgsCombine_width.total.MultiDimFit.mH125.38.root \
--main-label "Total Uncert."  \
--others \
higgsCombine_width.freeze_thu.MultiDimFit.mH125.38.root:"freeze thu":28 \
higgsCombine_width.freeze_thu_phoid.MultiDimFit.mH125.38.root:"freeze thu+phoid":2 \
higgsCombine_width.freeze_thu_phoid_brhgg.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg":3 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi":4 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi_sf.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi+sf":6 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi_sf_resoshift.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi+sf+resoshift":8 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi_sf_resoshift_trigger.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi+sf+resoshift+trigger":9 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi_sf_resoshift_trigger_scale.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi+sf+resoshift+trigger+scale":11 \
higgsCombine_width.freeze_thu_phoid_brhgg_lumi_sf_resoshift_trigger_scale_smear.MultiDimFit.mH125.38.root:"freeze thu+phoid+brhgg+lumi+sf+resoshift+trigger+scale+smear":28 \
higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root:"stat only":46 \
--output breakdown --y-max 6 --y-cut 6 --breakdown "THU,phoid,brhgg,lumi,sf,resoshift,trigger,scale,smear,rest,stat" \
--POI gamma

