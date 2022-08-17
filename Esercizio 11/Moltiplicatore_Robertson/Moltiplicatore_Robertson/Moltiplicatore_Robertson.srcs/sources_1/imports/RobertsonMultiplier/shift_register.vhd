library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shif_register is
	port( X: in std_logic_vector(15 downto 0);
		  F: in std_logic;
		  clock, reset, load, en, load_add, shift, f_shift:in std_logic;
		  x_add: in std_logic_vector(7 downto 0);
		  Y: out std_logic_vector(15 downto 0));		  
end shif_register;

architecture behavioural of shif_register is

	signal temp: std_logic_vector(15 downto 0);
	signal temp1: std_logic_vector(15 downto 0);
	begin
	
	SR: process(clock, reset)
		begin
		if(en='1') then
			if(reset='1') then temp<=(others=>'0');
			elsif(clock'event and clock='1') then
				if(load='1') then --se c'è lo start carica il moltiplicatore
					temp<=X;
				elsif(load_add='1') then
						temp(15 downto 8)<=x_add;
				elsif(shift='1') then 							
					  temp(14 downto 0)<=temp(15 downto 1);
					  temp(15)<=F;
				elsif(f_shift='1') then
					  temp(14 downto 0)<=temp(15 downto 1);
					  	
				end if;
				end if;
	    end if;	
		end process;
	Y<=temp;
	end behavioural;
		
			