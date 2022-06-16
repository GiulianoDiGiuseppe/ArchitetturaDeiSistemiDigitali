----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: UO_B
-- Module Name: UO_B - Behavorial
-- Project Name: Handshaking_A_B
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UO_B is
generic (
       N : integer := 8;
       M : integer := 8
    );
PORT (
    CLK_UO_B : in std_logic;
    RST_UO_B: in std_logic;
    out_data_UO_B: in STD_LOGIC_VECTOR(M-1 downto 0);
    out_data_MEM_B: in STD_LOGIC_VECTOR(M-1 downto 0);
    bit_overflow: out STD_LOGIC := '0';
    enable_ALU : in STD_LOGIC;
    end_somma_out : out std_logic := '0';
    sum_data: out STD_LOGIC_VECTOR(M-1 downto 0)
);
end UO_B;

architecture Behavioral of UO_B is

-- segnali temporanei per la gestione dell'overflow
signal sum_temp : STD_LOGIC_VECTOR(M downto 0);
signal out_data_UO_temp : STD_LOGIC_VECTOR(M downto 0);
signal out_data_MEM_temp : STD_LOGIC_VECTOR(M downto 0);

begin
    -- faccio la concatenazione di uno zero in testa per avere il bit di resto
    out_data_UO_temp <= "0" & out_data_UO_B;
    out_data_MEM_temp <= "0" & out_data_MEM_B;

    ALU : process (CLK_UO_B, RST_UO_B)
       begin
        if rising_edge(CLK_UO_B) then
           if(RST_UO_B = '1') then
               sum_temp <= "000000000";
           elsif(enable_ALU = '1' ) then
               sum_temp <= out_data_UO_temp + out_data_MEM_temp;
               end_somma_out <= '1';
               if (sum_temp(M) = '1') then
                   sum_data <= "00000000"; -- se c'è overflow allora stampo 0
                   bit_overflow <= '1';
               else
                   sum_data <= sum_temp(M-1 downto 0); -- se non c'è overflow allora stampo il risultato
                   bit_overflow <= '0';
               end if;
           else
               end_somma_out <= '0';
           end if;
        end if;
       end process;

end Behavioral;
