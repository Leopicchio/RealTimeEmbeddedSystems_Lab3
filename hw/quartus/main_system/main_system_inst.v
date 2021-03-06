	main_system u0 (
		.clk_clk                     (<connected-to-clk_clk>),                     //                   clk.clk
		.parallel_port_leds_export   (<connected-to-parallel_port_leds_export>),   //    parallel_port_leds.export
		.pll_clk_sdram_clk           (<connected-to-pll_clk_sdram_clk>),           //         pll_clk_sdram.clk
		.reset_reset_n               (<connected-to-reset_reset_n>),               //                 reset.reset_n
		.sdram_controller_wire_addr  (<connected-to-sdram_controller_wire_addr>),  // sdram_controller_wire.addr
		.sdram_controller_wire_ba    (<connected-to-sdram_controller_wire_ba>),    //                      .ba
		.sdram_controller_wire_cas_n (<connected-to-sdram_controller_wire_cas_n>), //                      .cas_n
		.sdram_controller_wire_cke   (<connected-to-sdram_controller_wire_cke>),   //                      .cke
		.sdram_controller_wire_cs_n  (<connected-to-sdram_controller_wire_cs_n>),  //                      .cs_n
		.sdram_controller_wire_dq    (<connected-to-sdram_controller_wire_dq>),    //                      .dq
		.sdram_controller_wire_dqm   (<connected-to-sdram_controller_wire_dqm>),   //                      .dqm
		.sdram_controller_wire_ras_n (<connected-to-sdram_controller_wire_ras_n>), //                      .ras_n
		.sdram_controller_wire_we_n  (<connected-to-sdram_controller_wire_we_n>)   //                      .we_n
	);

