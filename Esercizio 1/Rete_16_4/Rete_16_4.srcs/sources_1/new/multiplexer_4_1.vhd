----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: multiplexer_4_1 - Behavioral
-- Module Name: multiplexer_4_1 - Behavioral
-- Project Name: multiplexer_4_1
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

entity multiplexer_4_1 is

    Port ( 
        I: in STD_LOGIC_VECTOR (0 to 3);
        S: in STD_LOGIC_VECTOR (1 downto 0);
        O: out STD_LOGIC
    );
  
end multiplexer_4_1;

architecture Structural of multiplexer_4_1 is

component multiplexer_2_1 is

    Port (
        I0 : in STD_LOGIC;
        I1 : in STD_LOGIC;
        S0 : in STD_LOGIC;
        Y : out STD_LOGIC
    );

end component;

signal A : STD_LOGIC_VECTOR (0 to 1); 

begin

mux0_1: FOR j in 0 to 1 GENERATE m: multiplexer_2_1

    Port map(
        I0 => I(j*2),
        I1 => I(j*2 +1),
        S0 => S(0),
        Y => A(j)
    );

end GENERATE;

mux2: multiplexer_2_1
    
    Port map(
        I0 => A(0),
        I1 => A(1),
        S0 => S(1),
        Y => O
    );

end Structural;
