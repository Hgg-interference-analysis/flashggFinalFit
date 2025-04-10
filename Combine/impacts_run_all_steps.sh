source impacts-initial-step1.sh $1
source impacts-scans.sh $1
source impacts-step3.sh $1
plotImpacts.py -i impacts_${1}.json -o impacts_${1}
