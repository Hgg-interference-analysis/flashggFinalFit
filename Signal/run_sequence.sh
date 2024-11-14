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

DR=""

echo "Requested to run the step ${STEP} for the year: ${YEAR}"
if [[ $YEAR != "all" && ($YEAR < 2016 || $YEAR>2018) ]]; then
    echo "Year $YEAR does not belong to Run2. Exiting."
    exit
fi

DROPT=""
if [[ $DR ]]; then
    DROPT=" --printOnly "
fi

echo $DROPT

years=("2016preVFP" "2016postVFP" "2017" "2018")

if [[ $STEP == "fTest" ]] || [[ $STEP == "calcPhotonSyst" ]] || [[ $STEP == 'signalFit' ]]; then
    for year in ${years[*]}
    do
	if [[ $year == $YEAR ]] || [[ $YEAR == "all" ]]; then
	    echo "====> Running $STEP for year $year"
	    if [[ $STEP == "fTest" ]]; then
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode fTest --modeOpts "--skipWV --doPlots --outdir /eos/user/r/rgargiul/www/width_pdf/plots --nProcsToFTest -1" ${DROPT}
	    elif [[ $STEP == "calcPhotonSyst" ]]; then
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode calcPhotonSyst ${DROPT}
	    elif [[ $STEP == 'signalFit' ]]; then
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode signalFit --modeOpts="--skipVertexScenarioSplit --doPlots --outdir /eos/user/r/rgargiul/www/width_pdf/plots --skipSystematics" ${DROPT}
	    fi
	fi
    done
elif [[ $STEP == 'packager' ]]; then
    python RunPackager.py --cats "auto" --inputWSDir /eos/user/r/rgargiul/dataHggWidth/ws_postVBFcat_noVBFGGFmix/ --outputExt packaged --exts 2024-05-02_year2018 --year $YEAR --batch local --mergeYears
elif [[ $STEP == 'plotter' ]]; then
    smprocs_csv=("VBF,GG2HPLUSINT,vh")
    echo $smprocs_csv
    # just plot all the (SM) processes, all the categories, all the years together. Can be split with --year ${YEAR}. Do not include BSM to maintain the expected total yield for SM
    echo "Now plotting all categories for these SM processes: $smprocs_csv"
    python RunPlotter.py --procs $smprocs_csv --cats "all" --years 2018 --ext packaged --outdir /eos/user/r/rgargiul/www/width_pdf/plots 
    # split by category, all processes together
    significantCats=("UntaggedTag_0" "UntaggedTag_1" "UntaggedTag_2" "UntaggedTag_3" "UntaggedTag_4" "UntaggedTag_5" "UntaggedTag_6" "UntaggedTag_7" "UntaggedTag_8" "UntaggedTag_9" "VBFTag_0")
    significantCats_csv=$(echo "${significantCats[*]}")
    smprocs_csv=("VBF,GG2HPLUSINT,vh")
    for cat in ${significantCats[*]}
    do
    	echo "=> Now plotting all processes together for cat: $cat"
    	python RunPlotter.py --procs $smprocs_csv --cats $cat --years 2018 --outdir /eos/user/r/rgargiul/www/width_pdf/plots --ext packaged --translateCats ../Plots/cats.json
    done
    smprocs=("GG2H" "VBF" "GG2HPLUSINT" "vh")
    smprocs_csv=$(echo "${smprocs[*]}")
    # split by process, all the categories together (the SM + some alternatives)
    for proc in ${smprocs[*]}
    do
    	echo "=> Now plotting proc $proc for all categories"
    	python RunPlotter.py --procs $proc --cats "all" --years 2018 --ext packaged --outdir /eos/user/r/rgargiul/www/width_pdf/plots
    done

    for proc in ${smprocs[*]}
    do
      	for cat in ${significantCats[*]}
        do
            echo "=> Now plotting proc $proc for cat $cat"
            python RunPlotter.py --procs $proc --cats $cat --years 2018 \
 --ext packaged --outdir /eos/user/r/rgargiul/www/width_pdf/plots
        done
    done


fi

