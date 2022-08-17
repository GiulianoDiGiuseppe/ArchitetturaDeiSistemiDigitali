----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: UC_A
-- Module Name: UC_A - Behavioral
-- Project Name: Interfaccia_Seriale_handshaking
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
PORT (
        CLK_UC_A : in std_logic;
        RST_UC_A: in std_logic;
        --
        SR_ACK: in std_logic;
        DONE: in std_logic;
        WR_IN: in std_logic;
        CONT_START_UC_A: out std_logic;
        SR : out std_logic := '0';
        LOAD : out std_logic
    );
end UC_A;

architecture Behavioral of UC_A is

 type state is (idle, send_request, write_strobe, wait_done);
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
                              
                    CONT_START_UC_A <= '0'; 
                    LOAD <= '0';
                    SR <= '0';
                    if (WR_IN = '1') then
                        current_state <= send_request;
                    else
                        current_state <= idle;
                    end if;
                    
                when send_request =>
                
                    CONT_START_UC_A <= '0'; 
                    LOAD <= '0';
                    SR <= '1';
                    if (SR_ACK = '0') then
                        current_state <= send_request;
                    else
                        current_state <= write_strobe; 
                    end if;
               
                when write_strobe =>
                
                    CONT_START_UC_A <= '1';
                    LOAD <= '1';
                    SR <= '0';
                    current_state <= wait_done;
                
                WHEN wait_done =>
                
                    CONT_START_UC_A <= '0';
                    LOAD <= '0';
                    SR <= '0';
                    if (DONE = '0') then
                        current_state <= wait_done;
                    else
                        current_state <= idle;
                    end if;
            end case;
    
        end if;   
    end process;

end Behavioral;
