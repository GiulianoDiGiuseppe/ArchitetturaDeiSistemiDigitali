----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.01.2022
-- Design Name: Cell
-- Module Name: Cell - Structural
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

entity Cell is
port(
        --ingressi
		a0 	: in std_logic_vector(1 downto 0);
		a1 	: in std_logic_vector(1 downto 0);
		src	: in std_logic;	
        dst : in std_logic;
		--uscite
		u0 	: out std_logic_vector(1 downto 0);
		u1 	: out std_logic_vector(1 downto 0)	
	);
end Cell;

architecture Structural of Cell is

	COMPONENT Mux2_1
	PORT(
		a0 : IN std_logic_vector(1 downto 0);
		a1 : IN std_logic_vector(1 downto 0);
		sel: IN std_logic;        
		u  : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Demux1_2
	PORT(
		i  : IN std_logic_vector(1 downto 0);
		sel: IN std_logic;     
		u0 : OUT std_logic_vector(1 downto 0);
		u1 : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	signal temp : std_logic_vector(1 downto 0);
	
begin

	Inst_Mux2_1: Mux2_1 PORT MAP(
		a0 => a0,
		a1 => a1,
		sel => src,
		u => temp
	);
	
	
	Inst_Demux1_2: Demux1_2 PORT MAP(
		i => temp,
		sel => dst,
		u0 => u0,
		u1 => u1 
	);
	
end Structural;
