----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 21.01.2022
-- Design Name: Demux1_2
-- Module Name: Demux1_2 - Dataflow
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

entity Demux1_2 is
	port(
		sel	: in std_logic;
		i  	: in std_logic_vector(1 downto 0);
		u0 	: out std_logic_vector(1 downto 0);
		u1 	: out std_logic_vector(1 downto 0)
	);
end Demux1_2;

architecture dataflow of Demux1_2 is

begin

	u0 <= i when sel = '0' else 
			"00";
	u1 <= i when sel = '1' else 
			"00";

end dataflow;