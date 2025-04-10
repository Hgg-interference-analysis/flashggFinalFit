year=$1

for i in $(seq 0 3); do
  echo $i
  jstart=$( expr $i \* 11 )
  jend=$( expr $i \* 11 + 10 )
  prefix="outdir_dcb-newcat-2024-05-02_year${year}/signalFit/jobs/sub_signalFit_dcb-newcat-2024-05-02_year${year}"
  for j in $(seq $jstart $jend); do
    bash -c "source ${prefix}_$j.sh > ${prefix}_$j.log 2>&1 &";
  done
  sleep 60;
  while true; do
    if [ $(ps aux | grep "bash -c" | wc -l) -le 3 ]; then
      break
    fi
    sleep 10;
  done
done
