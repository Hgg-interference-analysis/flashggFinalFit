cats=(UntaggedTag_0 UntaggedTag_1 UntaggedTag_2 UntaggedTag_3 UntaggedTag_4 UntaggedTag_5 UntaggedTag_6 UntaggedTag_7 UntaggedTag_8 UntaggedTag_9 VBFTag_0)
sigmas_${1}.csv

for cat in "${cats[@]}"; do

  f=$(cat Datacard_${1}_xsec.txt  | grep ggH_ | grep Models | grep $cat | awk -F" " '{print $4}')
  echo $f
  root -q -b -l $f -e  "double sigma = wsig_13TeV->function(\"sigma_dcb_VBF_${1}_${cat}_13TeV\")->getVal();"\
"cout << \"${cat},\" << sigma << \",\" << sqrt(sigma*sigma + 0.7e-2*0.7e-2*125*125) << \",\" << sqrt(sigma*sigma + 0.7e-2*0.7e-2*125*125)/sigma - 1 << endl;"
done
