----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.11.2021
-- Design Name: Shift_Register_TB - Behavorial
-- Module Name: Shift_Register_TB - Behavorial
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

entity Shift_Register_TB is
--  Port ( );
end Shift_Register_TB;

architecture Behavioral of Shift_Register_TB is

    component Shift_Register is
      Port (  input : in  STD_LOGIC;
              outs : out  STD_LOGIC;
              clk_1 : in  STD_LOGIC;
              sel : in  STD_LOGIC_VECTOR (2 downto 0);
              clr_1 : in  STD_LOGIC
              );
    end component;

    --input
    signal input : std_logic := '0';
    signal clk_1 : std_logic := '0';
    signal sel : std_logic_vector(2 downto 0) := (others => '0');
    signal clr_1 : std_logic := '0';
    
    --output
    signal output : std_logic;
    
    --clock
     constant CLK_period : time := 10 ns;
     
     
begin

    uut : entity work.Shift_Register(Structural) 
    port map(
        input => input,
        outs => output,
        clk_1 => clk_1,
        sel => sel,
        clr_1 => clr_1
        );
       
              
   -- Clock process definitions
   CLK_process :process
   begin
        CLK_1 <= '0';
        wait for CLK_period/2;
        CLK_1 <= '1';
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
      
        --azzero tutti i registri
        clr_1 <= '0';
        wait for 30 ns;
        clr_1 <= '1';
  
        
        --test singolo shift a destra
        sel <= "001";
        
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
        input<='1';
        wait for 10 ns;
        input<='0';
        
        wait for 30 ns;
        
        clr_1 <= '0';
        wait for 30 ns;
        clr_1 <= '1';
        
        sel <= "010";
        
        input<='1';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='1';
        
        wait for 30 ns;
        
        clr_1 <= '0';
        wait for 30 ns;
        clr_1 <= '1';
        
        sel <= "101";
        
        input<='1';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='1';
        
        wait for 30 ns;
        
        clr_1 <= '0';
        wait for 30 ns;
        clr_1 <= '1';
        
        sel <= "110";
        
        input<='1';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='0';
        wait for 10 ns;
        input<='1';
        
        sel <= "000";
	
      wait;
   end process;

end Behavioral;
