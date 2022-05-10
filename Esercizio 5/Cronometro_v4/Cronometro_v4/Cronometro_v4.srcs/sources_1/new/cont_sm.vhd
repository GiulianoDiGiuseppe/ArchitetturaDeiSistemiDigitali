----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Contatore_secondi_minuti
-- Module Name: Contatore_secondi_minuti - RTL
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cont_sm is

    Port( CLK: in  std_logic;
          RST: in  std_logic;
          SET: in std_logic;
          ore_en: in std_logic;
          INIT: in  std_logic_vector(5 downto 0);
          Y1: out std_logic_vector(3 downto 0) := "0000";
          Y2: out std_logic_vector(3 downto 0) := "0000";
          EN: out std_logic 
    );

end cont_sm;

architecture rtl of cont_sm is

    signal TY1, TY2: std_logic_vector(3 downto 0) := "0000";
    signal count: integer;
    signal temp: integer;

begin

    -- Contatore modulo 60
    count_sec_min: process( CLK, RST, SET )
    begin
        if( RST = '1' ) then
            count <= 0;
            EN <= '0';
        elsif( SET = '1' and ore_en = '1' ) then
            temp <= to_integer(unsigned(INIT));
            if (temp >= 60) then
                count <= 0;
            else
                count <= temp;
            end if;
            EN <= '0';
        elsif( CLK'event and CLK = '1' ) then
            if( ore_en ='1') then
                count <= count;
            elsif( count = 59 ) then
                count <= 0;
                EN <= '1';
            else
                count <= count + 1;
                EN <= '0';
            end if;
        end if;
    end process;
    
    -- Uscita del contatore
    -- si suddividono due uscite, una per la cifra 1(TY1) e cifra 2 (TY2) opportunamente con
    -- la divisione di 10 e il modulo di 10 in maniera da mostrare l'orario in formato decimale
    TY1 <= std_logic_vector(to_unsigned(count/10, 4)); 
    TY2 <= std_logic_vector(to_unsigned(count mod 10, 4)); 
    Y1 <= TY1;
    Y2 <= TY2;

end rtl;
