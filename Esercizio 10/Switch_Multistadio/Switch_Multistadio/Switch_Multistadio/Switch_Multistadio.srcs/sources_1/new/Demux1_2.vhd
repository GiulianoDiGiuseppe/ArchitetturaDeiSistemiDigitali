----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2022 09:37:05
-- Design Name: 
-- Module Name: Demux1_2 - Behavioral
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