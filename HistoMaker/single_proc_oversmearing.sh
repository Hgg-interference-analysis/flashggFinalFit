filename=$1
year=$2
proc=$3
proc_name_in_tree=$4

root -l -b $1 << EOF
  tagsDumper->cd()
  trees->cd()

  //pho1_full5x5_r9

  TString cats[11];
  for (int i=0; i<10; i++) cats[i] = Form("UntaggedTag_%i", i);
  cats[10] = "VBFTag_0";

  for (int i=0; i<11; i++) {
    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearHighR9EBRhoUp01sigma->SetAlias(\"rng\",\"sin(2*3.1416*rndm)*sqrt(-2*log(rndm))\")", cats[i].Data()));


    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearHighR9EBRhoDown01sigma->Draw(\"mass>>%s_highr9EBsmeardown_nosmear(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), cats[i].Data()));
    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearHighR9EBRhoUp01sigma->Draw(\"sqrt(2*pho1_pt*(1 + 0.7*rng*1e-2*(pho1_pt > 50)*(pho1_full5x5_r9 > 0.96))*pho2_pt*(1 + 0.7*rng*1e-2*(pho2_pt > 50)*(pho2_full5x5_r9 > 0.96))*(cosh(pho1_eta-pho2_eta)-cos(pho1_phi-pho2_phi)))>>%s_highr9EBsmearup_smeared7permille_pt_gt_50(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), cats[i].Data()) );

  gInterpreter->ProcessLine(Form("%s_highr9EBsmearup_smeared7permille_pt_gt_50->SaveAs(\"%s_${year}_${proc}_highr9EBsmearup_smeared7permille_pt_gt_50.root\")", cats[i].Data(), cats[i].Data()));
  gInterpreter->ProcessLine(Form("%s_highr9EBsmeardown_nosmear->SaveAs(\"%s_${year}_${proc}_highr9EBsmeardown_nosmear.root\")", cats[i].Data(), cats[i].Data()));

    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearLowR9EBRhoUp01sigma->SetAlias(\"rng\",\"sin(2*3.1416*rndm)*sqrt(-2*log(rndm))\")", cats[i].Data()));

    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearLowR9EBRhoDown01sigma->Draw(\"mass>>%s_lowr9EBsmeardown_nosmear(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), cats[i].Data()));
    gInterpreter->ProcessLine(Form("${proc_name_in_tree}_125_13TeV_%s_MCSmearLowR9EBRhoUp01sigma->Draw(\"sqrt(2*pho1_pt*(1 + 0.7*rng*1e-2*(pho1_pt > 50)*(pho1_full5x5_r9 < 0.96))*pho2_pt*(1 + 0.7*rng*1e-2*(pho2_pt > 50)*(pho2_full5x5_r9 > 0.96))*(cosh(pho1_eta-pho2_eta)-cos(pho1_phi-pho2_phi)))>>%s_lowr9EBsmearup_smeared7permille_pt_gt_50(320, 100, 180)\", \"weight\", \"goff\")", cats[i].Data(), cats[i].Data()) );

  gInterpreter->ProcessLine(Form("%s_lowr9EBsmearup_smeared7permille_pt_gt_50->SaveAs(\"%s_${year}_${proc}_lowr9EBsmearup_smeared7permille_pt_gt_50.root\")", cats[i].Data(), cats[i].Data()));
  gInterpreter->ProcessLine(Form("%s_lowr9EBsmeardown_nosmear->SaveAs(\"%s_${year}_${proc}_lowr9EBsmeardown_nosmear.root\")", cats[i].Data(), cats[i].Data()));

  }

EOF
