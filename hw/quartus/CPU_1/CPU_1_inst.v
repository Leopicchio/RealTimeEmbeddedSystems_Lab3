	CPU_1 u0 (
		.clk_clk                      (<connected-to-clk_clk>),                      //            clk.clk
		.cpu_1_outgoing_waitrequest   (<connected-to-cpu_1_outgoing_waitrequest>),   // cpu_1_outgoing.waitrequest
		.cpu_1_outgoing_readdata      (<connected-to-cpu_1_outgoing_readdata>),      //               .readdata
		.cpu_1_outgoing_readdatavalid (<connected-to-cpu_1_outgoing_readdatavalid>), //               .readdatavalid
		.cpu_1_outgoing_burstcount    (<connected-to-cpu_1_outgoing_burstcount>),    //               .burstcount
		.cpu_1_outgoing_writedata     (<connected-to-cpu_1_outgoing_writedata>),     //               .writedata
		.cpu_1_outgoing_address       (<connected-to-cpu_1_outgoing_address>),       //               .address
		.cpu_1_outgoing_write         (<connected-to-cpu_1_outgoing_write>),         //               .write
		.cpu_1_outgoing_read          (<connected-to-cpu_1_outgoing_read>),          //               .read
		.cpu_1_outgoing_byteenable    (<connected-to-cpu_1_outgoing_byteenable>),    //               .byteenable
		.cpu_1_outgoing_debugaccess   (<connected-to-cpu_1_outgoing_debugaccess>),   //               .debugaccess
		.reset_reset_n                (<connected-to-reset_reset_n>)                 //          reset.reset_n
	);

