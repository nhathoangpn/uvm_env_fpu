#! /usr/bin/python
import subprocess
import os

print('Hi the exciting FPU world!!!!')

tfvi		= 'tfv_in_file'
tfvi_t	= 'tfv_in_file_tmp'
tfvo		= 'tfv_out_file'
tfvo_t	= 'tfv_out_file_tmp'

tfv_cmdi = "cat {} | ../testfloat/Lib/TestFloat-3e/build/Linux-x86_64-GCC/testfloat_ver".format(tfvi_t)
tfv_cmdo = "> tfv_out_file_tmp"

def fpu_dec_func(in_list):
	operation_str		= ''
	operation_opt		= ''
	round_mode_str	= ''
	round_mode_opt	= ''
	tfv_in_list			= ''

	if   in_list[1] == '0':
		round_mode_str = 'RNE'
		round_mode_opt = '-rnear_even'
	elif in_list[1] == '1':
		round_mode_str = 'RTZ'
		round_mode_opt = '-rminMag'
	elif in_list[1] == '2':
		round_mode_str = 'RDN'
		round_mode_opt = '-rmin'
	elif in_list[1] == '3':
		round_mode_str = 'RUP'
		round_mode_opt = '-rmax'
	elif in_list[1] == '4':
		round_mode_str = 'RMM'
		round_mode_opt = '-rnear_maxMag'
	else:
		round_mode_str = 'none'
		round_mode_opt = 'none'

	'''in_list = [op, rm, opa, opb, opc, rs, ff, if]'''
	'''in_list = [ 0,  1,   2,   3,   4,  5,  6,  7]'''
	if   in_list[0] == '00':
		operation_str = 'fadd'
		operation_opt = 'f32_add'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '01':
		operation_str = 'fsub'
		operation_opt = 'f32_sub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '02':
		operation_str = 'fmul'
		operation_opt = 'f32_mul'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '04':
		operation_str = 'fmadd'
		operation_opt = 'f32_mulAdd'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '05':
		operation_str = 'fmsub'
		operation_opt = 'f32_mulSub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '06':
		operation_str = 'fmnadd'
		operation_opt = 'f32_mulNegateAdd'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '07':
		operation_str = 'fmnsub'
		operation_opt = 'f32_mulNegateSub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '10':
		operation_str = 'add'
		operation_opt = 'i32_add'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '11':
		operation_str = 'add_u'
		operation_opt = 'ui32_add'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '12':
		operation_str = 'sub'
		operation_opt = 'i32_sub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '13':
		operation_str = 'sub_u'
		operation_opt = 'ui32_sub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '14':
		operation_str = 'mul'
		operation_opt = 'i32_mul'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '15':
		operation_str = 'mul_u'
		operation_opt = 'ui32_mul'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '16':
		operation_str = 'mul_su'
		operation_opt = 'i32_ui32_mul'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '18':
		operation_str = 'madd'
		operation_opt = 'i32_mulAdd'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '1A':
		operation_str = 'mnadd'
		operation_opt = 'i32_mulnegateAdd'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '1C':
		operation_str = 'msub'
		operation_opt = 'i32_mulSub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '1E':
		operation_str = 'mnsub'
		operation_opt = 'i32_mulNegateSub'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[4], in_list[5], '0' + in_list[7]))
	elif in_list[0] == '20':
		operation_str = 'fdiv'
		operation_opt = 'f32_div'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '21':
		operation_str = 'fsqrt'
		operation_opt = 'f32_sqrt'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '22':
		operation_str = 'fexp'
		operation_opt = 'Mpfr_exp2'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '23':
		operation_str = 'flog'
		operation_opt = 'Mpfr_log2'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '30':
		operation_str = 'div_s'
		operation_opt = 'i32_div'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '31':
		operation_str = 'div_u'
		operation_opt = 'ui32_div'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '32':
		operation_str = 'rem_s'
		operation_opt = 'i32_rem'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '33':
		operation_str = 'rem_u'
		operation_opt = 'ui32_rem'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], '0' + in_list[7]))
	elif in_list[0] == '40':
		operation_str = 'fmin'
		operation_opt = 'f32_min'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '41':
		operation_str = 'fmax'
		operation_opt = 'f32_max'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '42':
		operation_str = 'feq'
		operation_opt = 'f32_eq'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][15], in_list[6]))
	elif in_list[0] == '43':
		operation_str = 'flt'
		operation_opt = 'f32_lt'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][15], in_list[6]))
	elif in_list[0] == '44':
		operation_str = 'fle'
		operation_opt = 'f32_le'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][15], in_list[6]))
	elif in_list[0] == '45':
		operation_str = 'fne'
		operation_opt = 'f32_ne'
		tfv_in_list		= list((in_list[2], in_list[3], in_list[5][15], in_list[6]))
	elif in_list[0] == '50':
		operation_str = 'fcvt_w_s'
		operation_opt = 'f32_to_i32'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '51':
		operation_str = 'fcvt_wu_s'
		operation_opt = 'f32_to_ui32'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '52':
		operation_str = 'fcvt_s_w'
		operation_opt = 'i32_to_f32'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	elif in_list[0] == '53':
		operation_str = 'fcvt_s_wu'
		operation_opt = 'ui32_to_f32'
		tfv_in_list		= list((in_list[2], in_list[5][8:16], in_list[6]))
	else:
		operation_str = 'none'
		operation_opt = 'none'
		tfv_in_list		= '{} {} {} {}'.format(in_list[2], in_list[3], in_list[5], in_list[6])

	out_list = list((operation_str, operation_opt, in_list[0], round_mode_str, round_mode_opt, in_list[1], tfv_in_list))
	return out_list

with open(tfvo, 'w') as tfvo_file:
	with open(tfvi, 'r') as tfvi_file:
		for tfvi_line in tfvi_file:
			tfvo_wline = []
			tfvi_llist = tfvi_line.split()
			tfvo_wline = fpu_dec_func(tfvi_llist)

			with open(tfvi_t, 'w') as tfvi_tmp:
				for item in range(0,len(tfvo_wline[6])):
					tfvi_tmp.write(tfvo_wline[6][item])
					if item < (len(tfvo_wline[6]) - 1):
						tfvi_tmp.write(' ')
					else:
						tfvi_tmp.write('\n')

			os.system("{} {} {} {}".format(tfv_cmdi, tfvo_wline[1], tfvo_wline[4], tfv_cmdo))

			with open(tfvo_t, 'r') as tfvo_tmp:
				tfvo_tmp_line = tfvo_tmp.readlines()
				if 'no errors' in tfvo_tmp_line[0]:
					tfvo_wline_tail = 'OK'
				elif 'Errors' in tfvo_tmp_line[0]:
					if ('expected') in tfvo_tmp_line[1]:
						exp_value_tmp = tfvo_tmp_line[1].split()
						exp_value = exp_value_tmp[exp_value_tmp.index("expected")+1:]
					elif ('expected') in tfvo_tmp_line[2]:
						exp_value_tmp = tfvo_tmp_line[2].split()
						exp_value = exp_value_tmp[exp_value_tmp.index("expected")+1:]
					tfvo_wline_tail = 'NG {}'.format(' '.join(exp_value))
				elif 'Invalid' in tfvo_tmp_line[0]:
					exp_value = 'Invalid'
					tfvo_wline_tail = 'NG {}'.format(exp_value)

			tfvo_wline.append(' '.join(tfvo_wline.pop()))
			tfvo_wline.append(tfvo_wline_tail)
			tfvo_file.write(' '.join(tfvo_wline))
			tfvo_file.write('\n')
			del tfvo_wline
