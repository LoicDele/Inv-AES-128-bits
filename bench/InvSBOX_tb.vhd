library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvSBOX_tb is
end entity InvSBOX_tb;

architecture InvSBOX_tb_arch of InvSBOX_tb is
component InvSBOX
    Port ( bytes_i : in bit8;
	   InvSBOX_o : out bit8);
end component;
signal bytes_s : bit8;
signal InvSBOX_s : bit8;
begin
	DUT : InvSBOX
	Port map (
		bytes_i => bytes_s,
		InvSBOX_o => InvSBOX_s);
	bytes_s <= X"00", X"01" after 10 ns;
end architecture InvSBOX_tb_arch;

configuration InvSBOX_tb_conf of InvSBOX_tb is
	for InvSBOX_tb_arch
		for DUT: InvSBOX
			use entity source.InvSBOX(InvSBOX_arch);
		end for;
	end for;
end configuration InvSBOX_tb_conf;
