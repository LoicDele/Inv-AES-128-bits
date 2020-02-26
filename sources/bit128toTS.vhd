library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

--Convertion d'un bit128 en un type_state
entity Cbit128toTS is
    port(   Key_i, text_i : in bit128;
            Key_o, text_o : out type_state);
end Cbit128toTS;

architecture Cbit128toTS_arch of Cbit128toTS is
begin
    ligne1 : for l in 0 to 3 generate
    colonne1 : for c in 0 to 3 generate
       Key_o(l)(c) <= Key_i((127-8*(l+c*4)) downto (128-8*(l+c*4+1)));
       Text_o(l)(c) <= Text_i((127-8*(l+c*4)) downto (128-8*(l+c*4+1)));
   end generate colonne1;
end generate ligne1;
end architecture Cbit128toTS_arch;

