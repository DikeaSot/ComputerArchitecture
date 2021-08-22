--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--1-BIT REGISTER IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity GatedClockDFF is
	port (in1, clock, enable: in std_logic;
			out1: out std_logic);
end GatedClockDFF;

architecture logic of GatedClockDFF is
	signal P1, P2, P3, P4, P5, P6, afterClock: std_logic;
	begin
		P3 <= P1 NAND P4;
		P1 <= afterClock NAND P3;
		P2 <= NOT(afterClock AND P1 AND P4);
		P4 <= in1 NAND P2;
		P5 <= P6 NAND P2;
		P6 <= P2 NAND P5;
		afterClock <= Clock AND enable;
		out1 <= P5;
end logic;