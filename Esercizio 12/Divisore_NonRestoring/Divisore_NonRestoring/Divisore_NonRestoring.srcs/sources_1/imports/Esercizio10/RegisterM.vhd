----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: RegisterM
-- Module Name: RegisterM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterM is
	generic( N	: integer := 8);
	port(	CLOCK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			ENABLE : in STD_LOGIC;
			X : in STD_LOGIC_VECTOR(N-1 downto 0);
			Y : out STD_LOGIC_VECTOR(N-1 downto 0));
end RegisterM;

architecture behavioral of RegisterM is

	begin
		REG_M : process(CLOCK, RESET)
		begin
			if (RESET='1') then
				Y<=(others =>'0');
			elsif (falling_edge(CLOCK)) then
				if(ENABLE='1') then
					Y <=	X;
				end if;
			end if;		
		end process REG_M;

end behavioral;

