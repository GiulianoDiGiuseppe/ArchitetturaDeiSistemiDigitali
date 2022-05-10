----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Unità di controllo
-- Module Name: Unità di controllo - Behavorial
-- Project Name: Cronometro_v4
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity unita_controllo is
	port (
		stop : in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		sel : in std_logic;
		reg_en : out std_logic;
		op : out std_logic
	);
end unita_controllo;

architecture Behavioral of unita_controllo is


type state is (idle, carico_valori);
signal current_state : state := idle;
signal reg_en_temp : std_logic := '0';
signal op_temp : std_logic := '0';
	

begin

	reg_en <= reg_en_temp;
	op <= op_temp;

	p : process(clk, reset)
	
	begin
	
		if(reset = '1') then
			current_state <= idle;
			reg_en_temp <= '0';
			op_temp <= '0';
			
		elsif(clk'event AND clk = '1') then
		
			case current_state is
				when idle =>
							  
					if (stop = '1' AND sel = '0') then
                        current_state <= carico_valori;
                        reg_en_temp <= '1';
                        op_temp <= '1';
					 
					elsif (stop = '0' AND sel = '1') then
						current_state <= carico_valori;
						reg_en_temp <= '1';
						op_temp <= '0';
						
					else
					    current_state <= idle;
					    reg_en_temp <= '0';
					    op_temp <= '0';
						
					end if;
			
				when carico_valori =>
				
					if(stop = '0' and sel = '0') then
					    current_state <= idle;
					  
					else
					    current_state <= carico_valori;
					  
					end if;
					
					reg_en_temp <= '0';
					op_temp <= '0';
					
				when others =>
				
					current_state <= idle;
					reg_en_temp <= '0';
					op_temp <= '0';
				
			end case;
	
		end if;
	
	end process;


end Behavioral;
