plot1DScan.py higgsCombine_width.total.MultiDimFit.mH125.38.root \
--main-label "Total Uncert."  \
--others \
higgsCombine_width.freeze_intnorm.MultiDimFit.mH125.38.root:"1st - freeze also IntNorm":27 \
higgsCombine_width.freeze_intnorm_highr9smear.MultiDimFit.mH125.38.root:"2nd - freeze also HighR9EBSmear":8 \
higgsCombine_width.freeze_intnorm_highr9smear_lowr9smear.MultiDimFit.mH125.38.root:"3rd - freeze also LowR9EBSmear":3 \
higgsCombine_width.freeze_intnorm_highr9smear_lowr9smear_fnuf.MultiDimFit.mH125.38.root:"4th - freeze also FNUF":4 \
higgsCombine_width.freeze_intnorm_highr9smear_lowr9smear_fnuf_material.MultiDimFit.mH125.38.root:"5th - freeze also Material":4 \
higgsCombine_width.freeze_intnorm_highr9smear_lowr9smear_fnuf_material_ss.MultiDimFit.mH125.38.root:"6th - freeze also ShowerShape":42 \
higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root:"stat only":46 \
--output breakdown --y-max 6 --y-cut 6 --breakdown "IntNorm,HighR9Smear,LowR9Smear,FNUF,Material,ShowerShape,rest,stat" \
--POI gamma

