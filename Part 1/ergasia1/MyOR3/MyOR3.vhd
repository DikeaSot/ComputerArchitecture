--OR with 3 inputs
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity myOR3 is
port (in1, in2, in3: in std_logic;
		out1: out std_logic);
end myOR3;

architecture logic of myOR3 is
begin
	out1 <= in1 or in2 or in3;
end logic;