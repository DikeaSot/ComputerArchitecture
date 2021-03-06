--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--TRAP UNIT IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity trapUnit is
	port (
		op: in std_logic_vector(3 downto 0);
		EOR: out std_logic
	);
end trapUnit;

architecture behav of trapUnit is
	begin
		process(op)
		begin
			if op = "1110" then
				EOR <= '1';
			else
				EOR <= '0';
			end if;
		end process;
end architecture behav;