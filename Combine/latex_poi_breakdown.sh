infile=$1

root $infile << EOF
  TPaveText *tp;
  for(auto obj: *((TPad*)breakdown->GetListOfPrimitives()->At(0))->GetListOfPrimitives() ) {
    if (TString(obj->GetName()).CompareTo("TPave") == 0) {
      tp = (TPaveText*)obj; break;
    }
  }
  for(int i=0; i<2; i++){
    auto tl = (TLatex*)tp->GetLine(i);
    TString title = tl->GetTitle();
    title.ReplaceAll("gamma", "#Gamma_{H}/#Gamma_{H}^{SM}");
    tl->SetTitle(title);
  }

  breakdown->SaveAs("breakdown_latex.root")
EOF
