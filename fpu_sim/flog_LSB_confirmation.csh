#!/bin/csh -f

@ flog_condi = `egrep -c f32_log2 tfv_out_file`


###==== FEXP IGNORE CASE ====####
if ( ${flog_condi} != 0 ) then

    foreach line ("`egrep -n '\.\.\.\.\.. .* \.\.\.\.\..' tfv_out_file | sort -r -n`") 
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

endif

