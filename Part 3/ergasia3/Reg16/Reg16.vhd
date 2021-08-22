--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--16-BIT REGISTER IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity reg16 is
	generic (
		n: integer := 16
	);
	port	(
		in1: in std_logic_vector(n-1 downto 0);
		enable, clock: in std_logic;
		out1: out std_logic_vector(n-1 downto 0)
	);
end reg16;

architecture logic of reg16 is
	component GatedClockDFF is
		port (in1, clock, enable: in std_logic;
				out1: out std_logic);
	end component;

	begin
	G0: GatedClockDFF port map(in1(0), clock, enable, out1(0));
	G1: GatedClockDFF port map(in1(1), clock, enable, out1(1));
	G2: GatedClockDFF port map(in1(2), clock, enable, out1(2));
	G3: GatedClockDFF port map(in1(3), clock, enable, out1(3));
	G4: GatedClockDFF port map(in1(4), clock, enable, out1(4));
	G5: GatedClockDFF port map(in1(5), clock, enable, out1(5));
	G6: GatedClockDFF port map(in1(6), clock, enable, out1(6));
	G7: GatedClockDFF port map(in1(7), clock, enable, out1(7));
	G8: GatedClockDFF port map(in1(8), clock, enable, out1(8));
	G9: GatedClockDFF port map(in1(9), clock, enable, out1(9));
	G10: GatedClockDFF port map(in1(10), clock, enable, out1(10));
	G11: GatedClockDFF port map(in1(11), clock, enable, out1(11));
	G12: GatedClockDFF port map(in1(12), clock, enable, out1(12));
	G13: GatedClockDFF port map(in1(13), clock, enable, out1(13));
	G14: GatedClockDFF port map(in1(14), clock, enable, out1(14));
	G15: GatedClockDFF port map(in1(15), clock, enable, out1(15));
end logic;
	