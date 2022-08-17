----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Unita_Controllo
-- Module Name: Unita_Controllo - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unita_Controllo is
	port(	CLOCK 			: in STD_LOGIC;
			RESET 			: in STD_LOGIC;
			START	   		: in STD_LOGIC;
			S_BUF 			: in STD_LOGIC_VECTOR (1 downto 0);
			COUNT 			: in STD_LOGIC;
			LOAD_SA 		: out STD_LOGIC;
			LOAD_Q			: out STD_LOGIC;
			SHIFT 			: out STD_LOGIC;
			ENABLE_C		: out STD_LOGIC;
			ENABLE_EXIT		: out STD_LOGIC;
			SUB				: out STD_LOGIC;
			INIT_COUNT		: out STD_LOGIC
	);
end Unita_Controllo;

architecture Behavioral of Unita_Controllo is

	type STATE_TYPE is(
		IDLE_S,
		SHIFT_S,
		OP_S,
		LOAD_S,
		EXIT_S,
		CORR_S);
	
-- SEGNALI TEMPORANEI	
	signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

	begin
	
		CURR_STATE_PROC : process(CLOCK,RESET)
		begin
			if(RESET = '1') then 
				CURRENT_STATE <= IDLE_S;
			elsif(rising_edge(CLOCK)) then
                CURRENT_STATE <= NEXT_STATE;
			end if;
		end process CURR_STATE_PROC;
		
		NEXT_STATE_PROC : process(CURRENT_STATE, S_BUF, COUNT, START)
		begin
		
			LOAD_SA 		<= '0';
			LOAD_Q			<= '0';
			SHIFT 			<= '0';
			ENABLE_C		<= '0';
			ENABLE_EXIT		<= '0';
			SUB				<= '1';
			INIT_COUNT 		<= '0';

			
			case CURRENT_STATE is
				when IDLE_S =>
					INIT_COUNT <= '1';
					if (START = '1') then
					   NEXT_STATE <= SHIFT_S;
					else
					   NEXT_STATE <= IDLE_S;
					end if;
				
				when SHIFT_S =>
					SHIFT <= '1';
					ENABLE_C <= '1';
					NEXT_STATE <= OP_S;
					
				when OP_S =>
					if(S_BUF(1) = '0') then
						SUB <= '1'; -- 1 
					elsif(S_BUF(1) = '1') then
						SUB <= '0'; -- 0
					end if;
					NEXT_STATE <= LOAD_S;
				
				when LOAD_S =>
					if(S_BUF(1) = '1') then
						SUB <= '0'; -- 0
					end if;
					
					LOAD_SA <='1';
					LOAD_Q <= '1';
					if(COUNT = '0') then
						NEXT_STATE <= SHIFT_S;
					elsif(COUNT = '1') then 
						NEXT_STATE <= EXIT_S;
					end if;
				
				when EXIT_S =>
					if(S_BUF(0) = '0') then
						ENABLE_EXIT <= '1';
						NEXT_STATE <= IDLE_S;
					elsif(S_BUF(0) = '1') then
						SUB <= '0'; -- 0
						NEXT_STATE <= CORR_S;
					end if;
					
				when CORR_S =>
					SUB <= '0'; -- 0
					LOAD_SA <= '1';
					ENABLE_EXIT <= '1';
					NEXT_STATE <= IDLE_S;
					
			end case;
		end process NEXT_STATE_PROC;
		
end Behavioral;
