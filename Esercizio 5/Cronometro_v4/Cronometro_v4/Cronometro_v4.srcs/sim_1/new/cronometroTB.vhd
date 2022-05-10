----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Cronometro_TB
-- Module Name: Cronometro_TB - Behavioral
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

entity cronometroTB is
-- Port()
end cronometroTB;

architecture behavioral of cronometroTB is 
    component cronometro is

        Port ( CLOCK: in std_logic;
               RESET: in std_logic;
               SET_S, SET_M, SET_O: in std_logic;
               INIT_S, INIT_M: in std_logic_vector(7 downto 0);
               INIT_O: in std_logic_vector(7 downto 0);
               CIFRA1_SECONDI, CIFRA2_SECONDI: out std_logic_vector(3 downto 0); 
               CIFRA1_MINUTI, CIFRA2_MINUTI: out std_logic_vector(3 downto 0); 
               CIFRA1_ORE, CIFRA2_ORE: out std_logic_vector(3 downto 0)
        ); 

    end component;

    signal c, r: std_logic;
    signal sets, setm, seto: std_logic;
    signal in_s, in_m: std_logic_vector(7 downto 0);
    signal in_o: std_logic_vector(7 downto 0);
    signal c1_sec, c2_sec, c1_min, c2_min: std_logic_vector(3 downto 0);
    signal c1_ore, c2_ore: std_logic_vector (3 downto 0);

    begin
    uut: cronometro 
        port map ( CLOCK => c, 
                   RESET => r, 
                   SET_S => sets, 
                   SET_M => setm, 
                   SET_O => seto, 
                   INIT_S => in_s, 
                   INIT_M => in_m, 
                   INIT_O => in_o, 
                   CIFRA1_SECONDI => c1_sec, 
                   CIFRA2_SECONDI => c2_sec, 
                   CIFRA1_MINUTI => c1_min, 
                   CIFRA2_MINUTI => c2_min, 
                   CIFRA1_ORE => c1_ore,
                   CIFRA2_ORE => c2_ore
        );
    
    prc: process
    begin
        wait for 10 ns;

        -- resetto il cronometro a 00:00:00
        r <= '1';
        wait for 10 ns;

        r <= '0';
        -- setto l'ora iniziale a 10:59:40
        sets <= '1';
        in_s <= "00101000";
        wait for 10 ns;

        sets <= '0';
        setm <= '1';
        in_m <= "00111011";
        wait for 10 ns;

        setm <= '0';
        seto <= '1';
        in_o <= "00001010";
        wait for 10 ns;
        
        seto <= '0';
        
        for i in 0 to 40 loop
            wait for 10 ns;
            C<='1';
            wait for 10 ns;
            C<='0';
        end loop;
    wait;

    end process;

end behavioral;