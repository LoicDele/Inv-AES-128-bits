library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity FSM_tb is
end entity FSM_tb;

architecture FSM_tb_arch of FSM_tb is
component FSM
    Port ( 	clock_i, resetb_i, start_i : in std_logic;
		round_i : in bit4;
		done_o, enableCounter_o, enableMixColumns_o, enableOutput_o, enableRoundcomputing_o, getciphertext_o, resetCounter_o : out std_logic);
end component;
signal resetb_s, start_s,  done_s, enableCounter_s, enableMixColumns_s, enableOutput_s, enableRoundcomputing_s, getciphertext_s, resetCounter_s : std_logic;
signal clock_s: std_logic := '0';
signal round_s : bit4;
begin 
	DUT : FSM
	Port map (
		clock_i => clock_s,
		resetb_i => resetb_s,
		start_i => start_s,
		round_i => round_s,
		done_o => done_s,
		enableCounter_o => enableCounter_s,
		enableMixColumns_o => enableMixColumns_s,
		enableOutput_o => enableOutput_s,
		enableRoundcomputing_o => enableRoundcomputing_s,
		getciphertext_o => getciphertext_s,
		resetCounter_o => resetCounter_s);
clock_s <= not clock_s after 50 ns;
resetb_s <= '0', '1' after 90 ns;
start_s <= '0', '1' after 75 ns;
round_s <= "1010", "1001" after 225 ns, "1000" after 325 ns, "0111" after 425 ns, "0110" after 525 ns, "0101" after 625 ns, "0100" after 725 ns, "0011" after 825 ns, "0010" after 925 ns, "0001" after 1025 ns, "0000" after 1125 ns; 
end architecture FSM_tb_arch;

configuration FSM_tb_conf of FSM_tb is
	for FSM_tb_arch
		for DUT: FSM
			use entity source.FSM(FSM_moore_arch);
		end for;
	end for;
end configuration FSM_tb_conf;
