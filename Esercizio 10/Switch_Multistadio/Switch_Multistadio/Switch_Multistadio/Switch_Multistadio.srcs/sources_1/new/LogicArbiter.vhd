----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2022 10:17:17
-- Design Name: 
-- Module Name: LogicArbiter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity LogicArbiter is
  Port ( 
        enable00 : in std_logic;
        enable01 : in std_logic;
        enable10 : in std_logic;
        enable11 : in std_logic;
        src      : out std_logic_vector(1 downto 0)
  );
end LogicArbiter;

architecture Dataflow of LogicArbiter is

begin
    
    src <=  "00" when enable00 = '1' else
            "01" when enable01 = '1' else 
            "10" when enable10 = '1' else
            "11" when enable11 = '1' else
            "--";

end Dataflow;
