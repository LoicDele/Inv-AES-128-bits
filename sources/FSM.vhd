library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity FSM is
port( 	clock_i, resetb_i, start_i : in std_logic;
	round_i : in bit4;
	done_o, enableCounter_o, enableMixColumns_o, enableOutput_o, enableRoundcomputing_o, getciphertext_o, resetCounter_o : out std_logic);
end FSM;

architecture FSM_moore_arch of FSM is 
type state is (init, round0, round9to1, round10, endconv);
signal etat_present, etat_futur : state;
	begin
	seq0 : process(clock_i, resetb_i)
	begin
	if resetb_i = '0' then
		etat_present <= init;
	elsif clock_i'event and clock_i = '1' then
		etat_present <= etat_futur;
		else
		etat_present <= etat_present;
	end if;
	end process seq0;
	seq1 : process(round_i, start_i, etat_present)
	begin	
	case etat_present is
		when init =>
			if start_i = '1' then
				etat_futur <= round10;
			else
				etat_futur <= init;
			end if;
		when round10 =>
			if round_i = "1010" then
				etat_futur <= round9to1;
			else
				etat_futur <= round10;
			end if;
		when round9to1 =>
			if round_i = "0001" then
				etat_futur <= round0;
			else
				etat_futur <= round9to1;
			end if;
		when round0 =>
			if round_i = "0000" then
				etat_futur <= endconv;
			else
				etat_futur <= round0;
			end if;
		when endconv =>
			if start_i =  '0' then
				etat_futur <= init;
			else
				etat_futur <= endconv;
			end if;
	end case;
	end process seq1;
	seq2: process(etat_present)
	begin
		case etat_present is
		when init =>
			done_o <= '0';
			enableCounter_o <= '0';
			enableMixColumns_o <= '0';
			enableOutput_o <= '0';
			enableRoundcomputing_o <= '0';
			getciphertext_o <= '0';
			resetCounter_o <= '1';
		when round0 =>
			done_o <= '0';
			enableCounter_o <= '1';
			enableMixColumns_o <= '0';
			enableOutput_o <= '0';
			enableRoundcomputing_o <= '1';
			getciphertext_o <= '0';
			resetCounter_o <= '0';
		when round9to1 =>
			done_o <= '0';
			enableCounter_o <= '1';
			enableMixColumns_o <= '1';
			enableOutput_o <= '0';
			enableRoundcomputing_o <= '1';
			getciphertext_o <= '0';
			resetCounter_o <= '0';
		when round10 =>
			done_o <= '0';
			enableCounter_o <= '1';
			enableMixColumns_o <= '0';
			enableOutput_o <= '0';
			enableRoundcomputing_o <= '0';
			getciphertext_o <= '1';
			resetCounter_o <= '0';
		when endconv =>
			done_o <= '1';
			enableCounter_o <= '1';
			enableMixColumns_o <= '0';
			enableOutput_o <= '1';
			enableRoundcomputing_o <= '0';
			getciphertext_o <= '0';
			resetCounter_o <= '0';
		end case;
	end process seq2;
end architecture FSM_moore_arch;
