----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2022 08:53:39
-- Design Name: 
-- Module Name: Top_module - Behavioral
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

entity Top_module is
Port (clk1, clk2 : in std_logic;
           start: in std_logic  );
end Top_module;

architecture Behavioral of Top_module is

component SistemaA is
--  Port ( );
    port(
           clk : in std_logic;
           start: in std_logic;
           syn , data_s , sel : out STD_LOGIC:= '0';
           ack : in STD_LOGIC;
           data_p : out std_logic_vector (0 to 7) 
    );
end component;

component SistemaB is
    port(
           clk , sel : in std_logic;
           syn , data_s : in STD_LOGIC;
           ack : out STD_LOGIC;
           data_p: in  std_logic_vector (0 to 7)
    );
           
end component;

signal t_syn, t_data_s , t_sel , t_ack  :STD_LOGIC:= '0';
signal t_data_p :  std_logic_vector (0 to 7) ;

begin

a: SistemaA port map (clk1 ,start ,  t_syn, t_data_s , t_sel ,t_ack,t_data_p);
b : SistemaB port map (clk2 ,t_sel,t_syn,t_data_s,t_ack,t_data_p);

end Behavioral;
