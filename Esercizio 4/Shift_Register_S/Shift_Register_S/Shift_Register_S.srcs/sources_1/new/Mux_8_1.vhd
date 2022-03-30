----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.11.2021
-- Design Name: Mux_8_1 - Behavorial
-- Module Name: Mux_8_1 - Behavorial
-- Project Name: Shift_Register_S
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

entity Mux_8_1 is
  Port (  w : in  STD_LOGIC_VECTOR (4 downto 0);    -- w(0) = store, w(1) = s_rifht_1, w(2) = s_left_1, w(3) = s_riht_2, w(4) = s_left_2
		  m : in  STD_LOGIC_VECTOR (2 downto 0);  --il primo bit di selezione m(2) sarebbe y, memtre gli altri due indicano il modo di shift
		  f : out  STD_LOGIC);
end Mux_8_1;

architecture Behavioral of Mux_8_1 is

begin

    with m select
        f <=    w(1)	when "001",
                w(2) 	when "010",
                w(3) 	when "101",
                w(4)    when "110",
                w(0)    when others;
                

end Behavioral;
