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

entity MEM_A is
    Port ( data : out STD_LOGIC_VECTOR (0 to 7):=(others => '0');
           counter : in std_logic_vector ( 0 to 3);
            clk , en: in STD_LOGIC;
            sel : out STD_LOGIC:='1'
           ); 
end MEM_A;

architecture Behavioral of MEM_A is
type rom_type is array (0 to 7) of std_logic_vector(0 to 7);
signal MEM_A : rom_type:=("10000001",
                            "00000111",
                            "00011101",
                            "01010001",
                            "00010101",
                            "00011111",
                            "00011101",
                            "01011001"
                            );
                       
signal temp: std_logic_vector(0 to 7) := (others => '0');

type stato is (q0,q1);
signal stato_corrente: stato:= q0;
signal temp_Data_read:std_logic_vector(7 downto 0):=(others=> '0');


begin
    
    mem: process(clk)
    variable cnt_rom : integer := 0;
    begin
   if(clk'event and clk = '1') then
            case stato_corrente is
            when q0 => 
            if (en = '1') then
            if(counter = "0000")then
            temp_Data_read<= MEM_A(conv_integer(counter));
            sel<=MEM_A(conv_integer(counter))(0);
                stato_corrente <= q1;
              elsif(counter = "1000") then
                     stato_corrente<= q0;
                else
                temp_Data_read<= MEM_A(conv_integer(counter));
                stato_corrente <= q1;
                end if;
           else stato_corrente<= q0;
           end if;
           when q1 => if(en ='0') then stato_corrente <= q0;
                      else stato_corrente<= q1;
                      end if;
           end case;
       end if;
            
    end process;
    data<=temp_Data_read;

end Behavioral;
