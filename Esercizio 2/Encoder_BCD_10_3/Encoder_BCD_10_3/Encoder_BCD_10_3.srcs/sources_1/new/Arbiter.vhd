----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: Arbiter - Dataflow
-- Module Name: Arbiter - Dataflow
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

entity Arbiter is
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        Y : out STD_LOGIC_VECTOR(9 downto 0)
       );
end Arbiter;

architecture Dataflow of Arbiter is

begin
    Y <= "1000000000" when X(9) = '1' else 
         "0100000000" when X(8) = '1' else
         "0010000000" when X(7) = '1' else
         "0001000000" when X(6) = '1' else
         "0000100000" when X(5) = '1' else
         "0000010000" when X(4) = '1' else
         "0000001000" when X(3) = '1' else
         "0000000100" when X(2) = '1' else
         "0000000010" when X(1) = '1' else
         "0000000001" when X(0) = '1' else
         "----------";


end Dataflow;
