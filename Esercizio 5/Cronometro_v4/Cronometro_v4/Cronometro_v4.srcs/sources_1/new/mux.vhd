----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Mux2_1
-- Module Name: Mux2_1 - Behavorial
-- Project Name: Cronometro_v4
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity mux is
	generic (
		n	: positive := 2
	);
	port (
		x	: in std_logic_vector(32*(2**n) downto 1);
		sel	: in std_logic_vector(n-1 downto 0);
		y	: out std_logic_vector(31 downto 0)
	);
end mux;

architecture Behavioral of mux is


signal y_temp : std_logic_vector(31 downto 0) := (others => '0');


begin

	y <= y_temp;

	p : process(sel, x)
	
    variable temp : integer;
        
    begin
        
            temp := to_integer(unsigned(sel)); 
            y_temp <= x((32 * (2**n - temp)) downto (32 * (2**n - temp - 1) + 1));
	
	end process;


end Behavioral;
