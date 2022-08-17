----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.01.2022
-- Design Name: Switch_MultistadioTB
-- Module Name: Switch_MultistadioTB - Behavioral
-- Project Name: Switch_Multistadio
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

entity Switch_MultistadioTB is
-- port();
end Switch_MultistadioTB;

architecture tb of Switch_MultistadioTB is

    component Switch_Multistadio
        port (enable00 : in std_logic;
              enable01 : in std_logic;
              enable10 : in std_logic;
              enable11 : in std_logic;
              data0    : in std_logic_vector (1 downto 0);
              data1    : in std_logic_vector (1 downto 0);
              data2    : in std_logic_vector (1 downto 0);
              data3    : in std_logic_vector (1 downto 0);
              dst      : in std_logic_vector (1 downto 0);
              out0     : out std_logic_vector (1 downto 0);
              out1     : out std_logic_vector (1 downto 0);
              out2     : out std_logic_vector (1 downto 0);
              out3     : out std_logic_vector (1 downto 0));
    end component;

    signal enable00 : std_logic;
    signal enable01 : std_logic;
    signal enable10 : std_logic;
    signal enable11 : std_logic;
    signal data0    : std_logic_vector (1 downto 0);
    signal data1    : std_logic_vector (1 downto 0);
    signal data2    : std_logic_vector (1 downto 0);
    signal data3    : std_logic_vector (1 downto 0);
    signal dst      : std_logic_vector (1 downto 0);
    signal out0     : std_logic_vector (1 downto 0);
    signal out1     : std_logic_vector (1 downto 0);
    signal out2     : std_logic_vector (1 downto 0);
    signal out3     : std_logic_vector (1 downto 0);

begin

    dut : Switch_Multistadio
    port map (enable00 => enable00,
              enable01 => enable01,
              enable10 => enable10,
              enable11 => enable11,
              data0    => data0,
              data1    => data1,
              data2    => data2,
              data3    => data3,
              dst      => dst,
              out0     => out0,
              out1     => out1,
              out2     => out2,
              out3     => out3);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        enable00 <= '0';
        enable01 <= '0';
        enable10 <= '0';
        enable11 <= '0';
        data0 <= (others => '0');
        data1 <= (others => '0');
        data2 <= (others => '0');
        data3 <= (others => '0');
        dst <= (others => '0');
        
        wait for 100ns;
        
        -- EDIT Add stimuli here
        enable00 <= '1';
        enable01 <= '1';
        enable10 <= '0';
        enable11 <= '0';
        data0 <= "10";
        data1 <= "11";
        data2 <= "00";
        data3 <= "01";
        dst <= "11";
        
        wait for 100ns;
        
        enable00 <= '0';
        enable01 <= '1';
        enable10 <= '1';
        enable11 <= '0';
        data0 <= "01";
        data1 <= "11";
        data2 <= "11";
        data3 <= "10";
        dst <= "00";
        
        wait for 100ns;
        
        enable00 <= '0';
        enable01 <= '0';
        enable10 <= '1';
        enable11 <= '1';
        data0 <= "10";
        data1 <= "11";
        data2 <= "10";
        data3 <= "01";
        dst <= "10";
        
        wait for 100ns;
        
        enable00 <= '0';
        enable01 <= '0';
        enable10 <= '0';
        enable11 <= '1';
        data0 <= "11";
        data1 <= "01";
        data2 <= "10";
        data3 <= "01";
        dst <= "01";
        
        wait;
    end process;

end tb;
