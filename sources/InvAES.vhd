library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvAES is
    port(   clk_i, strt_i, rstb_i: in std_logic;
            data_i: in bit128;
            done_o: out std_logic;
            data_o: out bit128);
end InvAES;

architecture InvAES_arch of InvAES is
component InvRoundAES
    port(   clck_i, enableInvMixColumns_i, enableRoundcomputing_i, rsetb_i : in std_logic;
            currenttext_i, currentkey_i : in bit128;
            data_o : out bit128);
end component;

component counter
    port(	clock_i, resetb_i, enable_i : in std_logic;
            count_o : out std_logic_vector (3 downto 0));
end component;

component KeyExpansion_table
    Port (  round_i : in bit4;
            expansion_key_o : out bit128);
end component;

component data_reg
    port(	clock_i, enableOutput_i, resetb_i : in std_logic;
	        data_i : in bit128;
	        data_o : out bit128);
end component;

component FSM
    port( 	clock_i, resetb_i, start_i : in std_logic;
	        round_i : in bit4;
	        done_o, enableCounter_o, enableMixColumns_o, enableOutput_o, enableRoundcomputing_o, getciphertext_o, resetCounter_o : out std_logic);
end component;

component mult_currentText
    port(	getcyphertext_i : in std_logic;
            dataInvAES_i, dataNew_i : in bit128;
            data_o : out bit128);
end component;
signal currenttext_s, exitAESround_s, currentkey_s, dataf_s : bit128;
signal getcypertext_s, done_s, enableCounter_s, enableMixColumns_s, enableOutput_s, enableRoundcomputing_s, getcyphertext_s, resetCounter_s : std_logic;
signal round_s : std_logic_vector (3 downto 0);
begin
    InvRoundAES0 : InvRoundAES
        port map(   clck_i => clk_i,
                    enableInvMixColumns_i => enableMixColumns_s,
                    enableRoundcomputing_i => enableRoundcomputing_s,
                    rsetb_i => rstb_i,
                    currenttext_i => currenttext_s,
                    currentkey_i => currentkey_s,
                    data_o => exitAESround_s);
    mult_currentText0 : mult_currentText
        port map(   dataInvAES_i => exitAESround_s,
                    dataNew_i => data_i,
                    data_o => currenttext_s,
                    getcyphertext_i => getcyphertext_s);
    FSM0 : FSM
        port map(   clock_i => clk_i,
                    resetb_i => rstb_i,
                    start_i => strt_i,
                    done_o => done_s,
                    round_i => round_s,
                    enableCounter_o => enableCounter_s,
                    enableMixColumns_o => enableMixColumns_s,
                    enableOutput_o => enableOutput_s,
                    enableRoundcomputing_o => enableRoundcomputing_s,
                    getciphertext_o => getcyphertext_s,
                    resetCounter_o => resetCounter_s);
    data_reg0 : data_reg
        port map(   clock_i => clk_i,
                    enableOutput_i => enableOutput_s,
                    resetb_i => rstb_i,
                    data_i => exitAESround_s,
                    data_o => dataf_s);
    KeyExpansion_table0 : KeyExpansion_table
        port map(   round_i => round_s,
                    expansion_key_o => currentkey_s);
    counter0 : counter
        port map(   clock_i => clk_i,
                    resetb_i => resetCounter_s,
                    enable_i => enableCounter_s,
                    count_o => round_s);
    data_o <= dataf_s;
    done_o <= done_s;
end architecture InvAES_arch;

configuration InvAES_conf of InvAES is
for InvAES_arch
    for all : InvRoundAES
        use entity source.InvRoundAES(InvRoundAES_arcg);
    end for;
    for all : counter
        use entity source.counter(counter_arch);
    end for;
    for all : KeyExpansion_table
        use entity source.KeyExpansion_table(KeyExpansion_table_arch);
    end for;
    for all : FSM
        use entity source.FSM(FSM_moore_arch);
    end for;
    for all : mult_currentText
        use entity source.mult_currentText(mult_currentText_arch);
    end for;
    for all : data_reg
        use entity source.data_reg(data_reg_arch);
    end for;
end for;
end InvAES_conf;