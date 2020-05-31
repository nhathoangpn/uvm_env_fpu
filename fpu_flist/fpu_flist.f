+incdir+${AGENT_DIR}
+incdir+${ENV_DIR}
+incdir+${TOP_DIR}
+incdir+${TEST_DIR}

-F ${RTL_DIR}/fpu_top/rtl/fpu_rtl_list.f

${AGENT_DIR}/fpu_agent_pkg.sv
${AGENT_DIR}/fpu_if.sv
${AGENT_DIR}/fpu_if_bfm.sv

${ENV_DIR}/fpu_env_pkg.sv
${TEST_DIR}/fpu_test_pkg.sv

${TOP_DIR}/tb_top.sv
