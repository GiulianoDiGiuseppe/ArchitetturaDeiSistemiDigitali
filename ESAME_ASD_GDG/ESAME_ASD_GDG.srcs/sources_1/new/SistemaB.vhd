----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2022 15:47:58
-- Design Name: 
-- Module Name: SistemaB - Behavioral
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

entity SistemaB is
    port(
           clk , sel : in std_logic;
           syn , data_s : in STD_LOGIC;
           ack : out STD_LOGIC;
           data_p: in  std_logic_vector (0 to 7)
    );
           
end SistemaB;

architecture Behavioral of SistemaB is

component Interface_B is
--  Port ( );
port(
           clk , sel : in std_logic;           
           en_cont_n , en_rom, en_sh ,en_cont_b  : out std_logic; 
           syn  : in STD_LOGIC;
           ack  : out STD_LOGIC;
           counter : in STD_LOGIC_VECTOR(0 TO 3)
);
end component;

component counter_B is
    Port ( clk : in STD_LOGIC;
           en_b : in STD_LOGIC; -- sar√  ready
           counter : out STD_LOGIC_VECTOR(0 TO 3)
           );
end component;

component MEM_B is
    Port ( data_sh , data_p : in STD_LOGIC_VECTOR (0 to 7);
           counter : in std_logic_vector ( 0 to 3);
            clk , en, sel: in STD_LOGIC
           ); 
end component;

component counter_N is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC; -- sar√  ready
           counter : out STD_LOGIC_VECTOR(0 TO 3)
           );
end component;

component Shift_Register_b is
  Port (
        clk, en_sh   : in std_logic;
        data_out : out std_logic_vector( 0 to 7);
        counter : in STD_LOGIC_VECTOR(0 TO 3);
        data : in  std_logic
        );
end component;


signal  t_en_cont_n , t_en_cont_b , t_en_rom, t_en_sh ,t_en_bit, t_en_mux: std_logic;
signal data_s_out ,data_p_out ,data_fin: std_logic_vector( 0 to 7);
signal  cnt_n, cnt_b :  STD_LOGIC_VECTOR(0 TO 3);

begin
intB : Interface_B port map (clk , sel ,t_en_cont_n ,t_en_rom ,t_en_sh , t_en_cont_b , syn , ack,cnt_b);
--intB : Interface_B port map (clk ,sel, t_en_cont_b ,t_en_cont_n , t_en_rom, t_en_sh ,t_en_bit, t_en_mux , syn , ack);
conter_b : counter_B port map (clk,t_en_cont_b ,cnt_b);
MEMO_B : MEM_B port map(data_s_out, data_p ,cnt_n,clk,t_en_rom , sel);
conter_n : counter_N port map(clk,t_en_cont_n , cnt_n);
shift : Shift_Register_b port map (clk, t_en_sh ,data_s_out ,cnt_b,data_s );



end Behavioral;
