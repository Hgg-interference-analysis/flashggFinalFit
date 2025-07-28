plot1DScan.py ./runFitsVoigt_mu/profile1D_syst_Voigt_r_ggH.root \
    --y-cut 8 --y-max 8 \
    --output ./runFitsVoigt_mu/Plots/GammaH_unc_brkdwn \
    --POI GammaH \
    --translate ../Plots/pois_mu.json \
    --main-label "Total Unc." --main-color 1 \
    --others \
    ./runFitsVoigt_mu/profile1D_freezeScale_Voigt_r_ggH.root:"freeze scale":4 \
    ./runFitsVoigt_mu/profile1D_freezeScaleSS_Voigt_r_ggH.root:"freeze scale+showershape":38 \
    ./runFitsVoigt_mu/profile1D_freezeScaleSSMat_Voigt_r_ggH.root:"freeze scale+showershape+material":30 \
    ./runFitsVoigt_mu/profile1D_freezeSSSMatAlpha_Voigt_r_ggH.root:"freeze scale+showershape+material+alpha":3 \
    ./runFitsVoigt_mu/profile1D_freezeSSSMatAlphaFnuf_Voigt_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf":7 \
    ./runFitsVoigt_mu/profile1D_freezeSSSMatAlphaFnufSmear_Voigt_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf+smear":209 \
    ./runFitsVoigt_mu/profile1D_freezeSSSMatAlphaFnufSmearThu_Voigt_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf+smear+theory":46 \
    ./runFitsVoigt_mu/profile1D_statonly_Voigt_r_ggH.root:"stat. only":2 \
    --logo-sub "Preliminary" \
    --breakdown "scale,shower shape,material,alpha,FNUF,smear,theory,rest,stat"
