library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvAddRoundKey_tb is
end entity InvAddRoundKey_tb;

architecture InvAddRoundKey_tb_arch of InvAddRoundKey_tb is
    component InvAddRoundKey
        Port(data_i, Key_i : in type_state;
            data_o : out type_state);
    end component;
signal Key_s, data_is, data_os : type_state;
begin
    DUT : InvAddRoundKey
    port map (
        data_i => data_is,
        Key_i => Key_s,
        data_o => data_os
    );
    Key_s <= ((X"a0",X"88",X"23",X"2a"),(X"fa",X"54",X"a3",X"6c"),(X"fe",X"2c",X"39",X"76"),(X"17",X"b1",X"39",X"05"));
    data_is <= ((X"97",X"c5",X"6d",X"9a"),(X"35",X"a5",X"60",X"ed"),(X"fc",X"2e",X"ed",X"66"),(X"29",X"a1",X"2a",X"06"));
end architecture InvAddRoundKey_tb_arch;

configuration InvAddRoundKey_tb_conf of InvAddRoundKey_tb is
	for InvAddRoundKey_tb_arch
		for DUT: InvAddRoundKey
			use entity source.InvAddRoundKey(InvAddRoundKey_arch);
		end for;
	end for;
end configuration InvAddRoundKey_tb_conf;