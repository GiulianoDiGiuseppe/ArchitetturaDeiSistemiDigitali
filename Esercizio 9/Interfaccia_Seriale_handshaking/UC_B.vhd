----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: UC_B
-- Module Name: UC_B - Behavioral
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

entity UC_B is
    PORT (
        CLK_UC_B : in std_logic; -- clock della board
        RST_UC_B: in std_logic;
        ---gestione del contatore
        RDA : in STD_LOGIC;
        SR : in std_logic;
        count_start_UC_B : out STD_LOGIC;
        REQACK: out std_logic;
        DONE: out std_logic;
        write_enable : out STD_LOGIC
    );
end UC_B;

architecture Behavioral of UC_B is

    type state is (idle, send_ack, wait_rda, read_done, write_done);
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
                
                count_start_UC_B <= '0';
                REQACK <= '0';
                DONE <= '0';
                if (SR = '0') then
                    current_state <= idle ;
                else
                    current_state <= send_ack; 
                end if;
                
                WHEN send_ack =>
                    
                    count_start_UC_B <= '0';
                    REQACK <= '1';
                    DONE <= '0';
                    current_state <= wait_rda;
                
                WHEN wait_rda =>
                    
                    count_start_UC_B <= '0';
                    REQACK <= '1';
                    DONE <= '0';
                    if (RDA = '0') then
                        current_state <= wait_rda;
                    else
                        current_state <= read_done; 
                    end if;
                
                WHEN read_done => 
                
                    write_enable <= '1';
                    count_start_UC_B <= '1';
                    REQACK <= '0';                      
                    DONE <= '0';
                    current_state <= write_done;
        
                WHEN write_done =>
             
                    count_start_UC_B <= '0';
                    REQACK <= '0';
                    write_enable <= '0';
                    DONE <= '1';
                    current_state <= idle;
                    
            end case;
    
        end if;   
    end process;

end Behavioral;
