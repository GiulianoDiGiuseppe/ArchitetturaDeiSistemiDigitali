----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 21.01.2022
-- Design Name: Switch_Handshaking
-- Module Name: Switch_Handshaking - Structural
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switch_Handshaking is
  Port ( 
        clkA, rstA : in std_logic;
        clkB, rstB : in std_logic;
        enable     : in std_logic;
        src        : in std_logic_vector(1 downto 0);
        dst        : in std_logic_vector(1 downto 0);
        data       : in std_logic_vector(1 downto 0);
        dataout    : out std_logic_vector(1 downto 0)
  );
end Switch_Handshaking;

architecture Structural of Switch_Handshaking is

component Datapath is
	PORT(
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
	);
end component;

component nodo_A is
  Port ( 
        clk, rst        : in std_logic;
        enable          : in std_logic;
        pronto_ricevere : in std_logic;
        src_in          : in std_logic_vector(1 downto 0);
        data_in         : in std_logic_vector(1 downto 0);
        src_out         : out std_logic_vector(1 downto 0);
        data_out        : out std_logic_vector(1 downto 0);
        pronto_inviare  : out std_logic
  );
end component;

component nodo_B is
  Port ( 
        clk, rst        : in std_logic;
        pronto_inviare  : in std_logic;
        data_out        : in std_logic_vector(1 downto 0);
        dst_in          : in std_logic_vector(1 downto 0);
        dst_out         : out std_logic_vector(1 downto 0);
        pronto_ricevere : out std_logic
  );
end component;

component Mux4_1 is
	port(
		a0 	: in std_logic_vector(1 downto 0);
		a1 	: in std_logic_vector(1 downto 0);
		a2 	: in std_logic_vector(1 downto 0);
		a3 	: in std_logic_vector(1 downto 0);
		sel	: in std_logic_vector(1 downto 0);
		u  	: out std_logic_vector(1 downto 0)
	);
end component;

component Demux1_4 is
port(
		sel	: in std_logic_vector(1 downto 0);
		i  	: in std_logic_vector(1 downto 0);
		u0 	: out std_logic_vector(1 downto 0);
		u1 	: out std_logic_vector(1 downto 0);
		u2 	: out std_logic_vector(1 downto 0);
		u3 	: out std_logic_vector(1 downto 0)
	);
end component;

signal pronto_ricevere_temp, pronto_inviare_temp: std_logic; 
signal dst_temp, src_temp: std_logic_vector(1 downto 0);
signal data_temp: std_logic_vector(1 downto 0);
signal temp: std_logic_vector(1 downto 0);
signal data0_temp: std_logic_vector(1 downto 0);
signal data1_temp: std_logic_vector(1 downto 0);
signal data2_temp: std_logic_vector(1 downto 0);
signal data3_temp: std_logic_vector(1 downto 0);
signal out0_temp: std_logic_vector(1 downto 0);
signal out1_temp: std_logic_vector(1 downto 0);
signal out2_temp: std_logic_vector(1 downto 0);
signal out3_temp: std_logic_vector(1 downto 0);

begin
    
    dataout <= temp;
     
    inst_Switch_Multistadio : Datapath
    Port map (
        dst   => dst_temp,
		src   => src_temp,
		data0 => data0_temp,
		data1 => data1_temp,
		data2 => data2_temp,
		data3 => data3_temp,
		out0  => out0_temp,
		out1  => out1_temp,
		out2  => out2_temp,
		out3  => out3_temp
    );
    
    inst_A : nodo_A
    Port Map ( 
        clk             => clkA,
        rst             => rstA,
        enable          => enable,
        pronto_ricevere => pronto_ricevere_temp,
        src_in          => src,
        src_out         => src_temp,
        data_in         => data,
        data_out        => data_temp,
        pronto_inviare  => pronto_inviare_temp
    );
    
    inst_B : nodo_B
    Port Map ( 
        clk             => clkB,
        rst             => rstB,
        pronto_ricevere => pronto_ricevere_temp,
        dst_in          => dst,
        dst_out         => dst_temp,
        data_out        => temp,
        pronto_inviare  => pronto_inviare_temp
    );
    
    inst_Mux4_1 : Mux4_1
    Port Map(
		a0 	=> out0_temp,
		a1 	=> out1_temp,
		a2 	=> out2_temp,
		a3 	=> out3_temp,
		sel	=> dst_temp,
		u  	=> temp
	);
    
    inst_Demux1_4 : Demux1_4
    Port Map(
		u0 	=> data0_temp,
		u1 	=> data1_temp,
		u2 	=> data2_temp,
		u3 	=> data3_temp,
		sel	=> src_temp,
		i  	=> data_temp
	);
	
end Structural;
