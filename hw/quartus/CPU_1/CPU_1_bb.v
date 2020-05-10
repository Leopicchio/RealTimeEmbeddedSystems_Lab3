
module CPU_1 (
	clk_clk,
	cpu_1_outgoing_waitrequest,
	cpu_1_outgoing_readdata,
	cpu_1_outgoing_readdatavalid,
	cpu_1_outgoing_burstcount,
	cpu_1_outgoing_writedata,
	cpu_1_outgoing_address,
	cpu_1_outgoing_write,
	cpu_1_outgoing_read,
	cpu_1_outgoing_byteenable,
	cpu_1_outgoing_debugaccess,
	reset_reset_n);	

	input		clk_clk;
	input		cpu_1_outgoing_waitrequest;
	input	[31:0]	cpu_1_outgoing_readdata;
	input		cpu_1_outgoing_readdatavalid;
	output	[0:0]	cpu_1_outgoing_burstcount;
	output	[31:0]	cpu_1_outgoing_writedata;
	output	[27:0]	cpu_1_outgoing_address;
	output		cpu_1_outgoing_write;
	output		cpu_1_outgoing_read;
	output	[3:0]	cpu_1_outgoing_byteenable;
	output		cpu_1_outgoing_debugaccess;
	input		reset_reset_n;
endmodule
