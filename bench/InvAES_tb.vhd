library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvAES_tb is
end entity InvAES_tb;

architecture InvAES_tb_arch of InvAES_tb is
component InvAES
port(   clk_i, strt_i, rstb_i: in std_logic;
        data_i: in bit128;
        done_o: out std_logic;
        data_o: out bit128);
end component;
signal clock_s : std_logic := '0';
signal strt_s, rstb_s, done_s : std_logic;
signal data_is, data_os : bit128;
begin
	DUT : InvAES
    Port map (  clk_i => clock_s,
                strt_i => strt_s,
                rstb_i => rstb_s,
                data_i => data_is,
                done_o => done_s ,
                data_o => data_os);

rstb_s <= '0', '1' after 30 ns;
clock_s <= not clock_s after 50 ns;
data_is <= X"d6efa6dc4ce8efd2476b9546d76acdf0";
strt_s <= '0', '1' after 40 ns, '0' after 100 ns;

end architecture InvAES_tb_arch;

configuration InvAES_tb_conf of InvAES_tb is
	for InvAES_tb_arch
		for DUT: InvAES
			use entity source.InvAES(InvAES_arch);
		end for;
	end for;
end configuration InvAES_tb_conf;
