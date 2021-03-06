--AND implementation 16 bits
library ieee;
use ieee.std_logic_1164.all;

entity MyAND16 is
	port (in1, in2: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
end MyAND16;

architecture logic of MyAND16 is
begin
	out1 <= in1 and in2;
end logic;