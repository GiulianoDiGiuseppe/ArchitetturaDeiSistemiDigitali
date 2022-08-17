----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: RegisterSAQ
-- Module Name: RegisterSAQ - Behavioral
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

entity RegisterSAQ is
	generic( N	: integer := 8);
	port(	CLOCK			:	in		STD_LOGIC;	-- Clock
			RESET 		:	in		STD_LOGIC;	-- Reset
			X_INIT		:	in		STD_LOGIC_VECTOR(2*N-2 downto 0);	-- Ingresso inizializzazione
			X_SA			:	in		STD_LOGIC_VECTOR(N downto 0);	-- Ingresso SA
			X_Q			:	in		STD_LOGIC;	-- Ingresso Q
			INIT			:	in		STD_LOGIC;	-- Segnale inizializzazione
			LOAD_SA		:	in		STD_LOGIC;	-- Segnale caricamento SA
			LOAD_Q		:	in		STD_LOGIC;	-- Segnale caricamento Q(0)
			SHIFT			:	in		STD_LOGIC;	-- Segnale shift
			Y				:	out	STD_LOGIC_VECTOR(2*N+1 downto 0));	-- Contenuto del registro
end RegisterSAQ;

architecture behavioral of RegisterSAQ is
	
	signal Y_TEMP	:	STD_LOGIC_VECTOR(2*N+1 downto 0);
	
	begin
		REG_SAQ : process(CLOCK, RESET)
		begin
			if(RESET = '1') then	
				Y_TEMP	<= (others => '0');
			elsif(falling_edge(CLOCK)) then
				if(INIT = '1') then	-- Inizializzazione
					Y_TEMP <= "000" & X_INIT;
				end if;	
				if(LOAD_SA = '1') then	-- Caricamento S e A
					Y_TEMP(2*N downto N) <= X_SA;
				end if;
				if(LOAD_Q = '1') then	-- Caricamento Q(0)
					Y_TEMP(0) <= X_Q;
				end if;
				if(SHIFT = '1') then	-- Left shift
--					Y_TEMP(0) <= '0';
					Y_TEMP(2*N+1 downto 1) <= Y_TEMP(2*N downto 0);
				end if;
			end if;
		end process REG_SAQ;
			
		Y <= Y_TEMP;

end behavioral;