outdate=`date +%F` 

STEP=0
usage(){
    echo "Script to run fits and plots of fit output. dryRun option is for the fitting only, that can be run in batch."
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
    DROPT=" --dryRun "
fi

#fits=("latest_cat0" "latest_cat1" "latest_cat2" "latest_cat3" "latest_cat4" "latest_cat5" "latest_cat6" "latest_cat7" "latest_cat8" "latest_cat9" "latest_cat10")
fits=("newShiftwithAllYears")
mode=("mu_inclusive")

if [[ $STEP == "t2w" ]]; then
    for fit in ${fits[*]}
    do
        python3 RunText2Workspace.py --ext $fit --mode $mode --batch local
    done
elif [[ $STEP == "fit" ]]; then
    for obs in " " #" --doObserved "
    do
        for fit in ${fits[*]}
        do
            python3 RunFits.py --inputJson inputs_width_model.json --ext $fit --mode mu_inclusive --batch local --queue cmsan ${DROPT} $obs
        done
    done

elif [[ $STEP == "redefPOI" ]]; then
    for fit in ${fits[*]}
    do
	directory="runFits${fit}_${mode}"
	file_stat="condor_profile1D_statonly_${fit}_r.sh"
	file_syst="condor_profile1D_syst_${fit}_r.sh"
	if [ ! -d "$directory" ]; then
	    echo "Error: Directory $directory does not exist."
	    exit 1
	fi

	search_string="-t -1 -P r"
        replace_string="--expectSignal 1 -t -1 --redefineSignalPOIs GammaH,r -P GammaH"
	
	for file in "$directory/$file_stat" "$directory/$file_syst"
	do

	    if [ -f "$file" ]; then
		echo "Processing $file..."
		sed -i.bak "s|$search_string|$replace_string|g" "$file"
	    else
		echo "Warning: File $file does not exist, skipping."
	    fi
	done

        cd "$directory" || { echo "Failed to navigate to $directory"; exit 1; }

        # Find and submit all .sub files
        for sub_file in *.sub; do
            if [ -f "$sub_file" ]; then
                echo "Submitting job: $sub_file"
                condor_submit "$sub_file"
                if [ $? -ne 0 ]; then
                    echo "Error: Failed to submit $sub_file"
                fi
            else
                echo "No .sub files found in $directory"
            fi
        done
	# Return to the parent directory
        cd - > /dev/null || exit 1
	
    done
    
elif [[ $STEP == "collect" ]]; then
    for obs in " " # " --doObserved "
    do
	for fit in ${fits[*]}
	do
	    python3 CollectFits.py --inputJson inputs_width_model.json --ext $fit --mode mu_inclusive $obs
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

