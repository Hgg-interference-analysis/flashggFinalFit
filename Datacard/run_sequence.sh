#ext=`date +%F` 
#ext='final2018'
YEAR=2018
STEP=0
usage(){
    echo "Script to run yields and datacard making. Yields need to be done before running datacards"
    echo "options:"
    
    echo "-h|--help) "
    echo "-y|--year) "
    echo "-s|--step) "
    echo "-d|--dryRun) "
}
# options may be followed by one colon to indicate they have a required argument
#if ! options=$(getopt -u -o s:hd -l help,step:,dryRun -- "$@")
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
    DROPT=" --printOnly "
fi

smprocs=("GG2H" "VBF" "vh")
#smprocs=("GG2H" "VBF")
smprocs_csv=$(IFS=, ; echo "${smprocs[*]}")
ext='final'$YEAR
if [[ $STEP == "yields" ]]; then
    # for mu-simple: exclude ALT processes
    python3 RunYields.py --cats "auto" --inputWSDirMap $YEAR=/eos/cms/store/group/phys_higgs/cmshgg/rgargiul/ws_withTheoryWeight/ws_$YEAR --procs $smprocs_csv --doSystematics --skipZeroes --ext ${ext} --batch local --queue cmsan ${DROPT}
    
elif [[ $STEP == "datacard" ]]; then
    echo "making datacard for ext: $ext"
    python3 makeDatacard.py --years $YEAR --doSystematics --ext ${ext}
    python3 cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
    mv "Datacard_cleaned.txt" "Datacard_${ext}.txt"
    
elif [[ $STEP == "links" ]]; then
    cd Models 
    rm signal background 
    echo "linking Models/signal to ../../Signal/outdir_packaged"
    ln -s ../../Signal/outdir_packaged signal
    echo "linking Models/background to ../../Background/outdir_2023-05-02"
    ln -s ../../Background/outdir_2023-05-02 background
    cd -
else
    echo "Step $STEP is not one among yields,datacard,links. Exiting."
fi
