----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: multiplexer_16_1 - Structural
-- Module Name: multiplexer_16_1 - Structural
-- Project Name: multiplexer_16_1
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

entity multiplexer_16_1 is

    Port ( 
        INPUT: in STD_LOGIC_VECTOR(0 to 15);
        SEL: in STD_LOGIC_VECTOR(3 downto 0);
        OUTPUT: out STD_LOGIC
    );
  
end multiplexer_16_1;

architecture Structural of multiplexer_16_1 is

component multiplexer_4_1 is

    Port ( 
        I: in STD_LOGIC_VECTOR (0 to 3);
        S: in STD_LOGIC_VECTOR (1 downto 0);
        O: out STD_LOGIC
    );

end component;

signal A : STD_LOGIC_VECTOR (0 to 3);

begin

mux0_3: FOR j IN 0 to 3 GENERATE m: multiplexer_4_1

    Port map ( 
        I(0 to 3) => INPUT(j*4 to j*4+3),
        S(1 downto 0) => SEL(1 downto 0),
        O => A(j)
    );

end GENERATE;

mux4: multiplexer_4_1
    Port map (
        I(0 to 3) => A(0 to 3),
        S(1 downto 0) => SEL(3 downto 2),
        O => OUTPUT
    );

end Structural;
