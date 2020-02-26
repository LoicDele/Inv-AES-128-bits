library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity mult_currentText is
port(	getcyphertext_i : in std_logic;
	dataInvAES_i, dataNew_i : in bit128;
	data_o : out bit128);
end mult_currentText;

architecture mult_currentText_arch of mult_currentText is
signal data_s : bit128;
begin
seq_0 : process(getcyphertext_i, dataInvAES_i, dataNew_i)
	begin
	if getcyphertext_i = '1' then
		data_s <= dataNew_i;
	else
		data_s <= dataInvAES_i;
	end if;
end process seq_0;
data_o <= data_s;
end architecture mult_currentText_arch;
