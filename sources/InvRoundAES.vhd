library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvRoundAES is
    port(   clck_i, enableInvMixColumns_i, enableRoundcomputing_i, rsetb_i : in std_logic;
            currenttext_i, currentkey_i : in bit128;
            data_o : out bit128);
end InvRoundAES;

architecture InvRoundAES_arch of InvRoundAES is
component Cbit128toTS
    port(   Key_i, text_i : in bit128;
            Key_o, text_o : out type_state);
end component;

component InvShiftRows
    port(   Matrix_i: in type_state;
            Matrix_o: out type_state);
end component;

component InvSubBytes
    port(   Matrix_i: in type_state;
            Matrix_o: out type_state);
end component;

component mult_currentTS
    port(   data1_i, data2_i : in type_state;
            data_o : out type_state;
            switch_i : in std_logic);
end component;

component InvAddRoundKey
    port(   Key_i, data_i : in type_state;
            data_o : out type_state);
end component;

component InvMixColumns
    port(   matrix_i: in type_state;
            matrix_o: out type_state);
end component;

component CTStobit128
    port(   text_i: in type_state;
            text_o: out bit128);
end component;

component data_reg
    port(   data_i : in bit128;
            data_o : out bit128;
            clock_i, enableOutput_i, resetb_i : in std_logic);
end component;

signal KeyTS_s, data1_s, data2_s, data3_s, data4_s, data5_s, data6_s, data7_s : type_state;
signal dataf_s, dataf1_s : bit128;
begin
    Cbit128toTS0 : Cbit128toTS
        port map(   Key_i => currentKey_i,
                    text_i => currenttext_i,
                    Key_o => KeyTS_s,
                    text_o => data1_s);
    InvShiftRows0 : InvShiftRows
        port map(   Matrix_i => data1_s,
                    Matrix_o => data2_s);
    InvSubBytes0 : InvSubBytes
        port map(   Matrix_i => data2_s,
                    Matrix_o => data3_s);
    mult_currentTS0 : mult_currentTS
        port map(   data1_i => data1_s,
                    data2_i => data3_s,
                    data_o => data4_s,
                    switch_i => enableRoundcomputing_i);
    InvAddRoundKey0 : InvAddRoundKey
        port map(   Key_i => KeyTS_s,
                    data_i => data4_s,
                    data_o => data5_s);
    InvMixColumns0 : InvMixColumns
        port map(   matrix_i => data5_s,
                    matrix_o => data6_s);
    mult_currentTS1 : mult_currentTS
        port map(   data1_i => data5_s,
                    data2_i => data6_s,
                    data_o => data7_s,
                    switch_i => enableInvMixColumns_i);
    CTStobit1280 : CTStobit128
        port map(   text_i => data7_s,
                    text_o => dataf_s);
    data_reg0 : data_reg
        port map(   data_i => dataf_s,
                    data_o => dataf1_s,
                    clock_i => clck_i,
                    enableOutput_i => '1',
                    resetb_i => rsetb_i);
    data_o <= dataf1_s;
end architecture InvRoundAES_arch;

configuration InvRoundAES_conf of InvRoundAES is
for InvRoundAES_arch
    for all : Cbit128toTS
        use entity source.cbit128toTS(Cbit128toTS_arch);
    end for;
    for all : InvShiftRows
        use entity source.InvShiftRows(InvShiftROws_arch);
    end for;
    for all : InvSubBytes
        use entity source.InvSubBytes(InvSubBytes_arch);
    end for;
    for all : mult_currentTS
        use entity source.mult_currentts(mult_currentTS_arch);
    end for;
    for all : InvAddRoundKey
        use entity source.InvAddRoundKey(InvAddRoundKey_arch);
    end for;
    for all : InvMixColumns
        use entity source.InvMixColumns(InvMixColumns_arch);
    end for;
    for all : CTStobit128
        use entity source.CTStobit128(CTStobit128_arch);
    end for;
    for all : data_reg
        use entity source.data_reg(data_reg_arch);
    end for;
end for;
end InvRoundAES_conf;