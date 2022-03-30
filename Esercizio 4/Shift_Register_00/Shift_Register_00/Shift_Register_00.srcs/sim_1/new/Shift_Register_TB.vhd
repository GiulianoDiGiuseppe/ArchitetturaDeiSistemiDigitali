----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 13.11.2021
-- Design Name: Shift_Register_TB - Behavorial
-- Module Name: Shift_Register_TB - Behavorial
-- Project Name: Shift_Register_00
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

entity Shift_Register_TB is
--  Port();
end Shift_Register_TB;

architecture Behavioral of Shift_Register_TB is

component Shift_Register_TB 
    Generic (y : positive := 2);
    Port ( 
        clk, input, sel, reset : in std_logic;
        output : out std_logic);    
    end component;


--input
    signal input : std_logic := '0';
    signal reset : std_logic := '0';
    signal clk : std_logic := '0';
    signal sel : std_logic := '0';
    
--output 
    signal output : std_logic := '0';
    
--clock period definition
    constant clk_period : time := 10ns;

begin

    uut : entity work.Shift_Register(Behavioral) 
   generic map(y => 2)
    port map(
        input => input,
        reset => reset,
        clk => clk,
        sel => sel,
        output => output
    );


      -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;  
   
   
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- start da 200 (100 + CLK_period*10)
      wait for CLK_period*10;

      -- insert stimulus here 
      
		input<='0';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='1';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='1';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		 
		
		input<='0';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='1';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='1';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='0';
		wait for 10 ns;
		input<='1';
		wait for 10 ns;
		
		
--		sel<='1';
--		wait for 10 ns;
		
--		input<='0';
--		wait for 10 ns;
--		input<='0';
--		wait for 10 ns;
--		input<='1';
--		wait for 10 ns;
--		input<='0';
--		wait for 10 ns;
--		input<='0';
--		wait for 10 ns;
--		input<='1';
--		wait for 10 ns;
--		input<='0';
--		wait for 10 ns;

      wait;
   end process;      

end Behavioral;
