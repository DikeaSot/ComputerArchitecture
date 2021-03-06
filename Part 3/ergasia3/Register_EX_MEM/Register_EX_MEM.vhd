--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--REGISTER EX MEM IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_EX_MEM is
	generic (
		n : integer := 16;
		addressSize : integer := 3
	);
	port (
		clock, isLW, WriteEnable, ReadDigit, PrintDigit: in std_logic;
		R2Reg, Result : in std_logic_vector(n-1 downto 0);
		RegAD : in std_logic_vector(addressSize-1 downto 0);
		-------------------------------------------------------
		isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: out std_logic;
		R2Reg_EXMEM, Result_EXMEM : out std_logic_vector(n-1 downto 0);
		RegAD_EXMEM : out std_logic_vector(addressSize-1 downto 0)
	);
end register_EX_MEM;

architecture behav of register_EX_MEM is
	begin
	
	pc: process(clock)
	begin
		if clock ='1' then
			RegAD_EXMEM <= RegAD;
			R2Reg_EXMEM <= R2Reg;
			Result_EXMEM <= Result;
			isLW_EXMEM <= isLW;
			WriteEnable_EXMEM <= WriteEnable;
			ReadDigit_EXMEM <= ReadDigit;
			PrintDigit_EXMEM <= PrintDigit;
		end if;
	end process pc;
end architecture behav;