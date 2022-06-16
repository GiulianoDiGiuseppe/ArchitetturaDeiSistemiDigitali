----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 11.12.2021
-- Design Name: TestingSystem_TB
-- Module Name: TestingSystem_TB - Behavioral
-- Project Name: TestingSystem_onboard
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

entity TestingSystem_TB is
--  Port ( );
end TestingSystem_TB;

architecture Behavioral of TestingSystem_TB is

component TestingSystem is
  Port ( 
        clock_in : STD_LOGIC; 
        reset_in : in  STD_LOGIC;
        addr_strobe_in : in  STD_LOGIC; --bottone che abilita la selezione della cella della ROM da visualizzare
       -- address_in : in STD_LOGIC_VECTOR(2 downto 0);  --indirizzo di selezione inserito tramite switch
        output : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    constant CLK_period : time := 10 ns;
    
  signal clk: std_logic;
  signal read: std_logic;
  signal reset: std_logic;
  signal data: std_logic_vector(2 downto 0) ;

begin

    uut: TestingSystem port map(    clock_in => clk,
                                    reset_in => reset,
                                    addr_strobe_in => read,
                                    output => data );
                                    
                                    
    stimulus: process
  begin
  
    wait for 100ns;
    read <= '1';
    wait for 300ns;
    read <= '0';
    reset <= '1';

  end process;
  
  
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process; 

end Behavioral;
