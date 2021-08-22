--Full Adder 1 bit
library ieee;
use ieee.std_logic_1164.all;

entity fulladder is 
	port (in1, in2, carry_in: in std_logic;
			sum, carry_out: out std_logic);
end fulladder;

architecture logic of fulladder is
	component myAND
	port (in1, in2: in std_logic;
			out1: out std_logic);
	end component;

	component myOR3
	port (in1, in2, in3: in std_logic;
			out1: out std_logic);	end component;
	
	component myXOR3
	port (in1, in2, in3: in std_logic;
			out1: out std_logic);
	end component;
	
	signal s1, s2, s3: std_logic;
	begin
		V0: myXOR3 port map (in1, in2, carry_in, sum);
		V1: myAND port map (in1, in2, s1);
		V2: myAND port map (in1, carry_in, s2);
		V3: myAND port map (carry_in, in2, s3);
		V4: myOR3 port map (s1, s2, s3, carry_out);
		
end logic;
		
