----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: multiplexer_2_1 - Behavioral
-- Module Name: multiplexer_2_1 - Behavioral
-- Project Name: multiplexer_2_1
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

entity multiplexer_2_1 is

    Port ( I0 : in STD_LOGIC;
           I1 : in STD_LOGIC;
           S0 : in STD_LOGIC;
           Y : out STD_LOGIC
        );

end multiplexer_2_1;

architecture rtl of multiplexer_2_1 is
begin

    Y <= I0 when S0 = '0' else
         I1 when S0 = '1' else
         '-';

end rtl;
