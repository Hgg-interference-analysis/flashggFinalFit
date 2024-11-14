plot1DScan.py higgsCombine_width.total.MultiDimFit.mH125.38.root \
--main-label "Total Uncert."  \
--others \
higgsCombine_width.freeze_thu.MultiDimFit.mH125.38.root:"freeze thu":28 \
higgsCombine_width.freeze_thu_jet.MultiDimFit.mH125.38.root:"freeze thu+jet":8 \
higgsCombine_width.freeze_thu_jet_phoid.MultiDimFit.mH125.38.root:"freeze thu+jet+phoid":3 \
higgsCombine_width.freeze_thu_jet_phoid_resoshift.MultiDimFit.mH125.38.root:"freeze thu+jet+phoid+resoshift":4 \
higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root:"stat only":46 \
--output breakdown --y-max 6 --y-cut 6 --breakdown "THU,jet,phoid,reshoshift,rest,stat" \
--POI gamma
