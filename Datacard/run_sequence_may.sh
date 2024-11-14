#ext=`date +%F` 
ext='2024-10-06_may'

STEP=0
usage(){
    echo "Script to run yields and datacard making. Yields need to be done before running datacards"
    echo "options:"
    
    echo "-h|--help) "
    echo "-s|--step) "
    echo "-d|--dryRun) "
}
# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -u -o s:hd -l help,step:,dryRun -- "$@")
then
# something went wrong, getopt will put out an error message for us
exit 1
fi
set -- $options
while [ $# -gt 0 ]
do
case $1 in
-h|--help) usage; exit 0;;
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
    DROPT=" --printOnly "
fi

smprocs=("GG2H" "VBF" "GG2HPLUSINT")
smprocs_csv=$(IFS=, ; echo "${smprocs[*]}")

if [[ $STEP == "yields" ]]; then
    # for mu-simple: exclude ALT processes
    python3 RunYields.py --cats "auto" --inputWSDirMap 2018=/eos/user/r/rgargiul/dataHggWidth/ws_preVBFcat_noVBFGGFmix/ --procs $smprocs_csv --doSystematics  --mergeYears --skipZeroes --ext ${ext}_xsec --batch local --queue cmsan ${DROPT}

elif [[ $STEP == "datacards" ]]; then
    for fit in "xsec"
    do
	echo "making datacards for all years together for type of fit: $fit"
        python3 makeDatacard.py --years 2018 --doSystematics --ext ${ext}_${fit}  --output "Datacard_${fit}"
	python3 cleanDatacard.py --datacard "Datacard_${fit}" --factor 2 --removeDoubleSided
	mv "Datacard_${fit}_cleaned.txt" "Datacard_${fit}.txt"
    done
elif [[ $STEP == "links" ]]; then
    cd Models 
    rm signal background 
    echo "linking Models/signal to /afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Signal/outdir_2024-05-02_year2018"
    ln -s /afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Signal/outdir_packaged signal
    echo "linking Models/background to /afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Background/outdir_2023-05-02/"
    #ln -s /afs/cern.ch/work/r/rgargiul/CMSSW_10_2_13/src/flashggFinalFit/Background/outdir_2023-05-02 background
    ln -s ../../Background/outdir_2024-10-06_oldws/ background
    cd -
else
    echo "Step $STEP is not one among yields,datacard,links. Exiting."
fi


s
