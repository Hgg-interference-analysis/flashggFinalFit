plot1DScan.py ./runFitsVoigt_mu/profile1D_syst_Voigt_r_ggH.root \
    --y-cut 8 --y-max 8 \
    --output ./runFitsVoigt_mu/Plots/GammaH \
    --POI GammaH \
    --translate ../Plots/pois_mu.json \
    --main-label "Expected" --main-color 1 \
    --others \
    ./runFitsVoigt_mu/profile1D_statonly_Voigt_r_ggH.root:"Stat. only":2 \
    --logo-sub "Preliminary"