----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: MemoriaB
-- Module Name: MemoriaB - Behavorial
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

entity MemoriaB is
    generic (
       N : integer := 8;
       M : integer := 8
    );
port(
    ADDR: in std_logic_vector(2 downto 0); -- Address to write/read MEM
    MEM_SOMMA_IN: in std_logic_vector(M-1 downto 0); -- Data to write into MEM
    MEM_WE: in std_logic; -- Write enable 
    MEM_CLOCK: in std_logic; -- clock input for MEM
    MEM_DATA_OUT: out std_logic_vector(M-1 downto 0) -- Data output of MEM
);
end MemoriaB;

architecture Behavioral of MemoriaB is
-- definisco una memoria di 16 locazioni ognuna da 8 bit
type MEM_ARRAY is array (0 to 2*N-1 ) of std_logic_vector (M-1 downto 0);
-- valori iniziali nella memoria
signal MEM: MEM_ARRAY :=(
    "01010011", 
    "01010111", 
    "00111011", 
    "00110011",  
    "01010111", 
    "00000001", 
    "00001011", 
    "00010011",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000"); 
   
begin
proc: process(MEM_CLOCK)
begin

    if(falling_edge(MEM_CLOCK)) then
        if(MEM_WE='1') then --quando write enable è alto scrivo nella memoria
             
             MEM(to_integer(unsigned(ADDR))+8) <= MEM_SOMMA_IN; --scrivo nella memoria con
                                                                -- un offset di 8
        end if;
    end if;
end process;

-- Dato in uscita dalla memoria
MEM_DATA_OUT <= MEM(to_integer(unsigned(ADDR)));

end Behavioral;
