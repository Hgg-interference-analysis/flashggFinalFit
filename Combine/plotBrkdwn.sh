plot1DScan.py runFitsfullRun2_final_mu/profile1D_syst_fullRun2_final_r_ggH.root \
    --y-cut 10 --y-max 10 \
    --output runFitsfullRun2_final_mu/Plots/GammaH_unc_brkdwn_ggh \
    --POI GammaH \
    --translate ../Plots/pois_mu.json \
    --main-label "Total Unc." --main-color 1 \
    --others \
    runFitsfullRun2_final_mu/profile1D_freezeScale_fullRun2_final_r_ggH.root:"freeze scale":4 \
    runFitsfullRun2_final_mu/profile1D_freezeScaleSS_fullRun2_final_r_ggH.root:"freeze scale+showershape":38 \
    runFitsfullRun2_final_mu/profile1D_freezeScaleSSMat_fullRun2_final_r_ggH.root:"freeze scale+showershape+material":30 \
    runFitsfullRun2_final_mu/profile1D_freezeSSSMatAlpha_fullRun2_final_r_ggH.root:"freeze scale+showershape+material+alpha":3 \
    runFitsfullRun2_final_mu/profile1D_freezeSSSMatAlphaFnuf_fullRun2_final_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf":7 \
    runFitsfullRun2_final_mu/profile1D_freezeSSSMatAlphaFnufSmear_fullRun2_final_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf+smear":209 \
    runFitsfullRun2_final_mu/profile1D_freezeSSSMatAlphaFnufSmearThu_fullRun2_final_r_ggH.root:"freeze scale+showershape+material+alpha+fnuf+smear+theory":46 \
    runFitsfullRun2_final_mu/profile1D_statonly_fullRun2_final_r_ggH.root:"stat. only":2 \
    --logo-sub "Preliminary" \
    --breakdown "scale,shower shape,material,alpha,FNUF,smear,theory,rest,stat"
