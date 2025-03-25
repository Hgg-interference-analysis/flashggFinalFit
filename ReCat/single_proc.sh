root -l -b $1 << EOF
  tagsDumper->cd()
  trees->cd()
  double mass[161];
  for (int i=0; i<161; i++) mass[i] = 100+0.5*i;
  double pt[26];
  for (int i=0; i<20; i++) pt[i] = 15+5*i;
  pt[20] = 150
  pt[21] = 200
  pt[22] = 250
  pt[20] = 120
  pt[21] = 130
  pt[22] = 140
  pt[23] = 150
  pt[24] = 160
  pt[25] = 3000
  double mva[46]
  for (int i=5; i<46; i++) mva[i] = 0.6 + (1-0.6)/40 * (i-5);
  mva[0] = -1;
  mva[1] = -0.5;
  mva[2] = 0;
  mva[3] = 0.3;
  mva[4] = 0.5
  mass
  pt
  mva
  new TH3F("h_0", "h_0", 160, mass, 25, pt, 45, mva)
  $2_13TeV_UntaggedTag_0->Draw("diphoton_mva:diphoton_pt:mass>>h_0", "weight", "goff")

  h_0->SaveAs("$3_th3_recat.root")

EOF
