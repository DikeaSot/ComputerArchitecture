--XOR with 3 inputs
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity myXOR3 is
	port( in1, in2, in3: in std_logic;
			out1: out std_logic);
	end myXOR3;

	architecture logic of myXOR3 is
	Begin
		out1 <= in1 XOR in2 XOR in3;
	end logic;