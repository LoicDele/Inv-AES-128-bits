library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvSubBytes_tb is
end entity InvSubBytes_tb;

architecture InvSubBytes_tb_arch of InvSubBytes_tb is
component InvSubBytes
    Port ( matrix_i : in type_state;
	   matrix_o : out type_state);
end component;
signal matrix_s : type_state;
signal InvSubBytes_s : type_state;
begin 
	DUT : InvSubBytes
	Port map (
		matrix_i => matrix_s,
		matrix_o => InvSubBytes_s);
	matrix_s <= ((X"b6", X"af", X"33", X"aa"),(X"a0", X"19", X"a9", X"e8"), (X"3d", X"0c", X"10", X"69"), (X"4d", X"ac", X"a8", X"7b"));
end architecture InvSubBytes_tb_arch;

configuration InvSubBytes_tb_conf of InvSubBytes_tb is
	for InvSubBytes_tb_arch
		for DUT: InvSubBytes
			use entity source.InvSubBytes(InvSubBytes_arch);
		end for;
	end for;
end configuration InvSubBytes_tb_conf;
