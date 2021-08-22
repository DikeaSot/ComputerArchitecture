--DIMITRIS STEFANOU 3160245
--DIKEA SOTIROPOULOU 3160172
--REGISTER FILE IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;

entity regFile is
	generic	(n: integer := 16;
				 k: integer := 3;
				 regNum: integer := 8);
	port	(clock: in std_logic;
			 write1: in std_logic_vector(n-1 downto 0);
			 write1AD, read1AD, read2AD: in std_logic_vector(k-1 downto 0);
			 read1, read2: out std_logic_vector(n-1 downto 0);
			 outAll: out std_logic_vector(n*regNum-1 downto 0));
end regFile;

architecture logic of regFile is
	component reg0 is
		port	(in1: in std_logic_vector(n-1 downto 0);
				 enable, clock: in std_logic;
				 out1: out std_logic_vector(n-1 downto 0));
	end component;
	
	component reg16 is
		port	(in1: in std_logic_vector(n-1 downto 0);
				 enable, clock: in std_logic;
				 out1: out std_logic_vector(n-1 downto 0));
	end component;
	
	component decode3_8 is
		port	(in1: in std_logic_vector(k-1 downto 0);
				 out1: out std_logic_vector(regNum-1 downto 0));
	end component;
	
	component mux8to1 is
		port	(in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector(n-1 downto 0);
				 choice: in std_logic_vector(k-1 downto 0);
				 output: out std_logic_vector(n-1 downto 0));
	end component;
	
	signal enableSigs: std_logic_vector(regNum-1 downto 0);
	signal re0, re1, re2, re3, re4, re5, re6, re7: std_logic_vector(n-1 downto 0):= "0000000000000000";
	
	begin
		G0: decode3_8 port map (write1AD, enableSigs);
		
		G1: reg0 port map (write1, enableSigs(0), clock, re0);
		G2: reg16 port map (write1, enableSigs(1), clock, re1);
		G3: reg16 port map (write1, enableSigs(2), clock, re2);
		G4: reg16 port map (write1, enableSigs(3), clock, re3);
		G5: reg16 port map (write1, enableSigs(4), clock, re4);
		G6: reg16 port map (write1, enableSigs(5), clock, re5);
		G7: reg16 port map (write1, enableSigs(6), clock, re6);
		G8: reg16 port map (write1, enableSigs(7), clock, re7);
		
		G9: mux8to1 port map (re0, re1, re2, re3, re4, re5, re6, re7, read1AD, read1);
		G10: mux8to1 port map (re0, re1, re2, re3, re4, re5, re6, re7, read2AD, read2);
		
		outAll <= re7 & re6 & re5 & re4 & re3 & re2 & re1 & re0;

end logic;
				 