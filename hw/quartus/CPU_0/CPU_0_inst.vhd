	component CPU_0 is
		port (
			clk_clk                      : in  std_logic                     := 'X';             -- clk
			cpu_0_outgoing_waitrequest   : in  std_logic                     := 'X';             -- waitrequest
			cpu_0_outgoing_readdata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			cpu_0_outgoing_readdatavalid : in  std_logic                     := 'X';             -- readdatavalid
			cpu_0_outgoing_burstcount    : out std_logic_vector(0 downto 0);                     -- burstcount
			cpu_0_outgoing_writedata     : out std_logic_vector(31 downto 0);                    -- writedata
			cpu_0_outgoing_address       : out std_logic_vector(27 downto 0);                    -- address
			cpu_0_outgoing_write         : out std_logic;                                        -- write
			cpu_0_outgoing_read          : out std_logic;                                        -- read
			cpu_0_outgoing_byteenable    : out std_logic_vector(3 downto 0);                     -- byteenable
			cpu_0_outgoing_debugaccess   : out std_logic;                                        -- debugaccess
			reset_reset_n                : in  std_logic                     := 'X'              -- reset_n
		);
	end component CPU_0;

	u0 : component CPU_0
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --            clk.clk
			cpu_0_outgoing_waitrequest   => CONNECTED_TO_cpu_0_outgoing_waitrequest,   -- cpu_0_outgoing.waitrequest
			cpu_0_outgoing_readdata      => CONNECTED_TO_cpu_0_outgoing_readdata,      --               .readdata
			cpu_0_outgoing_readdatavalid => CONNECTED_TO_cpu_0_outgoing_readdatavalid, --               .readdatavalid
			cpu_0_outgoing_burstcount    => CONNECTED_TO_cpu_0_outgoing_burstcount,    --               .burstcount
			cpu_0_outgoing_writedata     => CONNECTED_TO_cpu_0_outgoing_writedata,     --               .writedata
			cpu_0_outgoing_address       => CONNECTED_TO_cpu_0_outgoing_address,       --               .address
			cpu_0_outgoing_write         => CONNECTED_TO_cpu_0_outgoing_write,         --               .write
			cpu_0_outgoing_read          => CONNECTED_TO_cpu_0_outgoing_read,          --               .read
			cpu_0_outgoing_byteenable    => CONNECTED_TO_cpu_0_outgoing_byteenable,    --               .byteenable
			cpu_0_outgoing_debugaccess   => CONNECTED_TO_cpu_0_outgoing_debugaccess,   --               .debugaccess
			reset_reset_n                => CONNECTED_TO_reset_reset_n                 --          reset.reset_n
		);

