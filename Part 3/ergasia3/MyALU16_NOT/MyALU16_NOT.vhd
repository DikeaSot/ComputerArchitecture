--NOT implementation
library ieee;
use ieee.std_logic_1164.all;

entity myALU16_NOT is
	port (in1: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
	end myALU16_NOT;

architecture logic of myALU16_NOT is

	begin
		out1 <= "0000000000000001" when (in1 = "0000000000000000") else "0000000000000000";
					
end logic;