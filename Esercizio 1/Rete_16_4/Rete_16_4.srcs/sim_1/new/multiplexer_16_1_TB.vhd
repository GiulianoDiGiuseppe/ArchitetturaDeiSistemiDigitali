----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: multiplexer_16_1_TB - Behavorial
-- Module Name: multiplexer_16_1_TB - Behavorial
-- Project Name: multiplexer_16_1_TB
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

entity multiplexer_16_1_TB is
--  Port ( );
end multiplexer_16_1_TB;

architecture Behavorial of multiplexer_16_1_TB is

component multiplexer_16_1 is

    Port ( 
        INPUT: in STD_LOGIC_VECTOR (0 to 15);
        SEL: in STD_LOGIC_VECTOR (3 downto 0);
        OUTPUT: out STD_LOGIC
    );

end component;

signal inputs : STD_LOGIC_VECTOR (0 to 15);
signal selections : STD_LOGIC_VECTOR (3 downto 0);
signal outputs : STD_LOGIC;

begin

--Unit Under Test
uut: multiplexer_16_1
    Port map (
    INPUT => inputs,
    SEL => selections,
    OUTPUT => outputs
    );
    
stim_proc: process

begin

    --selezione linea INPUT0
    wait for 10 ns;
    inputs <= "1000000000000000";
    selections <= "0000";
    wait for 10 ns;
    assert outputs <= '1'
    report "Errore sulla Linea 0"
    severity failure;
    
    --selezione linea INPUT6
    wait for 10 ns;
    inputs <= "0000001000000000";
    selections <= "0110";
    wait for 10 ns;
    assert outputs <= '1'
    report "Errore sulla Linea 6"
    severity failure;
    
    --selezione linea INPUT12
    wait for 10 ns;
    inputs <= "0000000000001000";
    selections <= "1100";
    wait for 10 ns;
    assert outputs <= '1'
    report "Errore sulla Linea 12"
    severity failure;
    
    --selezione linea INPUT3
    wait for 10 ns;
    inputs <= "0001000000000000";
    selections <= "0011";
    wait for 10 ns;
    assert outputs <= '1'
    report "Errore sulla Linea 3"
    severity failure;
    
    --selezione linea INPUT15
    wait for 10 ns;
    inputs <= "0000000000000001";
    selections <= "1111";
    wait for 10 ns;
    assert outputs <= '1'
    report "Errore sulla Linea 15"
    severity failure;

end process;
end Behavorial;