----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: rete_16_4 - Structural
-- Module Name: rete_16_4 - Structural
-- Project Name: rete_16_4
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

entity rete_16_4 is

    Port ( 
        INPUTR : in STD_LOGIC_VECTOR(0 to 15) := "1111111111111111";
        SM : in STD_LOGIC_VECTOR(3 downto 0);
        SDEM : in STD_LOGIC_VECTOR(1 downto 0);
        OUTPUTR : out STD_LOGIC_VECTOR(0 to 3)
    );
  
end rete_16_4;

architecture Structural of rete_16_4 is

component multiplexer_16_1 is

    Port ( 
        INPUT: in STD_LOGIC_VECTOR(0 to 15);
        SEL: in STD_LOGIC_VECTOR(3 downto 0);
        OUTPUT: out STD_LOGIC
    );

end component;

component demultiplexer_1_4 is

    Port ( 
        K : in STD_LOGIC;
        SD : in STD_LOGIC_VECTOR (1 downto 0);
        DO : out STD_LOGIC_VECTOR (0 to 3)
    );

end component;

signal A : STD_LOGIC;

begin

mux: multiplexer_16_1
    Port map (
        INPUT(0 to 15) => INPUTR(0 to 15), -- "0000000001000000"
        SEL(3 downto 0) => SM(3 downto 0),
        OUTPUT => A
    );
    
demux: demultiplexer_1_4
    Port map(
        K => A,
        SD(1 downto 0) => SDEM(1 downto 0),
        DO(0 to 3) => OUTPUTR(0 to 3)
    );

end Structural;
