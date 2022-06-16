----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: FSM_A
-- Module Name: FSM_A - Behavorial
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

entity FSM_A is
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port (
        CLK : in std_logic;
        RST : in std_logic;
        in_data_fsm_A: in std_logic_vector(M-1 downto 0);
        word_buffer: out std_logic_vector(M-1 downto 0);
        in_ready : in std_logic;
        in_received : out std_logic := '0';
        buffer_picked : in std_logic;    
        buffer_full : out std_logic := '0'
    );
end FSM_A;

architecture Behavioral of FSM_A is

    type state is (idle, wait_buffer, wait_data);
    signal current_state : state := idle;
    
begin

    fsm_a: process(CLK, RST)
        variable count : integer range 0 to 1 := 0;
    begin
        if (RST = '1') then
            current_state <= idle;
            
        elsif (CLK'event AND CLK = '1') then
            case current_state is
                when idle =>
                    
                    if(in_ready = '1') then
                        current_state <= wait_buffer;
                        word_buffer <= in_data_fsm_A;
                        buffer_full <= '1';
                        in_received <= '0';
                        
                    else
                        current_state <= idle;
                        buffer_full <= '0';
                        in_received <= '0';
                        
                    end if;
                
                when wait_buffer =>
                    
                    if(buffer_picked = '1') then
                        current_state <= wait_data;
                        buffer_full <= '0';
                        in_received <= '1';
                        
                    else
                        current_state <= wait_buffer;
                        buffer_full <= '1';
                        in_received <= '0';
                        
                    end if;
                    
                when wait_data =>
                    
                    if(in_ready = '1') then
                        current_state <= idle;
                        buffer_full <= '0';
                        in_received <= '0';
                        
                    else
                        current_state <= wait_data;
                        buffer_full <= '0';
                        in_received <= '0';
                        
                    end if;
                    
               when others =>
                        current_state <= idle;     
					                       
            end case;
        end if;
    end process;

end Behavioral;
