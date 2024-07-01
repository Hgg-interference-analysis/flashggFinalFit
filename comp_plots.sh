cd /eos/user/r/rgargiul/amrutha_ws/

root -l $1 << EOF

    tagsDumper->cd()

    auto *nom = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0")->createHistogram("CMS_hgg_mass")
    auto *up = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0_SigmaEOverEShiftUp01sigma")->createHistogram("CMS_hgg_mass")
    auto *down = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0_SigmaEOverEShiftDown01sigma")->createHistogram("CMS_hgg_mass")

    up->SetName("up_$2")
    down->SetName("down_$2")
    nom->SetName("nom_$2")

    up->Reset()
    down->Reset()
    nom->Reset()

    for(int i=0; i<9; i++)
      up->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_UntaggedTag_%i_SigmaEOverEShiftUp01sigma", i))->createHistogram("CMS_hgg_mass"));
    for(int i=0; i<9; i++)
      down->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_UntaggedTag_%i_SigmaEOverEShiftDown01sigma", i))->createHistogram("CMS_hgg_mass"));
    for(int i=0; i<9; i++)
      nom->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_UntaggedTag_%i", i))->createHistogram("CMS_hgg_mass"));

    up->SaveAs("up_$2.root")
    down->SaveAs("down_$2.root")
    nom->SaveAs("nom_$2.root")

    new TCanvas("c", "c")
    up_s->Scale(nom_s->Integral()/up_s->Integral())
    down_s->Scale(nom_s->Integral()/down_s->Integral())
    up_s->Divide(nom_s)
    down_s->Divide(nom_s)
    nom_si->Divide(nom_s)
    up_s->Draw()
    down_s->Draw("same")
    nom_si->Draw("same")

    TLegend l
    l.AddEntry(up_s, "SigmaEOverEShift_Up_Signal / Signal")
    l.AddEntry(down_s, "SigmaEOverEShift_Down_Signal / Signal")
    l.AddEntry(nom_si, "(Signal+Interference) / Signal")
    l.Draw()

    c.SaveAs("/eos/user/r/rgargiul/www/comp_plot.root")

EOF
