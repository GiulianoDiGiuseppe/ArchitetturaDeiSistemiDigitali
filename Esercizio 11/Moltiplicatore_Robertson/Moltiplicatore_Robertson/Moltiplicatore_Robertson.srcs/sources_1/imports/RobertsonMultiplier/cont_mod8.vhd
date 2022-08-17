library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont_mod8 is
	port( clock, reset: in std_logic;
		  count_in: in std_logic;
		  count_end: out std_logic;
		  count: out std_logic_vector(2 downto 0));
end cont_mod8;

architecture behavioural of cont_mod8 is
	signal c: std_logic_vector(2 downto 0);
	
	begin	
	CM8: process(clock, reset, count_in)
	begin
		if(reset='1') then 
			c<= (others=>'0');
			count_end<='0';
		elsif(clock'event and clock='1' and count_in='1') then
			c<= std_logic_vector(unsigned(c) + 1);
			if(c="111") then count_end<='1';
			else count_end<='0';
		end if;
		end if;
		end process;
	count<= c;
	end behavioural;