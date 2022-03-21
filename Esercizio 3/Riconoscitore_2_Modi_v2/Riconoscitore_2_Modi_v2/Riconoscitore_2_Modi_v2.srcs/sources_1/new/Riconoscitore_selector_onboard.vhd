----------------------------------------------------------------------------------
-- Company: Universit� Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.10.2021
-- Design Name: Riconoscitore sequenza 1001 con due modi
-- Module Name: Riconoscitore_selector_onboard - Structural
-- Project Name: Riconoscitore_2_Modi_onboard
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


entity Riconoscitore_selector_onboard is

    Port(
        clock_in : in  STD_LOGIC; --clock della board
        reset_in : in  STD_LOGIC; --bottone che abilita il cambio di modalità del riconoscitore
        I_strobe_in : in STD_LOGIC; --bottone che abilita la lettura dell'input I dallo switch
        Input : in STD_LOGIC;  --input della sequenza di bit (SWITCH)
        Mode : in STD_LOGIC; --modalità del riconoscitore (SWITCH)
        Output : out STD_LOGIC --output del riconoscitore
    );

end Riconoscitore_selector_onboard;

architecture Structural of Riconoscitore_selector_onboard is

component ButtonDebouncer 
    Generic (                       
        CLK_period: integer := 10;  -- periodo del clock della board in nanosecondi
        btn_noise_time: integer := 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                             --assumo che duri 500ms=500000microsec=500000000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC
    );
end component;

component Riconoscitore_Mealy_2_Modi is
    Port ( i: in std_logic;
           RST, CLK: in std_logic;
           READ_I: in std_logic;
           M: in std_logic;
           Y: out std_logic
    );
end component;

signal reset_n, read_strobeI : std_logic;

begin

reset_n <= not reset_in;  --visto che utilizzo il bottone CPU_reset della board, che è attivo-basso,
                          --devo convertire il segnale di reset

debouncerI: ButtonDebouncer 
    Generic map ( 
        CLK_period => 10, -- periodo del clock della board pari a 10ns
        btn_noise_time => 500000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 500ms=500000microsec=500000000ns
    )
    Port map ( RST => reset_n,
               CLK => clock_in, 
               BTN => I_strobe_in,
               CLEARED_BTN => read_strobeI
    );

riconoscitore: Riconoscitore_Mealy_2_Modi
    PORT MAP ( i => Input,
               RST => reset_n,
               CLK => clock_in,
               READ_I => read_strobeI,
               M => Mode,
               Y => Output
	);

end Structural;
