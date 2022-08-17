----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Counter
-- Module Name: Counter - Behavioral
-- Project Name: Divisore_NonRestoring
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
	generic( M : integer := 8;
				N : integer := 3);
				
	port( CLOCK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			ENABLE: in STD_LOGIC;
			INIT	: in STD_LOGIC; 
			COUNT : out STD_LOGIC			
			);
			
end Counter;

architecture Behavioral of Counter is

	signal COUNT_TEMP : STD_LOGIC_VECTOR(N-1 downto 0);
	
	begin
		COUNT_PROC : process(CLOCK, RESET)
		begin
			if(RESET = '1') then 
				COUNT_TEMP <= (others => '0');
				COUNT <= '0';
			elsif (falling_edge(CLOCK)) then
				if(INIT = '1') then
					COUNT_TEMP <= (others => '0');
				elsif (ENABLE = '1') then
					if (COUNT_TEMP = std_logic_vector(to_unsigned(M-1, COUNT_TEMP' length))) then
						COUNT_TEMP <= (others => '0');
						COUNT <= '1';
					else 
						COUNT_TEMP <= COUNT_TEMP + "1";
						COUNT <= '0';
					end if;
				end if;
			end if;
		end process COUNT_PROC;
				
end Behavioral;
