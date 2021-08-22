--Twos Complement implementation
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity TwosComplement is
	port (in1: in std_logic_vector (15 downto 0);  
			op: in std_logic_vector(3 downto 0);
			out1: out std_logic_vector (15 downto 0));
end entity;
		
architecture logic of TwosComplement is
	component myNOT16 is
		port (in1: in std_logic_vector (15 downto 0);         
				out1: out std_logic_vector (15 downto 0));
	end component;
	
	signal in1_not: std_logic_vector(15 downto 0);
	begin
		V0: myNOT16 port map (in1, in1_not);
		with op select
			out1 <=  in1_not + 1 when "0011",
						in1 			when others;
end logic;