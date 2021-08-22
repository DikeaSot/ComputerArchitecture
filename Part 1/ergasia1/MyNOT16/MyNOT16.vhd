--NOT 16 bits
library ieee;
use ieee.std_logic_1164.all;

entity myNOT16 is
	port (in1: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0));
end entity;

architecture logic of myNOT16 is

	begin
	out1 <= NOT in1;
	
end logic;
	