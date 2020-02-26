library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

--Convertion de type_state à bit128
entity CTStobit128 is
    port(   text_i : in type_state;
            text_o : out bit128);
end CTStobit128;

architecture CTStobit128_arch of CTStobit128 is
begin
    ligne2: for l in 3 downto 0 generate
			colonne2 : for c in 3 downto 0 generate
				text_o((127-8*(l+c*4)) downto (128-8*(l+c*4+1))) <= text_i(l)(c);
			end generate colonne2;
		end generate ligne2;
end architecture CTStobit128_arch;
