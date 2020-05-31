#!/bin/csh -f

@ is_hang = `egrep -c "UVM_FATAL.*uvm_phase.*reporter \[PH_TIMEOUT\] Explicit timeout of" run_sim.log`

set LINE1 = "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
set LINE2 = "\/\/ SIMULATION HANG UP                   \/\/"
set LINE3 = "\/\/ env error number =        NA         \/\/"
set LINE4 = "\/\/ C   error number =        NA         \/\/"
set LINE5 = "\/\/ sva error number =        NA         \/\/"
set LINE6 = "\/\/ valid_i number   =        NA         \/\/"
set LINE7 = "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"

if ($is_hang == 1) then
	#sed -i "/finish at simulation time/a $LINE1\n$LINE2\n$LINE3\n$LINE4\n$LINE5\n$LINE6\n$LINE7" run_sim.log
	sed -i "/UVM_FATAL.*uvm_phase.*reporter \[PH_TIMEOUT\] Explicit timeout of/i $LINE1\n$LINE2\n$LINE3\n$LINE4\n$LINE5\n$LINE6\n$LINE7" run_sim.log
endif
