----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: Counter
-- Module Name: Counter - Behavioral
-- Project Name: Interfaccia_Seriale_handshaking
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

entity Counter is
 port( 
       CLK : in std_logic;
       RST : in std_logic; 
       cont_addr : out std_logic_vector(2 downto 0);
       ---dall'unita' di controllo
       cont_start : in std_logic
    );
end Counter;

architecture Behavioral of Counter is
    signal TY: std_logic_vector(2 downto 0);
begin
    -- Counts
       count: process(CLK,RST)
       begin
           if(RST = '1') then
               TY <= "000";
           elsif(rising_edge(CLK)) then
               if (cont_start = '1') then
                   if( TY = "111" ) then
                       TY <= "000";
                   else
                       TY <= TY + "001";
                   end if;
               end if;
           end if;
       end process;
       -- Assigns the output signal
       cont_addr <= TY;

end Behavioral;
