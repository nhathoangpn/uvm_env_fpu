//==================================================================================================
// Owner:    ThinhLe
// Filename: fpu_test_sample
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_fcov_nx_0 extends fpu_test_base;
	`uvm_component_utils(fpu_test_fcov_nx_0)

	`include "../fpu_top/fpu_def.svh"

	bit [89:0][31:0] direct_spmath = {
					32'hbf800000, //-1
					32'hbf8ccccd, //-1.1
					32'hbf99999a, //-1.2
					32'hbfa66666, //-1.3
					32'hbfb33333, //-1.4
					32'hbfc00000, //-1.5
					32'hbfcccccd, //-1.6
					32'hbfd9999a, //-1.7
					32'hbfe66666, //-1.8
					32'hbff33333, //-1.9
					32'hc0000000, //-2
					32'hc0400000, //-3
					32'hc0800000, //-4
					32'hc0a00000, //-5
					32'hc0c00000, //-6
					32'hc0e00000, //-7
					32'hc1000000, //-8
					32'hc1100000, //-9
					32'hc1200000, //-10
					32'hc2f00000, //-120
					32'hc2f20000, //-121
					32'hc2f40000, //-122
					32'hc2f60000, //-123
					32'hc2f80000, //-124
					32'hc2fa0000, //-125
					32'hc2fc0000, //-126
					32'hc2fe0000, //-127
					32'hc2fe3333, //-127.1
					32'hc2fe6666, //-127.2
					32'hc2fe999a, //-127.3
					32'hc2fecccd, //-127.4
					32'hc2ff0000, //-127.5
					32'hc2ff3333, //-127.6
					32'hc2ff6666, //-127.7
					32'hc2ff999a, //-127.8
					32'hc2ffcccd, //-127.9
					32'hc2ffffff, //-127.9999
					32'hc3000000, //-128
					32'h3f800000, //+1
					32'h3f8ccccd, //+1.1
					32'h3f99999a, //+1.2
					32'h3fa66666, //+1.3
					32'h3fb33333, //+1.4
					32'h3fc00000, //+1.5
					32'h3fcccccd, //+1.6
					32'h3fd9999a, //+1.7
					32'h3fe66666, //+1.8
					32'h3ff33333, //+1.9
					32'h40000000, //+2
					32'h40400000, //+3
					32'h40800000, //+4
					32'h40a00000, //+5
					32'h40c00000, //+6
					32'h40e00000, //+7
					32'h41000000, //+8
					32'h41100000, //+9
					32'h41200000, //+10
					32'h42f00000, //+120
					32'h42f20000, //+121
					32'h42f40000, //+122
					32'h42f60000, //+123
					32'h42f80000, //+124
					32'h42fa0000, //+125
					32'h42fc0000, //+126
					32'h42fe0000, //+127
					32'h42fe3333, //+127.1
					32'h42fe6666, //+127.2
					32'h42fe999a, //+127.3
					32'h42fecccd, //+127.4
					32'h42ff0000, //+127.5
					32'h42ff3333, //+127.6
					32'h42ff6666, //+127.7
					32'h42ff999a, //+127.8
					32'h42ffcccd, //+127.9
					32'h42ffffff, //+127.9999
					32'h43000000, //+128
					//for fsqrt
					32'h7f7fffff, //Largest +Normal
					//for flog
					32'h7f000000 //Log(A)=127
					};

	fpu_seq_base seq_srandom;
	fpu_seq_base seq_sdirect;
	fpu_seq_base seq_final;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});
		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
		seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

		for (int i = 0; i < 1000; i++) begin // {+-322, +-14, +-69}
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i inside {
					 `FADD, `FSUB, `FMUL, `FDIV,
					 `FMADD, `FMSUB, `FMNADD, `FMNSUB
					 };
				 sqb_operand_a_i inside{32'h43a10000, 32'hc3a10000, 32'h41600000, 32'hc1600000, 32'h428a0000, 32'hc28a0000};
				 sqb_operand_b_i inside{32'h43a10000, 32'hc3a10000, 32'h41600000, 32'hc1600000, 32'h428a0000, 32'hc28a0000};
				 sqb_operand_c_i inside{32'h43a10000, 32'hc3a10000, 32'h41600000, 32'hc1600000, 32'h428a0000, 32'hc28a0000, 32'h00000000, 32'h80000000};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

		for (int i = 0; i < 91; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `FEXP;
				 sqb_operand_a_i == direct_spmath[i];
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

		for (int i = 0; i < 91; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `FLOG;
				 sqb_operand_a_i == direct_spmath[i];
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

		for (int i = 0; i < 91; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `FSQRT;
				 sqb_operand_a_i == direct_spmath[i];
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

		if (!seq_final.randomize() with
			{sub_num_seq_item == 1;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 1;})
		`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		seq_final.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		phase.drop_objection(this, {get_name, "run_phase finishes"});
		`uvm_info(get_name(), "run_phase finishes", UVM_FULL)
	endtask
endclass
