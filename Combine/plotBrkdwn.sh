plot1DScan.py ./runFitsVoigt_mu/profile1D_syst_Voigt_r_ggH.root \
    --y-cut 8 --y-max 8 \
    --output ./runFitsVoigt_mu/Plots/GammaH_unc_brkdwn \
    --POI GammaH \
    --translate ../Plots/pois_mu.json \
    --main-label "Total Unc." --main-color 1 \
    --others \
    ./runFitsVoigt_mu/profile1D_freezeMat_Voigt_r_ggH.root:"1.freeze material":4 \
    ./runFitsVoigt_mu/profile1D_freezeMatSmear_Voigt_r_ggH.root:"2.freeze also smear":30 \
    ./runFitsVoigt_mu/profile1D_freezeMatSmearScale_Voigt_r_ggH.root:"3.freeze also scale":3 \
    ./runFitsVoigt_mu/profile1D_freezeMatSSfnuf_Voigt_r_ggH.root:"4.freeze also fnuf":7 \
    ./runFitsVoigt_mu/profile1D_freezeMatSSfnufSS_Voigt_r_ggH.root:"5.freeze also showershape":209 \
    ./runFitsVoigt_mu/profile1D_freezeMatSSfnufSSthu_Voigt_r_ggH.root:"6.freeze also theory":46 \
    ./runFitsVoigt_mu/profile1D_freezeMatSSfnufSSthuAlpha_Voigt_r_ggH.root:"7.freeze alpha":38 \
    ./runFitsVoigt_mu/profile1D_statonly_Voigt_r_ggH.root:"stat. only":2 \
    --logo-sub "Preliminary" \
    --breakdown "material,smear,scale,FNUF,shower shape,theory,alpha,rest,stat"
