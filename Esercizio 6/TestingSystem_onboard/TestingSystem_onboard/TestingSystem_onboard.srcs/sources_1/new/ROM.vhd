----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 11.12.2021
-- Design Name: ROM
-- Module Name: ROM - Behavioral
-- Project Name: TestingSystem_onboard
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
use ieee.numeric_std.all;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
  Port ( 
        CLK : in std_logic; -- clock della board
        RST : in std_logic;
        READ : in std_logic; -- segnale che abilita la lettura, inserito tramite un bottone 
        ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switc
        DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit letto dalla ROM
        );
end ROM;

architecture Behavioral of ROM is

type rom_type is array (7 downto 0) of std_logic_vector(3 downto 0);
signal ROM : rom_type := (
"0000", 
"0001", 
"0010", 
"0011", 
"0100",
"0101",
"0110", 
"0111"
);

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT

begin

process (CLK)
    begin
        if rising_edge(CLK) then
            if (RST = '1') then
                DATA <= ROM(conv_integer("000"));
            elsif (READ = '1') then
            DATA <= ROM(conv_integer(ADDR));
            end if;
        end if;
        
    end process;


end Behavioral;
