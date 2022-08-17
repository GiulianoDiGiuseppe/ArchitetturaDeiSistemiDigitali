----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: RCA_Nbit
-- Module Name: RCA_Nbit - Structural
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

entity RCA_Nbit is 
	generic(	n : POSITIVE := 8);
	port(	A		: in	STD_LOGIC_VECTOR (n-1 downto 0);
			B		: in	STD_LOGIC_VECTOR (n-1 downto 0); 
			CIN	: in	STD_LOGIC;
			S		: out	STD_LOGIC_VECTOR (n-1 downto 0);
			COUT	: out STD_LOGIC); 
end RCA_Nbit;

architecture structural of RCA_Nbit is

	component FULL_ADDER
		port(	X		: in STD_LOGIC;
				Y		: in STD_LOGIC;
				C_IN	: in STD_LOGIC;          
				Z		: out STD_LOGIC;
				C_OUT : out STD_LOGIC);
	end component;

	signal C : STD_LOGIC_VECTOR (n-2 downto 0);

	begin
		FULL_ADDER_ALL	: for i in 0 to n-1 generate
			LEAST: if i = 0 generate
				l: FULL_ADDER 
					port map(	X		=> A(i), 
									Y 		=> B(i),
									C_IN	=> CIN,
									C_OUT	=> C(i),
									Z		=> S(i));
				end generate;
				
			REST: if (i > 0 and i < n-1) generate
				r: FULL_ADDER 
					port map(	X		=> A(i),
									Y		=> B(i),
									C_IN	=> C(i-1),
									C_OUT	=> C(i),
									Z		=> S(i));
				end generate;
			
			MOST: if i = n-1 generate
				M: FULL_ADDER 
					port map(	X		=> A(i), 
									Y		=> B(i),
									C_IN	=> C(i-1),
									C_OUT	=> COUT,
									Z		=> S(i));
					end generate;
			end generate;
			
end structural;
