----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.01.2022
-- Design Name: Interfaccia_Seriale_TB
-- Module Name: Interfaccia_Seriale_TB - Behavioral
-- Project Name: Interfaccia_Seriale
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

entity Interfaccia_Seriale_TB is
--  Port ( );
end Interfaccia_Seriale_TB;

architecture Behavioral of Interfaccia_Seriale_TB is

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_On_Board
    PORT(
         CLOCK : IN  std_logic;
         BTN_RESET : IN  std_logic;
         BTN_LOAD : IN  std_logic;
         SWITCH : IN  std_logic_vector(7 downto 0);
         LED : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal BTN_RESET : std_logic := '0';
   signal BTN_LOAD : std_logic := '0';
   signal SWITCH : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 20 ns;
   
   
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: UART_On_Board PORT MAP (
          CLOCK => CLOCK,
          BTN_RESET => BTN_RESET,
          BTN_LOAD => BTN_LOAD,
          SWITCH => SWITCH,
          LED => LED
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
      wait for 10 ms;	

      wait for CLOCK_period*10;

      -- insert stimulus here 
		SWITCH <= "00000011";
		BTN_LOAD <= '1';

      wait for 6 ms;
		 
		BTN_LOAD <= '0';
		
		wait for 50 ms;
		
		SWITCH <= "00010001";
		BTN_LOAD <= '1';

      wait for 6 ms;
		 
		BTN_LOAD <= '0';
		
      wait;
   end process;

end Behavioral;
