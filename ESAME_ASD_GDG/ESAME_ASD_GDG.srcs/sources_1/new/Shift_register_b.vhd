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

entity Shift_Register_b is
  Port (
        clk, en_sh   : in std_logic;
        data_out : out std_logic_vector( 0 to 7):=(others => '0');
        counter : in STD_LOGIC_VECTOR(0 TO 3);
        data : in  std_logic :='0'
        );
end Shift_Register_B;

architecture Behavioral of Shift_Register_B is

    signal tmp : std_logic;
    signal tmp_vector : std_logic_vector(7 downto 0):=(others => '0');
   
   type stato is (q0,q1);
signal stato_corrente: stato:= q0;

begin

    process(clk)
        begin
            if (clk'event and clk = '1') then   
            case stato_corrente is
            when q0 =>  if(en_sh = '1') then 
                         tmp_vector <= data & tmp_vector(7 downto 1);
                         stato_corrente<= q1;            
--                        elsif (counter = "1000")then 
--                              data_out<=tmp_vector ;
--                              stato_corrente<= q1;            
                 else stato_corrente<= q0;
                 end if;
                 
            when q1 => if(en_sh ='0') then stato_corrente <= q0;
                      else stato_corrente<= q1;
                      end if;
            end case;

             end if;           
    end process;
    
data_out<=tmp_vector;

end Behavioral;
