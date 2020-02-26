library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvMixColumn_tb is
end entity InvMixColumn_tb;

architecture InvMixColumn_tb_arch of InvMixColumn_tb is
component InvMixColumn
    Port ( column_i : in column_state;
	   column_o : out column_state);
end component;
signal column_s : column_state := (X"37", X"cf", X"02", X"3e");
signal InvMixColumn_s : column_state;
begin 
	DUT : InvMixColumn
	Port map (
		column_i => column_s,
		column_o => InvMixColumn_s);
end architecture InvMixColumn_tb_arch;

configuration InvMixColumn_tb_conf of InvMixColumn_tb is
	for InvMixColumn_tb_arch
		for DUT: InvMixColumn
			use entity source.InvMixColumn(InvMixColumn_arch);
		end for;
	end for;
end configuration InvMixColumn_tb_conf;
