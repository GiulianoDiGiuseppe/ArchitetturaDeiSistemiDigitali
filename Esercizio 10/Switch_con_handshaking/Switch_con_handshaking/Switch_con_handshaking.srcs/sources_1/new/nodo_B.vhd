----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 21.01.2022
-- Design Name: nodo_B
-- Module Name: nodo_B - Behavioral
-- Project Name: Switch_con_handshaking
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

entity nodo_B is
  Port ( 
        clk, rst        : in std_logic;
        pronto_inviare  : in std_logic;
        data_out        : in std_logic_vector(1 downto 0);
        dst_in          : in std_logic_vector(1 downto 0);
        dst_out         : out std_logic_vector(1 downto 0);
        pronto_ricevere : out std_logic
  );
end nodo_B;

architecture Behavioral of nodo_B is

type state is( idle, ricevi_richiesta, invia_risposta);
signal current_state : state := idle;

begin
    
    p : process (clk, rst)
    begin
    --automa nodo_A
        if(rst = '1') then
            current_state <= idle;
        
        elsif(clk'event AND clk = '1') then
        
            case current_state is
            
                when idle => 
                
                dst_out <= "--"; 
                pronto_ricevere <= '0';
                if (pronto_inviare = '1') then
                    current_state <= ricevi_richiesta;
                else
                    current_state <= idle;
                end if;
                
                when ricevi_richiesta =>
                
                    dst_out <= "--"; 
                    pronto_ricevere <= '1';
                    current_state <= invia_risposta;
                    
                when invia_risposta =>
                
                    dst_out <= dst_in; 
                    pronto_ricevere <= '0';
                    current_state <= idle;
                    
            end case;
            
        end if;
    end process;


end Behavioral;
