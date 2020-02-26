library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity data_reg_tb is
end entity data_reg_tb;

architecture data_reg_tb_arch of data_reg_tb is
component data_reg
    Port ( 	clock_i, enableOutPut_i, resetb_i : in std_logic;
		data_i : in bit128;
		data_o : out bit128);
end component;
signal clock_s : std_logic := '0';
signal enableOutput_s, resetb_s : std_logic;
signal data_is, data_os : bit128;
begin
	DUT : data_reg
	Port map (	clock_i => clock_s,
			enableOutput_i => enableOutput_s,
			resetb_i => resetb_s,
			data_i => data_is,
			data_o => data_os
		);
data_is <= (others => '1');
enableOutput_s <= '0', '1' after 300 ns, '0' after 500 ns;
resetb_s <= '1', '0' after 10 ns, '1' after 100 ns;
clock_s <= not clock_s after 50 ns;

end architecture data_reg_tb_arch;

configuration data_reg_tb_conf of data_reg_tb is
	for data_reg_tb_arch
		for DUT: data_reg
			use entity source.data_reg(data_reg_arch);
		end for;
	end for;
end configuration data_reg_tb_conf;
