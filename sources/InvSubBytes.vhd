library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvSubBytes is
port( 	Matrix_i : in type_state;
	Matrix_o : out type_state);
end InvSubBytes;

architecture InvSubBytes_arch of InvSubBytes is
component InvSBOX
	port(	bytes_i : in bit8;
		InvSBOX_o : out bit8);
end component;

begin
	G1:for i in 0 to 3 generate
		G2:for j in 0 to 3 generate
			InvSubBytes0 : InvSBOX 
			port map(
				bytes_i => Matrix_i(i)(j),
				InvSBOX_o => Matrix_o(i)(j)
			);
		end generate G2;
	end generate G1;
end architecture InvSubBytes_arch;

configuration InvSubBytes_conf of InvSubBytes is
for InvSubBytes_arch
	for G1
		for G2
			for InvSubBytes0 : InvSBOX 
				use entity source.InvSBOX(InvSBOX_arch);
			end for;
		end for;
	end for;
end for;
end InvSubBytes_conf;
