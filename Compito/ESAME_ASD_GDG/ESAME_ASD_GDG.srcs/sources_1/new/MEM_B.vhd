----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2021 12:50:23
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_B is
    Port ( data_sh , data_p : in STD_LOGIC_VECTOR (0 to 7):=(others => '0');
           counter : in std_logic_vector ( 0 to 3);
            clk , en, sel: in STD_LOGIC
           ); 
end MEM_B;

architecture Behavioral of MEM_B is
type rom_type is array (0 to 7) of std_logic_vector(0 to 7);
signal MEM_B : rom_type:=("00000000",
                            "00000000",
                            "00000000",
                            "00000000",
                            "00000000",
                            "00000000",
                            "00000000",
                            "00000000"
                            );
                       
signal temp: std_logic_vector(0 to 7) := (others => '0');

type stato is (q0,q1);
signal stato_corrente: stato:= q0;
signal temp_Data_read:std_logic_vector(7 downto 0):=(others=> '0');


begin
    
    mem: process(clk)
    begin
   if(clk'event and clk = '1') then
            case stato_corrente is
            when q0 => 
            if (en = '1') then
                  if(sel='0') then
                    MEM_B(conv_integer(counter))<=data_sh;
                stato_corrente <= q1;
                elsif(sel='1') then
                    MEM_B(conv_integer(counter))<=data_p;
                    stato_corrente <= q1;
  
           else stato_corrente<= q0;
           end if;
           end if;
           
           when q1 => if(en ='0') then stato_corrente <= q0;
                      else stato_corrente<= q1;
                      end if;
           end case;
       end if;
            
    end process;
    

end Behavioral;
