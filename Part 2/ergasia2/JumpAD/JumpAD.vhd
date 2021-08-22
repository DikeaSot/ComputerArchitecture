--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--JUMP ADDRESS IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jumpAD is
	generic (
		n: integer := 16;
		k: integer := 12
	);
	port (
		jumpADR: in std_logic_vector(k-1 downto 0);
		instrP2AD: in std_logic_vector(n-1 downto 0);
		EjumpAD: out std_logic_vector(n-1 downto 0)
	);
end jumpAD;

architecture logic of jumpAD is
	signal extended, multed: std_logic_vector(n-1 downto 0);
	begin
		extended <= (n-1 downto k => jumpADR(k-1)) & (jumpADR);
		
	process(instrP2AD)
		begin
			multed <= extended(n-2 downto 0) & '0';
			EjumpAD <= std_logic_vector(unsigned(multed) + unsigned(instrP2AD));
	end process;
end logic;