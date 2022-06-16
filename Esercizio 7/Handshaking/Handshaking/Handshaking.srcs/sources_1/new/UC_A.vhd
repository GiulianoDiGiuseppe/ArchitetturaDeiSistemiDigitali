----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: UC_A
-- Module Name: UC_A - Behavorial
-- Project Name: Handshaking_A_B
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

entity UC_A is
    Port (
        CLK_UC_A : in std_logic;
        RST_UC_A: in std_logic;
        --segnali di controllo
        in_received_UC_A : in STD_LOGIC;
        in_ready_UC_A : out STD_LOGIC := '0';
        ---gestione del contatore
        count_in_UC_A : out STD_LOGIC := '0';
        count_end_UC_A : in STD_LOGIC;
        ---leggo dalla ROM
        read_mem : out STD_LOGIC := '1'
    );
end UC_A;

architecture Behavioral of UC_A is

    type state is (idle, send_req, wait_ack);
    signal current_state : state := idle;
      
begin

    p : process (CLK_UC_A, RST_UC_A)
    begin
    --automa UC_A
        if(RST_UC_A = '1') then
            current_state <= idle;
        
        elsif(CLK_UC_A'event AND CLK_UC_A = '1') then
            case current_state is
            
				when idle =>
							  
					if (count_end_UC_A = '0') then
					  current_state <= send_req;
					  count_in_UC_A <= '0';
					  in_ready_UC_A <= '1';
					  read_mem <= '0';

					else
					  current_state <= idle;
					  count_in_UC_A <= '0';
					  in_ready_UC_A <= '0';
					  read_mem <= '0';
						
					end if;
			
				when send_req =>
				
					if(in_received_UC_A = '1') then
					  current_state <= wait_ack;
					  count_in_UC_A <= '1';
					  in_ready_UC_A <= '0';
					  read_mem <= '0';
					  					  
					else
					  current_state <= send_req;
					  count_in_UC_A <= '0';
					  in_ready_UC_A <= '1';
					  read_mem <= '0';
					  
					end if;
					
				when wait_ack =>
				
					if (in_received_UC_A = '0') then
					  current_state <= idle;
					  count_in_UC_A <= '0';
					  in_ready_UC_A <= '0';
					  read_mem <= '1';
					  
					else
					  current_state <= wait_ack;
					  count_in_UC_A <= '0';
					  in_ready_UC_A <= '0';
					  read_mem <= '0';
					   
					end if;					
					
				when others =>
					current_state <= idle;
	
			end case;
        end if;   
    end process;

end Behavioral;
