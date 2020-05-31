//==================================================================================================
// Owner:    Tinh.Ho
// Filename: fpu_test_fcov_flog_lzc.sv
// History:  10/24/2019 Create new version
//==================================================================================================

class fpu_test_fcov_flog_lzc extends fpu_test_base;
        `uvm_component_utils(fpu_test_fcov_flog_lzc)

        `include "../fpu_top/fpu_def.svh"
        bit [7:0]  op_i;
        bit [2:0]  rm;
        bit        fn;
        bit [31:0] op_a_range_0_s, op_a_range_0_e, op_a_range_1_s, op_a_range_1_e;
        bit [31:0] op_b_range_0_s, op_b_range_0_e, op_b_range_1_s, op_b_range_1_e;
        bit [31:0] op_c_range_0_s, op_c_range_0_e, op_c_range_1_s, op_c_range_1_e;

        fpu_seq_base seq_srandom;
        //fpu_seq_base seq_sdirect;

        function new(string name, uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task fpu_calc(int num=1);
                repeat (num) begin
                   if ((op_a_range_1_s == 0) && (op_a_range_1_e == 0)) begin op_a_range_1_s = op_a_range_0_s; op_a_range_1_e = op_a_range_0_e; end
                   if ((op_b_range_1_s == 0) && (op_b_range_1_e == 0)) begin op_b_range_1_s = op_b_range_0_s; op_b_range_1_e = op_b_range_0_e; end
                   if ((op_c_range_1_s == 0) && (op_c_range_1_e == 0)) begin op_c_range_1_s = op_c_range_0_s; op_c_range_1_e = op_c_range_0_e; end

                   if (!seq_srandom.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i dist {0 :=10, 1 :=90};
                        sqb_op_i == op_i;
                        sqb_rm_i inside {[3'h0:3'h4]};
//                        sqb_rm_i == rm;
//                        sqb_fn_i == fn;
                        sqb_user_i inside {[8'h00:8'hFF]};

//============================================================================================================================
//
                        sqb_operand_a_i inside{ 32'h3f800000
                                               ,32'h5feaa4ca
                                               ,32'h404ae010
                                               ,32'h3fb504f4
                                               ,32'h3f9837f3
                                               ,32'h3f8b95c2
                                               ,32'h3f85aac7
                                               ,32'h3f82cd8c
                                               ,32'h3f8164d4
                                               ,32'h3f80b1ef
                                               ,32'h3f8058d8
                                               ,32'h3f802c67
                                               ,32'h3f801632
                                               ,32'h3f800b1a
                                               ,32'h3f80058c
                                               ,32'h3f8002c6
                                               ,32'h3f800163
                                               ,32'h3f8000b5
                                               ,32'h3f800059
                                               ,32'h3f80002d
                                               ,32'h3f800019
                                               ,32'h3f80000d
                                               ,32'h3f800006
                                               ,32'h3f800004
                                               ,32'h3f800002
                                               ,32'h3f800001
                                               ,32'h3f7fffff};

//============================================================================================================================
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

                seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
                //seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");

                // START FPU OPERATION TESTING

                          //Operation name: FMADD
                          op_i = `FEXP;
                          //fn = 0;

                          //A: +normal, B: +normal, C: +normal

                               //Round mode: Random
                               //rm = `RNE;
                               //Preset operands
//                               op_a_range_0_s = `NO_FINITE_P_S;
//                               op_a_range_0_e = `NO_FINITE_P_E;
//                               op_b_range_0_s = `NO_FINITE_P_S;
//                               op_b_range_0_e = `NO_FINITE_P_E;
//                               op_c_range_0_s = `NO_FINITE_P_S;
//                               op_c_range_0_e = `NO_FINITE_P_E;
                               //Call calculation
                               fpu_calc(5000);

                               
                // FINISH FPU OPERATION TESTING
                if (!seq_srandom.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i == 1;
                        sqb_op_i  == `FLE;
                        sqb_operand_a_i == 32'h4F00_0001;
                        sqb_operand_b_i == 32'h4F00_0001;
                        sqb_operand_c_i == 32'h4F00_0001;
                        sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
                        sqb_fn_i inside{1'b1,1'b0};
                        sqb_user_i == 8'h00;
                        sqb_num_wait_clk == 1;
                        sqb_test_final == 1;
                        sqb_handshake_i == 1;})
                `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                phase.drop_objection(this, {get_name,"run_phase finishes"});
                `uvm_info(get_name(), "run_phase finishes", UVM_FULL)
        endtask
endclass
