//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_agent_pkg
// History:  2019.06.21 Create new version
//==================================================================================================

package fpu_agent_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "fpu_seq_item.sv"
	`include "fpu_mon_item.sv"
	`include "fpu_ft_opts.sv"
	`include "fpu_agent_cfg.sv"
	`include "fpu_sqr.sv"
	`include "fpu_drv.sv"
	`include "fpu_mon.sv"
	`include "fpu_agent.sv"

	`include "fpu_seq_base.sv"
endpackage
