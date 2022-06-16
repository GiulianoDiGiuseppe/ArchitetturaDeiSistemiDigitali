----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: TB_Handshaking_A_B
-- Module Name: TB_Handshaking_A_B - Behavorial
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

entity tb_handshaking_A_B is
end tb_handshaking_A_B;

architecture tb of tb_handshaking_A_B is

    component handshaking_A_B
        port (clk_A : in std_logic;
              clk_B : in std_logic;
              rst_A : in std_logic;
              rst_B : in std_logic);
    end component;

    signal clk_A : std_logic;
    signal clk_B : std_logic;
    signal rst_A : std_logic;
    signal rst_B : std_logic;

    constant TbPeriodA : time := 10 ns; -- EDIT Put right period here
    signal TbClockA : std_logic := '0';
    signal TbSimEndedA : std_logic := '0';
    constant TbPeriodB : time := 15 ns; -- EDIT Put right period here
    signal TbClockB : std_logic := '0';
    signal TbSimEndedB : std_logic := '0';

begin

    dut : handshaking_A_B
    port map (clk_A => clk_A,
              clk_B => clk_B,
              rst_A => rst_A,
              rst_B => rst_B);

    -- Clock generation
    TbClockA <= not TbClockA after TbPeriodA/2 when TbSimEndedA /= '1' else '0';
    TbClockB <= not TbClockB after TbPeriodB/2 when TbSimEndedB /= '1' else '0';

    -- EDIT: Check that clk_A is really your main clock signal
    clk_A <= TbClockA;
    clk_B <= TbClockB;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
--        clk_B <= '0';
--        rst_B <= '0';

        -- Reset generation
        -- EDIT: Check that rst_A is really your reset signal
        rst_A <= '1';
        rst_B <= '1';
        wait for 100 ns;
        rst_A <= '0';
        rst_B <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriodA;
        wait for 100 * TbPeriodB;
        
        -- Stop the clock and hence terminate the simulation
        TbSimEndedA <= '1';
        TbSimEndedB <= '1';
        wait;
    end process;

end tb;
