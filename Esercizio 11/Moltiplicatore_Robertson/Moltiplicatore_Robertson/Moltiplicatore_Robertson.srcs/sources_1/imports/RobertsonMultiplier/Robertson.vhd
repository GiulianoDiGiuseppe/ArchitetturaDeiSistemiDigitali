library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Robertson is
	 port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   stop: out std_logic;		   
		   P: out std_logic_vector(15 downto 0);
			stop_cu: out std_logic);
end Robertson;

architecture structural of Robertson is
	component unita_controllo is 
		port( q0, clock, reset, start: in std_logic;
			count: in std_logic_vector(2 downto 0);
		  en_SR, en_R8, en_D, count_in, load_add, en_shift: out std_logic;
		  sel, reset_out, subtract, load, stop, en_fshift, stop_cu: out std_logic);
	end component;
	
	component unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);
		  clock, reset, load, sub, sel: in std_logic;
		  en_SR, en_R8, en_D, count_in, load_add, shift, f_shift: in std_logic;
		  count: out std_logic_vector(2 downto 0);
		  P: out std_logic_vector(15 downto 0));
	end component;
	
	
	signal tempq0, temp_sel, temp_clock, temp_res, temp_sub,temp_load: std_logic;
	signal temp_count: std_logic_vector(2 downto 0);
	signal temp_p: std_logic_vector(15 downto 0);
	signal ab_sr, ab_r8, ab_d, ab_c, t_load_add: std_logic;
	signal fine_conteggio: std_logic;
	signal temp_shift, temp_fshift: std_logic;
	
	begin
	
	UC: unita_controllo port map(tempq0, clock, reset, start, temp_count, ab_sr, ab_r8, ab_d, ab_c, t_load_add, temp_shift, temp_sel, temp_res, temp_sub, temp_load, stop, temp_fshift, stop_cu);
	UO: unita_operativa port map(X, Y, clock, temp_res, temp_load, temp_sub, temp_sel, ab_sr, ab_r8, ab_d,ab_c,t_load_add, temp_shift, temp_fshift, temp_count, temp_p); 
	tempq0<=temp_p(0);
	P<=temp_p;
	end structural;