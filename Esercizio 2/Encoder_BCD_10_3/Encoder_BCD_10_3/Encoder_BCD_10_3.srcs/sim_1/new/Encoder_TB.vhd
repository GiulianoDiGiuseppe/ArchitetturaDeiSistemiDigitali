----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: Encoder_TB - Behavorial
-- Module Name: Encoder_TB - Behavorial
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

entity Encoder_TB is
--  Port ( );
end Encoder_TB;

architecture Behavioral of Encoder_TB is

    COMPONENT Encoder 
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
    END COMPONENT;
    
signal input : STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
signal output : STD_LOGIC_VECTOR(3 downto 0);
begin

    uut : Encoder PORT MAP (
        X => input,
        Y => output
    );

stim_proc: process 
    begin 
        wait for 100 ns;
        
        input <= "0000000001";
        wait for 50 ns;
        input <= "0000000010";
        wait for 50 ns;
        input <= "0000000100";
        wait for 50 ns;
        input <= "0000001000";
        wait for 50 ns;
        input <= "0000010000";
        wait for 50 ns;
        input <= "0000100000";
        wait for 50 ns;
        input <= "0001000000";
        wait for 50 ns;
        input <= "0010000000";
        wait for 50 ns;
        input <= "0100000000";
        wait for 50 ns;
        input <= "1000000000";
        wait for 50 ns;
        input <= "0000000000";
        wait;
end process;
end Behavioral;
