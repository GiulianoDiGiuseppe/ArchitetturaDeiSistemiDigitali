----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: Handshaking_A_B
-- Module Name: Handshaking_A_B - Structural
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity handshaking_A_B is
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port (
    clk_A : in std_logic;
    clk_B : in std_logic;
    rst_A : in std_logic;
    rst_B : in std_logic
    );
end handshaking_A_B;

architecture Structural of handshaking_A_B is

component entity_A
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port ( 
        clk_A : in STD_LOGIC;
        rst_A : in STD_LOGIC;
        --- dall'interfaccia
        in_received : in STD_LOGIC;
        in_data : out std_logic_vector(M-1 downto 0);
        in_ready : out std_logic
    );
end component;

component entity_B
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port ( 
        clk_B : in STD_LOGIC;
        rst_B : in STD_LOGIC;
        --- dall'interfaccia
        out_received : out STD_LOGIC;
        out_data : in std_logic_vector(M-1 downto 0);
        out_ready : in std_logic
    );
end component;

component interface_HS
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port ( 
        CLK_A : in std_logic;
        RST_A : in std_logic;
        CLK_B : in std_logic;
        RST_B : in std_logic;
        in_received : out STD_LOGIC;
        in_data : in std_logic_vector(M-1 downto 0);
        in_ready : in std_logic;
        out_received : in STD_LOGIC;
        out_data : out std_logic_vector(M-1 downto 0);
        out_ready : out std_logic
    );
end component;

--segnali interni
signal indata : std_logic_vector(M-1 downto 0);
signal outdata : std_logic_vector(M-1 downto 0);
signal inready, inreceived, outready, outreceived : std_logic;

begin

    A_ENTITY : entity_A
    generic map (
        M => 8,
        N => 8
    )
    port map (
        clk_A => clk_A,
        rst_A => rst_A,
        in_received => inreceived,
        in_data => indata,
        in_ready => inready
    );
    
      
    B_ENTITY : entity_B
    generic map (
        M => 8,
        N => 8
    )
    port map (
        clk_B => clk_B,
        rst_B => rst_B,
        out_received => outreceived,
        out_data => outdata,
        out_ready => outready
    );
    
    INTERFACE : interface_HS
    generic map(
       N => 8,
       M => 8
    )
    Port map( 
        CLK_A => clk_A,
        RST_A => rst_A,
        CLK_B => clk_B,
        RST_B => rst_B,
        in_received => inreceived,
        in_data => indata,
        in_ready => inready,
        out_received => outreceived,
        out_data => outdata,
        out_ready => outready
    );


end Structural;
