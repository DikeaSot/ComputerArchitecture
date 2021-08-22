--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--ALU IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU16 is 
      port(in1, in2: in std_logic_vector(15 downto 0);
			  carry_in: in std_logic;
		     op: in std_logic_vector(3 downto 0);
		     output: out std_logic_vector(15 downto 0);
			  carry_out: out std_logic);
end ALU16;

architecture logic of ALU16 is

	component fulladder16
	port (in1, in2: in std_logic_vector(15 downto 0);
			carry_in: in std_logic;
			sum: out std_logic_vector(15 downto 0);
			carry_out: out std_logic);
	end component;

	component myAND16
	port (in1, in2: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
	end component;
	
	component myOR16
	port (in1, in2: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
	end component;
	
	component TwosComplement
	port (in1: in std_logic_vector(15 downto 0);
			op: in std_logic_vector(3 downto 0);
			out1: out std_logic_vector(15 downto 0));
	end component;
	
	component myMUX2_1_16 
	port (in1: in std_logic;
			out1: out std_logic_vector(15 downto 0));
	end component;
	
	component myALU16_NOT
	port (in1: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
	end component;
	
	component myMUX8_1
	port (add_out, and_out, or_out, geq_out, not_out: in std_logic_vector(15 downto 0);
			sel: in std_logic_vector(3 downto 0);
			final_out: out std_logic_vector(15 downto 0));
	end component;
	
	--In TwosComplement component, if op == '011' then the numbers are subtracted
	--myMUX2_1_16 component is GEQ
	signal in2_not, add_out, and_out, or_out, geq_out, not_out: std_logic_vector(15 downto 0);
	begin
		G0: TwosComplement 	port map (in2, op, in2_not);
		V0: fulladder16 		port map (in1, in2_not, carry_in, add_out, carry_out);
		V1: myAND16 			port map (in1, in2, and_out);
		V2: myOR16 				port map (in1, in2, or_out);
		V3: myMUX2_1_16		port map (in1(15), geq_out);
		V4: myALU16_NOT		port map (in1, not_out);
		V5: myMUX8_1 			port map (add_out, and_out, or_out, geq_out, not_out, op, output);
	
end logic;