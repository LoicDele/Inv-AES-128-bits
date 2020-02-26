library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity counter_tb is
end entity counter_tb;

architecture counter_tb_arch of counter_tb is
component counter
    Port ( 	clock_i, resetb_i, enable_i : in std_logic;
		count_o : out std_logic_vector (3 downto 0));
end component;
signal resetb_s, enable_s : std_logic;
signal clock_s : std_logic := '0';
signal count_s : std_logic_vector (3 downto 0);
begin
	DUT : counter
	Port map (	clock_i => clock_s,
			resetb_i => resetb_s,
			enable_i => enable_s,
			count_o => count_s);
clock_s <= not clock_s after 50 ns;
enable_s <= '1';
resetb_s <= '1', '0' after 10 ns, '1' after 40 ns;

end architecture counter_tb_arch;

configuration counter_tb_conf of counter_tb is
	for counter_tb_arch
		for DUT: counter
			use entity source.counter(counter_arch);
		end for;
	end for;
end configuration counter_tb_conf;
