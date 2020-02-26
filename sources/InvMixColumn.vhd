library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvMixColumn is
port(	column_i : in column_state;
	column_o : out column_state);
end InvMixColumn;

architecture InvMixColumn_arch of InvMixColumn is
signal columnMultBy2_s : column_state;
signal columnMultBy4_s : column_state;
signal columnMultBy8_s : column_state;

signal columnMultBy14_s : column_state;
signal columnMultBy13_s : column_state;
signal columnMultBy11_s : column_state;
signal columnMultBy9_s : column_state;
begin
	--Multiplication par 2
	columnMultBy2_s(0) <= column_i(0)(6 downto 0)&'0' xor ("000"&column_i(0)(7)&column_i(0)(7)&'0'&column_i(0)(7)&column_i(0)(7));
	columnMultBy2_s(1) <= column_i(1)(6 downto 0)&'0' xor ("000"&column_i(1)(7)&column_i(1)(7)&'0'&column_i(1)(7)&column_i(1)(7));
	columnMultBy2_s(2) <= column_i(2)(6 downto 0)&'0' xor ("000"&column_i(2)(7)&column_i(2)(7)&'0'&column_i(2)(7)&column_i(2)(7));
	columnMultBy2_s(3) <= column_i(3)(6 downto 0)&'0' xor ("000"&column_i(3)(7)&column_i(3)(7)&'0'&column_i(3)(7)&column_i(3)(7));
	
	--Multiplication par 4
	columnMultBy4_s(0) <= columnMultBy2_s(0)(6 downto 0)&'0' xor ("000"&columnMultBy2_s(0)(7)&columnMultBy2_s(0)(7)&'0'&columnMultBy2_s(0)(7)&columnMultBy2_s(0)(7));
	columnMultBy4_s(1) <= columnMultBy2_s(1)(6 downto 0)&'0' xor ("000"&columnMultBy2_s(1)(7)&columnMultBy2_s(1)(7)&'0'&columnMultBy2_s(1)(7)&columnMultBy2_s(1)(7));
	columnMultBy4_s(2) <= columnMultBy2_s(2)(6 downto 0)&'0' xor ("000"&columnMultBy2_s(2)(7)&columnMultBy2_s(2)(7)&'0'&columnMultBy2_s(2)(7)&columnMultBy2_s(2)(7));
	columnMultBy4_s(3) <= columnMultBy2_s(3)(6 downto 0)&'0' xor ("000"&columnMultBy2_s(3)(7)&columnMultBy2_s(3)(7)&'0'&columnMultBy2_s(3)(7)&columnMultBy2_s(3)(7));

	--Multiplication par 8
	columnMultBy8_s(0) <= columnMultBy4_s(0)(6 downto 0)&'0' xor ("000"&columnMultBy4_s(0)(7)&columnMultBy4_s(0)(7)&'0'&columnMultBy4_s(0)(7)&columnMultBy4_s(0)(7));
	columnMultBy8_s(1) <= columnMultBy4_s(1)(6 downto 0)&'0' xor ("000"&columnMultBy4_s(1)(7)&columnMultBy4_s(1)(7)&'0'&columnMultBy4_s(1)(7)&columnMultBy4_s(1)(7));
	columnMultBy8_s(2) <= columnMultBy4_s(2)(6 downto 0)&'0' xor ("000"&columnMultBy4_s(2)(7)&columnMultBy4_s(2)(7)&'0'&columnMultBy4_s(2)(7)&columnMultBy4_s(2)(7));
	columnMultBy8_s(3) <= columnMultBy4_s(3)(6 downto 0)&'0' xor ("000"&columnMultBy4_s(3)(7)&columnMultBy4_s(3)(7)&'0'&columnMultBy4_s(3)(7)&columnMultBy4_s(3)(7));
	
	--Multiplication par 9 (8+1) 0x09
	columnMultBy9_s(0) <= columnMultBy8_s(0) xor column_i(0);
	columnMultBy9_s(1) <= columnMultBy8_s(1) xor column_i(1);
	columnMultBy9_s(2) <= columnMultBy8_s(2) xor column_i(2);
	columnMultBy9_s(3) <= columnMultBy8_s(3) xor column_i(3);

	--Multiplication par 11 (8+2+1) 0x0b
	columnMultBy11_s(0) <= columnMultBy8_s(0) xor columnMultBy2_s(0) xor column_i(0);
	columnMultBy11_s(1) <= columnMultBy8_s(1) xor columnMultBy2_s(1) xor column_i(1);
	columnMultBy11_s(2) <= columnMultBy8_s(2) xor columnMultBy2_s(2) xor column_i(2);
	columnMultBy11_s(3) <= columnMultBy8_s(3) xor columnMultBy2_s(3) xor column_i(3);
	
	--Multiplication par 13 (8+4+1) 0x0d
	columnMultBy13_s(0) <= columnMultBy8_s(0) xor columnMultBy4_s(0) xor column_i(0);
	columnMultBy13_s(1) <= columnMultBy8_s(1) xor columnMultBy4_s(1) xor column_i(1);
	columnMultBy13_s(2) <= columnMultBy8_s(2) xor columnMultBy4_s(2) xor column_i(2);
	columnMultBy13_s(3) <= columnMultBy8_s(3) xor columnMultBy4_s(3) xor column_i(3);

	--Multiplication par 14 (8+4+2) 0x0e
	columnMultBy14_s(0) <= columnMultBy8_s(0) xor columnMultBy4_s(0) xor columnMultBy2_s(0);
	columnMultBy14_s(1) <= columnMultBy8_s(1) xor columnMultBy4_s(1) xor columnMultBy2_s(1);
	columnMultBy14_s(2) <= columnMultBy8_s(2) xor columnMultBy4_s(2) xor columnMultBy2_s(2);
	columnMultBy14_s(3) <= columnMultBy8_s(3) xor columnMultBy4_s(3) xor columnMultBy2_s(3);

	--Produit matriciel
	column_o(0) <= columnMultBy14_s(0) xor columnMultBy11_s(1) xor columnMultBy13_s(2) xor columnMultBy9_s(3);
	column_o(1) <= columnMultBy9_s(0) xor columnMultBy14_s(1) xor columnMultBy11_s(2) xor columnMultBy13_s(3);
	column_o(2) <= columnMultBy13_s(0) xor columnMultBy9_s(1) xor columnMultBy14_s(2) xor columnMultBy11_s(3);
	column_o(3) <= columnMultBy11_s(0) xor columnMultBy13_s(1) xor columnMultBy9_s(2) xor columnMultBy14_s(3);
end architecture InvMixColumn_arch;
