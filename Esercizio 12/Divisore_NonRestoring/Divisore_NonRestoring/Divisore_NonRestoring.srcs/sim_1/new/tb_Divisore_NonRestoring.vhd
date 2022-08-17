----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Tb_Divisore_NonRestoring
-- Module Name: Tb_Divisore_NonRestoring - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_Divisore_NonRestoring IS
END tb_Divisore_NonRestoring;
 
ARCHITECTURE Behavioral OF tb_Divisore_NonRestoring IS 

COMPONENT Divisore_NonRestoring is
	GENERIC(	N : integer := 8);
	port(	CLOCK : in  STD_LOGIC;
			RESET : in STD_LOGIC;
			X : in  std_logic_vector(7 downto 0);
			Y : in  std_logic_vector(7 downto 0);
			BTN_START : in STD_LOGIC;
			Q : out std_logic_vector(7 downto 0)
	);
end COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal X : std_logic_vector(7 downto 0) := (others => '0');
   signal Y : std_logic_vector(7 downto 0) := (others => '0');
   signal BTN_START : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Divisore_NonRestoring PORT MAP (
          CLOCK => CLOCK,
          RESET => RESET,
          X => X,
          Y => Y,
          BTN_START => BTN_START,
          Q => Q
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLOCK_period*10;

      -- insert stimulus here 
		X <= "00011101";	-- 8

      wait for 12 ns;	

		Y <= "00000100";	-- 4

      wait for 12 ns;	
		
		BTN_START	<= '1';

      wait for 12 ns;	
		BTN_START	<= '0';
		
		
		wait for 400 ns;	
--		RESET <= '1';
		wait for 100 ns;	
--		RESET <= '0';
		
		
      -- insert stimulus here 
		X <= "11111111";	-- 255

      wait for 12 ns;	

		Y <= "00001110";	-- 14

      wait for 12 ns;	
		
		BTN_START	<= '1';

      wait for 12 ns;	
		BTN_START	<= '0';
		
      wait for 400 ns;	
--		RESET <= '1';
	  wait for 100 ns;	
--		RESET <= '0';
		 
      wait;
   end process;

END Behavioral;
