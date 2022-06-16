----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: FSM_B
-- Module Name: FSM_B - Behavorial
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

entity FSM_B is
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port (
        CLK : in std_logic;
        RST : in std_logic; 
        out_data_fsm_B: out std_logic_vector(M-1 downto 0);
        word_buffer: in std_logic_vector(M-1 downto 0);
        out_ready : out std_logic := '0';
        out_received : in std_logic;
        buffer_full : in std_logic;
        buffer_picked : out std_logic := '0'
    );
end FSM_B;

architecture Behavioral of FSM_B is

    type state is (idle, wait_data, wait_buffer);
    signal current_state : state := idle;
    
begin

    fsm_b: process(CLK,RST)
    begin
        if (RST = '1') then
            current_state <= idle;
            
        elsif (CLK'event AND CLK = '1') then
            case current_state is
                when idle =>
                    
                    if(buffer_full = '1') then
                        current_state <= wait_data;
                        out_data_fsm_B <= word_buffer;
                        out_ready <= '1';
                        buffer_picked <= '1';
        
                    else
                        current_state <= idle;
                        buffer_picked <= '0';
                        out_ready <= '0';
                        
                    end if;
                
                when wait_data =>
                    
                    if(out_received = '1') then
                        current_state <= wait_buffer;
                        buffer_picked <= '0';
                        out_ready <= '0';
                        
                    else
                        current_state <= wait_data;
                        buffer_picked <= '0';
                        out_ready <= '1';
                        
                    end if;
                    
                when wait_buffer =>
                    
                    if(buffer_full = '1') then
                        current_state <= idle;
                        buffer_picked <= '0';
                        out_ready <= '0';
                        
                    else
                        current_state <= wait_buffer;
                        buffer_picked <= '0';
                        out_ready <= '0';
                        
                    end if;
                    
               when others =>
                        current_state <= idle;     
                                                   
            end case;
        end if;
    end process;

end Behavioral;
