----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: rete_16_4_TB - Behavorial
-- Module Name: rete_16_4_TB - Behavorial
-- Project Name: rete_16_4_TB
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

entity rete_16_4_TB is
--  Port ( );
end rete_16_4_TB;

architecture Behavorial of rete_16_4_TB is

component rete_16_4 is

    Port ( 
        INPUTR : in STD_LOGIC_VECTOR(0 to 15);
        SM : in STD_LOGIC_VECTOR(3 downto 0);
        SDEM : in STD_LOGIC_VECTOR(1 downto 0);
        OUTPUTR : out STD_LOGIC_VECTOR(0 to 3)
    );

end component;

signal inputs: STD_LOGIC_VECTOR(0 to 15);
signal selections1: STD_LOGIC_VECTOR(3 downto 0);
signal selections2: STD_LOGIC_VECTOR(1 downto 0);
signal outputs: STD_LOGIC_VECTOR(0 to 3);

begin

--Unit Under Test
uut: rete_16_4
    Port map ( 
        INPUTR => inputs,
        SM => selections1,
        SDEM => selections2,
        OUTPUTR => outputs
    );

stim_proc: process

begin

    --selezione INPUT9
    wait for 10 ns;
    inputs <= "0000000001000000";
    selections1 <= "1001";
    selections2 <= "10";
    wait for 10 ns;
    assert outputs <= "0010"
    report "Errore sulla Linea 9"
    severity failure;
    
    --selezione INPUT9
    wait for 10 ns;
    selections2 <= "00";
    wait for 10 ns;
    assert outputs <= "1000"
    report "Errore sulla Linea 9"
    severity failure;
    
    --selezione INPUT15
    wait for 10 ns;
    inputs <= "0000000000000001";
    selections1 <= "1111";
    selections2 <= "01";
    wait for 10 ns;
    assert outputs <= "0100"
    report "Errore sulla Linea 15"
    severity failure;
    
    wait;
end process;
end Behavorial;
