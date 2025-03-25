cats=(UntaggedTag_0 UntaggedTag_1 UntaggedTag_2 UntaggedTag_3 UntaggedTag_4 UntaggedTag_5 UntaggedTag_6 UntaggedTag_7 UntaggedTag_8 UntaggedTag_9 VBFTag_0)
echo "cat,a1,n1" > a1_n1_centralvalues.csv

for cat in "${cats[@]}"; do

  root -q -b -l $(cat Datacard_xsec.txt  | grep ggh_ | grep Models | grep $cat | awk -F" " '{print $4}') -e \
  "cout << \"${cat},\" << wsig_13TeV->function(\"a1_dcb_GG2HPLUSINT_2018_${cat}_13TeV\")->getVal() << \",\""\
"<< wsig_13TeV->function(\"n1_dcb_GG2HPLUSINT_2018_${cat}_13TeV\")->getVal() << endl;"\
  | grep "${cat}," >> a1_n1_centralvalues.csv

done
