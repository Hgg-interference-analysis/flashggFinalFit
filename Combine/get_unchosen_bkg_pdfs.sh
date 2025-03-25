indexes=""
if [ $1 == "all" ]; then
  years=(2016preVFP 2016postVFP 2017 2018)
else
  years=($1)
fi

for year in "${years[@]}"; do
  for i in $(seq 0 9); do indexes=$(echo $indexes" "pdfindex_UntaggedTag_${i}_${year}_13TeV); done
  indexes=$(echo $indexes" "pdfindex_VBFTag_0_${year}_13TeV);
done


for ind in $indexes; do
  value=$(root -q -l -b ${2} -e "limit->Scan(\"${ind}\"); exit(0)" | grep "2 " | awk -F " " '{print $4}' | head -n 1)
  category=$(echo $ind | awk -F "_" '{print $2"_"$3"_"$4}')
  echo $ind,$value,$category
  root -b -l Models/background/CMS-HGG_multipdf_${category}.root << EOF
    RooMultiPdf *mp = (RooMultiPdf*)multipdf->pdf("CMS_hgg_${category}_13TeV_bkgshape");
    for (int i=0; i<mp->getNumPdfs(); i++){
      if (i==int(${value})) continue;
      cout << "'rgx{" << mp->getPdf(i)->getTitle() << ".*}'," << endl;
    }
EOF
done
