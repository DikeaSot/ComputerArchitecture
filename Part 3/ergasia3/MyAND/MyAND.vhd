--AND implementation 1 bit
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity myAND is
	port (in1, in2: in std_logic;
			out1: out std_logic);
	end myAND;

	architecture logic of myAND is
	begin
		out1 <= in1 AND in2;
	end logic;