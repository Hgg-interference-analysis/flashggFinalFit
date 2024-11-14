#example: outdir_2023-05-02/CMS-HGG_multipdf_UntaggedTag_9.root
infile=$1
#example: pdfindex_UntaggedTag_9_13TeV
syst_name=$2
#example: 1
pdf_to_discard=$3

root $infile << EOF
  auto *mpdf = (RooMultiPdf*)multipdf->pdf("CMS_hgg_UntaggedTag_9_13TeV_bkgshape")
  int num_pdf = mpdf->getNumPdfs()
  int pdf_to_discard = $pdf_to_discard
  auto lst = RooArgList()
  for(int i=0; i<num_pdf; i++){
    if (i!=pdf_to_discard) lst.add(*mpdf->getPdf(i));
  }
  RooCategory catIndex("$syst_name","c");
  auto mpdf_mod = new RooMultiPdf(mpdf->GetName(), mpdf->GetTitle(), catIndex, lst)

  auto *ws_mod = new RooWorkspace("multipdf", "")

  auto dataset = *((RooDataSet*)multipdf->allData().front())
  ws_mod->import(dataset)
  //auto pdf_set = RooArgSet()
  //auto pdfs = multipdf->allPdfs()
  //for(int i=1; i<pdfs.getSize(); i++) pdf_set.add(*pdfs[i])
  //ws_mod->import(pdf_set)
  auto funcs = multipdf->allFunctions()
  //ws_mod->import(funcs)
  ws_mod->import(*mpdf_mod)
  ws_mod->SaveAs("prova.root")
EOF
