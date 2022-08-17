library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);
		  clock, reset, load, sub, sel: in std_logic;
		  en_SR, en_R8, en_D, count_in, load_add, shift, f_shift: in std_logic;
		  count: out std_logic_vector(2 downto 0);
		  P: out std_logic_vector(15 downto 0));
end unita_operativa;

architecture structural of unita_operativa is

	component adder_sub is
	port( X, Y: in std_logic_vector(7 downto 0);
		  cin: in std_logic;
		  Z: out std_logic_vector(7 downto 0);
		  cout: out std_logic);		  
	end component;
	
	component registro8 is 
	port( A: in std_logic_vector(7 downto 0);
		  clk, res,en: in std_logic;
		  B: out std_logic_vector(7 downto 0));
	end component;
	
	
	component mux_21 is
	port( x0, x1: in std_logic_vector(7 downto 0); --x1 è moltiplicatore e x0 è la stringa di 0
		  s: in std_logic;
		  y: out std_logic_vector(7 downto 0));
	end component;
	
	
	component shif_register is
	port( X: in std_logic_vector(15 downto 0);
		  F: in std_logic;
		  clock, reset, load, en, load_add, shift, f_shift:in std_logic;
		  x_add: in std_logic_vector(7 downto 0);
		  Y: out std_logic_vector(15 downto 0));	  
	end component;
	
	component FFD is
	port( clock, reset, d, en: in std_logic;
          y: out std_logic);
	end component;
	
	component cont_mod8 is
	port( clock, reset: in std_logic;
		  count_in: in std_logic;
		  count_end: out std_logic;
		  count: out std_logic_vector(2 downto 0));
	end component;


	signal temp1: std_logic_vector(7 downto 0); --segnale temporaneao tra reg8 M e mux 21
	signal op1: std_logic_vector(7 downto 0); --segnale temporaneo di uscita dal multiplexer tra mux e adder
	signal temp2: std_logic_vector(15 downto 0); --segnale temporaneo per definire input all'SR 
	signal temp_p: std_logic_vector(15 downto 0); --segnale temporaneo uscita dell'SR
	signal temp_d: std_logic :='0';
	signal temp_F: std_logic;
	signal tempadd: std_logic_vector(7 downto 0); --uscita del parallel adder 
	signal riporto: std_logic; -- riporto in uscita dell'adder che non utilizziamo
	signal temp_countend: std_logic;
begin
	
	M: registro8 port map(Y, clock, reset, en_R8,temp1);
	MUX: mux_21 port map("00000000", temp1, sel, op1);
	
    temp2<="00000000" & X;
    
	SR: shif_register port map(temp2, temp_F, clock, reset, load, en_SR, load_add, shift, f_shift, tempadd, temp_p);
	
	-- and tra Y(7) e Xi e una or con F
	temp_d<=(temp1(7) and temp_p(0)) or temp_F;
	
	D: FFD port map(clock, reset, temp_d, en_D, temp_F);
	ADD_SUB: adder_sub port map(temp_p(15 downto 8), op1, sub, tempadd, riporto);
	CONT: cont_mod8 port map(clock, reset, count_in, temp_countend, count);
	P<=temp_p;
	
	

end structural;
