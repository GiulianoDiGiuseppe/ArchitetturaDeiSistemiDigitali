----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 11.12.2021
-- Design Name: ROM3
-- Module Name: ROM3 - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_3 is
  Port ( 
        CLK : in std_logic; -- clock della board
        RST : in std_logic;
        READ : in std_logic; -- segnale che abilita la lettura, inserito tramite un bottone 
        ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switch
        --WRITE : in std_logic;
        --ADDR_WRITE : in std_logic_vector(2 downto 0);
        DATA_IN : in std_logic_vector(2 downto 0) ; --dato in ingresso da memorizzare
        DATA_OUT : out std_logic_vector(2 downto 0) 
        );
end ROM_3;

architecture Behavioral of ROM_3 is

type rom_type is array (7 downto 0) of std_logic_vector(2 downto 0);
signal ROM : rom_type;

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT

begin

process(CLK)
  begin
    if rising_edge(CLK) then
        if (RST = '1') then
--            for i in 0 to 7 loop
--            ROM(i) <= "000"; 
--            DATA_OUT <= ROM(conv_integer("000"));
--            end loop;
            ROM(0) <= "000"; 
            ROM(1) <= "000"; 
            ROM(2) <= "000"; 
            ROM(3) <= "000"; 
            ROM(4) <= "000"; 
            ROM(5) <= "000"; 
            ROM(6) <= "000"; 
            ROM(7) <= "000"; 
            DATA_OUT <= ROM(conv_integer("000"));
            
        elsif (READ = '1') then                
            ROM(conv_integer(ADDR-1))<= DATA_IN;
            DATA_OUT <= ROM(conv_integer(ADDR-1));
        end if;
    end if;
end process;


end Behavioral;
