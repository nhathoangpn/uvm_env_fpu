//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_if_bfm
// History:  2019.06.21 Create new version
//==================================================================================================

interface fpu_if_bfm (fpu_if m_fpu_if);
	`include "../fpu_top/fpu_def.svh"

	import fpu_agent_pkg::fpu_mon;
	import fpu_agent_pkg::fpu_seq_item;
	import fpu_agent_pkg::fpu_mon_item;

	fpu_mon mon_stdin;

	task automatic rst_gen_direct(int num_wait_clk, int rst_width);
		repeat(num_wait_clk) @(posedge m_fpu_if.clk);
		m_fpu_if.rst <= 1;
		repeat(rst_width) @(posedge m_fpu_if.clk);
		m_fpu_if.rst <= 0;
	endtask

	task automatic stall_gen_direct(int num_wait_clk, int stall_width);
		repeat(num_wait_clk) @(posedge m_fpu_if.clk);
		m_fpu_if.stall_i <= 1;
		repeat(stall_width) @(posedge m_fpu_if.clk);
		m_fpu_if.stall_i <= 0;
	endtask

	task automatic rst_gen_rand(int ratio, int rst_width);
		forever begin
			@(posedge m_fpu_if.clk);
			randcase
				ratio      : m_fpu_if.rst <= 1;
				100 - ratio: m_fpu_if.rst <= 0;
			endcase
			if (m_fpu_if.rst)
				repeat(rst_width - 1) @(posedge m_fpu_if.clk);
		end
	endtask

	task automatic stall_gen_rand(int ratio, int stall_width);
		forever begin
			@(posedge m_fpu_if.clk);
			randcase
				ratio      : m_fpu_if.stall_i <= 1;
				100 - ratio: m_fpu_if.stall_i <= 0;
			endcase
			if (m_fpu_if.stall_i)
				repeat(stall_width - 1) @(posedge m_fpu_if.clk);
		end
	endtask

	task automatic drive_bfm(fpu_seq_item req_item);
		if (req_item.num_wait_clk > 1) begin
			@(posedge m_fpu_if.clk);
			m_fpu_if.valid_i <= 0;
			repeat(req_item.num_wait_clk - 1) @(posedge m_fpu_if.clk);
		end else begin
			repeat(req_item.num_wait_clk) @(posedge m_fpu_if.clk);
		end

		m_fpu_if.valid_i     <= req_item.valid_i;
		m_fpu_if.op_i        <= req_item.op_i;
		m_fpu_if.operand_a_i <= req_item.operand_a_i;
		m_fpu_if.operand_b_i <= req_item.operand_b_i;
		m_fpu_if.operand_c_i <= req_item.operand_c_i;
		m_fpu_if.rm_i        <= req_item.rm_i;
		m_fpu_if.fn_i        <= req_item.fn_i;
		m_fpu_if.user_i      <= req_item.user_i;

		while (1) begin
			@(negedge m_fpu_if.clk);
			if (m_fpu_if.valid_i & (!m_fpu_if.ready_o) & req_item.handshake_i) begin
				@(posedge m_fpu_if.clk);
			end else begin
				break;
			end
		end
	endtask

	task automatic capture_bfm_i();
		fpu_seq_item seq_item, seq_item_grs;

		forever begin
			seq_item = fpu_seq_item::type_id::create("seq_item");
			seq_item_grs = fpu_seq_item::type_id::create("seq_item_grs");
			@(posedge m_fpu_if.clk);

			if (m_fpu_if.valid_i & m_fpu_if.ready_o) begin
				seq_item.op_i        = m_fpu_if.op_i;
				seq_item.operand_a_i = m_fpu_if.operand_a_i;
				seq_item.operand_b_i = m_fpu_if.operand_b_i;
				seq_item.operand_c_i = m_fpu_if.operand_c_i;
				seq_item.rm_i        = m_fpu_if.rm_i;
				seq_item.fn_i        = m_fpu_if.fn_i;
				seq_item.user_i      = m_fpu_if.user_i;
				seq_item.rst         = m_fpu_if.rst;
				seq_item.valid_i     = m_fpu_if.valid_i;
				seq_item.ready_o     = m_fpu_if.ready_o;
				seq_item.valid_o     = m_fpu_if.valid_o;
				seq_item_grs.op_i        = m_fpu_if.op_i;
				seq_item_grs.operand_a_i = m_fpu_if.operand_a_i;
				seq_item_grs.operand_b_i = m_fpu_if.operand_b_i;
				seq_item_grs.operand_c_i = m_fpu_if.operand_c_i;
				seq_item_grs.rm_i        = m_fpu_if.rm_i;
				seq_item_grs.fn_i        = m_fpu_if.fn_i;
				seq_item_grs.user_i      = m_fpu_if.user_i;
				seq_item_grs.rst         = m_fpu_if.rst;
				seq_item_grs.valid_i     = m_fpu_if.valid_i;
				seq_item_grs.ready_o     = m_fpu_if.ready_o;
				seq_item_grs.valid_o     = m_fpu_if.valid_o;

				mon_stdin.broadcast_seq_item(seq_item);
				mon_stdin.broadcast_seq_item_grs(seq_item_grs);
				//$display("Printing seq_item:     op = %h, rm = %h, fn = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, rst = %b",
				//seq_item.op_i, seq_item.rm_i, seq_item.fn_i, seq_item.operand_a_i, seq_item.operand_b_i, seq_item.operand_c_i, seq_item.user_i, seq_item.rst);
				//$display("Printing seq_item_grs: op = %h, rm = %h, fn = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, rst = %b",
				//seq_item_grs.op_i, seq_item_grs.rm_i, seq_item_grs.fn_i, seq_item_grs.operand_a_i, seq_item_grs.operand_b_i, seq_item_grs.operand_c_i, seq_item_grs.user_i, seq_item_grs.rst);

			end else if (m_fpu_if.rst) begin
				seq_item.op_i        = m_fpu_if.op_i;
				seq_item.operand_a_i = m_fpu_if.operand_a_i;
				seq_item.operand_b_i = m_fpu_if.operand_b_i;
				seq_item.operand_c_i = m_fpu_if.operand_c_i;
				seq_item.rm_i        = m_fpu_if.rm_i;
				seq_item.fn_i        = m_fpu_if.fn_i;
				seq_item.user_i      = m_fpu_if.user_i;
				seq_item.rst         = m_fpu_if.rst;
				seq_item.valid_i     = m_fpu_if.valid_i;
				seq_item.ready_o     = m_fpu_if.ready_o;
				seq_item.valid_o     = m_fpu_if.valid_o;
				seq_item_grs.op_i        = m_fpu_if.op_i;
				seq_item_grs.operand_a_i = m_fpu_if.operand_a_i;
				seq_item_grs.operand_b_i = m_fpu_if.operand_b_i;
				seq_item_grs.operand_c_i = m_fpu_if.operand_c_i;
				seq_item_grs.rm_i        = m_fpu_if.rm_i;
				seq_item_grs.fn_i        = m_fpu_if.fn_i;
				seq_item_grs.user_i      = m_fpu_if.user_i;
				seq_item_grs.rst         = m_fpu_if.rst;
				seq_item_grs.valid_i     = m_fpu_if.valid_i;
				seq_item_grs.ready_o     = m_fpu_if.ready_o;
				seq_item_grs.valid_o     = m_fpu_if.valid_o;

				mon_stdin.broadcast_seq_item(seq_item);
				mon_stdin.broadcast_seq_item_grs(seq_item_grs);
			end
		end
	endtask

	task automatic capture_bfm_o();
		fpu_mon_item mon_item, mon_item_grs;

		forever begin
			mon_item = fpu_mon_item::type_id::create("mon_item");
			mon_item_grs = fpu_mon_item::type_id::create("mon_item_grs");
			@(posedge m_fpu_if.clk);

			if (m_fpu_if.valid_o_arith) begin
				mon_item_grs.guard_bit_arith  = m_fpu_if.guard_bit_arith;
				mon_item_grs.round_bit_arith  = m_fpu_if.round_bit_arith;
				mon_item_grs.sticky_bit_arith = m_fpu_if.sticky_bit_arith;

				mon_stdin.broadcast_mon_item_grs(mon_item_grs);
				//$display("Arith: GRS = %h%h%h", mon_item_grs.guard_bit_arith, mon_item_grs.round_bit_arith, mon_item_grs.sticky_bit_arith);
			end
			if (m_fpu_if.valid_o_spmath_div_sqrt | m_fpu_if.valid_o_spmath_log_exp) begin
				mon_item_grs.guard_bit_spmath  = m_fpu_if.guard_bit_spmath;
				mon_item_grs.round_bit_spmath  = m_fpu_if.round_bit_spmath;
				mon_item_grs.sticky_bit_spmath = m_fpu_if.sticky_bit_spmath;

				mon_stdin.broadcast_mon_item_grs(mon_item_grs);
				//$display("Spmath: GRS = %h%h%h", mon_item_grs.guard_bit_spmath, mon_item_grs.round_bit_spmath, mon_item_grs.sticky_bit_spmath);
			end
			if (m_fpu_if.valid_o_cmpcnv_i2f) begin
				mon_item_grs.guard_bit_cmpcnv_i2f  = m_fpu_if.guard_bit_cmpcnv_i2f;
				mon_item_grs.round_bit_cmpcnv_i2f  = m_fpu_if.round_bit_cmpcnv_i2f;
				mon_item_grs.sticky_bit_cmpcnv_i2f = m_fpu_if.sticky_bit_cmpcnv_i2f;

				mon_stdin.broadcast_mon_item_grs(mon_item_grs);
				//$display("Cmpcnv_i2f: GRS = %h%h%h", mon_item_grs.guard_bit_cmpcnv_i2f, mon_item_grs.round_bit_cmpcnv_i2f, mon_item_grs.sticky_bit_cmpcnv_i2f);
			end
			if (m_fpu_if.valid_o_cmpcnv_f2i) begin
				mon_item_grs.fraction_0_cmpcnv_f2i  = m_fpu_if.fraction_0_cmpcnv_f2i;
				mon_item_grs.fraction_1_cmpcnv_f2i  = m_fpu_if.fraction_1_cmpcnv_f2i;

				mon_stdin.broadcast_mon_item_grs(mon_item_grs);
				//$display("Cmpcnv_f2i: Fraction[1:0] = %h%h", mon_item_grs.fraction_1_cmpcnv_f2i, mon_item_grs.fraction_0_cmpcnv_f2i);
			end
			if (m_fpu_if.valid_o) begin
				mon_item.result_o = m_fpu_if.result_o;
				mon_item.fflags_o = m_fpu_if.fflags_o;
				mon_item.iflags_o = m_fpu_if.iflags_o;
				mon_item.user_o   = m_fpu_if.user_o;
				mon_item.error_o  = m_fpu_if.error_o;
				mon_item.stall_i  = m_fpu_if.stall_i;
				mon_item.rst      = m_fpu_if.rst;

				mon_stdin.broadcast_mon_item(mon_item);
			end
		end
	endtask

	task automatic drive_ctrl_i(bit value);
		@(posedge m_fpu_if.clk);
		m_fpu_if.valid_i <= {`VLDI_W{value}};
		m_fpu_if.stall_i <= {`STLL_W{value}};
		m_fpu_if.rst     <= value;
	endtask

	task automatic drive_valid_i(bit [`VLDI_W - 1 : 0] value);
		@(posedge m_fpu_if.clk);
		m_fpu_if.valid_i <= value;
	endtask

	task automatic drive_stall_i(bit [`STLL_W - 1 : 0] value);
		@(posedge m_fpu_if.clk);
		m_fpu_if.stall_i <= value;
	endtask

	task automatic drive_rst(bit value);
		@(posedge m_fpu_if.clk);
		m_fpu_if.rst <= value;
	endtask

	task automatic wait_for_op(int pos, bit[`OP_W-1:0] op);
		int itr = 0;
		while (itr < pos) begin
			@(posedge m_fpu_if.clk);
			if (m_fpu_if.op_i == op) begin
				itr = itr + 1;
			end
		end
	endtask
endinterface 
