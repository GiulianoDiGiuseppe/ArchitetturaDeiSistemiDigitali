----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: UC_B
-- Module Name: UC_B - Behavorial
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

entity UC_B is
  Port (
    CLK_UC_B : in std_logic;
    RST_UC_B: in std_logic;
    ---gestione del contatore
    out_received_UC_B : out STD_LOGIC := '0';
    out_ready_UC_B : in STD_LOGIC;
    count_in_UC_B : out STD_LOGIC := '0';
    count_end_UC_B : in STD_LOGIC;
    write_enable : out STD_LOGIC := '0';
    enable_ALU : out STD_LOGIC := '0';
    end_somma_in : in std_logic;
    bit_overflow : in STD_LOGIC 
);
end UC_B;

architecture Behavioral of UC_B is

    type state is (idle, send_ack, wait_req);
    signal current_state : state := idle;
    
begin

    p : process (CLK_UC_B, RST_UC_B)
    begin
    --automa UC_B
        if(RST_UC_B = '1') then
            current_state <= idle;
        
        elsif(CLK_UC_B'event AND CLK_UC_B = '1') then
            case current_state is
            
				when idle =>
				
					if (count_end_UC_B = '0' AND out_ready_UC_B = '1') then
					  current_state <= send_ack;
					  write_enable <= '0';
					  enable_ALU <= '1';
					  out_received_UC_B <= '0';
					  count_in_UC_B <= '0';
					
					else
					  current_state <= idle;
						
					end if;
			
				when send_ack =>
				
					if(end_somma_in = '1') then
					  current_state <= wait_req;
					  write_enable <= '1';
					  enable_ALU <= '0';
					  out_received_UC_B <= '1';
					  count_in_UC_B <= '1';
					
					else
					  current_state <= send_ack;
					  write_enable <= '0';
					  enable_ALU <= '1';
					  out_received_UC_B <= '0';
					  count_in_UC_B <= '0';
					  
					end if;
					
				when wait_req =>
				
					if(out_ready_UC_B = '1') then
					  current_state <= idle;
					  write_enable <= '0';
					  enable_ALU <= '0';
					  out_received_UC_B <= '0';
					  count_in_UC_B <= '0';
					  
					else
					  current_state <= wait_req;
					  write_enable <= '1';
					  enable_ALU <= '0';
					  out_received_UC_B <= '1';
					  count_in_UC_B <= '0';
					  
					end if;					
					
				when others =>
					current_state <= idle;
	
			end case;
    
        end if;   
    end process;

end Behavioral;
