----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2021 10:04:57
-- Design Name: 
-- Module Name: ButtonDebouncer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ButtonDebouncer is
    generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end ButtonDebouncer;

architecture Behavioral of ButtonDebouncer is

-- questo componente prende in input il segnale proveniente dal bottone e genera un 
-- segnale "ripulito" che presenta un impulso della durata di un colpo di clock per 
-- segnalare l'avvenuta pressione del bottone.
-- ATTENZIONE: per questo progetto non sarebbe necessario, in quanto il bottone viene
-- usato solo per dare un enable all'indirizzo di selezione della ROM (eventuali oscillazioni
-- che risultino in più pressioni successive non modificherebbero la logica del sistema)
-- Il debouncer implementa un semplice automa di 2 stati
-- si parte da NOT_PRESSED e, appena si rileva BTN=1, si va in PRESSED dove 
-- si aspettano 6.5 millisecondi in modo da "superare" l'oscillazione

type stato is (NOT_PRESSED, PRESSED);
signal BTN_state : stato := NOT_PRESSED;

constant max_count : integer := btn_noise_time/CLK_period; -- 6500000/10= conto 650000 colpi di clock 

begin

deb: process (CLK)
variable count: integer := 0;

begin
   if rising_edge(CLK) then
	   
	   if( RST = '1') then
	       BTN_state <= NOT_PRESSED;
	       CLEARED_BTN <= '0';
	   else
	   	  case BTN_state is
			when NOT_PRESSED =>
			    CLEARED_BTN<= '0';
				if( BTN = '1' ) then
					BTN_state <= PRESSED;
				else 
					BTN_state <= NOT_PRESSED;
				end if;
            when PRESSED =>
               if(count = max_count -1) then
                       count:=0;
                       CLEARED_BTN <= '1';
                       BTN_state <= NOT_PRESSED;
                   else 
                       count:= count+1;
                       BTN_state <= PRESSED;
                   end if;
            when others => 
                BTN_state <= NOT_PRESSED;
		  end case;
    end if;  
  end if;  
end process;


end Behavioral;
