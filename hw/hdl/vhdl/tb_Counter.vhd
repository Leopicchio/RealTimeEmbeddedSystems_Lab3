-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 2.3.2020 09:55:03 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_Counter is
end tb_Counter;

architecture tb of tb_Counter is

    component Counter
        port (Clk        : in std_logic;
              nReset     : in std_logic;
              Address    : in std_logic_vector (2 downto 0);
              ChipSelect : in std_logic;
              Read       : in std_logic;
              Write      : in std_logic;
              ReadData   : out std_logic_vector (31 downto 0);
              WriteData  : in std_logic_vector (31 downto 0);
              IRQ        : out std_logic);
    end component;

    signal Clk        : std_logic;
    signal nReset     : std_logic;
    signal Address    : std_logic_vector (2 downto 0);
    signal ChipSelect : std_logic;
    signal Read       : std_logic;
    signal Write      : std_logic;
    signal ReadData   : std_logic_vector (31 downto 0);
    signal WriteData  : std_logic_vector (31 downto 0);
    signal IRQ        : std_logic;

    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Counter
    port map (Clk        => Clk,
              nReset     => nReset,
              Address    => Address,
              ChipSelect => ChipSelect,
              Read       => Read,
              Write      => Write,
              ReadData   => ReadData,
              WriteData  => WriteData,
              IRQ        => IRQ);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Address <= (others => '0');
        ChipSelect <= '0';
        Read <= '0';
        Write <= '0';
        WriteData <= (others => '0');

        -- Reset the counter
        nReset <= '0';
        wait for 100 ns;
        nReset <= '1';
        wait for 100 ns;
        
        -- Initialize counting value
        Address <= "001";
        wait for 100 ns;
        ChipSelect <= '1';
        Write <= '1';
        wait for 40 ns;
        ChipSelect <= '0';
        Write <= '0';
        
        -- start the counting
        Address <= "010";
        wait for 100 ns;
        ChipSelect <= '1';
        Write <= '1';
        wait for 40 ns;
        ChipSelect <= '0';
        Write <= '0';
        Address <= "000";
        
        -- read back counter value
        wait for 500 ns;
        Address <= "000";
        Write <= '0';
        wait for 100 ns;
        Read <= '1';
        ChipSelect <= '1';
        
        -- stop the counter
        wait for 100 ns;
        Address <= "011";
        Write <= '1';
        Read <= '0';
        wait for 100 ns;
        Write <= '0';
        
        
        
        
        -- restart the counter
        wait for 100 ns;
        Address <= "010";
        Write <= '1';
        wait for 100 ns;
        Write <= '0';
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Counter of tb_Counter is
    for tb
    end for;
end cfg_tb_Counter;
