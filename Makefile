main:
	iverilog -o any_name.vvp top.v top_tb.v controller.v ALU.v ALU_NOT_5bit.v ALU_ROL_5bit.v ALU_tb.v
	iverilog -o any_name.vvp ALU.v ALU_NOT_5bit.v ALU_ROL_5bit.v ALU_tb.v
	vvp any_name.vvp
	gtkwave alu_test.vcd
	gtkwave top_test.vcd