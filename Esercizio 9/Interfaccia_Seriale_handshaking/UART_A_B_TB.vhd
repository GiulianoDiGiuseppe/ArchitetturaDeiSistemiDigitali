----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: UART_A_B_TB
-- Module Name: UART_A_B_TB - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity tb_UART_A_B is
end tb_UART_A_B;

architecture tb of tb_UART_A_B is

    component UART_A_B
        port (CLK    : in std_logic;
              RST    : in std_logic;
              ENABLE : in std_logic);
    end component;

    signal CLK    : std_logic;
    signal RST    : std_logic;
    signal ENABLE : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal stoptheclock : boolean;

begin

    dut : UART_A_B
    port map (CLK    => CLK,
              RST    => RST,
              ENABLE => ENABLE);

    stimulus : process
    begin
        
        RST <= '1';
        wait for 100ns;
        RST <= '0';
        
        enable <= '0';
        wait for 100ns;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait for 100 us;
        enable <= '1';
        wait for 50 ns;
        enable <= '0';
        wait;
end process;

clocking: process
begin
    while not stoptheclock loop
        CLK <= '0', '1' after TbPeriod / 2; 
        wait for TbPeriod;
    end loop;
    wait;

end process;

end tb;