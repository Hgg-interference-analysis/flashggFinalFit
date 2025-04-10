plot1DScan.py higgsCombine_width.total.MultiDimFit.mH125.38.root \
--main-label "Total Uncert."  \
--others \
higgsCombine_width.freeze_nonlinearity.MultiDimFit.mH125.38.root:"1st - freeze also nonlinearity":27 \
higgsCombine_width.freeze_nonlinearity_material.MultiDimFit.mH125.38.root:"2nd - freeze also material":8 \
higgsCombine_width.freeze_nonlinearity_material_intnorm.MultiDimFit.mH125.38.root:"3rd - freeze also intnorm":3 \
higgsCombine_width.freeze_nonlinearity_material_intnorm_smear.MultiDimFit.mH125.38.root:"4th - freeze also smear":4 \
higgsCombine_width.freeze_nonlinearity_material_intnorm_smear_fnuf.MultiDimFit.mH125.38.root:"5th - freeze also FNUF":4 \
higgsCombine_width.freeze_nonlinearity_material_intnorm_smear_fnuf_ss.MultiDimFit.mH125.38.root:"6th - freeze also ShowerShape":42 \
higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root:"stat only":46 \
--output breakdown --y-max 6 --y-cut 6 --breakdown "nonlinearity,Material,IntNorm,Smear,FNUF,ShowerShape,rest,stat" \
--POI gamma

