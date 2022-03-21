----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: demultiplexer_1_4 - Behavorial
-- Module Name: demultiplexer_1_4 - Behavorial
-- Project Name: demultiplexer_1_4 - Behavorial
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

entity demultiplexer_1_4 is

    Port (
    K : in STD_LOGIC;
    SD : in STD_LOGIC_VECTOR (1 downto 0);
    DO : out STD_LOGIC_VECTOR (0 to 3)
    );

end demultiplexer_1_4;

architecture Behavioral of demultiplexer_1_4 is
begin

process (SD,K)
begin 

   if SD="00" then
        DO <= K&"000";
   elsif SD="01" then
        DO <= '0'&K&"00";
   elsif SD="10" then
        DO <= "00"&K&'0';
   elsif SD="11" then
        DO <= "000"&K;    
   end if; 

end process;
end Behavioral;
