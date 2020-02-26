library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvRoundAES_tb is
end entity InvRoundAES_tb;

architecture InvRoundAES_tb_arch of InvRoundAES_tb is
component InvRoundAES
    Port (  clck_i, enableInvMixColumns_i, enableRoundcomputing_i, rsetb_i : in std_logic;
            currenttext_i, currentkey_i : in bit128;
            data_o : out bit128);
end component;
signal clock_s : std_logic := '0';
signal enableInvMixColumns_s, enableRoundcomputing_s, rsetb_s : std_logic;
signal currenttext_s, currentkey_s, data_s : bit128;
begin
	DUT : InvRoundAES
    Port map (  clck_i => clock_s,
                enableInvMixColumns_i => enableInvMixColumns_s,
                enableRoundcomputing_i => enableRoundcomputing_s,
                rsetb_i => rsetb_s,
                currenttext_i =>  currenttext_s,
                currentkey_i => currentkey_s,
                data_o => data_s);

rsetb_s <= '1';
clock_s <= not clock_s after 50 ns;
enableInvMixColumns_s <= '1';
enableRoundcomputing_s <= '1';
currentkey_s <= X"ead27321b58dbad2312bf5607f8d292f";
currenttext_s <= X"362baab27ee343ff292dea22bfea0fc0";
end architecture InvRoundAES_tb_arch;

configuration InvRoundAES_tb_conf of InvRoundAES_tb is
	for InvRoundAES_tb_arch
		for DUT: InvRoundAES
			use entity source.InvRoundAES(InvRoundAES_arch);
		end for;
	end for;
end configuration InvRoundAES_tb_conf;
