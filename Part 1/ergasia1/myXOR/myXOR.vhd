library ieee;
use ieee.std_logic_1164.all;

entity myXOR is
port(in1, in2: in std_logic;
out1: out std_logic);
end myXOR;


architecture LogicFunc of myXOR is
begin
out1 <= in1 XOR in2;
end LogicFunc;