library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro8 is 
	port( A: in std_logic_vector(7 downto 0);
		  clk, res, en: in std_logic;
		  B: out std_logic_vector(7 downto 0));
end registro8;

architecture behavioural of registro8 is

	begin
	
	R_PP: process(clk, res)
		begin
		if(en='1') then
			if(res='1') then
			   B<= (others=>'0');		   
			elsif(clk'event and clk='1') then
			   B<=A;
	    end if;
		end if;
	end process;
end behavioural;
		  