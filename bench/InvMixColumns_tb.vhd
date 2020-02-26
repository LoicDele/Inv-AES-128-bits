library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvMixColumns_tb is
end entity InvMixColumns_tb;

architecture InvMixColumns_tb_arch of InvMixColumns_tb is
component InvMixColumns
    Port ( matrix_i : in type_state;
	   matrix_o : out type_state);
end component;
signal matrix_s : type_state;
signal InvMixColumns_s : type_state;
begin 
	DUT : InvMixColumns
	Port map (
		matrix_i => matrix_s,
		matrix_o => InvMixColumns_s);
	matrix_s <= ((X"37", X"4d", X"4e", X"b0"),(X"cf", X"f1", X"c3", X"81"), (X"02", X"02", X"d4", X"10"), (X"3e", X"10", X"13", X"03"));
end architecture InvMixColumns_tb_arch;

configuration InvMixColumns_tb_conf of InvMixColumns_tb is
	for InvMixColumns_tb_arch
		for DUT: InvMixColumns
			use entity source.InvMixColumns(InvMixColumns_arch);
		end for;
	end for;
end configuration InvMixColumns_tb_conf;
