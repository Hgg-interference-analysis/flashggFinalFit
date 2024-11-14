systematics=("FNUFEB" "SigmaEOverEShift")

root -l /eos/user/r/rgargiul/dataHggWidth/ws_postVBFcat_noVBFGGFmix/output_GluGluHToGGplusint_M125_sherpa_placeholderpythia8_GG2HPLUSINT.root << EOF

    tagsDumper->cd()
    auto *nom = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0")->createHistogram("CMS_hgg_mass")
    nom->SetName("nom_si")

    nom->Reset()

    for(int i=0; i<11; i++){
      TString category;
      if (i==10)  category = "VBFTag_0";
      else        category = Form("UntaggedTag_%i", i);
      nom->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_%s", category.Data()))->createHistogram("CMS_hgg_mass"));
    }

    nom->SaveAs("nom_si.root")

EOF

root -l /eos/user/r/rgargiul/dataHggWidth/ws_postVBFcat_noVBFGGFmix/output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8_GG2H.root << EOF

    tagsDumper->cd()
    auto *nom = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0")->createHistogram("CMS_hgg_mass")
    nom->SetName("nom_s")

    nom->Reset()

    for(int i=0; i<11; i++){
      TString category;
      if (i==10)  category = "VBFTag_0";
      else        category = Form("UntaggedTag_%i", i);
      nom->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_%s", category.Data()))->createHistogram("CMS_hgg_mass"));
    }

    nom->SaveAs("nom_s.root")

EOF

for syst in ${systematics[@]}; do

  root -l /eos/user/r/rgargiul/dataHggWidth/ws_postVBFcat_noVBFGGFmix/output_GluGluHToGG_M125_TuneCP5_13TeV-amcatnloFXFX-pythia8_GG2H.root << EOF

      tagsDumper->cd()

      auto *up = cms_hgg_13TeV->data("ggh_125_13TeV_UntaggedTag_0")->createHistogram("CMS_hgg_mass")
      auto *down = (TH1*)up->Clone();

      TString systematic = "$syst";

      up->SetName("up")
      down->SetName("down")

      up->Reset()
      down->Reset()

      for(int i=0; i<11; i++){
        TString category;
        if (i==10)  category = "VBFTag_0";
        else        category = Form("UntaggedTag_%i", i);
        up->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_%s_%sUp01sigma", category.Data(), systematic.Data()))->createHistogram("CMS_hgg_mass"));
        down->Add(cms_hgg_13TeV->data(Form("ggh_125_13TeV_%s_%sDown01sigma", category.Data(), systematic.Data()))->createHistogram("CMS_hgg_mass"));
      }

      cout << "eccomi" << endl;
      up->SaveAs(Form("up_%s.root", systematic.Data()))
      down->SaveAs(Form("down_%s.root", systematic.Data()))

EOF

  hadd -f    comp_$syst.root     nom_s.root nom_si.root up_$syst.root down_$syst.root

  root -l comp_$syst.root << EOF

      new TCanvas("c", "c")

      gStyle->SetOptStat(0)
      gStyle->SetOptTitle(0);

      up->Scale(nom_s->Integral()/up->Integral())
      down->Scale(nom_s->Integral()/down->Integral())

      up->Divide(nom_s)
      down->Divide(nom_s)
      nom_si->Divide(nom_s)

      up->Draw()
      down->Draw("same")
      nom_si->Draw("same")

      TLegend l(.15, .15, .5, .35)
      l.AddEntry(up, "$syst_Up_Signal / Signal")
      l.AddEntry(down, "$syst_Down_Signal / Signal")
      l.AddEntry(nom_si, "(Signal+Interference) / Signal")
      l.Draw()

      up->GetXaxis()->SetTitle("m_{#gamma #gamma}")
      up->GetXaxis()->SetRangeUser(110, 140)
      up->GetYaxis()->SetRangeUser(0, 2)

      up->SetMarkerStyle(21)
      up->SetMarkerColor(kGreen+3)

      down->SetMarkerStyle(21)
      down->SetMarkerColor(kRed+3)

      nom_si->SetMarkerStyle(21)
      nom_si->SetMarkerColor(kBlue+2)

      up->SetLineColor(kGreen+3)
      down->SetLineColor(kRed+3)
      nom_si->SetLineColor(kBlue+2)

      up->SetLineWidth(2)
      down->SetLineWidth(2)
      nom_si->SetLineWidth(2)

      c->SaveAs("/eos/user/r/rgargiul/www/width_pdf/comp_plots/$syst.root")
      c->SaveAs("/eos/user/r/rgargiul/www/width_pdf/comp_plots/$syst.pdf")

EOF

done
