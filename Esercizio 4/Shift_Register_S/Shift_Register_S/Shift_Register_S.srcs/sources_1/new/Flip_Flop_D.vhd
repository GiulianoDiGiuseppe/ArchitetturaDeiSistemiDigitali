----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.11.2021
-- Design Name: Flip_Flop_D - Behavorial
-- Module Name: Flip_Flop_D - Behavorial
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

entity Flip_Flop_D is
  Port (   D : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Reset_N : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end Flip_Flop_D;

architecture Behavioral of Flip_Flop_D is

begin

    process (Clock)
	Begin
	    if (Clock'EVENT AND Clock = '1') then
		  if (Reset_N = '0') then
			 Q <= '0';
		  else 
			Q <= D;
		  end if;	
		end if;
	end process;


end Behavioral;
