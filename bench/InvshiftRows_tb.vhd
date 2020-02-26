library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvShiftRows_tb is
end entity InvShiftRows_tb;

architecture InvShiftRows_tb_arch of InvShiftRows_tb is
component InvShiftRows
    Port ( Matrix_i : in type_state;
	   Matrix_o : out type_state);
end component;
signal matrix_s : type_state := ((X"b6", X"a0", X"3d", X"4d"), (X"19", X"0c", X"ac", X"af"),(X"10", X"a8", X"33", X"a9"), (X"7b", X"aa", X"e8", X"69"));
signal InvShiftRows_s : type_state;
begin 
	DUT : InvShiftRows
	Port map (	matrix_i => matrix_s,
			matrix_o => InvShiftRows_s);
	
end architecture InvShiftRows_tb_arch;

configuration InvShiftRows_tb_conf of InvShiftRows_tb is
	for InvShiftRows_tb_arch
		for DUT: InvShiftRows
			use entity source.InvShiftRows(InvShiftRows_arch);
		end for;
	end for;
end configuration InvShiftRows_tb_conf;
