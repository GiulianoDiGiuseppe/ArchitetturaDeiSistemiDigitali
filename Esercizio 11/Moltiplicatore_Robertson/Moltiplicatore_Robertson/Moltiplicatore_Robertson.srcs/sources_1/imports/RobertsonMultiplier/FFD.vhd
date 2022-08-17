library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFD is
	port( clock, reset, d, en: in std_logic;
          y: out std_logic);
end FFD;

architecture behavioural of FFD is

	begin
	
	FF_D: process(clock, reset)
		  begin
		  if(en='1') then
			if(reset='1') then	
				y<='0';
			elsif(clock'event and clock='1') then --decidiamo di lavorare sul fronte di discesa per i vantaggi
		  -- di realizzare un SR che lavora sul f.d.d, mentre il contatore lavora sul f.d.s-
			   y<=d;
				end if;
	      end if;
		  end process;
		  
	
	end behavioural;