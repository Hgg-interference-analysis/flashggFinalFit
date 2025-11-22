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
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode fTest --modeOpts "--doPlots --freezeGammaH --doVoigtian --skipWV --outdir /eos/user/a/amkrishn/www/hggWidth/finalfit/VoigtianSignal --nProcsToFTest -1" ${DROPT}
	    elif [[ $STEP == "calcPhotonSyst" ]]; then
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode calcPhotonSyst ${DROPT}
	    elif [[ $STEP == 'signalFit' ]]; then
		#python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode signalFit --modeOpts="--skipVertexScenarioSplit --useDCB --doPlots" ${DROPT}
		python3 RunSignalScripts.py --inputConfig config_test_${year}.py --mode signalFit --modeOpts="--skipVertexScenarioSplit --freezeGammaH --doVoigtian --doPlots" ${DROPT}
	    fi
	fi
    done
elif [[ $STEP == 'packager' ]]; then
    #python3 RunPackager.py --cats "auto" --inputWSDir /eos/user/a/amkrishn/hggWidth/mcNtuples/condor_output/2018/UL18_sigMC_newFNUF_VBFTag0/hadded_trees/ws_sig --outputExt packaged --exts newFNUF_VBFTag0_2018 --year $YEAR --massPoints 125 --batch local
    python3 RunPackager.py --cats UntaggedTag_0,UntaggedTag_1,UntaggedTag_2,UntaggedTag_3,UntaggedTag_4,UntaggedTag_5,UntaggedTag_6,UntaggedTag_7,UntaggedTag_8,UntaggedTag_9,VBFTag_0 --outputExt packaged --exts final${YEAR} --year $YEAR --massPoints 120,125,130 --batch local
elif [[ $STEP == 'plotter' ]]; then
    smprocs_csv=("VBF,GG2H,vh")
    echo $smprocs_csv
    year_string=$(IFS=, ; echo "${years[*]}")
    # just plot all the (SM) processes, all the categories, all the years together. Can be split with --year ${YEAR}. Do not include BSM to maintain the expected total yield for SM
    echo "Now plotting all categories for these SM processes: $smprocs_csv"
    #python3 RunPlotter.py --procs $smprocs_csv --cats "all" --years $year_string --ext packaged --outdir /eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/final 
    python3 RunPlotter.py --procs GG2H,VBF,vh --cats all --years 2016preVFP,2016postVFP,2017,2018 --ext packaged --outdir /eos/user/a/amkrishn/www/hggWidth/finalfit/VoigtianSignal
    # split by category, all processes together
    for year in ${years[*]}; do
    significantCats=("UntaggedTag_0_$year" "UntaggedTag_1_$year" "UntaggedTag_2_$year" "UntaggedTag_3_$year" "UntaggedTag_4_$year" "UntaggedTag_5_$year" "UntaggedTag_6_$year" "UntaggedTag_7_$year" "UntaggedTag_8_$year" "UntaggedTag_9_$year" "VBFTag_0_$year")
    significantCats_csv=$(echo "${significantCats[*]}")
    smprocs_csv=("GG2H,VBF,vh")
    for cat in ${significantCats[*]}
    do
    	echo "=> Now plotting all processes together for cat: $cat"
    	python3 RunPlotter.py --procs GG2H,VBF,vh --cats $cat --years $year --outdir /eos/user/a/amkrishn/www/hggWidth/finalfit/VoigtianSignal --ext packaged --translateCats ../Plots/cats.json
    done
    done
    smprocs=("GG2H" "VBF" "vh")
    smprocs_csv=$(echo "${smprocs[*]}")
    for proc in ${smprocs[*]}; do
    # split by process, all the categories together (the SM + some alternatives)
    echo "=> Now plotting proc $proc for all categories"
    python3 RunPlotter.py --procs $proc --cats all --years 2017,2018,2016preVFP,2016postVFP --ext packaged --outdir /eos/user/a/amkrishn/www/hggWidth/finalfit/VoigtianSignal
    done
    #echo "=> Now plotting proc VBF for all categories"
    #python3 RunPlotter.py --procs VBF --cats all --years 2017,2018,2016preVFP,2016postVFP --ext packaged --outdir eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/final
    #echo "=> Now plotting proc vh for all categories"
    #python3 RunPlotter.py --procs vh --cats all --years 2016preVFP,2016postVFP,2017,2018 --ext packaged --outdir eos/user/a/amkrishn/www/hggWidth/finalfit/sig_el9/final
fi
