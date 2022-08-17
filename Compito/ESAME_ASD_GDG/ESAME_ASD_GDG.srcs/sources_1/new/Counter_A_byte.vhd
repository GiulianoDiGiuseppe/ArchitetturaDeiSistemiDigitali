----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2022 14:04:26
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_a_byte is
    Port ( clk : in STD_LOGIC;
           en_b : in STD_LOGIC; -- sarÃ  ready
           stop : out STD_LOGIC;
           counter : out STD_LOGIC_VECTOR(0 TO 3):= (others => '0') 
           );
end counter_a_byte;


architecture Behavioral of counter_a_byte is

signal tmp_stop: STD_LOGIC := '0';
signal tmp_count : std_logic_vector (0 TO 3) := (others => '0') ;


type stato is (q0,q1);
signal stato_corrente: stato:= q0;

begin
process (clk)
    begin
        if(clk'event and clk = '1') then
            case stato_corrente is
            when q0 => 
            if (en_b = '1') then
                stato_corrente <= q1;
                if(tmp_count = "1000") then
                     tmp_count <= "0000";
                     tmp_stop <= '1';
                else
                     tmp_count <= std_logic_vector(unsigned(tmp_count) + 1);
                     tmp_stop <= '0';
                end if;
           else stato_corrente<= q0;
           end if;
           when q1 => if(en_b ='0') then stato_corrente <= q0;
                      else stato_corrente<= q1;
                      end if;
           end case;
       end if;
    end process;
    stop <= tmp_stop;
    counter <= tmp_count;
end Behavioral;
