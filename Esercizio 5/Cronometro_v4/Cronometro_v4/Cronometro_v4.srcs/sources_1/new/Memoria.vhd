----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Memoria
-- Module Name: Memoria - Behavorial
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

entity Memoria is
	port (
		x		: in std_logic_vector(31 downto 0);
		en		: in std_logic;
		clk	: in std_logic;
		reset	: in std_logic;
		y		: out std_logic_vector(31 downto 0)
	);
end Memoria;

architecture Behavioral of Memoria is


signal y_temp : std_logic_vector(31 downto 0) := (others => '0'); 


begin

	y <= y_temp;
	
	p : process(clk, reset)
	
	begin
	
		if(reset = '1') then
			y_temp <= (others => '0');
			
		elsif(clk'event and clk = '0' and en = '1') then
			y_temp <= x;
			
		end if;
	
	end process;

end Behavioral;
