
module CPU_0 (
	clk_clk,
	cpu_0_outgoing_waitrequest,
	cpu_0_outgoing_readdata,
	cpu_0_outgoing_readdatavalid,
	cpu_0_outgoing_burstcount,
	cpu_0_outgoing_writedata,
	cpu_0_outgoing_address,
	cpu_0_outgoing_write,
	cpu_0_outgoing_read,
	cpu_0_outgoing_byteenable,
	cpu_0_outgoing_debugaccess,
	reset_reset_n);	

	input		clk_clk;
	input		cpu_0_outgoing_waitrequest;
	input	[31:0]	cpu_0_outgoing_readdata;
	input		cpu_0_outgoing_readdatavalid;
	output	[0:0]	cpu_0_outgoing_burstcount;
	output	[31:0]	cpu_0_outgoing_writedata;
	output	[27:0]	cpu_0_outgoing_address;
	output		cpu_0_outgoing_write;
	output		cpu_0_outgoing_read;
	output	[3:0]	cpu_0_outgoing_byteenable;
	output		cpu_0_outgoing_debugaccess;
	input		reset_reset_n;
endmodule
