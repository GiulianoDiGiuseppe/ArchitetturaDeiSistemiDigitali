----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: D_Latch
-- Module Name: D_Latch - Behavioral
-- Project Name: Divisore_NonRestoring
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


Library IEEE;
USE IEEE.Std_logic_1164.all;

entity D_Latch is 
   port(
      Q : out std_logic_vector(7 downto 0);    
      ENABLE :in std_logic;  
      RESET : in std_logic;  
      D : in  std_logic_vector(7 downto 0)    
   );
end D_Latch;

architecture Behavioral of D_Latch is 

begin
  
    process(ENABLE, RESET)
    begin 
    
        if(RESET='1') then
            Q <= ( others => '0');
        elsif(ENABLE = '1') then
            Q <= D; 
        end if; 
       
end process; 

end Behavioral; 
