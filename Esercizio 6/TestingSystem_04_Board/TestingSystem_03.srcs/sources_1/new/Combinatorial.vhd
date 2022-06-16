----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 11:23:56
-- Design Name: 
-- Module Name: Combinatorial - Behavioral
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

entity Combinatorial is
  Port ( 
        input : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(2 downto 0)
        );
end Combinatorial;

architecture Behavioral of Combinatorial is

begin

output <=    "000" when input = "0000" else
                     "001" when input = "0001" else
                     "001" when input = "0010" else
                     "010" when input = "0011" else
                     "001" when input = "0100" else
                     "010" when input = "0101" else
                     "010" when input = "0110" else
                     "011" when input = "0111" else
                     "001" when input ="1000" else
                     "010" when input ="1001" else
                     "010" when input ="1010" else
                     "011" when input ="1011" else
                     "010" when input ="1100" else
                     "011" when input ="1101" else
                     "011" when input ="1110" else
                     "100" when input ="1111" else
                     "---" when input ="----";

end Behavioral;
