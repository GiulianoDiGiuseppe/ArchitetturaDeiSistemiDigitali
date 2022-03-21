----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.10.2021
-- Design Name: Riconoscitore sequenza 1001 con due modi
-- Module Name: Riconoscitore_Mealy_2_Modi - Behavioral
-- Project Name: Riconoscitore_2_Modi
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- entitÃ 
entity Riconoscitore_Mealy_2_Modi is

    Port( i: in std_logic;
		  RST, CLK: in std_logic;
		  M: in std_logic;
		  Y: out std_logic
	);

end Riconoscitore_Mealy_2_Modi;

-- architettura
architecture Behavioral of Riconoscitore_Mealy_2_Modi is

-- enumerazione stati
type stato is (SM, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);

-- stato iniziale SM
signal stato_corrente : stato := SM;
signal stato_prossimo : stato;

begin

stato_uscita: process(stato_corrente, i)
begin
    
    -- se M = 0 : Riconoscitore di Sequenza con valutazione di sequenza per gruppi di 4 bit
    -- se M = 1 : Riconoscitore di Sequenza con valutazione di sequenza ad ogni singolo bit
    case stato_corrente is
        when S0 =>
            if( i = '0' ) then
               stato_prossimo <= S1;
               Y <= '0';
            else 
               stato_prossimo <= S4;
               Y <= '0';
            end if;
        
        when S1 =>
            if( i = '0' or i = '1' ) then
               stato_prossimo <= S2;
               Y <= '0';
            end if;
        
        when S2 =>
            if( i = '0' or i = '1' ) then
               stato_prossimo <= S3;
               Y <= '0';
            end if;
        
        when S3 =>
            if( i = '0' or i = '1' ) then
               stato_prossimo <= S0;
               Y <= '0';
            end if;
        
        when S4 =>
            if( i = '0' ) then
               stato_prossimo <= S5;
               Y <= '0';
            else 
               stato_prossimo <= S2;
               Y <= '0';
            end if;
        
        when S5 =>
            if( i = '0' ) then
               stato_prossimo <= S6;
               Y <= '0';
            else 
               stato_prossimo <= S3;
               Y <= '0';
            end if;
        
        when S6 =>
            if( i = '0' ) then
               stato_prossimo <= S0;
               Y <= '0';
            else 
               stato_prossimo <= S0;
               Y <= '1';
            end if;     
        
        when S7 => 
            if( i = '0' ) then
               stato_prossimo <= S7;
               Y <= '0';
            else 
               stato_prossimo <= S8;
               Y <= '0';
            end if;
          
        when S8 =>
            if( i = '0' ) then
               stato_prossimo <= S9;
               Y <= '0';
            else 
               stato_prossimo <= S8;
               Y <= '0';
            end if;
        
        when S9 =>
            if( i = '0' ) then
               stato_prossimo <= S10;
               Y <= '0';
            else 
               stato_prossimo <= S8;
               Y <= '0';
            end if;
        
        when S10 =>
            if( i = '0' ) then
               stato_prossimo <= S7;
               Y <= '0';
            else 
               stato_prossimo <= S7;
               Y <= '1';
            end if;
        
        when others =>
            stato_prossimo <= S7;
            Y <= '0';
    end case;

end process;

-- Questo processo rappresenta gli elementi di memoria
mem: process (CLK)
begin

    if(CLK'event and CLK = '1') then
        if(RST = '1') then
           stato_corrente <= SM;
               if(M = '0') then
                   stato_corrente <= S0;
               else 
                   stato_corrente <= S7;
               end if;
        else
           stato_corrente <= stato_prossimo;
        end if;
    end if;

end process;
end Behavioral;
