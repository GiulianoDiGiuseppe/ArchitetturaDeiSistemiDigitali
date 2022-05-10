----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Cronometro_On_Board
-- Module Name: Cronometro_On_Board - Structural
-- Project Name: Cronometro_v4
-- Target Devices: Nexys A7 100T
-- Tool Versions: Vivado 2019.1
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro_on_board is
	Port(
		  clock_in : in  STD_LOGIC;
		  reset_in : in  STD_LOGIC;
		  --bottoni
		  sel : in STD_LOGIC; --bottone per selezionare gli intertempi
		  stop : in STD_LOGIC; --bottone per salvare gli intertempi
		  set_h, set_m, set_s : in STD_LOGIC; --bottoni per settare l'orario iniziale
		  --switches
		  switch_in : in STD_LOGIC_VECTOR(5 downto 0);  --switch per inizializzamento orologio
		  init_en : in STD_LOGIC_VECTOR(0 downto 0); --switch per selezionare la modalità  del cronometro
		  ore_en : in STD_LOGIC; --switch per selezionare la modalità cambio orario
		  --visore
		  anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		  cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end cronometro_on_board;

architecture Structural of cronometro_on_board is

COMPONENT ButtonDebouncer 
    GENERIC (                       
        CLK_period: integer := 10;  -- periodo del clock della board in nanosecondi
        btn_noise_time: integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                           --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    PORT ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
END COMPONENT;

COMPONENT intertempi is
    GENERIC (
        n_register : positive := 2 -- Numero di locazioni di memoria (registri) desiderate
    );
    PORT (
        stop : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        sel : in std_logic; -- Shift sulla posizione di memoria da visualizzare
        current_time : in std_logic_vector(31 downto 0);
        intertime : out std_logic_vector(31 downto 0)
    );
END COMPONENT;
	
COMPONENT mux is
    GENERIC (
        n	: positive := 1	-- Bit di ingresso al MUX per la selezione
    );
    PORT (
        x	: in std_logic_vector(32*(2**n) downto 1); -- Abbiamo 32*2^n ingressi
        sel	: in std_logic_vector(n-1 downto 0);
        y	: out std_logic_vector(31 downto 0)
    );
END COMPONENT;

COMPONENT cronometro
PORT (
       CLOCK: in std_logic;
       RESET: in std_logic;
       SET_S, SET_M : in std_logic;
       SET_H: in std_logic;
       ore_en: in std_logic;
       INIT_S, INIT_M: in std_logic_vector(5 downto 0);
       INIT_O: in std_logic_vector(4 downto 0);
       CIFRA1_SECONDI, CIFRA2_SECONDI: out std_logic_vector(3 downto 0); 
       CIFRA1_MINUTI, CIFRA2_MINUTI: out std_logic_vector(3 downto 0); 
       CIFRA1_ORE, CIFRA2_ORE: out std_logic_vector(3 downto 0)
);
END COMPONENT;

COMPONENT clock_filter
    generic(
        CLKIN_freq : integer := 100000000; --clock board 100MHz
        CLKOUT_freq : integer := 500       --frequenza desiderata 500Hz
    );
    Port ( 
        clock_in : in  STD_LOGIC;
        reset : in STD_LOGIC;
        clock_out : out  STD_LOGIC -- attenzione: non è un vero clock ma un impulso che sarà usato come enable
    ); 
END COMPONENT;
   
COMPONENT display_seven_segments
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		VALUE : IN std_logic_vector(31 downto 0);--valori da mostrare sul display
		ENABLE : IN std_logic_vector(7 downto 0);--abilitazione di ciascuna cifra (accensione)
		DOTS : IN std_logic_vector(7 downto 0); --abilitazione punti (accensione)      
		ANODES : OUT std_logic_vector(7 downto 0);
		CATHODES : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

-- i segnali che posso prelevare (reset, read_strobe(lettura dal bottone), value_temp (valore da leggere)
signal reset_n : std_logic;
signal read_strobe_sel, read_strobe_stop, read_strobe_set_h, read_strobe_set_m, read_strobe_set_s : std_logic;
signal clock_crono : std_logic;
signal value_temp : std_logic_vector(31 downto 0) := (others => '0');
signal inter_temp : std_logic_vector(31 downto 0) := (others => '0');
signal output : std_logic_vector(31 downto 0) := (others => '0');
signal x_in : std_logic_vector(63 downto 0) := (others => '0');

begin
--IN CASO DI SCELTA DEL BUTTON CPU_RESET E' NECESSARIO QUESTA OPERAZIONE
reset_n <= not reset_in;  --visto che utilizzo il bottone CPU_reset della board, che è attivo-basso,
                          --devo invertire il segnale di reset

-- MAPPATURA DEI SEGNALI
-- SEL è per la visualizzazione degli intertempi
debouncer_sel: ButtonDebouncer GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 6.5ms=6500microsec=6500000ns
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => sel,
           CLEARED_BTN => read_strobe_sel
);

-- STOP per salvare gli intertempi
debouncer_stop: ButtonDebouncer GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 6.5ms=6500microsec=6500000ns
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => stop,
           CLEARED_BTN => read_strobe_stop
);

debouncer_set_h: ButtonDebouncer 
GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 6.5ms=6500microsec=6500000ns
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => set_h,
           CLEARED_BTN => read_strobe_set_h
);

debouncer_set_m: ButtonDebouncer 
GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 6.5ms=6500microsec=6500000ns
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => set_m,
           CLEARED_BTN => read_strobe_set_m
);

debouncer_set_s: ButtonDebouncer 
GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 6.5ms=6500microsec=6500000ns
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => set_s,
           CLEARED_BTN => read_strobe_set_s
);

div_freq: clock_filter
GENERIC MAP(
            CLKIN_freq => 100000000, --clock board 100MHz
            CLKOUT_freq  => 1        --frequenza desiderata 1Hz
         )
PORT MAP( 
           clock_in => clock_in,
           reset => reset_n,
           clock_out => clock_crono 
); 

crono: cronometro
PORT MAP (   
           CLOCK => clock_crono,
           RESET => reset_n,
           SET_S => read_strobe_set_s,
           SET_M => read_strobe_set_m,
           SET_H => read_strobe_set_h,
           ore_en => ore_en,
           INIT_S => switch_in(5 downto 0), 
           INIT_M => switch_in(5 downto 0), 
           INIT_O => switch_in(4 downto 0), 
           CIFRA1_SECONDI => value_temp(7 downto 4),
           CIFRA2_SECONDI => value_temp(3 downto 0), 
           CIFRA1_MINUTI => value_temp(15 downto 12),
           CIFRA2_MINUTI => value_temp(11 downto 8), 
           CIFRA1_ORE => value_temp(23 downto 20),
           CIFRA2_ORE => value_temp(19 downto 16)
);
 
it : intertempi
PORT MAP(
        stop => read_strobe_stop,
        reset => reset_n,
        clk => clock_in,
        sel => read_strobe_sel,
        current_time => value_temp,
        intertime => inter_temp
);

x_in <= value_temp & inter_temp; --in ingresso al mux va sia il valore del conteggio
                                 --che quello degli intertempi e sulla base della selezione
                                 -- viene visualizzato il valore corrispondente
mux21 : mux
PORT MAP(
        x => x_in,
        sel => init_en,
        y => output
);   

seven_segment_array: display_seven_segments
PORT MAP(
    CLK => clock_in,
    RST => reset_n,
    value => output,
    enable => "00111111", --accendo solo le prime 6 cifre a partire da destra 
    dots => "00010100",  --accendo i punti per separare le ore dai minuti e i minuti dai secondi
    anodes => anodes_out,
    cathodes => cathodes_out
);

end Structural;
