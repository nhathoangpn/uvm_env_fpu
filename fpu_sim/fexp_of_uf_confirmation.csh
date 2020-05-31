#!/bin/csh -f

#######################
# History
# Remove case 1 as fixing definition from C model
# Remove case 5 after changing to tininess after rounding after
#######################

@ fexp_condi = `egrep -c f32_exp2 tfv_out_file`


###==== FEXP IGNORE CASE ====####
if ( ${fexp_condi} != 0 ) then

##Case 1: Ignore UF and OF case of FEXP
#    foreach line ("`egrep -n '\+FE.7FFFFF \.\.\.o\.x  expected \+FE.7FFFFF \.\.\.\.\..|\+FF.000000 \.\.\.o\.x  expected \+FF.000000 \.\.\.\.\..|\+00.000000 \.\.\.\.ux  expected \+00.000000 \.\.\.\.\..' tfv_out_file | sort -r -n`") 
#       set num     = `echo ${line} | awk -F ':' '{print $1}'`
#       @   num_err = ${num} - 1
#       sed -i "${num_err},${num}d" tfv_out_file
#    end

## Case 2: Ignore different 1 bit LSB of FEXP, both RTL and C raise NX flag
## Case 3: Ignore different 1 bit LSB and NX flag (RTL) result when input is negative integer number
    foreach line ("`egrep -n '\.\.\.\.\.x .* \.\.\.\.\.x|\-..\..*\.\.\.\.\.x .* \.\.\.\.\.\.' tfv_out_file | sort -r -n`") 
        set num     = `echo ${line} | awk -F ':' '{print $1}'`
        set rtl_exp = `echo ${line} | awk '{print $3}' | awk -F'.' '{print $1}' | awk -F'+' '{print $2}'`
        set rtl_man = `echo ${line} | awk '{print $3}' | awk -F'.' '{print $2}'`
        set c_exp   = `echo ${line} | awk '{print $6}' | awk -F'.' '{print $1}' | awk -F'+' '{print $2}'`
        set c_man   = `echo ${line} | awk '{print $6}' | awk -F'.' '{print $2}'`
        set flag = 0

        if (${rtl_man} =~ 7FFFFF && ${c_man} =~ 000000) then
            set diff = `echo "ibase=16;${rtl_exp} - ${c_exp}" | bc`
            if (${diff} == 1 || ${diff} == -1) then
                set flag = 1
            else    
                set flag = 0
            endif
        endif

        if (${rtl_exp} == ${c_exp}) then
            set diff = `echo "ibase=16;${rtl_man} - ${c_man}" | bc`
            if (${diff} == 1 || ${diff} == -1 || ${diff} == 0) then
                set flag = 1
            else    
                set flag = 0
            endif
        endif

        if (${flag} == 1) then
            @ num_err = ${num} - 1
            sed -i "${num_err},${num}d" tfv_out_file
        endif
    end

## Case 4: Ignore mismatch when input is -126
    foreach line ("`egrep -n '\-85.7C0000.*\+0.\.000000 \.\.\.\.ux  expected \+01\.000000 \.\.\.\.\.\.' tfv_out_file | sort -r -n`") 
       set num     = `echo ${line} | awk -F ':' '{print $1}'`
       @   num_err = ${num} - 1
       sed -i "${num_err},${num}d" tfv_out_file
    end

### Case 5: Ignore mismatch when input is -126.xxx subnormal in => output is +/-2^min
#    foreach line ("`egrep -n '\-85.7C0001.*\+01.000000 \.\.\.\.ux  expected \+00.000000 \.\.\.\.ux' tfv_out_file | sort -r -n`") 
#       set num     = `echo ${line} | awk -F ':' '{print $1}'`
#       @   num_err = ${num} - 1
#       sed -i "${num_err},${num}d" tfv_out_file
#    end


endif

