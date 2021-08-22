-- GEQ IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity myMUX2_1_16 is
	port (in1: in std_logic;
			out1: out std_logic_vector(15 downto 0));
	end myMUX2_1_16;

architecture logic of mymUX2_1_16 is

	begin
	with in1 select
		out1 <=	"1111111111111111" when '0',
					"0000000000000000" when '1';
					
end logic;