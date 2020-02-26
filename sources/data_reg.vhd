library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity data_reg is
port(	clock_i, enableOutput_i, resetb_i : in std_logic;
	data_i : in bit128;
	data_o : out bit128);
end data_reg;

architecture data_reg_arch of data_reg is
signal data_s : bit128;
begin
seq_0 : process(clock_i, enableOutput_i, resetb_i)
	begin
	if resetb_i = '0' then
		data_s <= (others => '0');
	elsif clock_i'event and clock_i = '1' then
		if enableOutput_i = '1' then
			data_s <= data_i;
		else
			data_s <= data_s;
		end if;
	else
		data_s <= data_s;
	end if;
end process seq_0;
data_o <= data_s;
end architecture data_reg_arch;
