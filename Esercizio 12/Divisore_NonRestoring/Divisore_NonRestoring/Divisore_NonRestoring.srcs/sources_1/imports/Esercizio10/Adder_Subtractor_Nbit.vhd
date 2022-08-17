----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: AdderSubtractor
-- Module Name: AdderSubtractor - Structural
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

entity ADDER_SUBTRACTOR_Nbit is
	generic(	N : POSITIVE := 9);
	port(	OP_0		: in STD_LOGIC_VECTOR (N-1 downto 0);
			OP_1		: in STD_LOGIC_VECTOR (N-1 downto 0); 
			SUB		: in STD_LOGIC;
			RIS		: out STD_LOGIC_VECTOR (N-1 downto 0);
			C_OUT		: out STD_LOGIC
	    );
end ADDER_SUBTRACTOR_Nbit;

architecture structural of ADDER_SUBTRACTOR_Nbit is

	component RCA_Nbit
		generic( N : positive);
		port(	A 		: in STD_LOGIC_VECTOR(N-1 downto 0);
				B 		: in STD_LOGIC_VECTOR(N-1 downto 0);
				CIN 	: in STD_LOGIC;          
				S 		: out STD_LOGIC_VECTOR(N-1 downto 0);
				COUT 	: out STD_LOGIC);
	end component;

	signal OP_1_xor : std_logic_vector(N-1 downto 0);

	begin
			
		loo : process (OP_1, SUB)
		begin
			for i in 0 to N-1 loop
				OP_1_xor(i) <= OP_1(i) xor SUB;
			end loop;
		end process;
		
		
		Inst_RCA_Nbit: RCA_Nbit 
			generic map( N => N)
			port map(	A 		=> OP_0,
							B 		=> OP_1_xor,
							S 		=> RIS,
							CIN	=> SUB,
							COUT	=> C_OUT);
		
end structural;
