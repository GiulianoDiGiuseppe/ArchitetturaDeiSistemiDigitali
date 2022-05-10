----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Cronometro
-- Module Name: Cronometro - Structural
-- Project Name: Cronometro_v4
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

entity cronometro is

    Port ( CLOCK: in std_logic;
           RESET: in std_logic;
           SET_S, SET_M: in std_logic;
           SET_H : in std_logic;
           ore_en : in std_logic;
           INIT_S, INIT_M: in std_logic_vector(5 downto 0);
           INIT_O: in std_logic_vector(4 downto 0);
           CIFRA1_SECONDI, CIFRA2_SECONDI: out std_logic_vector(3 downto 0); 
           CIFRA1_MINUTI, CIFRA2_MINUTI: out std_logic_vector(3 downto 0); 
           CIFRA1_ORE, CIFRA2_ORE: out std_logic_vector(3 downto 0)
    ); 

end cronometro;

architecture Structural of cronometro is
component cont_sm is

    Port( CLK: in  std_logic;
          RST: in  std_logic;
          SET: in std_logic;
          ore_en : in std_logic;
          INIT: in  std_logic_vector(5 downto 0);
          Y1: out std_logic_vector(3 downto 0) := "0000";
          Y2: out std_logic_vector(3 downto 0) := "0000";
          EN: out std_logic 
    );

end component;

component cont_o is 

    Port( CLK: in  std_logic;
          RST: in  std_logic;
          SET: in std_logic;
          ore_en : in std_logic;
          INIT: in  std_logic_vector(4 downto 0);
          Y1: out std_logic_vector(3 downto 0) := "0000";
          Y2: out std_logic_vector(3 downto 0) := "0000"
    );

end component;

signal en1, en2: std_logic; 

begin

    contatore_secondi: cont_sm 
        Port map ( CLK => CLOCK,
                   RST => RESET,
                   SET => SET_S,
                   ore_en => ore_en,
                   INIT => INIT_S,
                   Y1 => CIFRA1_SECONDI,
                   Y2 => CIFRA2_SECONDI,
                   EN => en1
        );

    contatore_minuti: cont_sm 
        Port map ( CLK => en1,
                   RST => RESET,
                   SET => SET_M,
                   ore_en => ore_en,
                   INIT => INIT_M,
                   Y1 => CIFRA1_MINUTI,
                   Y2 => CIFRA2_MINUTI,
                   EN => en2
        );

    contatore_ore: cont_o 
        Port map ( CLK => en2,
                   RST => RESET,
                   SET => SET_H,
                   ore_en => ore_en,
                   INIT => INIT_O,
                   Y1 => CIFRA1_ORE,
                   Y2 => CIFRA2_ORE
        );

end Structural;