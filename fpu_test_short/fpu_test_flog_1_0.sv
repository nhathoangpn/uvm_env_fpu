//==================================================================================================
// Owner:    Tinh.Ho
// Filename: fpu_test_flog_1_0.sv
// History:  10/24/2019 Create new version
//==================================================================================================

class fpu_test_flog_1_0 extends fpu_test_base;
        `uvm_component_utils(fpu_test_flog_1_0)

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

//                      a is negative int  
                        sqb_operand_a_i[31:0] == 32'h3F80_0000;


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
                          op_i = `FLOG;
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
                               fpu_calc(100);

                               
                // FINISH FPU OPERATION TESTING
                if (!seq_srandom.randomize() with
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

                seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                phase.drop_objection(this, {get_name,"run_phase finishes"});
                `uvm_info(get_name(), "run_phase finishes", UVM_FULL)
        endtask
endclass
