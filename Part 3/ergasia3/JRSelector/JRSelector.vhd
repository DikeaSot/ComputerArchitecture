--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--JR SELECTOR IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity JRSelector is
	generic (
		n : integer := 16
	);
	port (
		EjumpAD, branchAD, PCP2AD: in std_logic_vector(n-1 downto 0);
		JRopcode: in std_logic_vector(1 downto 0);
		result: out std_logic_vector(n-1 downto 0)
	);
end JRSelector;

architecture behav of JRSelector is
	
	begin
		process(JROpcode)
		begin
			case JRopcode is
				when "00" =>
					result <= PCP2AD;
				when "01" =>
					result <= EjumpAD;
				when "10" =>
					result <= branchAD;
				when others => result <= PCP2AD;
			end case;
		end process;
		
end architecture behav;