----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: Display - Behavorial
-- Module Name: Display - Behavorial
-- Project Name: Encoder_BCD
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

entity display is
  Port (
    number: in STD_LOGIC_VECTOR(3 downto 0);
    anodi: out STD_LOGIC_VECTOR(7 downto 0);
    catodi: out STD_LOGIC_VECTOR(7 downto 0) 
    );
end display;

architecture Behavioral of display is

begin

    process (number)
    
    begin 
    
        case number  is
            when "0000" => 
            catodi <= "11000000"; --0
            anodi <= "11111110";
            when "0001" =>
            catodi <= "11111001"; --1
            anodi <= "11111110";
            when "0010" =>
            catodi <= "10100100"; --2
            anodi <= "11111110";
            when "0011" =>
            catodi <= "10110000"; --3
            anodi <= "11111110";
            when "0100" =>
            catodi <= "10011001"; --4
            anodi <= "11111110";
            when "0101" =>
            catodi <= "10010010"; --5
            anodi <= "11111110";
            when "0110" =>
            catodi <= "10000010"; --6
            anodi <= "11111110";
            when "0111" =>
            catodi <= "11111000"; --7
            anodi <= "11111110";
            when "1000" =>
            catodi <= "10000000"; --8
            anodi <= "11111110";
            when "1001" =>
            catodi <= "10010000"; --9
            anodi <= "11111110";
            when "1010" =>
            catodi <= "10100000"; --a
            anodi <= "11111110";
            when "1011" =>
            catodi <= "10000011"; --b
            anodi <= "11111110";
            when "1100" => 
            catodi <= "11000110"; --c
            anodi <= "11111110";
            when "1101" =>
            catodi <= "10100001"; --d
            anodi <= "11111110";
            when "1110" => 
            catodi <= "10000110"; --e
            anodi <= "11111110";
            when "1111" => 
            catodi <= "10001110"; --f
            anodi <= "11111110";
            when others =>
            catodi <= "11000000"; --x
            anodi <= "11111101";
       end case;
    
    end process;


end Behavioral;
