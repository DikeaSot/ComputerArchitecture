--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--CONTROLLER IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port (
		op: in std_logic_vector(3 downto 0);
		func: in std_logic_vector(2 downto 0);
		flush: in std_logic;
		isMFPC, isJumpD, isReadRight, isPrintDigit, isR, isLW, isSW, isBranch, isJR: out std_logic
	);
end controller;

architecture rtl of controller is
	begin
		get_result: process(flush, func, op) begin
			isR <= '0';
			isMFPC <= '0';
			isLW <= '0';
			isSW <= '0';
			isBranch <= '0';
			isReadRight <= '0';
			isPrintDigit <= '0';
			isJumpD <= '0';
			isJR <= '0';
			
			if flush = '0' then
				case op is
					when "0000" =>
						isR <= '1';
						if func = "111" then
							isMFPC <= '1';
						end if;
					when "0001" =>
						isLW <= '1';
					when "0010" =>
						isSW <= '1';
					when "0100" =>
						isBranch <= '1';
					when "0110" =>
						isReadRight <= '1';
					when "0111" =>
						isPrintDigit <= '1';
					when "1111" =>
						isJumpD <= '1';
					when "1101" =>
						isJR <= '1';
					when others =>
						isR <= '0';
				end case;
			end if;
		end process;
		
end architecture rtl;