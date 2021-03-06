--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--ALU CONTROL IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity aluControl is
	port (
		opCode: in std_logic_vector(3 downto 0);
		func: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(3 downto 0)
	);
end aluControl;

architecture behav of aluControl is
	begin
		process (opCode, func) begin
			case opCode is
				when "0000" =>
					output(3) <= '0';
					output(2 downto 0) <= func(2 downto 0);
				when others => output <= opCode;
			end case;
		end process;
end behav;