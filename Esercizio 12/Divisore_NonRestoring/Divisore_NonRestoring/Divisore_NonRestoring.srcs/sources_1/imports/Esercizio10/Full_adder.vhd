----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Full_adder
-- Module Name: Full_adder - Dataflow
-- Project Name: Divisore_NonRestoring
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

entity FULL_ADDER is
	port(	X		: in STD_LOGIC;
			Y 		: in STD_LOGIC;
			C_IN	: in STD_LOGIC;
			Z		: out STD_LOGIC;
			C_OUT	: out STD_LOGIC);
end FULL_ADDER;

architecture dataflow of FULL_ADDER is

begin
	Z		<= X XOR Y XOR C_IN;
	C_OUT	<= (X AND Y) OR (C_IN AND (X XOR Y));

end dataflow;
