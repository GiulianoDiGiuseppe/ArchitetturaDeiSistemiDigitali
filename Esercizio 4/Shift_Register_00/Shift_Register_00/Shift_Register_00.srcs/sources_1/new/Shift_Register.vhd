----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 13.11.2021
-- Design Name: Shift_Register - Behavorial
-- Module Name: Shift_Register - Behavorial
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

entity Shift_Register is
  Generic (
        y : positive := 2);
  Port (
        clk, input, sel, reset : in std_logic;
        output : out std_logic);
end Shift_Register;

architecture Behavioral of Shift_Register is

    signal tmp : std_logic_vector(7 downto 0);
    
begin
    process(clk)
        begin
            if (clk'event and clk = '1') then   
                if(reset = '1') then
                    tmp <= "00000000";
                else   
                        if(sel = '0') then  --shifta a destra
                            output <= tmp(0);
                            if(y = 1) then
                                tmp <= input & tmp(7 downto 1);
                            else
                                tmp <= input & tmp(y-1 downto 1) & tmp(7 downto y);
                            end if;
                            
                        else                --shifta a sinistra
                            output <= tmp(7);
                            if(y = 1) then
                                tmp <= tmp(6 downto 0) & input;
                            else 
                                tmp <= tmp(7-y downto 0) & tmp(6 downto 8-y) & input;
                            end if;
                        end if;
                   
                 end if;
            end if;
    end process;

end Behavioral;
