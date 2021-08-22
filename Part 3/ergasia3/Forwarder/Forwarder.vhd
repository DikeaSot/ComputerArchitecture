--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--FORWARDER IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity forwarder is
	generic (
		addr_size : integer := 3
	);
	port (
		R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: in std_logic_vector(addr_size-1 downto 0);
		S1, S2: out std_logic_vector(1 downto 0)
	);
end entity forwarder;

architecture behav of forwarder is
	begin
	process(RegAD_EXMEM, RegAD_MEMWB, R1AD, R2AD)
		begin
			-- just set it to 00 for the default case (so the default input in the Selector's is used)
			S1 <= "00";		--select R1AD
			S2 <= "00"; 	--select R2AD
			
			if (R1AD = RegAD_EXMEM) then
				S1 <= "10"; --select RegAD_EXMEM
			elsif (R1AD = RegAD_MEMWB) then
				S1 <= "01"; --select RegAD_MEMWB
			end if;
			
			if (R2AD = RegAD_EXMEM) then
				S2 <= "10"; --select RegAD_EXMEM
			elsif (R2AD = RegAD_MEMWB) then
				S2 <= "01";	--select RegAD_MEMWB
			end if;
	end process;
end architecture behav;