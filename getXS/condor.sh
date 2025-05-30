#!/bin/bash
export X509_USER_PROXY=/afs/cern.ch/user/a/amkrishn/x509up_u117432

source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`

file="$1"
file_index="$2"
proc="$3"
mass="$4"
year="$5"

file_to_process="root://cms-xrd-global.cern.ch//$file"
echo "Processing file $file"

python3 extract_weights.py "$file_to_process" "$proc/m$mass/$year/weights_$file_index.root"

echo "Job finished at $(date)"
