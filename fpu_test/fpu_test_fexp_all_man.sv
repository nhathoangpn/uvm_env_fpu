//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_test_sample
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_fexp_all_man extends fpu_test_base;
	`uvm_component_utils(fpu_test_fexp_all_man)

	`include "../fpu_top/fpu_def.svh"

	fpu_seq_base seq_srandom;
	fpu_seq_base seq_sdirect;
	fpu_seq_base seq_final;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_top.set_timeout(0);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});
		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
		seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

		for (int i = 0; i < 8388608; i++) begin //Mantissa: 00_0000 to 7F_FFFF
			for (int j = 0; j < 2; j++) begin //Sign: Positive <-> Minus
				if (!seq_srandom.randomize() with
					{sub_num_seq_item == 1;
					 sqb_valid_i == 1;
					 sqb_op_i == `FEXP;
					 sqb_operand_a_i[31] == j;
					 sqb_operand_a_i[30:23] == 8'b0111_1111; //Exponent: Fixed 0x7F
					 sqb_operand_a_i[22:0] == i;
					 sqb_rm_i == `RNE;
					 sqb_fn_i == 0;
					 sqb_user_i inside{[8'h00:8'hFF]};
					 sqb_num_wait_clk == 1;
					 sqb_test_final == 0;
					 sqb_handshake_i == 1;
					})
				`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

				seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
			end

			if (seq_srandom.sqb_operand_a_i[22:0]%65536 == 0)
				`uvm_info("MANT_COUNT", $psprintf("Mantissa value reaches %h", seq_srandom.sqb_operand_a_i[22:0]), UVM_NONE)
		end

		if (!seq_final.randomize() with
			{sub_num_seq_item == 1;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 1;});
		`uvm_error("FINAL SEQUENCE", "randomization failure for sequence")

		seq_final.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		phase.drop_objection(this, {get_name, "run_phase finishes"});
		`uvm_info(get_name(), "run_phase finishes", UVM_FULL)
	endtask
endclass
