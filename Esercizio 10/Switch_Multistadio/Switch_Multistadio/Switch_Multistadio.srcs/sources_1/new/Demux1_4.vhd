----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 20.01.2022
-- Design Name: Demux1_4
-- Module Name: Demux1_4 - Dataflow
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Demux1_4 is
port(
		sel	: in std_logic_vector(1 downto 0);
		i  	: in std_logic_vector(1 downto 0);
		u0 	: out std_logic_vector(1 downto 0);
		u1 	: out std_logic_vector(1 downto 0);
		u2 	: out std_logic_vector(1 downto 0);
		u3 	: out std_logic_vector(1 downto 0)
	);
end Demux1_4;

architecture dataflow of Demux1_4 is

begin

	u0 <= i when sel = "00" else 
			"00";
	u1 <= i when sel = "01" else 
			"00";
	u2 <= i when sel = "10" else 
			"00";
	u3 <= i when sel = "11" else 
			"00";
			
end dataflow;
