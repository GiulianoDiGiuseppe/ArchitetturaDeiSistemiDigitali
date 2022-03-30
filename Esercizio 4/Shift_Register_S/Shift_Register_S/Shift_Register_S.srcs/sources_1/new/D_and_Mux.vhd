----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.11.2021
-- Design Name: D_and_Mux - Structural
-- Module Name: D_and_Mux - Structural
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

entity D_and_Mux is
  Port (  in_put : in  STD_LOGIC_VECTOR (4 downto 0);
		  Sel : in  STD_LOGIC_VECTOR (2 downto 0);
		  clk :	in STD_LOGIC;
		  clearN : in STD_LOGIC;
		  Output : out  STD_LOGIC);
end D_and_Mux;

architecture Structural of D_and_Mux is

    component Mux_8_1 is
      Port (  w : in  STD_LOGIC_VECTOR (4 downto 0);
              m : in  STD_LOGIC_VECTOR (2 downto 0);  --il primo bit di selezione m(2) sarebbe y, memtre gli altri due indicano il modo di shift
              f : out  STD_LOGIC);
    end component; 

    component Flip_Flop_D is
      Port (   D : in  STD_LOGIC;
               Clock : in  STD_LOGIC;
               Reset_N : in  STD_LOGIC;
               Q : out  STD_LOGIC);
    end component;
    
    signal mux_d : STD_LOGIC;
    
begin

    mux : Mux_8_1 
        port map (
            w => in_put,
            m => sel, 
            f => mux_d
            );
            
     FFD : Flip_Flop_D
        port map (
            D => mux_d,
            Q => Output, 
            Clock => clk, 
            Reset_N => clearN
            );

end Structural;
