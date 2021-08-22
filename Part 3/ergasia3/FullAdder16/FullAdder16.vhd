--Full Adder 16 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity fulladder16 is 
	port (in1, in2: in std_logic_vector(15 downto 0);
			carry_in: in std_logic;
			sum: out std_logic_vector(15 downto 0);
			carry_out: out std_logic);
end fulladder16;

architecture logic of fulladder16 is
	component fulladder
	port (in1, in2, carry_in: in std_logic;
			sum, carry_out: out std_logic);
	end component;
	
	component myXOR
	port (in1, in2: in std_logic;
			out1: out std_logic);
	end component;
	
	signal cout: std_logic_vector(15 downto 0);
	begin
		V0: fulladder port map (in1(0), in2(0), carry_in, sum(0), cout(0));
		V1: fulladder port map (in1(1), in2(1), cout(0), sum(1), cout(1));
		V2: fulladder port map (in1(2), in2(2), cout(1), sum(2), cout(2));
		V3: fulladder port map (in1(3), in2(3), cout(2), sum(3), cout(3));
		V4: fulladder port map (in1(4), in2(4), cout(3), sum(4), cout(4));
		V5: fulladder port map (in1(5), in2(5), cout(4), sum(5), cout(5));
		V6: fulladder port map (in1(6), in2(6), cout(5), sum(6), cout(6));
		V7: fulladder port map (in1(7), in2(7), cout(6), sum(7), cout(7));
		V8: fulladder port map (in1(8), in2(8), cout(7), sum(8), cout(8));
		V9: fulladder port map (in1(9), in2(9), cout(8), sum(9), cout(9));
		V10: fulladder port map (in1(10), in2(10), cout(9), sum(10), cout(10));
		V11: fulladder port map (in1(11), in2(11), cout(10), sum(11), cout(11));
		V12: fulladder port map (in1(12), in2(12), cout(11), sum(12), cout(12));
		V13: fulladder port map (in1(13), in2(13), cout(12), sum(13), cout(13));
		V14: fulladder port map (in1(14), in2(14), cout(13), sum(14), cout(14));
		V15: fulladder port map (in1(15), in2(15), cout(14), sum(15), cout(15));
		Overflow: myXOR port map (cout(14), cout(15), carry_out);
		
		
end logic;