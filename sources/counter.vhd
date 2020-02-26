library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity counter is
port(	clock_i, resetb_i, enable_i : in std_logic;
	count_o : out std_logic_vector (3 downto 0));
end counter;

architecture counter_arch of counter is
signal q_s : integer range 0 to 10;
begin
	seq_0 : process(clock_i, resetb_i, enable_i)
		begin
			if resetb_i ='1' then
				q_s <= 10;
			elsif clock_i'event and clock_i ='1' then
				if enable_i = '1' then
					if q_s = 0 then
						q_s <= q_s;
					else
						q_s <= q_s - 1;
					end if;
				else
					q_s <= q_s;
				end if;
			else
				q_s <= q_s;
			end if;
		end process seq_0;
count_o <= std_logic_vector(to_unsigned(q_s,4));
end architecture counter_arch;

