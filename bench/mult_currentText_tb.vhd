library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity mult_currentText_tb is
end entity mult_currentText_tb;

architecture mult_currentText_tb_arch of mult_currentText_tb is
component mult_currentText
    Port ( 	getcyphertext_i : in std_logic;
		dataInvAES_i, dataNew_i : in bit128;
		data_o : out bit128);
end component;
signal getcyphertext_s : std_logic;
signal dataInvAES_s, dataNew_s, data_os : bit128;
begin 
	DUT : mult_currentText
	Port map ( 
			getcyphertext_i => getcyphertext_s,
			dataInvAES_i => dataInvAES_s,
			dataNew_i => dataNew_s,
			data_o => data_os	 
		);

getcyphertext_s <= '0', '1' after 50 ns, '0' after 250 ns;
dataInvAES_s <= (others => '1');
dataNew_s <= (others => '0');

end architecture mult_currentText_tb_arch;

configuration mult_currentText_tb_conf of mult_currentText_tb is
	for mult_currentText_tb_arch
		for DUT: mult_currentText
			use entity source.mult_currentText(mult_currentText_arch);
		end for;
	end for;
end configuration mult_currentText_tb_conf;
