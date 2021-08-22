--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--SELECTOR IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selector is
	generic (n : integer := 16);
	port (
		Reg, Mem, WB: in std_logic_vector(n-1 downto 0);
		op: in std_logic_vector(1 downto 0);
		output: out std_logic_vector(n-1 downto 0)
	);
end entity selector;

architecture behav of selector is
	begin
		with op select
			output <= 	Reg when "00",
							WB when "01",
							Mem when "10",
							"0000000000000000" when "11";
end architecture behav;
		