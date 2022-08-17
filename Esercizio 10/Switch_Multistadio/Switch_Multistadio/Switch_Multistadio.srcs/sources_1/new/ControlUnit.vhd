----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.01.2022
-- Design Name: ControlUnit
-- Module Name: ControlUnit - Structural
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
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
end ControlUnit;

architecture Structural of ControlUnit is

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

component LogicArbiter is
port ( 
        enable00 : in std_logic;
        enable01 : in std_logic;
        enable10 : in std_logic;
        enable11 : in std_logic;
        src      : out std_logic_vector(1 downto 0)
);
end component;

signal src_temp: std_logic_vector(1 downto 0);
signal temp: std_logic_vector(1 downto 0);

begin
    
    src <= src_temp;

	inst_Mux4_1 : Mux4_1
	port map(
		a0 	=> data0,
		a1 	=> data1,
		a2 	=> data2,
		a3 	=> data3,
		sel	=> src_temp,
		u  	=> temp
	);

    inst_Demux1_4 : Demux1_4
    port map(
            sel	=> src_temp,
            i  	=> temp,
            u0 	=> out0,
            u1 	=> out1,
            u2 	=> out2,
            u3 	=> out3
    );

    inst_Arbiter : LogicArbiter
    port map ( 
            enable00 => enable00,
            enable01 => enable01,
            enable10 => enable10,
            enable11 => enable11,
            src      => src_temp
    );

end Structural;
