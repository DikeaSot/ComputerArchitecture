--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--PSEUDO-REGISTER 0 IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity reg0 is
generic	(n: integer := 16);
	port	(in1: in std_logic_vector(n-1 downto 0);
			 enable, clock: in std_logic;
			 out1: out std_logic_vector(n-1 downto 0));
end reg0;

architecture behav of reg0 is
	begin
		out1 <= (others => '0');
end behav;