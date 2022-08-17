----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2022 15:26:05
-- Design Name: 
-- Module Name: SistemaA - Behavioral
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

entity SistemaA is
--  Port ( );
    port(
           clk : in std_logic;
           start: in std_logic;
           syn , data_s , sel : out STD_LOGIC  := '0';
           ack : in STD_LOGIC;
           data_p : out std_logic_vector (0 to 7) 
    );
end SistemaA;

architecture Behavioral of SistemaA is

component interface_A is port(
           clk : in std_logic;
           start,stop_byte : in std_logic;
           sel: inout std_logic;
           stop : in std_logic_vector(0 to 1 );
           en ,en_sh : out std_logic;
           syn : out STD_LOGIC;
           ack : in STD_LOGIC;
            counter : in STD_LOGIC_VECTOR(0 TO 3)
);
end component;

component MEM_A is port(
            data : out STD_LOGIC_VECTOR (0 to 7);
           counter : in std_logic_vector ( 0 to 3);
            clk , en: in STD_LOGIC;
            sel : out STD_LOGIC
);
end component;

component counter_a is
    Port (clk : in STD_LOGIC;
           en : in STD_LOGIC; -- sar√  ready
           stop : out STD_LOGIC_vector(0 to 1);
           counter : out STD_LOGIC_VECTOR(0 TO 3)
           );
end component;

COMPONENT counter_a_byte is
    Port ( clk : in STD_LOGIC;
           en_b : in STD_LOGIC; -- sar√  ready
           stop : out STD_LOGIC;
           counter : out STD_LOGIC_VECTOR(0 TO 3)
           );
end COMPONENT;

component Shift_Register is
  Port (
        clk, en_sh   : in std_logic;
        data : in std_logic_vector( 0 to 7);
        counter : in STD_LOGIC_VECTOR(0 TO 3);
        data_out : out  std_logic
        );
end component;

signal t_en, t_en_sh, sel_t  ,stop_b : std_logic;
signal stop_n :  std_logic_vector(0 to 1 );
signal data_tmp : std_logic_vector( 0 to 7);
signal data_out : std_logic_vector( 0 to 7);
signal counter_N :  std_logic_vector ( 0 to 3);
signal counter_B :  std_logic_vector ( 0 to 3);
signal	t_data_s 	:  std_logic_vector(7 downto 0);
signal t_data_p 	:  std_logic_vector(7 downto 0);


begin

interface : interface_A port map( clk,start,stop_b,sel_t,stop_n,t_en,t_en_sh,syn,ack,counter_N);
MEMA : MEM_A port map (data_tmp ,counter_n, clk,t_en, sel_t);
contatore_N : counter_a port map (clk , t_en , stop_n , counter_N);
counter_8 :counter_a_byte port  map(clk , t_en_sh, stop_b,counter_B);
shift_a : Shift_Register port map(clk,t_en_sh,data_tmp,counter_B,data_s);

sel<=sel_t;
data_p<=data_tmp;

end Behavioral;
