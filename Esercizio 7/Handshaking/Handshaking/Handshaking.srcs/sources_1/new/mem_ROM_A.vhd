----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: ROM_A
-- Module Name: ROM_A - Behavorial
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM_A is
generic(
    N : integer := 8;
    M : integer := 8 
);
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic;
    ADDR : in std_logic_vector(2 downto 0);
    DATA : out std_logic_vector(M-1 downto 0)
);
end ROM_A;

-- creo una ROM di 8 elementi da 8 bit ciascuno

architecture behavioral of ROM_A is 
type rom_type is array (0 to N-1) of std_logic_vector(M-1 downto 0);
signal ROM : rom_type := (
    "00010011", 
    "00010111", 
    "00011011", 
    "00110011",  
    "01010011", 
    "11111111", 
    "01110011", 
    "10010011");

attribute rom_style : bit;

begin

process(CLK)
  begin
    if (rising_edge(CLK)) then
        if (RST = '1') then
            DATA <= ROM(conv_integer("000"));
        elsif (READ = '1') then -- uc che gli dice invia
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
end process;

end behavioral;
