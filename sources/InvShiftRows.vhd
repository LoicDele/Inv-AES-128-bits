library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvShiftRows is
port( 	Matrix_i: in type_state;
	Matrix_o: out type_state);
end InvShiftRows;

architecture InvShiftRows_arch of InvShiftRows is
begin
	Matrix_o(0) <= matrix_i(0);
	Matrix_o(1)(0) <= Matrix_i(1)(3);
	Matrix_o(1)(1) <= Matrix_i(1)(0);
	Matrix_o(1)(2) <= Matrix_i(1)(1);
	Matrix_o(1)(3) <= Matrix_i(1)(2);
	Matrix_o(2)(0) <= Matrix_i(2)(2);
	Matrix_o(2)(1) <= Matrix_i(2)(3);
	Matrix_o(2)(2) <= Matrix_i(2)(0);
	Matrix_o(2)(3) <= Matrix_i(2)(1);
	Matrix_o(3)(0) <= Matrix_i(3)(1);
	Matrix_o(3)(1) <= Matrix_i(3)(2);
	Matrix_o(3)(2) <= Matrix_i(3)(3);
	Matrix_o(3)(3) <= Matrix_i(3)(0);

end architecture InvShiftRows_arch;
