//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_seq_base
// History:  20190621 Create new version
//==================================================================================================

class fpu_seq_base extends uvm_sequence #(fpu_seq_item);
	`uvm_object_utils(fpu_seq_base)

	`include "../fpu_top/fpu_def.svh"

	static bit [`USRI_W - 1 : 0] user_db[$:50];

	rand int sub_num_seq_item;

	rand logic [`VLDI_W - 1 : 0] sqb_valid_i;
	rand logic [`OP_W   - 1 : 0] sqb_op_i;
	rand logic [`OPD_W  - 1 : 0] sqb_operand_a_i;
	rand logic [`OPD_W  - 1 : 0] sqb_operand_b_i;
	rand logic [`OPD_W  - 1 : 0] sqb_operand_c_i;
	rand logic [`RM_W   - 1 : 0] sqb_rm_i;
	rand logic [`FN_W   - 1 : 0] sqb_fn_i;
	rand logic [`USRI_W - 1 : 0] sqb_user_i;

	rand int sqb_num_wait_clk;
	rand bit sqb_test_final;
	rand bit sqb_handshake_i;

	function new(string name = "fpu_seq_base");
		super.new(name);
	endfunction

	function void post_randomize();
		//bit [1:0]  position     = $urandom_range(0,3);
		//bit [31:0] random_value = $urandom;

		//case (position)
		//	2'b00:   sqb_user_i = random_value[ 7: 0];
		//	2'b01:   sqb_user_i = random_value[15: 8];
		//	2'b10:   sqb_user_i = random_value[23:16];
		//	2'b11:   sqb_user_i = random_value[31:24];
		//	default: sqb_user_i = random_value[ 7: 0];
		//endcase

		bit [31:0] random_value;
		bit        curr_val_in_queue = 0;
		bit        rand_val_in_queue;

		for (int i = 0; i < user_db.size(); i++) begin
			if ((user_db[i] == sqb_user_i) || (sqb_user_i == 8'h00)) begin
				curr_val_in_queue = 1;
			end
		end

		if (curr_val_in_queue) begin
			while(1) begin
				rand_val_in_queue = 0;
				random_value = $urandom;
				sqb_user_i   = random_value[7:0];
				for (int j = 0; j < user_db.size(); j++) begin
					if ((user_db[j] == sqb_user_i) ||  (sqb_user_i == 8'h00)) begin
						rand_val_in_queue = 1;
					end
				end
				if (!rand_val_in_queue) begin
					break;
				end
			end
		end

		if (user_db.size() == 50) begin
			user_db.pop_front();
		end

		user_db.push_back(sqb_user_i);
		curr_val_in_queue = 0;
	endfunction

	task body();
		fpu_seq_item req_item;
		fpu_seq_item req_item_clone;

		req_item = fpu_seq_item::type_id::create("req_item");

		for (int i = 0; i < sub_num_seq_item; i++) begin
			$cast(req_item_clone, req_item);
			start_item(req_item_clone);
			if(!req_item_clone.randomize() with {
				valid_i      == sqb_valid_i     ;
				op_i         == sqb_op_i        ;
				operand_a_i  == sqb_operand_a_i ;
				operand_b_i  == sqb_operand_b_i ;
				operand_c_i  == sqb_operand_c_i ;
				rm_i         == sqb_rm_i        ;
				fn_i         == sqb_fn_i        ;
				user_i       == sqb_user_i      ;
				num_wait_clk == sqb_num_wait_clk;
				test_final   == sqb_test_final  ;
				handshake_i  == sqb_handshake_i ;})
				`uvm_fatal("SEQ_RAND", "cannot randomize req_item_clone")

			finish_item(req_item_clone);
			`uvm_info(get_name(), "finish_item() finishes", UVM_FULL)
		end
	endtask
endclass
