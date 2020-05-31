#! /usr/bin/perl
if( ! -d "temp_log" ){
        mkdir "temp_log";
}
if( ! -d "temp_log/line" ){
        mkdir "temp_log/line";
}
if( ! -d "temp_log/fsm" ){
        mkdir "temp_log/fsm";
}
if( ! -d "temp_log/cond" ){
        mkdir "temp_log/cond";
}
if( ! -d "temp_log/branch" ){
        mkdir "temp_log/branch";
}
if( ! -d "temp_log/assert" ){
        mkdir "temp_log/assert";
}
if( ! -d "./temp_log/group" ){
        mkdir "./temp_log/group";
}
if( ! -d "./temp_log/tgl" ){
            mkdir "./temp_log/tgl";
}

if( ! -d "./temp_log/MOD/all" ){
        mkdir "./temp_log/all";
}

if( ! -d "./temp_log/MOD/all_detail" ){
            mkdir "./temp_log/all_detail";
}

if( ! -d "./temp_log/MOD/all_summary" ){
            mkdir "./temp_log/all_summary";
}


$COV_DIR = "cov_report/";
@COV_TYPE = ( "line", "fsm", "cond", "branch", "assert", "tgl", "all", "all_detail", "all_summary" );
$TYPE_NUM = $#COV_TYPE + 1;

for ( $i = 0 ;$i < $TYPE_NUM; $i++  ){
    if( @COV_TYPE[$i] eq all_summary ){

        $INFO_FILE=$COV_DIR.@COV_TYPE[$i]."/groups.txt";
        warn "$INFO_FILE";
        open(INFO_GROUP,$INFO_FILE);
        open($GROUP,">./temp_log/@COV_TYPE[$i]"."/"."001_group.log");
        while($line = <INFO_GROUP>){
            print $GROUP "$line";
        }
        
        $INFO_FILE=$COV_DIR.@COV_TYPE[$i]."/hierarchy.txt";
        warn "$INFO_FILE";
        open(INFO_HIERARCHY,$INFO_FILE);
        open($HIERARCHY,">./temp_log/@COV_TYPE[$i]"."/002_hierarchy.log");
        while($line = <INFO_HIERARCHY>){
            print $HIERARCHY "$line";
        }

        push @WRITE_FP,"GROUP";
        push @WRITE_FP,"HIERARCHY";
        close(INFO_GROUP);
        close(INFO_HIERARCHY);
        
    }else{
        $INFO_FILE = $COV_DIR.@COV_TYPE[$i]."/modinfo.txt" ;
        open(MODINFO,$INFO_FILE);
        warn "$INFO_FILE ----------------------------------";
        $dump_on = 1;
        $i_inst = 1;
        $i_mod  = 1;
        $fp_cnt = 0;
        $INST_FP = 0;


        while($line = <MODINFO>){
            @CurrentLine = split(/\s+/,$line);
            #if( $line =~ /Since/ ){
            #    $dump_on = 1;
            #}
            #elsif( @CurrentLine[1] =~ /Instance/ ){
            if( @CurrentLine[1] =~ /Instance/ ){
                $inst_on = 1;
                $mod_on  = 0;
                if($dump_on == 1 && @COV_TYPE[$i] ne "all" ){
                    $INST_FP = @CurrentLine[3];
                    $INST_NAME = ">./temp_log/@COV_TYPE[$i]"."/".sprintf("%03d",$i_inst)."_"."@CurrentLine[3]".".log";
                    open($INST_FP,$INST_NAME);
                    push @WRITE_FP,@CurrentLine[3];
                    $i_inst++;
                }
            }
            elsif( @CurrentLine[0] =~ /Module/ && @CurrentLine[1] =~ /:/ && $PreviousLine =~ /=/  ){
                $mod_on  = 1;
                $inst_on = 0;
                if($dump_on == 1 && @COV_TYPE[$i] eq "all"){
                    $MOD_FP = @CurrentLine[2];
                    $MOD_NAME = ">./temp_log/@COV_TYPE[$i]"."/".sprintf("%03d",$i_mod)."_"."@CurrentLine[2]".".log";
                    open($MOD_FP,$MOD_NAME);
                    push @WRITE_FP,@CurrentLine[2];
                    $i_mod++;
                }
            }

            if( $dump_on == 1 ){
                if( $inst_on == 1 && @COV_TYPE[$i] ne "all"){
                    print $INST_FP "$PreviousLine";
                }
                if( $mod_on == 1 && @COV_TYPE[$i] eq "all"){
                    print $MOD_FP "$PreviousLine";
                }
            }
            $PreviousLine = $line;
        }
    }
    if( @COV_TYPE[$i] ne all_summary ){
        close(MODINFO);
    }
}

foreach(@WRITE_FP){
    close($_);
}


