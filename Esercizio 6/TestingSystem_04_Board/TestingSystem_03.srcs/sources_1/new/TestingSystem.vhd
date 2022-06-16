----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 11:29:30
-- Design Name: 
-- Module Name: TestingSystem - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestingSystem is
  Port ( 
        clock_in : STD_LOGIC; 
        reset_in : in  STD_LOGIC;
        addr_strobe_in : in  STD_LOGIC; --bottone che abilita la selezione della cella della ROM da visualizzare
       -- address_in : in STD_LOGIC_VECTOR(2 downto 0);  --indirizzo di selezione inserito tramite switch
        output : out STD_LOGIC_VECTOR(2 downto 0)
        );
end TestingSystem;

architecture Behavioral of TestingSystem is


component ButtonDebouncer is
    generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end component;


component ROM is
  Port ( 
        CLK : in std_logic; -- clock della board
        RST : in std_logic;
        READ : in std_logic; -- segnale che abilita la lettura, inserito tramite un bottone 
        ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switc
        DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit letto dalla ROM
        );
end component;

component Combinatorial is
  Port ( 
        input : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(2 downto 0)
        );
end component;

component ROM_3 is
  Port ( 
        CLK : in std_logic; -- clock della board
        RST : in std_logic;
        READ : in std_logic; -- segnale che abilita la lettura, inserito tramite un bottone 
        ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switch
        --WRITE : in std_logic;
        --ADDR_WRITE : in std_logic_vector(2 downto 0);
        DATA_IN : in std_logic_vector(2 downto 0) ; --dato in ingresso da memorizzare
        DATA_OUT : out std_logic_vector(2 downto 0) 
        );
end component;

component counter_mod8 is
  Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR (2 downto 0)
           );
end component;



signal reset_n : std_logic;
signal read_strobe : std_logic;
signal reset_strobe : std_logic;
signal data_temp_1 : std_logic_vector(3 downto 0);
signal data_temp_2 : std_logic_vector(2 downto 0);
signal data_temp_out : std_logic_vector(2 downto 0);
signal addr : std_logic_vector(2 downto 0);

begin

    reset_n <= reset_in;  --visto che utilizzo il bottone CPU_reset della board, che è attivo-basso,
                          --devo convertire il segnale di reset
                          
    
    b_deb_reset : ButtonDebouncer 
    generic map( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                 --assumo che duri 500ms=500000microsec=500000000ns
)
    port map (
        rst => '0',
        clk => clock_in, 
        btn => reset_n, 
        cleared_btn => reset_strobe
        );
        
        
    b_deb_read : ButtonDebouncer 
    generic map( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                 --assumo che duri 500ms=500000microsec=500000000ns
)
    port map (
        rst => reset_strobe,
        clk => clock_in, 
        btn => addr_strobe_in, 
        cleared_btn => read_strobe
        );
    
                          
                              
    mem_1 : ROM
    port map (
        clk => clock_in,
        rst => reset_strobe,
        read => read_strobe, 
        addr => addr, 
        data => data_temp_1
        );
        
    mac_comb : Combinatorial
    port map (
        input => data_temp_1,
        output => data_temp_2
        );
        
    mem_2 : ROM_3
    port map (
        clk => clock_in,
        rst => reset_strobe,
        read => read_strobe,
        addr => addr, 
        data_in => data_temp_2,
        data_out => output
        );  
        
    counter : counter_mod8
    port map (
        clock => clock_in, 
        reset => reset_strobe,
        enable => read_strobe,
        counter => addr
         );

end Behavioral;
