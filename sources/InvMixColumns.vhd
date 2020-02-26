library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvMixColumns is
port( 	matrix_i: in type_state;
	matrix_o: out type_state);
end InvMixColumns;

architecture InvMixColumns_arch of InvMixColumns is
component InvMixColumn
	port( 	column_i : in column_state;
		column_o : out column_state);
end component;
signal column0_is, column1_is, column2_is, column3_is, column0_os, column1_os, column2_os, column3_os: column_state;

begin
	column0_is(0) <= matrix_i(0)(0);
	column0_is(1) <= matrix_i(1)(0);
	column0_is(2) <= matrix_i(2)(0);
	column0_is(3) <= matrix_i(3)(0);

	column1_is(0) <= matrix_i(0)(1);
	column1_is(1) <= matrix_i(1)(1);
	column1_is(2) <= matrix_i(2)(1);
	column1_is(3) <= matrix_i(3)(1);

	column2_is(0) <= matrix_i(0)(2);
	column2_is(1) <= matrix_i(1)(2);
	column2_is(2) <= matrix_i(2)(2);
	column2_is(3) <= matrix_i(3)(2);

	column3_is(0) <= matrix_i(0)(3);
	column3_is(1) <= matrix_i(1)(3);
	column3_is(2) <= matrix_i(2)(3);
	column3_is(3) <= matrix_i(3)(3);
	
	InvMixColumns0 : InvMixColumn
		port map(
			column_i => column0_is,
			column_o => column0_os);
	
	InvMixColumns1 : InvMixColumn
		port map(
			column_i => column1_is,
			column_o => column1_os);

	InvMixColumns2 : InvMixColumn
		port map(
			column_i => column2_is,
			column_o => column2_os);

	InvMixColumns3 : InvMixColumn
		port map(
			column_i => column3_is,
			column_o => column3_os);
	
	matrix_o(0)(0) <= column0_os(0);
	matrix_o(0)(1) <= column1_os(0);
	matrix_o(0)(2) <= column2_os(0);
	matrix_o(0)(3) <= column3_os(0);
	
	matrix_o(1)(0) <= column0_os(1);
	matrix_o(1)(1) <= column1_os(1);
	matrix_o(1)(2) <= column2_os(1);
	matrix_o(1)(3) <= column3_os(1);

	matrix_o(2)(0) <= column0_os(2);
	matrix_o(2)(1) <= column1_os(2);
	matrix_o(2)(2) <= column2_os(2);
	matrix_o(2)(3) <= column3_os(2);

	matrix_o(3)(0) <= column0_os(3);
	matrix_o(3)(1) <= column1_os(3);
	matrix_o(3)(2) <= column2_os(3);
	matrix_o(3)(3) <= column3_os(3);

end architecture InvMixColumns_arch;

configuration InvMixColumns_conf of InvMixColumns is
for InvMixColumns_arch
	for all : InvMixColumn
		use entity source.InvMixColumn(InvMixColumn_arch);
	end for;
end for;
end InvMixColumns_conf;
