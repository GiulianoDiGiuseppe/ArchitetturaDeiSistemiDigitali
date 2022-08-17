----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2022 15:15:05
-- Design Name: 
-- Module Name: Interface_B - Behavioral
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

entity Interface_B is
--  Port ( );
port(
           clk , sel : in std_logic;           
           en_cont_n , en_rom, en_sh ,en_cont_b  : out std_logic; 
           syn  : in STD_LOGIC;
           ack  : out STD_LOGIC;
           counter : in STD_LOGIC_VECTOR(0 TO 3)
);
end Interface_B;

architecture Behavioral of Interface_B is



type stato is (q0,q1,q2,q3,q4);
signal stato_prossimo: stato := q0;

begin
    process(clk) 
    begin
        if(clk = '1' and clk'event) then
            case stato_prossimo is
            
                when q0 =>     en_cont_b<='0';
                               en_sh <='0';
                               en_cont_n<='0';
                               en_rom<='0';
                                                               
                               if(syn = '1' and sel='1') then
                                ack<= '1';
                                stato_prossimo <= q1;
                                
                                elsif(syn = '1' and sel='0') then
                                ack<= '1';
                                stato_prossimo <= q3;
                              
                              else
                                ack <= '0';
                                stato_prossimo <= q0;
                              end if;
                             
                 when q1 =>  en_cont_n<='1';
                             en_rom<='1';
                             stato_prossimo <= q2;

                 when q2 =>  if(syn = '1') then
                                stato_prossimo <= q2;
                            else
                                ack <= '0';
                                stato_prossimo <= q0;
                           end if;
                                             
                 when q3 =>    en_sh <='1';
                               en_cont_b<='1';  
                               stato_prossimo <= q4;                     
                                             
                 when q4 =>   if(syn = '1') then
                                stato_prossimo <= q4;
                            elsif( syn = '0' and counter="1000")then
                                ack <= '0';
                                en_cont_n<='1';
                                en_rom<='1';
                                stato_prossimo <= q0;
                           else
                                ack <= '0';
                                stato_prossimo <= q0;
                              end if;                             
                                             
                                                           
                 when others => stato_prossimo <= q4;
                 
                end case;
            end if;
    end process;




end Behavioral;
