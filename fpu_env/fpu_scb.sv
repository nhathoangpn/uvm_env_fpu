//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_scb
// History:  20190621 Create new version
//==================================================================================================

`uvm_analysis_imp_decl(_scb_seq)
`uvm_analysis_imp_decl(_scb_mon)

class fpu_scb extends uvm_scoreboard;
	`uvm_component_utils(fpu_scb)

	`include "../fpu_top/fpu_def.svh"

	uvm_analysis_imp_scb_seq #(fpu_seq_item, fpu_scb) scb_seq_exp;
	uvm_analysis_imp_scb_mon #(fpu_mon_item, fpu_scb) scb_mon_exp;

	fpu_ft_opts m_fpu_ft_opts;

	int num_stall_i    = 0;
	int num_rst        = 0;
	int num_env_err_o  = 0;
	int queue_size     = 0;
	int in_queue_size  = 0;
	int out_queue_size = 0;
	int cur_queue_diff = 0;
	int num_env_err    = 0;
	int num_log_err    = 0;
	//int num_sva_err    = 0;
	int pos_error_o    = 0;
	string has_tfvo_file  = "";

	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W + `RS_W + `FF_W + `IF_W + `USRO_W) - 1 : 0] comb_queue[$];
	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] in_queue[$];
	bit [(`RS_W + `FF_W + `IF_W + `USRO_W) - 1 : 0]            out_queue[$];
	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] iq_item;
	bit [(`RS_W + `FF_W + `IF_W + `USRO_W) - 1 : 0]            oq_item;

	bit [`OP_W   - 1 : 0] op_i;
	bit [`RM_W   - 1 : 0] rm_i;
	bit [`FN_W   - 1 : 0] fn_i;
	bit [`OPD_W  - 1 : 0] operand_a_i;
	bit [`OPD_W  - 1 : 0] operand_b_i;
	bit [`OPD_W  - 1 : 0] operand_c_i;
	bit [`USRI_W - 1 : 0] user_i;
	bit [`RS_W   - 1 : 0] result_o;
	bit [`FF_W   - 1 : 0] fflags_o;
	bit [`IF_W   - 1 : 0] iflags_o;
	bit [`USRO_W - 1 : 0] user_o;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction


	function void build_phase(uvm_phase phase);
		scb_seq_exp = new("scb_seq_exp", this);
		scb_mon_exp = new("scb_mon_exp", this);

		if (!uvm_config_db #(fpu_ft_opts)::get(this, "", "fpu_ft_opts", m_fpu_ft_opts))
			`uvm_fatal("SCB_CONFIG", "cannot get fpu_ft_opts from config database")
	endfunction


	task run_phase(uvm_phase phase);
	endtask

	function void write_scb_seq(fpu_seq_item seq_item);
		iq_item = {seq_item.op_i,
							 seq_item.rm_i,
							 seq_item.fn_i,
							 seq_item.operand_a_i,
							 seq_item.operand_b_i,
							 seq_item.operand_c_i,
							 seq_item.user_i};
		`uvm_info(get_name(),
							$sformatf("\ninput_item: op = %h, rm = %h, fn = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, rst = %b",
							seq_item.op_i, seq_item.rm_i, seq_item.fn_i, seq_item.operand_a_i, seq_item.operand_b_i, seq_item.operand_c_i, seq_item.user_i, seq_item.rst),
							UVM_FULL)

		if (seq_item.rst) begin
			if (seq_item.valid_i && seq_item.ready_o) begin
				in_queue.push_back(iq_item);
			end
			if (seq_item.valid_o) begin
				cur_queue_diff = in_queue.size() - out_queue.size() - 1;
			end else begin
				cur_queue_diff = in_queue.size() - out_queue.size();
			end
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			in_queue.push_back(iq_item);
		end
	endfunction

	function void write_scb_mon(fpu_mon_item mon_item);
		oq_item = {mon_item.result_o,
							 mon_item.fflags_o,
							 mon_item.iflags_o,
							 mon_item.user_o};
		`uvm_info(get_name(),
							$sformatf("\noutput_item: res = %h, ff = %h, if = %h, uso = %h, stall = %b, rst =%b",
							mon_item.result_o, mon_item.fflags_o, mon_item.iflags_o, mon_item.user_o, mon_item.stall_i, mon_item.rst),
							UVM_FULL)

		if (mon_item.rst) begin
			if (!mon_item.error_o) begin
				out_queue.push_back(oq_item);
			end
			cur_queue_diff = in_queue.size() - out_queue.size();
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			if (mon_item.stall_i) begin
        num_stall_i = num_stall_i + 1;
			end else if (mon_item.error_o) begin
				pos_error_o = out_queue.size();
				if (in_queue.size() > out_queue.size()) begin
					in_queue.delete(pos_error_o);
					num_env_err_o = num_env_err_o + 1;
				end
      end else begin
        out_queue.push_back(oq_item);
      end
		end
	endfunction


	function void ioqueue_to_file();
		int tfv_in_file;

		tfv_in_file = $fopen("tfv_in_file", "w");

		`uvm_info(get_name(), $sformatf("\nin queue_size = %0d", in_queue.size()), UVM_FULL)
		`uvm_info(get_name(), $sformatf("\nout queue_size = %0d", out_queue.size()), UVM_FULL)

		in_queue_size  = in_queue.size();
		out_queue_size = out_queue.size();

		queue_size = (in_queue_size <= out_queue_size) ? in_queue_size : out_queue_size;

		for (int i = 0; i < queue_size; i++) begin
			{op_i,
			 rm_i,
			 fn_i,
			 operand_a_i,
			 operand_b_i,
			 operand_c_i,
			 user_i} = in_queue.pop_front();

			{result_o,
			 fflags_o,
			 iflags_o,
			 user_o} = out_queue.pop_front();

			comb_queue.push_back({op_i,
														fn_i,
														rm_i,
														operand_a_i,
														operand_b_i,
														operand_c_i,
														user_i,
														result_o,
														fflags_o,
														iflags_o,
														user_o});

			$fwrite(tfv_in_file, "%h %h %h %h %h %h %h %h %h %h %h\n",
							op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, result_o, fflags_o, iflags_o, user_i, user_o, fn_i);
		end

		$fclose(tfv_in_file);
	endfunction

	function void extract_phase(uvm_phase phase);
		`uvm_info(get_name(), "extract_phase starts", UVM_FULL)

		ioqueue_to_file();

		`uvm_info(get_name(), "extract_phase finishes", UVM_FULL)
	endfunction

	function void check_ioqueue_size();
		if (in_queue_size != out_queue_size) begin
			num_env_err = num_env_err + 1;
			`uvm_error(get_name,
								 $sformatf("\nnumber of input operations doesn't equal number of output operations, in = %0d, out = %0d",
								 in_queue_size, out_queue_size))
		end

		if (in_queue_size != (m_fpu_ft_opts.num_seq_item - m_fpu_ft_opts.num_iseq_item - m_fpu_ft_opts.num_not_handshake - num_rst - num_env_err_o)) begin
			num_env_err = num_env_err + 1;
			`uvm_error(get_name,
								 $sformatf("\nnumber of input operations doesn't equal actual total number of operations, in = %0d, ref = %0d",
								 in_queue_size, m_fpu_ft_opts.num_seq_item - m_fpu_ft_opts.num_iseq_item - m_fpu_ft_opts.num_not_handshake - num_rst - num_env_err_o))
		end

		if (out_queue_size != (m_fpu_ft_opts.num_seq_item - m_fpu_ft_opts.num_iseq_item - m_fpu_ft_opts.num_not_handshake - num_rst - num_env_err_o)) begin
			num_env_err = num_env_err + 1;
			`uvm_error(get_name,
								 $sformatf("\nnumber of output operations doesn't equal actual total number of operations, out = %0d, ref = %0d",
								 out_queue_size, m_fpu_ft_opts.num_seq_item - m_fpu_ft_opts.num_iseq_item - m_fpu_ft_opts.num_not_handshake - num_rst - num_env_err_o))
		end
	endfunction

	function void check_flag_and_user();
		for (int j = 0; j < comb_queue.size(); j++) begin
			{op_i,
			 rm_i,
			 fn_i,
			 operand_a_i,
			 operand_b_i,
			 operand_c_i,
			 user_i,
			 result_o,
			 fflags_o,
			 iflags_o,
			 user_o} = comb_queue.pop_front();

			if (user_i != user_o) begin
				num_env_err = num_env_err + 1;
				`uvm_error(get_name,
									 $sformatf("\nuser signals doesn't match, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
			end

			case(op_i)
				`FADD, `FSUB, `FMUL, `FMADD, `FMSUB, `FMNADD, `FMNSUB: begin
					if (iflags_o != 4'b0000) begin
						num_env_err = num_env_err + 1;
						`uvm_error(get_name,
											 $sformatf("\niflags occur with float operation, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 		 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
					end
				end
				`ADD, `SUB, `MUL, `MULH, `MADD, `MSUB, `MNADD, `MNSUB, `ADD_U, `SUB_U, `MUL_U, `MULH_U, `MUL_SU, `MULH_SU: begin
					if (fflags_o != 6'b000000) begin
						num_env_err = num_env_err + 1;
						`uvm_error(get_name,
											 $sformatf("\nfflags occur with integer operation, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 		 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
					end
				end
				`FDIV, `FSQRT, `FEXP, `FLOG: begin
					if (iflags_o != 4'b0000) begin
						num_env_err = num_env_err + 1;
						`uvm_error(get_name,
											 $sformatf("\niflags occur with float operation, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 		 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
					end
				end
				`DIV_S, `DIV_U, `REM_S, `REM_U: begin
					if (fflags_o != 6'b000000) begin
						num_env_err = num_env_err + 1;
						`uvm_error(get_name,
											 $sformatf("\nfflags occur with integer operation, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 		 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
					end
				end
				`FMIN, `FMAX, `FEQ, `FLT, `FLE, `FNE, `FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU: begin
					if (iflags_o != 4'b0000) begin
						num_env_err = num_env_err + 1;
						`uvm_error(get_name,
											 $sformatf("\niflags occur with float operation, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 		 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
					end
				end
				default: begin
					num_env_err = num_env_err + 1;
					`uvm_error(get_name,
										 $sformatf("\noperation is not supported, op = %h, rm = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, res = %h, ff = %h, if = %h, uso = %h",
									 	 op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, user_i, result_o, fflags_o, iflags_o, user_o))
				end
			endcase
		end
	endfunction

	function void tfv_num_env_err();
		int num_log_err_file;
		//int num_sva_err_file;
		int tfv_out_file;
		int status;

`ifdef FOR_DEBUG
		$system($sformatf("grep -c NG tfv_out_file > num_log_err"));
`else
		tfv_out_file = $fopen("tfv_out_file", "r");
		$fclose(tfv_out_file);

		if (tfv_out_file) begin
			has_tfvo_file = "yes";
			$system("./fexp_of_uf_confirmation.csh");
			$system("./flog_LSB_confirmation.csh");
			$system($sformatf("egrep -c \"expected|Invalid|No such file or directory\" tfv_out_file > num_log_err"));
		end else begin
			has_tfvo_file = "no";
			$system("rm -rf tfv_out_file");
		end
`endif
		num_log_err_file = $fopen("num_log_err", "r");
		status = $fscanf(num_log_err_file, "%d", num_log_err);
		$fclose(num_log_err_file);
		//$display("\nnumber of C model error = %0d, status = %0d", num_log_err, status);
		//`uvm_info(get_name(), $sformatf("\nnumber of C model error = %0d", num_log_err), UVM_FULL)
		//num_env_err = num_env_err + num_log_err;

		//$system($sformatf("egrep -c \"Error: \" run_sim.log > num_sva_err"));
		//num_sva_err_file = $fopen("num_sva_err", "r");
		//status = $fscanf(num_sva_err_file, "%d", num_sva_err);
		//$fclose(num_sva_err_file);
		//$display("\nnumber of SVA error = %0d, status = %0d", num_sva_err, status);
		//`uvm_info(get_name(), $sformatf("\nnumber of SVA error = %0d", num_sva_err), UVM_FULL)
		//num_env_err = num_env_err + num_sva_err;
	endfunction

	function void check_phase(uvm_phase phase);
		`uvm_info(get_name(), "check_phase starts", UVM_FULL)
		`uvm_info(get_name(),
							$sformatf("\nnum_seq_item = %0d, num_iseq_item = %0d, num_not_handshake = %0d, num_stall_i = %0d, num_rst = %0d, num_env_err_o = %0d",
							m_fpu_ft_opts.num_seq_item, m_fpu_ft_opts.num_iseq_item, m_fpu_ft_opts.num_not_handshake, num_stall_i, num_rst, num_env_err_o), UVM_FULL)

`ifdef FOR_DEBUG
		$system($sformatf("python ../fpu_sim/call_model.py"));
`else
		$system($sformatf("python ../fpu_sim/call_regression.py"));
`endif
		check_ioqueue_size();
		check_flag_and_user();
		tfv_num_env_err();

		`uvm_info(get_name(), "check_phase finishes", UVM_FULL)
	endfunction

	function void result_report();
		//if (((num_env_err + num_log_err + num_sva_err) == 0) && (m_fpu_ft_opts.num_seq_item != 0) && (has_tfvo_file == "yes")) begin
		if (((num_env_err + num_log_err) == 0) && (m_fpu_ft_opts.num_seq_item != 0) && (has_tfvo_file == "yes")) begin
			$display("//////////////////////////////////////////");
			$display("// SIMULATION PASSED                    //");
			$display("// env error number = %8d          //",num_env_err);
			$display("// C   error number = %8d          //",num_log_err);
			//$display("// sva error number = %8d          //",num_sva_err);
			$display("// valid_i number   = %8d          //",m_fpu_ft_opts.num_seq_item);
			$display("// has_tfv_out_file = %8s          //",has_tfvo_file);
			$display("//////////////////////////////////////////");
		end else begin
			$display("//////////////////////////////////////////");
			$display("// SIMULATION FAILED                    //");
			$display("// env error number = %8d          //",num_env_err);
			$display("// C   error number = %8d          //",num_log_err);
			//$display("// sva error number = %8d          //",num_sva_err);
			$display("// valid_i number   = %8d          //",m_fpu_ft_opts.num_seq_item);
			$display("// has_tfv_out_file = %8s          //",has_tfvo_file);
			$display("//////////////////////////////////////////");
		end
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info(get_name(), "report_phase starts", UVM_FULL)

		result_report();

		`uvm_info(get_name(), "report_phase finishes", UVM_FULL)
	endfunction

	function clean_variables();
		num_stall_i = 0;
		num_rst     = 0;
		num_env_err = 0;
		m_fpu_ft_opts.num_seq_item      = 0;
		m_fpu_ft_opts.num_iseq_item     = 0;
		m_fpu_ft_opts.num_not_handshake = 0;
	endfunction

	function void final_phase(uvm_phase phase);
		`uvm_info(get_name(), "final_phase starts", UVM_FULL)

		clean_variables();

		`uvm_info(get_name(), "final_phase finishes", UVM_FULL)
	endfunction
endclass
