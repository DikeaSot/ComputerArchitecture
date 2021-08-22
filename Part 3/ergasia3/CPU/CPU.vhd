--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--CPU IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
	port (
		keyData, fromData, instr: in std_logic_vector(15 downto 0);
		clock, clock2: in std_logic;
		printEnable, keyEnable, DataWriteFlag: out std_logic;
		dataAD, toData, printCode, printData, instructionAD: out std_logic_vector(15 downto 0);
		regOUT: out std_logic_vector(143 downto 0)
	);
end CPU;

architecture behav of CPU is
	---------------- Components ----------------
	component ALU16 is
		port(in1, in2: in std_logic_vector(15 downto 0);
			  carry_in: in std_logic;
		     op: in std_logic_vector(3 downto 0);
		     output: out std_logic_vector(15 downto 0);
			  carry_out: out std_logic);
	end component;
	
	component ALUControl is
		port (
			opCode: in std_logic_vector(3 downto 0);
			func: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component Controller is
		port (
			op: in std_logic_vector(3 downto 0);
			func: in std_logic_vector(2 downto 0);
			flush: in std_logic;
			isMFPC, isJumpD, isReadRight, isPrintDigit, isR, isLW, isSW, isBranch, isJR: out std_logic
		);
	end component;
	
	component RegFile is
		generic	(
			n: integer := 16;
			k: integer := 3;
			regNum: integer := 8
		);
		port	(
			clock: in std_logic;
			write1: in std_logic_vector(n-1 downto 0);
			write1AD, read1AD, read2AD: in std_logic_vector(k-1 downto 0);
			read1, read2: out std_logic_vector(n-1 downto 0);
			outAll: out std_logic_vector(n*regNum-1 downto 0)
		);
	end component;
	
	component reg16b is
		port (
			input: in std_logic_vector(15 downto 0);
			Enable, Clock: in std_logic;
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component forwarder is
		generic (
			addr_size : integer := 3
		);
		port (
			R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: in std_logic_vector(addr_size-1 downto 0);
			S1, S2: out std_logic_vector(1 downto 0)
		);
	end component;
	
	component hazardUnit is
		port (
			isJR, isJump, wasJump, mustBranch: in std_logic;
			flush, wasJumpOut: out std_logic;
			JRopcode: out std_logic_vector(1 downto 0)
		);
	end component;
	
	component JRSelector is
		generic (
			n : integer := 16
		);
		port (
			EjumpAD, branchAD, PCP2AD: in std_logic_vector(n-1 downto 0);
			JRopcode: in std_logic_vector(1 downto 0);
			result: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component jumpAD is
		generic (
			n: integer := 16;
			k: integer := 12
		);
		port (
			jumpADR: in std_logic_vector(k-1 downto 0);
			instrP2AD: in std_logic_vector(n-1 downto 0);
			EjumpAD: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component register_IF_ID is
		generic (
			n: integer := 16
			);
		port (
			inPC, inInstruction: in std_logic_vector(n-1 downto 0);
			clock, IF_Flush, IF_ID_ENABLE: in std_logic;
			outPC, outInstruction: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component register_ID_EX is
		generic (
			n : integer := 16;
			addressSize : integer := 3
		);
		port (
			-- input
			clock, isEOR, wasJumpOut, isJump, isJR: in std_logic;
			isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit: in std_logic;
			ALUFunc: in std_logic_vector(3 downto 0);
			R1Reg, R2Reg, immediate16: in std_logic_vector(n-1 downto 0);
			R1AD, R2AD: in std_logic_vector(addressSize-1 downto 0);
			jumpShortAddr: in std_logic_vector(11 downto 0);
			-- output
			clock_IDEX, isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX: out std_logic;
			isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX: out std_logic;
			ALUFunc_IDEX: out std_logic_vector(3 downto 0);
			R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: out std_logic_vector(n-1 downto 0);
			R1AD_IDEX, R2AD_IDEX: out std_logic_vector(addressSize-1 downto 0);
			jumpShortAddr_IDEX: out std_logic_vector(11 downto 0)
		);
	end component;
	
	component register_EX_MEM is
		generic (
			n : integer := 16;
			addressSize : integer := 3
		);
		port (
			-- input
			clock, isLW, WriteEnable, ReadDigit, PrintDigit: in std_logic;
			R2Reg, Result : in std_logic_vector(n-1 downto 0);
			RegAD : in std_logic_vector(addressSize-1 downto 0);
			-- output
			isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: out std_logic;
			R2Reg_EXMEM, Result_EXMEM : out std_logic_vector(n-1 downto 0);
			RegAD_EXMEM : out std_logic_vector(addressSize-1 downto 0)
		);
	end component;
	
	component register_MEM_WB is
		generic (
			n : integer := 16;
			addressSize : integer := 3
		);
		port (
			Result: in std_logic_vector(n-1 downto 0);
			RegAD: in std_logic_vector(addressSize-1 downto 0);
			clock: in std_logic;
			writeData: out std_logic_vector(n-1 downto 0);
			writeAD: out std_logic_vector(addressSize-1 downto 0)
		);
	end component;
	
	component selector is
		generic (n : integer := 16);
		port (
			Reg, Mem, WB: in std_logic_vector(n-1 downto 0);
			op: in std_logic_vector(1 downto 0);
			output: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component signExtender is
		generic (
			n: integer := 16;
			k: integer := 6
		);
		port (
			immediate: in std_logic_vector(k-1 downto 0);
			extended: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component trapUnit is
		port (
			op: in std_logic_vector(3 downto 0);
			EOR: out std_logic
	);
	end component;
	---------------- End of Components ----------------
	
	---------------- Signals ----------------
	--	Register_IF_ID output
	signal	outPC, outInstruction: 		std_logic_vector(15 downto 0);
	-- ALU Controller output
	signal	ALUFunc: 					std_logic_vector(3 downto 0);
	-- Sign Extender output
	signal	immediate16: 					std_logic_vector(15 downto 0);
	-- Trap Unit output
	signal	isEOR: 						std_logic;
	
	-- Register_ID_EX output
	signal	clock_IDEX, isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, 
				isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, 
				isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX:					std_logic;
				
	signal 	ALUFunc_IDEX: 											std_logic_vector(3 downto 0);	
	signal	R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: 	std_logic_vector(15 downto 0);
	signal	R1AD_IDEX, R2AD_IDEX: 								std_logic_vector(2 downto 0);
	signal	jumpShortAddr_IDEX: 									std_logic_vector(11 downto 0);
	
	-- Register_EX_MEM output
	signal	isLW_EXMEM, isReadDigit_EXMEM:		std_logic;
	signal	R2Reg_EXMEM, Result_EXMEM: 			std_logic_vector(15 downto 0);
	signal	RegAD_EXMEM:								std_logic_vector(2 downto 0);
	
	-- MEM_WB Multiplexer output
	signal	MEM_WB_Out:	std_logic_vector(15 downto 0);
	
	-- Register_MEM_WB output
	signal 	writeData_WB: 				std_logic_vector(15 downto 0);
	signal	writeAD_WB: 				std_logic_vector(2 downto 0);
	
	-- Forwarder output
	signal	forward1, forward2: 			std_logic_vector(1 downto 0);
	
	-- Selectors output
	signal	sel_out1, sel_out2:			std_logic_vector(15 downto 0);
	
	-- ALUinput Multiplxer output
	signal	ALU_Input1, ALU_Input2:		std_logic_vector(15 downto 0);
	
	-- ALU output signals
	signal	ALUout:				std_logic_vector(15 downto 0);
	signal	carry_out:			std_logic;
	
	-- Hazard Unit output
	signal	wasJumpOut, flush: 		std_logic;
	signal	JRopcode: 					std_logic_vector(1 downto 0);
	
	-- Controller output
	signal	isMFPC, isJump, isReadDigit, isPrintDigit, 
				isR, isLW, isSW, isBranch, isJR:					std_logic;
				
	-- Jump Address output
	signal EJumpAD:				std_logic_vector(15 downto 0);
				
	-- JR Selector output
	signal	JROut: 				std_logic_vector(15 downto 0);
	
	-- PC Register output
	signal	outReg16b:				std_logic_vector(15 downto 0);
	
	-- Register File output
	signal	R1Reg, R2Reg: 				std_logic_vector(15 downto 0);
	signal	outAll: 						std_logic_vector(127 downto 0);
	
	-- R1AD: rs, R2AD: rd OR rt
	signal 	R1AD, R2AD: std_logic_vector(2 downto 0);
	
	---------------- End of Signals ----------------
				
	begin
		
		-- MEM_WB multiplexer
		MUX2_1_MEM_WB: process(isLW_EXMEM, isReadDigit_EXMEM)
		begin
			if (isLW_EXMEM = '1') then
				MEM_WB_Out <= fromData;
			elsif (isReadDigit_EXMEM = '1') then
				MEM_WB_Out <= keyData;
			else
				MEM_WB_Out <= Result_EXMEM;
			end if;
		end process;
				
		Trap: trapUnit				port map (outInstruction(15 downto 12), isEOR);
		
		JumpAddress: jumpAD		port map (jumpShortAddr_IDEX, outInstruction, EjumpAD);
		
		JRSelect: JRSelector		port map (EjumpAD, immediate16_IDEX, outPC, JRopcode, JROut);
		
		PCRegister: reg16b		port map (JRout,(isEOR NOR isEOR_IDEX), clock, outReg16b); -- isEOR NOR isEOR_IDEX -> Enable
		
		RMEMWB: register_MEM_WB		port map (MEM_WB_Out, RegAD_EXMEM, clock, writeData_WB, writeAD_WB);
		
		RIFID: register_IF_ID 		port map (outReg16b, instr, clock, '0', '1', outPC, outInstruction);	-- IF_Flush = '0', IF_ID_ENABLE = '1'
		
		Forward: forwarder			port map	(R1AD_IDEX, R2AD_IDEX, RegAD_EXMEM, writeAD_WB, forward1, forward2);
		Selector1: selector			port map (R1Reg_IDEX, MEM_WB_Out, writeData_WB, forward1, sel_out1);
		Selector2: selector			port map (R2Reg_IDEX, MEM_WB_Out, writeData_WB, forward2, sel_out2);
		
		ALUController: ALUControl 	port map (outInstruction(15 downto 12), outInstruction(2 downto 0), ALUFunc);	-- opcode, func, output
		sign_extend: signExtender	port map (outInstruction(5 downto 0), immediate16);	-- immediate, extended
		
		-- First ALU Input Multiplexer
		MUX2_1_ALU1: process(isMFPC_IDEX)
		begin
			if isMFPC_IDEX = '0' then
				ALU_Input1 <= sel_out1;	
			else
				ALU_Input1 <= outPC; 	
			end if;
		end process;
		
		-- Second ALU Input Multiplexer
		MUX2_1_ALU2: process(isR_IDEX)
		begin
			if isR_IDEX = '0' then
				ALU_Input2 <= immediate16_IDEX;	
			else
				ALU_Input2 <= sel_out2;			
			end if;
		end process;
		
		Control: Controller		port map (outInstruction(15 downto 12), outInstruction(2 downto 0), (flush OR isEOR_IDEX), -- input, flush OR isEOR_IDEX -> flush
														isMFPC, isJump, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR);	-- output
		
		ALU: ALU16					port map (ALU_Input1, ALU_Input2, '0', ALUFunc_IDEX, ALUout, carry_out);
		
		Hazard: hazardUnit		port map (isJR, isJump, '0', (carry_out AND isBranch_IDEX), flush, wasJumpOut, JRopcode); -- carry_out AND isBranch_IDEX -> mustBranch
		
		selectRegister: process(isR)
		begin
			case isR is
				when '1' =>
					R2AD <= outInstruction(5 downto 3);		-- RT
				when '0' =>
					R2AD <= outInstruction(11 downto 9);	-- RD
				when others =>
					R2AD <= outInstruction(11 downto 9);	-- RD
				end case;
		end process;
		
		R1AD <= outInstruction(8 downto 6);		-- RS
		FileRegister: RegFile 	port map (clock2, writeData_WB, writeAD_WB, R1AD, R2AD, R1Reg, R2Reg, outAll);
		
		RIDEX: register_ID_EX		port map (clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit, ALUFunc, R1Reg, R2Reg, immediate16, R1AD, R2AD, outInstruction(11 downto 0),	--input
														 clock_IDEX, isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX, ALUFunc_IDEX,	--output
														 R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX, R1AD_IDEX, R2AD_IDEX, jumpShortAddr_IDEX);	--output
												
														 
		REXMEM: register_EX_MEM		port map (clock, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX, R2Reg_IDEX, ALUout, R2AD_IDEX, --input
														 isLW_EXMEM, DataWriteFlag, isReadDigit_EXMEM, printEnable, R2Reg_EXMEM, Result_EXMEM, RegAD_EXMEM);	--output

		-- Final Output
		dataAD <= R2Reg_EXMEM;
		keyEnable <= isReadDigit_EXMEM;
		printCode <= R2Reg_EXMEM;
		toData <= Result_EXMEM;
		printData <= Result_EXMEM;
		instructionAD <= outReg16b;
		regOUT <= outReg16b & outAll;
		
end architecture behav;





