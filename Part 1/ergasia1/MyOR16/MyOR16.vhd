--OR with inputs of 16 bits
library ieee;
use ieee.std_logic_1164.all;

entity MyOR16 is
	port (in1, in2: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
end MyOR16;

architecture logic of MyOR16 is
begin
	out1 <= in1 or in2;
end logic;