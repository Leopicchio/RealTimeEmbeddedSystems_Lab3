	CPU_0 u0 (
		.clk_clk                      (<connected-to-clk_clk>),                      //            clk.clk
		.cpu_0_outgoing_waitrequest   (<connected-to-cpu_0_outgoing_waitrequest>),   // cpu_0_outgoing.waitrequest
		.cpu_0_outgoing_readdata      (<connected-to-cpu_0_outgoing_readdata>),      //               .readdata
		.cpu_0_outgoing_readdatavalid (<connected-to-cpu_0_outgoing_readdatavalid>), //               .readdatavalid
		.cpu_0_outgoing_burstcount    (<connected-to-cpu_0_outgoing_burstcount>),    //               .burstcount
		.cpu_0_outgoing_writedata     (<connected-to-cpu_0_outgoing_writedata>),     //               .writedata
		.cpu_0_outgoing_address       (<connected-to-cpu_0_outgoing_address>),       //               .address
		.cpu_0_outgoing_write         (<connected-to-cpu_0_outgoing_write>),         //               .write
		.cpu_0_outgoing_read          (<connected-to-cpu_0_outgoing_read>),          //               .read
		.cpu_0_outgoing_byteenable    (<connected-to-cpu_0_outgoing_byteenable>),    //               .byteenable
		.cpu_0_outgoing_debugaccess   (<connected-to-cpu_0_outgoing_debugaccess>),   //               .debugaccess
		.reset_reset_n                (<connected-to-reset_reset_n>)                 //          reset.reset_n
	);

