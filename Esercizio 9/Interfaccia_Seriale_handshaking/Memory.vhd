----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: Memory
-- Module Name: Memory - Behavioral
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
    generic (
       N : integer := 8;
       M : integer := 8
        );
    port(
    ADDR : in std_logic_vector(2 downto 0); -- Address to write/read MEM
    MEM_DATA_IN : in std_logic_vector(M-1 downto 0); -- Data to write into MEM
    MEM_WE : in std_logic; -- Write enable 
    MEM_CLOCK : in std_logic; -- clock input for MEM
    MEM_RST : in std_logic -- reset for MEM
);
end Memory;

architecture Behavioral of Memory is

-- define the new type for the 128x8 MEM 
type MEM_ARRAY is array (0 to N-1 ) of std_logic_vector (M-1 downto 0);
-- initial values in the MEM
signal MEM: MEM_ARRAY :=(
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000"); 

begin

process(MEM_CLOCK)
begin
 if(rising_edge(MEM_CLOCK)) then
    if(MEM_WE='1') then -- when write enable = 1, 
         -- write input data into MEM at the provided address
         MEM(to_integer(unsigned(ADDR))) <= MEM_DATA_IN;
         -- The index of the MEM array type needs to be integer so
         -- converts MEM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
    end if;
 end if;
end process;
 -- Data to be read out 
 --MEM_DATA_OUT <= MEM(to_integer(unsigned(ADDR)));


end Behavioral;
