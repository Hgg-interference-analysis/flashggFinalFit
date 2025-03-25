#!/bin/bash

YEAR=2018
STEP=0

usage(){
    echo "The script runs background scripts:"
    echo "options:"
    
    echo "-h|--help) "
    echo "-y|--year) "
    echo "-s|--step) "
    echo "-d|--dryRun) "
}
# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -u -o s:y:dh -l help,step:,year:,dryRun -- "$@")
then
# something went wrong, getopt will put out an error message for us
exit 1
fi
set -- $options
while [ $# -gt 0 ]
do
case $1 in
-h|--help) usage; exit 0;;
-y|--year) YEAR=$2; shift ;;
-s|--step) STEP=$2; shift ;;
-d|--dryRun) DR=$2; shift ;;
(--) shift; break;;
(-*) usage; echo "$0: error - unrecognized option $1" 1>&2; usage >> /dev/stderr; exit 1;;
(*) break;;
esac
shift
done

DROPT=""
if [[ $DR ]]; then
    DROPT=" --dryRun "
fi

fits=("xsec")

if [[ $STEP == "t2w" ]]; then
    for fit in ${fits[*]}
    do
        python3 RunText2Workspace.py --ext ${YEAR}_$fit --mode $fit --batch local
    done
elif [[ $STEP == "fit" ]]; then
    for obs in " " #" --doObserved "
    do
        for fit in ${fits[*]}
        do
            python3 RunFits.py --inputJson inputs.json --ext $fit --mode $fit --batch local --queue cmsan ${DROPT} $obs
        done
    done
elif [[ $STEP == "collect" ]]; then
    for obs in " " # " --doObserved "
    do
	for fit in ${fits[*]}
	do
	    python3 CollectFits.py --inputJson inputs.json --ext $fit --mode $fit $obs
	done
    done
elif [[ $STEP == "plot" ]]; then
    for obs in " " # " --doObserved "
    do
        for fit in ${fits[*]}
        do
            python3 PlotScans.py --inputJson inputs.json --mode $fit  --ext $fit --outdir $outdate-fits $obs
        done
    done
elif [[ $STEP == "impacts-initial" ]]; then
    for fit in ${fits[*]} 
    do
	python3 RunImpacts.py --inputJson inputs.json --ext $fit --mode $fit --batch local --queue cmsan ${DROPT}
    done
elif [[ $STEP == "impacts-scans" ]]; then
    for fit in ${fits[*]}
    do
	python3 RunImpacts.py --inputJson inputs.json --ext $fit --mode $fit --doFits --batch local --queue cmsan ${DROPT}
    done
elif [[ $STEP == "impacts-collect" ]]; then
    for fit in ${fits[*]}
    do
	cd runImpacts${fit}_${fit}
	echo "Making JSON file for fit $fit It might take time, depending on the number of parameters..."
	combineTool.py -M Impacts -n _bestfit_syst_${fit}_initialFit -d ../Datacard_${fit}.root -i impacts_${fit}.json -m 125 -o impacts_${poi}
	if [[ $fit == "xsec" ]]; then 
	    pois=("c" "gamma")
	    translate="pois_mu.json"
	fi
	for poi in ${pois[*]}
	do
	    echo "    ===> Producing impact plots for the *** main-only *** systematics for fit: === $fit === and POI: == $poi === "
	    plotImpacts.py -i impacts_${fit}.json -o impacts_${poi} --POI ${poi}  --translate "../../Plots/${translate}" --max-pages 1
	done
	cd -
    done
else
    echo "Step $STEP is not one among t2w,fit,plot. Exiting."
fi

