--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--IMMEDIATE SIGN EXTENDER IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity signExtender is
	generic (
		n: integer := 16;
		k: integer := 6
	);
	port (
		immediate: in std_logic_vector(k-1 downto 0);
		extended: out std_logic_vector(n-1 downto 0)
	);
end signExtender;

architecture logic of signExtender is
	begin
		extended <= (n-1 downto k => immediate(k-1)) & (immediate);
end logic;
		