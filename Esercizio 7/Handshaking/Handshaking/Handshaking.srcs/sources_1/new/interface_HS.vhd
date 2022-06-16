----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: Interface
-- Module Name: Interface - Structural
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

entity interface_HS is
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
end interface_HS;

architecture Structural of interface_HS is

component FSM_A
PORT (
    CLK : in std_logic;
    RST : in std_logic;
    in_data_fsm_A: in std_logic_vector(M-1 downto 0);
    word_buffer: out std_logic_vector(M-1 downto 0);
    in_ready : in std_logic;
    in_received : out std_logic;
    buffer_picked : in std_logic;    
    buffer_full : out std_logic
);
END component;

component FSM_B
PORT (
    CLK : in std_logic;
    RST : in std_logic;
    out_data_fsm_B: out std_logic_vector(M-1 downto 0);
    word_buffer: in std_logic_vector(M-1 downto 0);
    out_ready : out std_logic;
    out_received : in std_logic;
    buffer_full : in std_logic;
    buffer_picked : out std_logic
);
END component;

--segnali interni
signal count: std_logic := '0';
signal buffer_full_signal: std_logic := '0';
signal buffer_picked_signal: std_logic := '0';
signal exchange_word_buffer: std_logic_vector(M-1 downto 0);

begin

    FSMA : FSM_A
    port map (
        CLK => CLK_A,
        RST => RST_A,
        in_data_fsm_A => in_data,
        word_buffer => exchange_word_buffer,
        in_ready => in_ready,
        in_received => in_received,
        buffer_picked => buffer_picked_signal,   
        buffer_full => buffer_full_signal
    );

        
    FSMB : FSM_B
    port map (
        CLK => CLK_B,
        RST => RST_B,
        out_data_fsm_B => out_data,
        word_buffer => exchange_word_buffer,
        out_ready => out_ready,
        out_received => out_received,
        buffer_picked => buffer_picked_signal,   
        buffer_full => buffer_full_signal
    );

END structural;
