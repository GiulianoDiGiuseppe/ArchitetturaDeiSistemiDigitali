----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 19:41:28
-- Design Name: 
-- Module Name: interfacciaA - Behavioral
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
use IEEE.math_real."log2";
use IEEE.math_real."ceil";
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interface_A is
    Port ( 
           clk : in std_logic;
           start,stop_byte : in std_logic;
           sel: in std_logic;
           stop : in std_logic_vector(0 to 1 );
           en ,en_sh : out std_logic;
           syn : out STD_LOGIC;
           ack : in STD_LOGIC;
           counter : in STD_LOGIC_VECTOR(0 TO 3):= (others => '0') 
           );
end interface_A;

architecture Behavioral of interface_A is

type stato is (q0,q1,q2,q3,q4,q5,q6);
signal stato_prossimo: stato := q0;

begin
    process(clk) 
    begin
        if(clk = '1' and clk'event) then
            case stato_prossimo is
            
                when q0 =>      
                                
                                if(start = '0') then
                                stato_prossimo <= q0;
                    else
                                    en <='1';
                                    stato_prossimo <= q1;
                                    end if;
                                    
                --sel =1 parallelo
                --sel =0 serie             
                 when q1 =>     en<='0';
                                if(ack = '0' and counter="0000" )then
                                syn <= '1';                                
                                stato_prossimo <= q2;
                                
                               
                                elsif(ack = '0' and sel='1' ) then-- parallelo
                                syn <= '1'; 
                                stato_prossimo <= q2;                                
                                    elsif(ack = '0' and sel='0') then 
                                     en_sh<='1';
                                    syn <= '1';
                                    stato_prossimo <= q4;
                                        else                                
                                        stato_prossimo <= q1;                                
                                        end if;
                    
                 when q2 =>   if(ack='1')then
                                syn<='0';
                                stato_prossimo <= q3;
                             else
                                    stato_prossimo <= q2;  
                              end if;    
                 
                              
                when q3 =>   if(ack='0' and counter="1000")then
                             stato_prossimo <= q6;
                             elsif(ack = '0') then
                                 stato_prossimo <= q0;
                             else
                                    stato_prossimo <= q3;  
                              end if;
                              
                              
                when q4 =>   if(ack='1' )then
                             syn<='0';
                             en_sh<='0';
                             stato_prossimo <= q5;
                             else
                                    stato_prossimo <= q4;  
                              end if;
                              
                when q5 =>
                             if(ack='0' and stop_byte='0')then
                             stato_prossimo <= q1;
                             elsif(ack = '0'and stop_byte='1') then
                                 stato_prossimo <= q0;
                             elsif(ack = '0'and stop_byte='1' and counter="1000")then
                                    stato_prossimo <= q6;  
                             else
                                   stato_prossimo <= q5;  
                              end if;                 
       
                
                 when q6 =>  stato_prossimo <= q6;  
                              
                 when others => stato_prossimo <= q0;
                 
                end case;
            end if;
    end process;


    

end Behavioral;
