----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2022 09:47:32
-- Design Name: 
-- Module Name: Switch_Multistadio - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity Switch_Multistadio is
    Port ( 
        enable00 : in std_logic;
        enable01 : in std_logic;
        enable10 : in std_logic;
        enable11 : in std_logic;
        data0    : in std_logic_vector(1 downto 0);
        data1    : in std_logic_vector(1 downto 0);
        data2    : in std_logic_vector(1 downto 0);
        data3    : in std_logic_vector(1 downto 0);
        dst      : in std_logic_vector(1 downto 0);
        out0     : out std_logic_vector(1 downto 0);
        out1     : out std_logic_vector(1 downto 0);
        out2     : out std_logic_vector(1 downto 0);
        out3     : out std_logic_vector(1 downto 0)		
    );
end Switch_Multistadio;

architecture Structural of Switch_Multistadio is

component Datapath is
    port(
    --      en : IN std_logic;
    --		dst0 : IN std_logic_vector(1 downto 0);
    --		dst1 : IN std_logic_vector(1 downto 0);
    --		dst2 : IN std_logic_vector(1 downto 0);
        dst   : IN std_logic_vector(1 downto 0);
        src   : IN std_logic_vector(1 downto 0);
        data0 : IN std_logic_vector(1 downto 0);
        data1 : IN std_logic_vector(1 downto 0);
        data2 : IN std_logic_vector(1 downto 0);
        data3 : IN std_logic_vector(1 downto 0);
        out0  : OUT std_logic_vector(1 downto 0);
        out1  : OUT std_logic_vector(1 downto 0);
        out2  : OUT std_logic_vector(1 downto 0);
        out3  : OUT std_logic_vector(1 downto 0)
    --		u : OUT std_logic_vector(1 downto 0)
    );
end component;

component ControlUnit is
	port(
		data0    : in std_logic_vector(1 downto 0);
		data1    : in std_logic_vector(1 downto 0);
		data2    : in std_logic_vector(1 downto 0);
		data3    : in std_logic_vector(1 downto 0);
		enable00 : in std_logic;
		enable01 : in std_logic;
		enable10 : in std_logic;
		enable11 : in std_logic;
		src      : out std_logic_vector(1 downto 0);
		out0     : out std_logic_vector(1 downto 0);
		out1     : out std_logic_vector(1 downto 0);
		out2     : out std_logic_vector(1 downto 0);
		out3     : out std_logic_vector(1 downto 0)
	);
end component;

signal src_temp: std_logic_vector(1 downto 0);
signal data0_temp : std_logic_vector(1 downto 0);
signal data1_temp : std_logic_vector(1 downto 0);
signal data2_temp : std_logic_vector(1 downto 0);
signal data3_temp : std_logic_vector(1 downto 0);

begin

    inst_Datapath : Datapath
    port map(
    --      en : IN std_logic;
    --		dst0 : IN std_logic_vector(1 downto 0);
    --		dst1 : IN std_logic_vector(1 downto 0);
    --		dst2 : IN std_logic_vector(1 downto 0);
        dst   => dst,
        src   => src_temp,
        data0 => data0_temp,
        data1 => data1_temp,
        data2 => data2_temp,
        data3 => data3_temp,
        out0  => out0,
        out1  => out1,
        out2  => out2,
        out3  => out3
    --		u : OUT std_logic_vector(1 downto 0)
    );
    
    inst_UC : ControlUnit
    port map(
		data0    => data0,
		data1    => data1,
		data2    => data2,
		data3    => data3,
		enable00 => enable00,
		enable01 => enable01,
		enable10 => enable10,
		enable11 => enable11,
		src      => src_temp,
		out0     => data0_temp,
		out1     => data1_temp,
		out2     => data2_temp,
		out3     => data3_temp
	);

end Structural;
