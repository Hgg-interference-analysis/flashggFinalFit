# higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root  higgsCombine_width.total.MultiDimFit.mH125.38.root

#-rw-r--r--. 1 rgargiul zh  7206 Mar 21 11:23 higgsCombine_scan_statonly_2017.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7238 Mar 21 11:23 higgsCombine_scan_statonly_2016preVFP.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7234 Mar 21 11:23 higgsCombine_scan_statonly_2016postVFP.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7211 Mar 21 11:23 higgsCombine_scan_statonly_2018.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7200 Mar 21 11:24 higgsCombine_scan_2016preVFP.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7210 Mar 21 11:24 higgsCombine_scan_2016postVFP.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7170 Mar 21 11:24 higgsCombine_scan_2017.MultiDimFit.mH125.38.root
#-rw-r--r--. 1 rgargiul zh  7177 Mar 21 11:25 higgsCombine_scan_2018.MultiDimFit.mH125.38.root

plot1DScan.py higgsCombine_width.total.MultiDimFit.mH125.38.root \
--main-label "Full Run 2"  \
--others \
higgsCombine_width.freeze_all.MultiDimFit.mH125.38.root:"Full Run 2 (stat. only)":27 \
higgsCombine_scan_2018.MultiDimFit.mH125.38.root:"2018":603 \
higgsCombine_scan_statonly_2018.MultiDimFit.mH125.38.root:"2018 (stat. only)":591 \
higgsCombine_scan_2017.MultiDimFit.mH125.38.root:"2017":634 \
higgsCombine_scan_statonly_2017.MultiDimFit.mH125.38.root:"2017 (stat. only)":623 \
higgsCombine_scan_2016postVFP.MultiDimFit.mH125.38.root:"2016postVFP":620 \
higgsCombine_scan_statonly_2016postVFP.MultiDimFit.mH125.38.root:"2016postVFP (stat. only)":607 \
higgsCombine_scan_2016preVFP.MultiDimFit.mH125.38.root:"2016postVFP":810 \
higgsCombine_scan_statonly_2016preVFP.MultiDimFit.mH125.38.root:"2016preVFP (stat. only)":801 \
--output all_scans --y-max 6 --y-cut 6 \
--POI gamma #"#Gamma_{H}/#Gamma_{H}^{SM}"

rm all_scans.png
rm all_scans.pdf

root all_scans.root << EOF
  TPaveText *tp;
  for(auto obj: *((TPad*)all_scans->GetListOfPrimitives()->At(0))->GetListOfPrimitives() ) {
    if (TString(obj->GetName()).CompareTo("TPave") == 0) {
      tp = (TPaveText*)obj; break;
    }
  }
  for(int i=0; i<10; i++){
    auto tl = (TLatex*)tp->GetLine(i);
    TString title = tl->GetTitle();
    title.ReplaceAll("gamma", "#Gamma_{H}/#Gamma_{H}^{SM}");
    tl->SetTitle(title);
  }

  all_scans->SaveAs("all_scans_latex.root")
EOF
