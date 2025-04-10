root -l -b $1 << EOF
  tagsDumper->cd()
  trees->cd()

  TString cats[11];
  for (int i=0; i<10; i++) cats[i] = Form("UntaggedTag_%i", i);
  cats[10] = "VBFTag_0";

  TString syst[3] = {
    "MaterialCentralBarrel",
    "MaterialOuterBarrel",
    "MaterialForward"
  };


  for (int i=0; i<11; i++) {
    for (int j=0; j<3; j++) {
      gInterpreter->ProcessLine(Form("ggh_125_13TeV_%s_%sDown01sigma->Draw(\"mass>>%s_%s_down(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), syst[j].Data(), cats[i].Data(), syst[j].Data()));
      gInterpreter->ProcessLine(Form("%s_%s_down->SaveAs(\"%s_%sdown.root\")", cats[i].Data(), syst[j].Data(), cats[i].Data(), syst[j].Data()));
      gInterpreter->ProcessLine(Form("ggh_125_13TeV_%s_%sUp01sigma->Draw(\"mass>>%s_%s_up(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), syst[j].Data(), cats[i].Data(), syst[j].Data()));
      gInterpreter->ProcessLine(Form("%s_%s_up->SaveAs(\"%s_%s_up.root\")", cats[i].Data(), syst[j].Data(), cats[i].Data(), syst[j].Data()));
    }
    gInterpreter->ProcessLine(Form("ggh_125_13TeV_%s->Draw(\"mass>>%s_nominal(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), cats[i].Data()));
    gInterpreter->ProcessLine(Form("%s_nominal->SaveAs(\"%s_nominal.root\")", cats[i].Data(), cats[i].Data()));

  }

EOF
