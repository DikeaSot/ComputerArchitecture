library ieee;
use ieee.std_logic_1164.all;

entity myMUX8_1 is
	port (add_out, and_out, or_out, geq_out, not_out: in std_logic_vector(15 downto 0);
			sel: in std_logic_vector(2 downto 0);
			final_out: out std_logic_vector(15 downto 0));
	end myMUX8_1;

architecture logic of mymUX8_1 is
	begin
	with sel select
		final_out <=   add_out when "010" | "011",
							and_out when "000",
							or_out  when "001",
							geq_out when "101",
							not_out when "110",
							"0000000000000000" when others;
							
end logic;