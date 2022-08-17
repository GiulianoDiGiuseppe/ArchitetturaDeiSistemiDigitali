----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: StartDivisione
-- Module Name: StartDivisione - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity StartDivisione is
	generic (N : integer := 8);
	port (CLOCK : in STD_LOGIC;
			RESET : in STD_LOGIC;
			X : in STD_LOGIC_VECTOR(N-1 downto 0); --switch
			Y : in STD_LOGIC_VECTOR(N-1 downto 0); --switch
			BTN_START : in STD_LOGIC;
			SAQ : out STD_LOGIC_VECTOR(2*N-2 downto 0);  -- dividendo
			M : out STD_LOGIC_VECTOR(N-1 downto 0);	 -- divisore		
			START : out STD_LOGIC;
			ENABLE_SAQ : out STD_LOGIC;
			ENABLE_M : out STD_LOGIC;
			ERR : out STD_LOGIC
			);
end StartDivisione;

architecture Behavioral of StartDivisione is

	signal ERR_TEMP : STD_LOGIC;
	signal M_TEMP : STD_LOGIC_VECTOR(N-1 downto 0);
	
	constant CONST : integer := 0;
	begin
		PROC : process (CLOCK, RESET )
		variable i : integer := 0;
		begin

        	if(RESET = '1') then
				SAQ <= (others =>'0');
				M	<=(others =>'0');
				ENABLE_SAQ <= '1';
				ENABLE_M <= '1';
				ERR_TEMP <= '0';	
				i := 0;
			elsif(rising_edge(CLOCK)) then ---qui ci mette il DIVIDENDO
				    if(BTN_START = '1' and i = 0) then
                        SAQ <= "0000000" & X;
                        ENABLE_SAQ <= '1';
                        M <= Y; 
                        M_TEMP <= Y;
                        ENABLE_M <= '1';
                        i := 1;
				    elsif(i = 1) then
                        if (M_TEMP = std_logic_vector(to_unsigned(CONST, M_TEMP' length))) then
                            ERR_TEMP <= '1'; --divisione con lo 0 grande error
                        else 
                            START<= '1';
                            ERR_TEMP <= '0';
                        end if;
                        ENABLE_SAQ <= '0';
                        ENABLE_M <= '0';
                        i := 0;
                    else
                        ENABLE_SAQ <= '0';
                        ENABLE_M <= '0';
                        START <= '0'; 
                    end if;
                end if;
            end process;

		ERR <= ERR_TEMP;
			
end Behavioral;
