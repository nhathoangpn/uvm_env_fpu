//==================================================================================================
// Owner:    Toan.Vu
// Filename: fpu_test_arith_ccov_improve
// History:  11/04/2019 Create new version
//           Improve for rounding mode and toggle of wallace tree
//==================================================================================================


class fpu_seq_base_rand extends fpu_seq_base;

	`uvm_object_utils(fpu_seq_base_rand)

  typedef enum {ONEHOT, ALL1, ALL0, GAP, OTHER} kind_data_e;
  rand kind_data_e         	oprd_a_kind;
  rand kind_data_e         	oprd_b_kind;
  rand kind_data_e         	oprd_c_kind;

  constraint c_operand_a_i {
    (oprd_a_kind == ONEHOT) -> $countones(sqb_operand_a_i[31:0]) == 1;
    (oprd_a_kind == ALL1)   -> sqb_operand_a_i[31:0] == 32'hFFFF_FFFF;
    (oprd_a_kind == ALL0)   -> sqb_operand_a_i[31:0] == 32'h0000_0000;
    (oprd_a_kind == GAP)    -> sqb_operand_a_i[31:0] inside {32'h5555_5555, 32'hAAAA_AAAA};
    (oprd_a_kind == OTHER)  -> sqb_operand_a_i[31:0] inside {32'hFFFF_0000, 32'h0000_FFFF, 32'hFFFF_AAAA, 32'hFFFF_5555, 32'h5555_FFFF, 32'hAAAA_FFFF};
  }

  constraint c_operand_b_i {
    (oprd_b_kind == ONEHOT) -> $countones(sqb_operand_b_i[31:0]) == 1;
    (oprd_b_kind == ALL1)   -> sqb_operand_b_i[31:0] == 32'hFFFF_FFFF;
    (oprd_b_kind == ALL0)   -> sqb_operand_b_i[31:0] == 32'h0000_0000;
    (oprd_b_kind == GAP)    -> sqb_operand_b_i[31:0] inside {32'h5555_5555, 32'hAAAA_AAAA};
    (oprd_b_kind == OTHER)  -> sqb_operand_b_i[31:0] inside {32'hFFFF_0000, 32'h0000_FFFF, 32'hFFFF_AAAA, 32'hFFFF_5555, 32'h5555_FFFF, 32'hAAAA_FFFF};
  }

  constraint c_operand_c_i {
    (oprd_c_kind == ONEHOT) -> $countones(sqb_operand_c_i[31:0]) == 1;
    (oprd_c_kind == ALL1)   -> sqb_operand_c_i[31:0] == 32'hFFFF_FFFF;
    (oprd_c_kind == ALL0)   -> sqb_operand_c_i[31:0] == 32'h0000_0000;
    (oprd_c_kind == GAP)    -> sqb_operand_c_i[31:0] inside {32'h5555_5555, 32'hAAAA_AAAA};
    (oprd_c_kind == OTHER)  -> sqb_operand_c_i[31:0] inside {32'hFFFF_0000, 32'h0000_FFFF, 32'hFFFF_AAAA, 32'hFFFF_5555, 32'h5555_FFFF, 32'hAAAA_FFFF};
  }

  constraint order_cfg {
    solve oprd_a_kind before sqb_operand_a_i;
    solve oprd_b_kind before sqb_operand_b_i;
    solve oprd_c_kind before sqb_operand_c_i;
  }

    function new(string name = "fpu_seq_base_rand");
		super.new(name);
	endfunction

endclass


class fpu_test_arith_ccov_improve extends fpu_test_base;
        `uvm_component_utils(fpu_test_arith_ccov_improve)

        `include "../fpu_top/fpu_def.svh"
        bit [7:0]  op_i;
        bit [2:0]  rm;
        bit        fn;
        bit [31:0] op_a_range_0_s, op_a_range_0_e, op_a_range_1_s, op_a_range_1_e;
        bit [31:0] op_b_range_0_s, op_b_range_0_e, op_b_range_1_s, op_b_range_1_e;
        bit [31:0] op_c_range_0_s, op_c_range_0_e, op_c_range_1_s, op_c_range_1_e;
        bit [31:0] oprd_a, oprd_b, oprd_c;

        fpu_seq_base_rand seq_srandom;
        fpu_seq_base seq_sdirect;

        function new(string name, uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                //Add more to overwritten default sequence base random
                //fpu_seq_base::type_id::set_type_override(fpu_seq_base_rand::get_type());
                super.build_phase(phase);
        endfunction

        task fpu_calc_dr(int num=1);
                repeat (num) begin
                   if ((op_a_range_1_s == 0) && (op_a_range_1_e == 0)) begin op_a_range_1_s = op_a_range_0_s; op_a_range_1_e = op_a_range_0_e; end
                   if ((op_b_range_1_s == 0) && (op_b_range_1_e == 0)) begin op_b_range_1_s = op_b_range_0_s; op_b_range_1_e = op_b_range_0_e; end
                   if ((op_c_range_1_s == 0) && (op_c_range_1_e == 0)) begin op_c_range_1_s = op_c_range_0_s; op_c_range_1_e = op_c_range_0_e; end

                   if (!seq_sdirect.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i dist {0 :=10, 1 :=90};
                        //sqb_op_i inside {`FMADD,`FMSUB,`FMNADD,`FMNSUB};
//                        sqb_op_i inside {`FMADD};
                        sqb_op_i == op_i;
                        sqb_rm_i inside {[3'h0:3'h4]};
//                        sqb_rm_i == rm;
//                        sqb_fn_i == fn;
                        sqb_user_i inside {[8'h00:8'hFF]};
//                        sqb_operand_a_i inside {[op_a_range_0_s:op_a_range_0_e],[op_a_range_1_s:op_a_range_1_e]};
//                        sqb_operand_b_i inside {[op_b_range_0_s:op_b_range_0_e],[op_b_range_1_s:op_b_range_1_e]};
//                        sqb_operand_c_i inside {[op_c_range_0_s:op_c_range_0_e],[op_c_range_1_s:op_c_range_1_e]};
                        sqb_operand_a_i[31:0] == oprd_a;
                        sqb_operand_b_i[31:0] == oprd_b;
                        sqb_operand_c_i[31:0] == oprd_c;
                        sqb_num_wait_clk inside {[1:2]};
                        sqb_test_final == 0;
                        sqb_handshake_i == 1;})
                   `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                   op_a_range_1_s = 0; op_a_range_1_e = 0;
                   op_b_range_1_s = 0; op_b_range_1_e = 0;
                   op_c_range_1_s = 0; op_c_range_1_e = 0;

                   seq_sdirect.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
                end
        endtask

        task fpu_calc_rand(int num=1);
                repeat (num) begin

                   if (!seq_srandom.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i dist {0 :=10, 1 :=90};
                        //sqb_op_i inside {`FMADD,`FMSUB,`FMNADD,`FMNSUB};
//                        sqb_op_i inside {`FMADD};
                        sqb_op_i == op_i;
                        sqb_rm_i inside {[3'h0:3'h4]};
//                        sqb_rm_i == rm;
//                        sqb_fn_i == fn;
                        sqb_user_i inside {[8'h00:8'hFF]};
//                        sqb_operand_a_i[31:0] == oprd_a;
//                        sqb_operand_b_i[31:0] == oprd_b;
//                        sqb_operand_c_i[31:0] == oprd_c;
                        sqb_num_wait_clk inside {[1:2]};
                        sqb_test_final == 0;
                        sqb_handshake_i == 1;})
                   `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                   op_a_range_1_s = 0; op_a_range_1_e = 0;
                   op_b_range_1_s = 0; op_b_range_1_e = 0;
                   op_c_range_1_s = 0; op_c_range_1_e = 0;

                   seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
                end
        endtask

        task run_phase(uvm_phase phase);
                phase.phase_done.set_drain_time(this,110);
                phase.raise_objection(this, {get_name,"run_phase starts"});
                `uvm_info(get_name(), "run_phase starts", UVM_FULL)

                m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1,10);

                seq_srandom = fpu_seq_base_rand::type_id::create("seq_srandom");
                seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");

                // START FPU OPERATION TESTING

                          //Operation name: FMADD
                          op_i = `FMADD;
                          //fn = 0;

                          // Cover RNE with GRS= {1,0,0} and all mantissa = 1 before round
                          //A: +normal, B: +normal, C: +zero

                               //Round mode: Random
                               //rm = `RNE;
                               //Preset operands
//                               op_a_range_0_s = `NO_FINITE_P_S;
//                               op_a_range_0_e = `NO_FINITE_P_E;
//                               op_b_range_0_s = `NO_FINITE_P_S;
//                               op_b_range_0_e = `NO_FINITE_P_E;
//                               op_c_range_0_s = `NO_FINITE_P_S;
//                               op_c_range_0_e = `NO_FINITE_P_E;
                               oprd_a = 32'hC75A1700;
                               oprd_b = 32'h24964000;
                               oprd_c = 32'h00000000;
                               //Call calculation
                               fpu_calc_dr(10);

                          // Cover with GRS= {1,0,0} and man_round_in[0] = 0 before round

                               oprd_a = 32'h256F8000;
                               oprd_b = 32'hFE88D180;
                               oprd_c = 32'h00000000;
                               //Call calculation
                               fpu_calc_dr(10);

                //Start random with expected random here                               
                          //Operation name: MUL_U
                          //To improve toggle coverage for wallace tree
                          op_i = `MUL_U;
                          //fn = 0;
                               fpu_calc_rand(2000);


                // FINISH FPU OPERATION TESTING
                if (!seq_sdirect.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i == 1;
                        sqb_op_i  == `FLE;
                        sqb_operand_a_i == 32'h4F00_0001;
                        sqb_operand_b_i == 32'h4F00_0001;
                        sqb_operand_c_i == 32'h4F00_0001;
                        sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
                        sqb_fn_i == 0;
                        sqb_user_i == 8'h00;
                        sqb_num_wait_clk == 1;
                        sqb_test_final == 1;
                        sqb_handshake_i == 1;})
                `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                seq_sdirect.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                phase.drop_objection(this, {get_name,"run_phase finishes"});
                `uvm_info(get_name(), "run_phase finishes", UVM_FULL)
        endtask
endclass
