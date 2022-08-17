----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2022 16:12:41
-- Design Name: 
-- Module Name: TB1 - Behavioral
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

entity TB1 is
--  Port ( );
end TB1;

architecture Behavioral of TB1 is

component Top_module is
--  Port ( );
port(
            clk1 : in std_logic;
            clk2 : in std_logic;
           start: in std_logic
);
end component;

signal  clk1, clk2, start :  std_logic := '0';

begin

sistop : top_module port map ( clk1,clk2,start);

   process
    begin
    clk1 <= '1';
    wait for 2ns;
    clk1 <= '0';
    wait for 2ns;
    end process;
    
    process
    begin
    clk2 <= '1';
    wait for 4ns;
    clk2 <= '0';
    wait for 4ns;
    end process;
    
    process
    begin
    wait for 50ns;
    start <= '1';
    wait for 10000ns;

    wait;
    end process;
    

end Behavioral;
