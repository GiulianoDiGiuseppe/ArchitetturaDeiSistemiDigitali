----------------------------------------------------------------------------------
-- Company: Universit� Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.10.2021
-- Design Name: Riconoscitore sequenza 1001 con due modi
-- Module Name: Riconoscitore_Mealy_2_Modi_TB - Behavioral
-- Project Name: Riconoscitore_2_Modi_onboard
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

entity Riconoscitore_Mealy_2_Modi_TB is
--  Port ( );
end Riconoscitore_Mealy_2_Modi_TB;

architecture Behavioral of Riconoscitore_Mealy_2_Modi_TB is

component Riconoscitore_Mealy_2_Modi_TB

    Port(
        i : in  std_logic;
        CLK,RST,M : in  std_logic;
        READ_I: in std_logic;
        Y : out  std_logic
    );

end component;
    
-- Inputs
signal i : std_logic := '0';
signal CLK : std_logic := '0';
signal RST : std_logic := '0'; 
signal READ_I : std_logic := '0';
signal M : std_logic := '1'; 

--Outputs
signal Y : std_logic;

-- Clock period definitions
constant CLK_period : time := 10 ns;

begin

-- Instantiate the Unit Under Test (UUT)
-- Qui si specifica quale architecture simulare di quelle definite nel progetto corrente
uut: entity work.Riconoscitore_Mealy_2_Modi(Behavioral) port map(
  i => i,
  CLK => CLK,
  RST => RST,
  READ_I => READ_I,
  M => M,
  Y => Y
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
    -- sequenza di bit in ingresso 0010010000101001
    
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    
    --C'è il cambio di M e viene abilitato il reset (RST<='1') 
    M<='0';
    RST<='1';
    wait for 10 ns;
    RST<='0';
    
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    
    -- C'è il cambio di M e viene abilitato il reset (RST<='1')
    M<='1';
    RST<='1';
    wait for 10 ns;
    RST<='0';
    
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='0';
    wait for 10 ns;
    i<='1';
    
    wait;
    
end process;
end Behavioral;
