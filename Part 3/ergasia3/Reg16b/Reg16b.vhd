--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--PC REGISTER IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity reg16b is
	port (
		input: in std_logic_vector(15 downto 0);
		Enable, Clock: in std_logic;
		output: out std_logic_vector(15 downto 0)
	);
end reg16b;

architecture behav of reg16b is
	begin
		process(Clock)
		begin
			if Clock'EVENT AND Clock = '1' then -- Rising edge
				if Enable = '1' then
					output <= input;
				end if;
			end if;
		end process;

end architecture behav;