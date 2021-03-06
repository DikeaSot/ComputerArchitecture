--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--REGISTER ID EX IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_ID_EX is
	generic (
		n : integer := 16;
		addressSize : integer := 3
	);
	port (
		clock, isEOR, wasJumpOut, isJump, isJR: in std_logic;
		isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit: in std_logic;
		ALUFunc: in std_logic_vector(3 downto 0);
		R1Reg, R2Reg, immediate16: in std_logic_vector(n-1 downto 0);
		R1AD, R2AD: in std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr: in std_logic_vector(11 downto 0);
		----------------------------------------------------------
		clock_IDEX, isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX: out std_logic;
		isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX: out std_logic;
		ALUFunc_IDEX: out std_logic_vector(3 downto 0);
		R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: out std_logic_vector(n-1 downto 0);
		R1AD_IDEX, R2AD_IDEX: out std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr_IDEX: out std_logic_vector(11 downto 0)
	);
end register_ID_EX;

architecture behav of register_ID_EX is
	begin
	
	pc: process(clock)
	begin
		if clock='1' then
			isEOR_IDEX <= isEOR;
			wasJumpOut_IDEX <= wasJumpOut;
			isJump_IDEX <= isJump;
			isJR_IDEX <= isJR;
			isBranch_IDEX <= isBranch;
			isR_IDEX <= isR;
			isMFPC_IDEX <= isMFPC;
			AluFunc_IDEX <= ALuFunc;
			R1Reg_IDEX <= R1Reg;
			R2Reg_IDEX <= R2Reg;
			immediate16_IDEX <= immediate16;
			R1AD_IDEX <= R1AD;
			R2AD_IDEX <= R2AD;
			jumpShortAddr_IDEX <= jumpShortAddr;
			isReadDigit_IDEX <= isReadDigit;
			isPrintDigit_IDEX <= isPrintDigit;
			isLW_IDEX <= isLW;
			isSW_IDEX <= isSW;
		else
			isEOR_IDEX <= '0';
			wasJumpOut_IDEX <= '0';
			isJump_IDEX <= '0';
			isJR_IDEX <= '0';
			isBranch_IDEX <= '0';
			isR_IDEX <= '0';
			isMFPC_IDEX <= '0';
			AluFunc_IDEX <= (others => '0');
			R1Reg_IDEX <= (others => '0');
			R2Reg_IDEX <= (others => '0');
			immediate16_IDEX <= (others => '0');
			R1AD_IDEX <= (others => '0');
			R2AD_IDEX <= (others => '0');
			jumpShortAddr_IDEX <= (others => '0');
			isReadDigit_IDEX <= '0';
			isPrintDigit_IDEX <= '0';
			isLW_IDEX <= '0';
			isSW_IDEX <= '0';
		end if;
	end process pc;
end architecture behav;
		 