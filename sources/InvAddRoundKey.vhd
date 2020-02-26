library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvAddRoundKey is
    port(   Key_i, data_i : in type_state;
            data_o : out type_state
    );
end InvAddRoundKey;

architecture InvAddRoundKey_arch of InvAddRoundKey is
begin
    G1: for i in 0 to 3 generate
        G2: for j in 0 to 3 generate
            data_o(i)(j) <= Key_i(i)(j) XOR data_i(i)(j);
        end generate G2;
    end generate G1;
end architecture InvAddRoundKey_arch;