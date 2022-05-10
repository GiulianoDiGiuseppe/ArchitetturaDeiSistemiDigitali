----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:42:32 09/16/2012 
-- Design Name: 
-- Module Name:    anodes_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

entity anodes_manager is
    Port ( counter : in  STD_LOGIC_VECTOR (2 downto 0);
           enable_digit : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end anodes_manager;

architecture Behavioral of anodes_manager is

signal anodes_switching : std_logic_vector(7 downto 0) := (others => '0');

begin


anodes <= not anodes_switching OR not enable_digit;

anodes_process: process(counter)
begin
	--a seconda del valore di caunter le cifre si illuminano una alla volta da destra a sinistra
	case counter is
		when "000" =>
			anodes_switching <= "00000001"; -- accendo l'ultimo anodo a destra e cos� via
		when "001" =>
			anodes_switching <= "00000010";
		when "010" =>
			anodes_switching <= "00000100";
		when "011" =>
			anodes_switching <= "00001000";
		when "100" =>
			anodes_switching <= "00010000";
		when "101" =>
			anodes_switching <= "00100000";
		when "110" =>
			anodes_switching <= "01000000";
		when "111" =>
			anodes_switching <= "10000000";
		when others =>
			anodes_switching <= (others => '0');
	end case;

end process;


end Behavioral;

