library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY Counter IS
	PORT(
		-- Avalon interfaces signals
		Clk : IN std_logic;
		nReset : IN std_logic;
		
		Address : IN std_logic_vector (2 DOWNTO 0);
		ChipSelect : IN std_logic;
		
		Read : IN std_logic;
		Write : IN std_logic;
		
		ReadData : OUT std_logic_vector (31 DOWNTO 0);
		WriteData : IN std_logic_vector (31 DOWNTO 0);

		--Avalon bus 2
		Address2 : IN std_logic_vector (2 DOWNTO 0);
		ChipSelect2 : IN std_logic;
		
		Read2 : IN std_logic;
		Write2 : IN std_logic;
		
		ReadData2 : OUT std_logic_vector (31 DOWNTO 0);
		WriteData2 : IN std_logic_vector (31 DOWNTO 0);

		
		-- Interruptions
		IRQ : OUT std_logic
	);
End Counter;


ARCHITECTURE comp OF Counter IS
	signal iCounter : unsigned(31 DOWNTO 0);
	signal iEn : std_logic;
	signal iRz : std_logic;
	signal iEOT : std_logic;
	signal iClrEOT : std_logic;
	signal iIRQEn : std_logic;
	signal iMutex : std_logic;
BEGIN
	-- Counter process, synchronous Reset by command and count if enabled
	pCounter:
	process(Clk)
		begin
			if rising_edge(Clk) then
				if iRz= '1' then
					iCounter <= (others => '0'); -- Reset Counter  0
				elsif iEn = '1' then
					iCounter <= iCounter+1; -- increment
				end if;
			end if;
	end process pCounter;
	
	
	pRegWr: -- Process Write to registers
	process(Clk, nReset)
		begin
			if nReset = '0' then -- asynchronous Reset
				iEn <= '0'; -- No Count by default
				iRz <= '0';
				iIRQEn <= '0'; -- No IRQ Enable by default
				
			elsif rising_edge(Clk) then
				iRz <= '0'; -- No Reset, as it's just a command
				iClrEOT <= '0' ;
				
				if (ChipSelect = '1' and Write = '1') then -- Write cycle
					case Address(2 downto 0) is
						when "000" => null ;
						when "001" => iRz <= '1'; -- Reset Counter (pulse)
						when "010" => iEn <= '1'; -- Start Run
						when "011" => iEn <= '0'; -- Stop Run
						when "100" => iIRQEn <= WriteData(0);
						when "101" => iClrEOT <= WriteData(0);
						when "111" => iMutex <= WriteData(0);
						when others => null;
					end case;
				elsif (ChipSelect2 = '1' and Write2 = '1') then
					case Address2(2 downto 0) is
						when "000" => null ;
						when "001" => iRz <= '1'; -- Reset Counter (pulse)
						when "010" => iEn <= '1'; -- Start Run
						when "011" => iEn <= '0'; -- Stop Run
						when "100" => iIRQEn <= WriteData2(0);
						when "101" => iClrEOT <= WriteData2(0);
						when "111" => iMutex <= WriteData2(0);
						when others => null;
					end case;
				end if;
			end if;
	end process pRegWr;


	
	-- Read registers Process nead 1 WaitCycle on Avalon 
	pRegRd:
	process(Clk)
		begin
			if rising_edge(Clk) then
				ReadData <= (others => '0'); -- default value
				
				if ChipSelect = '1' and Read = '1' then -- Read cycle
					case Address(2 downto 0) is
						when "000" => ReadData <= std_logic_vector(iCounter);
						when "111" => ReadData(0) <= iMutex;
						-- cast and Read Counter
						when "100" => ReadData(0) <= iIRQEn;
						when "101" => ReadData(0) <= iEOT; -- EOT
						ReadData(1) <= iEn; -- Run
						when others => null;
					end case;
				elsif ChipSelect2 = '1' and Read2 = '1' then
					case Address2(2 downto 0) is
						when "000" => ReadData2 <= std_logic_vector(iCounter);
						when "111" => ReadData2(0) <= iMutex;
						-- cast and Read Counter
						when "100" => ReadData2(0) <= iIRQEn;
						when "101" => ReadData2(0) <= iEOT; -- EOT
						ReadData2(1) <= iEn; -- Run
						when others => null;
					end case;
				end if;
			end if;
	end process pRegRd;
	
	pInterrupt:
	process(Clk)
		begin
			if rising_edge(Clk) then
				If iCounter = X"0000_0000" then
					iEOT <= '1'; -- Flag End Of Time  '1' when counter =0
				Elsif iClrEOT = '1' then
					iEOT <= '0'; -- Cleared on access by WrStatus(0)
				End if;
			end if;
	end process pInterrupt;
	
	-- IRQ activation
	IRQ <= '1' when iEOT ='1' and iIRQEn = '1' and iEn = '1'else '0';


END comp;