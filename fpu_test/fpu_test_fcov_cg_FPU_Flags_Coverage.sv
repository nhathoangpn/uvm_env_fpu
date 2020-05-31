//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_test_sample
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_fcov_cg_FPU_Flags_Coverage extends fpu_test_base;
	`uvm_component_utils(fpu_test_fcov_cg_FPU_Flags_Coverage)

	`include "../fpu_top/fpu_def.svh"

	fpu_seq_base seq_srandom;
	fpu_seq_base seq_sdirect;
	fpu_seq_base seq_final;

	bit [31:0] sqb_operand_a_i_force;
	bit [31:0] sqb_operand_b_i_force;
	bit [31:0] sqb_operand_c_i_force;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});
		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

//==================================================================================================
		for (int i = 0; i < 3; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `ADD;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `ADD_U;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 3; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `SUB;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 2; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `SUB_U;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 4; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MUL;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 4; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MULH;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 2; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MUL_U;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 2; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MULH_U;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 2; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MUL_SU;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 2; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MULH_SU;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 7; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				4: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'hFFFF_FF9C;
					end
				5: begin
					sqb_operand_a_i_force = 32'hFFFF_FFFB;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'h0000_0064;
					end
				6: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0005;
					sqb_operand_c_i_force = 32'h0000_0005;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MADD;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 7; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				4: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'hFFFF_FF9C;
					end
				5: begin
					sqb_operand_a_i_force = 32'hFFFF_FFFB;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'h0000_0064;
					end
				6: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0005;
					sqb_operand_c_i_force = 32'h0000_0005;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MNADD;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 6; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				4: begin
					sqb_operand_a_i_force = 32'hFFFF_FFFB;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'h0000_0064;
					end
				5: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0005;
					sqb_operand_c_i_force = 32'h0000_0005;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MSUB;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 6; i++) begin
			case (i)
				0: begin
					sqb_operand_a_i_force = 32'h0000_0064;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				1: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0064;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				2: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'hFFFF_FF9C;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				3: begin
					sqb_operand_a_i_force = 32'hFFFF_FF9C;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
				4: begin
					sqb_operand_a_i_force = 32'hFFFF_FFFB;
					sqb_operand_b_i_force = 32'h0000_0014;
					sqb_operand_c_i_force = 32'h0000_0064;
					end
				5: begin
					sqb_operand_a_i_force = 32'h0000_0005;
					sqb_operand_b_i_force = 32'h0000_0005;
					sqb_operand_c_i_force = 32'h0000_0005;
					end
				default: begin
					sqb_operand_a_i_force = 32'h0000_0000;
					sqb_operand_b_i_force = 32'h0000_0000;
					sqb_operand_c_i_force = 32'h0000_0000;
					end
			endcase

			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i == 1;
				 sqb_op_i == `MNSUB;
				 sqb_operand_a_i == sqb_operand_a_i_force;
				 sqb_operand_b_i == sqb_operand_b_i_force;
				 sqb_operand_c_i == sqb_operand_c_i_force;
				 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i == 0;
				 sqb_user_i inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final == 0;
				 sqb_handshake_i == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
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
