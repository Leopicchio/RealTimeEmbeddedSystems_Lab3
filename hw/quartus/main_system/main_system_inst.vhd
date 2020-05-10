	component main_system is
		port (
			clk_clk                     : in    std_logic                     := 'X';             -- clk
			parallel_port_leds_export   : out   std_logic_vector(9 downto 0);                     -- export
			pll_clk_sdram_clk           : out   std_logic;                                        -- clk
			reset_reset_n               : in    std_logic                     := 'X';             -- reset_n
			sdram_controller_wire_addr  : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_controller_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_controller_wire_cas_n : out   std_logic;                                        -- cas_n
			sdram_controller_wire_cke   : out   std_logic;                                        -- cke
			sdram_controller_wire_cs_n  : out   std_logic;                                        -- cs_n
			sdram_controller_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_controller_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_controller_wire_ras_n : out   std_logic;                                        -- ras_n
			sdram_controller_wire_we_n  : out   std_logic                                         -- we_n
		);
	end component main_system;

	u0 : component main_system
		port map (
			clk_clk                     => CONNECTED_TO_clk_clk,                     --                   clk.clk
			parallel_port_leds_export   => CONNECTED_TO_parallel_port_leds_export,   --    parallel_port_leds.export
			pll_clk_sdram_clk           => CONNECTED_TO_pll_clk_sdram_clk,           --         pll_clk_sdram.clk
			reset_reset_n               => CONNECTED_TO_reset_reset_n,               --                 reset.reset_n
			sdram_controller_wire_addr  => CONNECTED_TO_sdram_controller_wire_addr,  -- sdram_controller_wire.addr
			sdram_controller_wire_ba    => CONNECTED_TO_sdram_controller_wire_ba,    --                      .ba
			sdram_controller_wire_cas_n => CONNECTED_TO_sdram_controller_wire_cas_n, --                      .cas_n
			sdram_controller_wire_cke   => CONNECTED_TO_sdram_controller_wire_cke,   --                      .cke
			sdram_controller_wire_cs_n  => CONNECTED_TO_sdram_controller_wire_cs_n,  --                      .cs_n
			sdram_controller_wire_dq    => CONNECTED_TO_sdram_controller_wire_dq,    --                      .dq
			sdram_controller_wire_dqm   => CONNECTED_TO_sdram_controller_wire_dqm,   --                      .dqm
			sdram_controller_wire_ras_n => CONNECTED_TO_sdram_controller_wire_ras_n, --                      .ras_n
			sdram_controller_wire_we_n  => CONNECTED_TO_sdram_controller_wire_we_n   --                      .we_n
		);

