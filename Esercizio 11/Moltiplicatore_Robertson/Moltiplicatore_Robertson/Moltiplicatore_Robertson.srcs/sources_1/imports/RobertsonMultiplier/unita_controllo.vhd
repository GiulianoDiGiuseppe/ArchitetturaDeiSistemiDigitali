library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_controllo is 
	port( q0, clock, reset, start: in std_logic;
			count: in std_logic_vector(2 downto 0);
		  en_SR, en_R8, en_D, count_in, load_add, en_shift: out std_logic;
		  sel, reset_out, subtract, load, stop, en_fshift, stop_cu: out std_logic); 
end unita_controllo;

architecture structural of unita_controllo is
	type state is (idle, init, acquisizione, add, shift, correzione, f_shift);
	signal current_state, next_state: state;

	begin 

	
	reg_stato: process(clock, reset)
			  begin
		      if(reset='1') then 
				current_state<=init;
			  elsif(clock'event and clock='1') then 
				current_state<=next_state;
			  end if;
			  end process;
			  
	comb: process(current_state, count)
		  begin
		  next_state<=idle;
		 
		  CASE current_state is
		  
		  WHEN idle => reset_out<='1';
					   en_D<='1'; --serve l'abilitazione alta altrimenti non resetta
					   en_R8<='1';
					   en_SR<='1';
					   count_in<='0'; 
					   subtract<='0';
					   load_add<='0';
					   load<='0';
					   sel<='0';
					   stop<='0';
						stop_cu<='0';
						en_fshift<='0';
						en_shift<='0';
					   if(start='1') then next_state<=init;
					   else next_state<=idle;
					   end if;
		--in ogni stato dobbiamo predisporre i valori dei segnali per lo stadio successivo
		  WHEN init => reset_out<='0'; 
		               count_in<='0';
					   load_add<='0';
					   en_D<='1';
					   en_R8<='1'; --carica y in acquisizione
					   en_SR<='1';
					   load<='1'; --abilitiamo SR per caricare x in acquisizione
					   subtract<='0';
					   stop<='0';
					   sel<=q0;
						en_shift<='0';
						en_fshift<='0';
						stop_cu<='0';
					   next_state<=acquisizione;
						
		--acquisisce gli operandi e predispone la add
		 WHEN acquisizione =>   en_SR<='1'; --disabilitiamo Sr così non shifta
					  load<='0'; 
					  reset_out<='0'; 
					  en_D<='1';
					  load_add<='1';
					  en_R8<='1';
					  count_in<='1';
					  subtract<='0';
					  sel<=q0;
					  stop<='0';
					  stop_cu<='0';
					  en_fshift<='0';
					  en_shift<='0';
					  if(count="111") then 
									subtract<='1';
									next_state<=correzione;
									 --predispone la sottrazione
					  else next_state<=add;
					  end if;
		--esegue la somma e predispone lo shift  
		 WHEN add =>  count_in<='0';
					  reset_out<='0'; 
		              sel<=q0;
					  subtract<='0';
					  load_add<='0'; --carico il valore nello shift
					  en_SR<='1'; 
					  en_shift<='1';
					  load<='0'; 
					  en_D<='0';
					  en_R8<='1';
					  stop_cu<='0';
					  stop<='0';
					  en_fshift<='0';
					  next_state<=shift;
		--esegue lo shift e predispone per acquisizione	  
		WHEN shift => load<='0';
					  load_add<='0';
					  en_SR<='1'; --sr abilitato senza caricare x
					  reset_out<='0'; 
		              sel<=q0;
					  en_shift<='0';
					  count_in<='0';
					  subtract<='0';
					  en_D<='0';
					  en_R8<='1';
					  stop_cu<='0';
					  en_fshift<='0';
					  stop<='0';
					  next_state<=acquisizione;
	
	
	
	--in correzione fa la sottrazione e predispone per l'ultimo shift
		WHEN correzione => 	en_SR<='1';
							subtract<='0';
							load<='0'; 
							reset_out<='0'; 
							load_add<='0';
							en_D<='0'; --a(7)=a(7)
							en_R8<='1';
							count_in<='0';
							en_shift<='0';
							en_fshift<='1';
							sel<=q0;
							stop<='1';
							stop_cu<='0';
							next_state<=f_shift;
		
		WHEN f_shift => subtract<='0';
		                en_SR<='0';
						load<='0'; 
						reset_out<='0'; 
						load_add<='0';
						
						en_D<='0';
						en_R8<='1';
						en_shift<='0';
						en_fshift<='0';
						count_in<='0';
						sel<=q0;
						stop<='0';
						stop_cu<='1';
						next_state<=idle;
		  end CASE;
		  end process; 
		  end structural;