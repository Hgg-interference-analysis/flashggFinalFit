source scan_statonly.sh 2018 > log_scan_statonly_2018 2>&1 &
source scan_statonly.sh 2017 > log_scan_statonly_2017 2>&1 &
source scan_statonly.sh 2016postVFP > log_scan_statonly_2016postVFP 2>&1 &
source scan_statonly.sh 2016preVFP > log_scan_statonly_2016preVFP 2>&1 &

source scan.sh 2018 > log_scan_2018 2>&1 &
source scan.sh 2017 > log_scan_2017 2>&1 &
source scan.sh 2016postVFP > log_scan_2016postVFP 2>&1 &
source scan.sh 2016preVFP > log_scan_2016preVFP 2>&1 &
