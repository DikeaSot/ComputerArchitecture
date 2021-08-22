--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--DECODER 3-TO-8 IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity decode3_8 is
	port	(in1: in std_logic_vector(2 downto 0);
			 out1: out std_logic_vector(7 downto 0));
end decode3_8;

architecture logic of decode3_8 is
	begin
		with in1 select
			out1 <=  "00000001" when "000",
						"00000010" when "001",
						"00000100" when "010",
						"00001000" when "011",
						"00010000" when "100",
						"00100000" when "101",
						"01000000" when "110",
						"10000000" when "111",
						"00000000" when others;
end logic;