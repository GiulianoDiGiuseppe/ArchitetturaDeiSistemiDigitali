----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: ROM_A
-- Module Name: ROM_A - Behavioral
-- Project Name: Interfaccia_Seriale_handshaking
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_A is
 generic (
           M : integer := 8
            );
        PORT (
            CLK : in std_logic; -- clock della board
            RST: in std_logic;
            READ : in std_logic; -- segnale da uc
            ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                                    --sono inseriti tramite gli switch (DA VEDERE LOG2N)
            DATA : out std_logic_vector(M-1 downto 0) -- dato su 8 bit letto dalla ROM
        );
end ROM_A;

architecture Behavioral of ROM_A is

type rom_type is array (0 to M-1) of std_logic_vector(M-1 downto 0);
signal ROM : rom_type := (
    "00010011", 
    "00010111", 
    "00011011", 
    "00110011",  
    "01010011", 
    "10111111", 
    "01110011", 
    "10010011");
attribute rom_style : bit;

begin

process(CLK)
  begin
    if rising_edge(CLK) then
        if (RST = '1') then
            DATA <= ROM(conv_integer("000"));
        elsif (READ = '1') then -- uc che gli dice invia
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
end process;

end Behavioral;
