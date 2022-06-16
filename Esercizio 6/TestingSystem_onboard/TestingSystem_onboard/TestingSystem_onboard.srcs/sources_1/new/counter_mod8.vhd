----------------------------------------------------------------------------------
-- Company: Universit� Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 11.12.2021
-- Design Name: counter_mod8
-- Module Name: counter_mod8 - Behavioral
-- Project Name: TestingSystem_onboard
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_mod8 is
  Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR (2 downto 0)
           );
end counter_mod8;

architecture Behavioral of counter_mod8 is

signal c : std_logic_vector (2 downto 0) := (others => '0');
begin
counter <= c;

counter_process: process(clock)
begin

     if(rising_edge(clock)) then
       if reset = '1' then
          c <= (others => '0');
       elsif enable = '1' then
          c <= std_logic_vector(unsigned(c) + 1);
      end if;
     end if;
end process;

end Behavioral;
