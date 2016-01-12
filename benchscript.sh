#!/bin/bash

IPERF_SERVER="/Users/Maho/Desktop/iperf-2.0.5/src/iperf"

declare -a X_VAL_LIST=(1 2 4 8 16)
declare -a Y_VAL_LIST=(1 -1)

function exec_bench() {
	for j in "${Y_VAL_LIST[@]}"; do
		for i in "${X_VAL_LIST[@]}"; do
			echo "X val:$i, Y val:$j"
			ssh root@192.168.56.61 "/root/satamaho_kernel_module/app/a.out $i $j; pkill iperf > /dev/null; echo try connect; /root/iperf-2.0.5/src/iperf -c 192.168.56.1 > /dev/null" &
			ssh satamaho@192.168.56.16 "pkill iperf > /dev/null; /home/satamaho/iperf -c 192.168.56.1 > /dev/null";
			sleep 1
			ssh root@192.168.56.61 "pkill iperf > /dev/null"
			ssh satamaho@192.168.56.16 "pkill iperf > /dev/null"
			echo
			echo
		done
	done
}

pkill iperf
${IPERF_SERVER} -s &
ssh root@192.168.56.61 "pkill iperf > /dev/null"
ssh satamaho@192.168.56.16 "pkill iperf > /dev/null"
exec_bench 2>&1 | tee ~/Desktop/result-`date +%Y_%m_%d__%H_%M_%S`.log
