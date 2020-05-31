#!/bin/csh -f

@ sva_not_fin_num = `egrep -c " not finished" run_sim.log`
@ is_hang = `egrep -c "UVM_FATAL.*uvm_phase.*reporter \[PH_TIMEOUT\] Explicit timeout of" run_sim.log`

if ($is_hang == 1) then
	set LINE = "\/\/ sva not finished =        NA         \/\/"
else
	set LINE = "\/\/ sva not finished =        $sva_not_fin_num         \/\/"
	if ($sva_not_fin_num > 0) then
		sed -i "s/SIMULATION PASSED/SIMULATION FAILED/g" run_sim.log
	endif
endif


sed -i "/sva error number/a $LINE" run_sim.log
#sed -i "/UVM_FATAL.*uvm_phase.*reporter \[PH_TIMEOUT\] Explicit timeout of/i $LINE1\n$LINE2\n$LINE3\n$LINE4\n$LINE5\n$LINE6\n$LINE7" run_sim.log
endif
