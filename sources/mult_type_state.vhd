library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity mult_currentTS is
port(	switch_i : in std_logic;
	data1_i, data2_i : in type_state;
	data_o : out type_state);
end mult_currentTS;

architecture mult_currentTS_arch of mult_currentTS is
signal data_s : type_state;
begin
seq_0 : process(switch_i, data1_i, data2_i)
	begin
	if switch_i = '0' then
		data_s <= data1_i;
	else
		data_s <= data2_i;
	end if;
end process seq_0;
data_o <= data_s;
end architecture mult_currentTS_arch;
