#!/bin/csh -f

@ pat_total = 0
@ pat_pass  = 0
@ pat_fail  = 0
@ pat_unk   = 0
@ sim_time  = 0

echo  "==================================================================================================================================================================================="
echo  "| TEST NAME                                        |  RESULT      | Start time                       | End time                         | Seed           |   Sim time (HH:MM:SS)  |"
echo  "==================================================================================================================================================================================="

foreach log_top (log_$argv[1]*)
	cd $log_top
	echo $log_top
	@ num_test = `ls -l | wc -l`
	if ($num_test == 1) then
		goto TURN_BACK
	endif
	foreach pattern (*)
		@ pat_total = $pat_total + 1
		@ pat_hour = 0
		@ pat_min  = 0
		@ pat_sec  = 0
	
		setenv pat_log ${pattern}/${pattern}.log
		setenv pat_res "UNKNOWN"
		setenv pat_start   ""
		setenv pat_end     ""
		setenv pat_start_s ""
		setenv pat_end_s   ""
		setenv pat_seed    ""
		setenv pat_time    ""
	
		setenv sim_res `egrep "SIMULATION" ${pat_log}  | awk '{print $3}' | sed 's/\*//'`
		if (${sim_res} == "PASSED") then 
			set pat_res = "SIM PASSED"
			@ pat_pass  = $pat_pass + 1
		else if (${sim_res} == "FAILED") then
			set pat_res = "SIM FAILED"
			@ pat_fail  = $pat_fail + 1
		else 
			set pat_res = "UNKNOWN"
			@ pat_unk   = $pat_unk + 1
		endif
	
		setenv pat_start    `egrep "Runtime" ${pat_log} | awk -F\; '{print $NF}'`
		setenv pat_start    `date -d"${pat_start}"`
		setenv pat_end      `tail -n 1 ${pat_log}`
		setenv pat_end      `date -d"${pat_end}" `
		setenv pat_start_s  `date -d"${pat_start}" +%s`
		setenv pat_end_s    `date -d"${pat_end}" +%s`
		setenv pat_seed     `head -n 1 ${pat_log} | awk '{for (i=1;i<=NF;i++){if ($i ~ "seed") {split ($i,a,"="); print a[2]}}}'`
	
		@ pat_time  =   ${pat_end_s} - ${pat_start_s}
		@ sim_time  =   ${sim_time} + ${pat_time}
		@ pat_hour  =   $pat_time / 3600
		@ pat_min   =   ($pat_time - 3600 * $pat_hour) / 60;
		@ pat_sec   =   $pat_time % 60;

		echo "$pattern | $pat_res | $pat_start | $pat_end | $pat_seed | $pat_hour | $pat_min | $pat_sec" | \
		awk -F\| '{printf "%s%-50s%s%-14s%s%-34s%s%-34s%s%-16s%s%4s%-1s%4s%-1s%4s%11s", "|",$1, "|",$2,"|", $3,"|", $4,"|", $5,"|", $6,":", $7,":", $8, "|"}'
		echo ""
	end
	TURN_BACK:
	echo
	echo "==================================================================================================================================================================================="
	cd -
end
echo

@ sim_hour = $sim_time / 3600
@ sim_min  = ($sim_time - 3600 * $sim_hour) / 60;
@ sim_sec  = $sim_time % 60;
echo "==================================="
echo " SUMMARY "
echo " TOTAL        : $pat_total"
echo " SIM PASSED   : $pat_pass"
echo " SIM FAILED   : $pat_fail"
echo " SIM UNKNOWN  : $pat_unk"
echo " Simulation time : ${sim_hour} hour(s) ${sim_min} min(s) ${sim_sec} sec(s)"
echo "==================================="
