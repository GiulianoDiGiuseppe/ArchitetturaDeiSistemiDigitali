----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 21.01.2022
-- Design Name: Switch_MultistadioTB
-- Module Name: Switch_MultistadioTB - Behavioral
-- Project Name: Switch_con_handshaking
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

entity tb_Switch_Handshaking is
-- Port();
end tb_Switch_Handshaking;

architecture tb of tb_Switch_Handshaking is

    component Switch_Handshaking
        port (clkA    : in std_logic;
              rstA    : in std_logic;
              clkB    : in std_logic;
              rstB    : in std_logic;
              enable  : in std_logic;
              src     : in std_logic_vector (1 downto 0);
              dst     : in std_logic_vector (1 downto 0);
              data    : in std_logic_vector (1 downto 0);
              dataout : out std_logic_vector (1 downto 0));
    end component;

    signal clkA    : std_logic;
    signal rstA    : std_logic;
    signal clkB    : std_logic;
    signal rstB    : std_logic;
    signal enable  : std_logic;
    signal src     : std_logic_vector (1 downto 0);
    signal dst     : std_logic_vector (1 downto 0);
    signal data    : std_logic_vector (1 downto 0);
    signal dataout : std_logic_vector (1 downto 0);

    constant TbPeriodA : time := 10 ns; -- EDIT Put right period here
    signal TbClockA : std_logic := '0';
    signal TbSimEndedA : std_logic := '0';
    
    constant TbPeriodB : time := 15 ns; -- EDIT Put right period here
    signal TbClockB : std_logic := '0';
    signal TbSimEndedB : std_logic := '0';

begin

    dut : Switch_Handshaking
    port map (clkA    => clkA,
              rstA    => rstA,
              clkB    => clkB,
              rstB    => rstB,
              enable  => enable,
              src     => src,
              dst     => dst,
              data    => data,
              dataout => dataout);

    -- Clock generation
    TbClockA <= not TbClockA after TbPeriodA/2 when TbSimEndedA /= '1' else '0';
    TbClockB <= not TbClockB after TbPeriodB/2 when TbSimEndedB /= '1' else '0';

    -- EDIT: Check that clkA is really your main clock signal
    clkA <= TbClockA;
    clkB <= TbClockB;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        enable <= '0';
        src <= (others => '0');
        dst <= (others => '0');
        data <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rstA is really your reset signal
        rstA <= '1';
        rstB <= '1';
        wait for 100 ns;
        rstA <= '0';
        rstB <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        enable <= '1';
        src <= "01";
        dst <= "11";
        data <= "01";
        
        wait for 50ns;
        
        enable <= '0';
        
        wait for 50ns;
        
        enable <= '1';
        src <= "00";
        dst <= "10";
        data <= "11";
        
        wait for 50ns;
        
        enable <= '0';
        
        wait for 50ns;
        
        enable <= '1';
        src <= "01";
        dst <= "00";
        data <= "10";
        
        wait for 50ns;
        
        enable <= '0';
        
        wait for 100 * TbPeriodA;
        wait for 100 * TbPeriodB;

        -- Stop the clock and hence terminate the simulation
        TbSimEndedA <= '1';
        TbSimEndedB <= '1';
        wait;
    end process;

end tb;