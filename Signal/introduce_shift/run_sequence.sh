#!/bin/bash

usage() {
    echo "Usage: $0 -y YEAR -d inwsDir [-e ext]"
    echo "Options:"
    echo "  -y, --year YEAR          Specify the year (e.g., 2016, 2017 or 2018)"
    echo "  -d, --dir inwsDir        Specify the input ws directory path."
    echo "  -e, --ext ext            Specify the extension."
    echo "  -h, --help               help message."
}

while [ $# -gt 0 ]
do
case $1 in
-h|--help) usage; exit 0;;
-y|--year) YEAR=$2; shift ;;
-d|--dir) inwsDir=$2; shift ;;
-e|--ext) ext=$2; shift ;;
*) echo "Error: Unrecognized option $1"
usage
exit 1
;;
esac
shift
done

echo "Requested to run the mass shift script for the year: ${YEAR}"
if [[ $YEAR != "all" && ($YEAR < 2016 || $YEAR>2018) ]]; then
    echo "Year $YEAR does not belong to Run2. Exiting."
    exit
fi

if [[ -z $YEAR || -z $inwsDir || -z $ext ]]; then
    echo "Error: YEAR, inwsDir and extension must be specified."
    echo "Usage: $0 -y YEAR -d inwsDir -e ext"
    exit 1
fi

procs=("GG2H" "VBF" "vh")
cats=("UntaggedTag_0" "UntaggedTag_1" "UntaggedTag_2" "UntaggedTag_3" "UntaggedTag_4" "UntaggedTag_5" "UntaggedTag_6" "UntaggedTag_7" "UntaggedTag_8" "UntaggedTag_9" "VBFTag_0")
#procs=("GG2H" "VBF")
#cats=("UntaggedTag_0" "UntaggedTag_1" "UntaggedTag_2" "UntaggedTag_3" "UntaggedTag_4" "UntaggedTag_5" "UntaggedTag_6" "UntaggedTag_7" "UntaggedTag_8" "UntaggedTag_9")
    for proc in ${procs[*]}; do
        for cat in ${cats[*]}; do
        inputWS=${inwsDir}/CMS-HGG_sigfit_${ext}_${proc}_${YEAR}_${cat}.root
        echo "Running: python3 introduce_shift.py --inputWS $inputWS --ext $ext --cat $cat --proc $proc"
        python3 introduce_shift.py --inputWS $inputWS --cat ${cat} --proc ${proc} --ext ${ext}
        done
    done

echo "Done!"
