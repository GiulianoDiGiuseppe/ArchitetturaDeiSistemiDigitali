----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: cont_A_B
-- Module Name: cont_A_B - Behavorial
-- Project Name: Handshaking_A_B
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cont_A_B is
      generic(
            N: integer := 8
      );
       port( 
            CLK : in std_logic;
            RST : in std_logic; 
            cont : out std_logic_vector(2 downto 0) := "000";
            ---dall'unita' di controllo
            cont_in : in std_logic;
            cont_end : out std_logic := '0'
       );
end cont_A_B;
   
architecture rtl of cont_A_B is


signal TY: std_logic_vector(2 downto 0);


begin
       -- Contatore modulo 8
       count: process(CLK,RST)
       begin
           
           if(RST = '1') then
               TY <= "000";
           elsif(rising_edge(CLK)) then
               if (cont_in = '1') then
                   if( TY = "111" ) then
                       TY <= "000";
                       cont_end <= '1';
                   else
                       TY <= TY + "001";
                   end if;
               end if;
           end if;
       end process;
       
       -- Conteggio in uscita
       cont <= TY;
       
end rtl;
