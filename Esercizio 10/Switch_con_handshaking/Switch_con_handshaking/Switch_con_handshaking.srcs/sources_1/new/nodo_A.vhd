----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 21.01.2022
-- Design Name: nodo_A
-- Module Name: nodo_A - Behavioral
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

entity nodo_A is
  Port ( 
        clk, rst        : in std_logic;
        enable          : in std_logic;
        pronto_ricevere : in std_logic;
        src_in          : in std_logic_vector(1 downto 0);
        data_in         : in std_logic_vector(1 downto 0);
        src_out         : out std_logic_vector(1 downto 0);
        data_out        : out std_logic_vector(1 downto 0);
        pronto_inviare  : out std_logic
  );
end nodo_A;

architecture Behavioral of nodo_A is 

type state is( idle, invia_richiesta, aspetta_risposta, invia);
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
                
                src_out <= "--"; 
                data_out <= "--";
                pronto_inviare <= '0';
                if (enable = '1') then
                    current_state <= invia_richiesta;
                else
                    current_state <= idle;
                end if;
                
                when invia_richiesta =>
                
                    src_out <= "--"; 
                    data_out <= "--";
                    pronto_inviare <= '1';
                    current_state <= aspetta_risposta;
                    
                when aspetta_risposta =>
                
                    src_out <= "--"; 
                    data_out <= "--";
                    pronto_inviare <= '1';
                    if (pronto_ricevere = '1') then
                        current_state <= invia;
                    else
                        current_state <= aspetta_risposta;
                    end if;
                    
                when invia =>
                
                    src_out <= src_in; 
                    data_out <= data_in;
                    pronto_inviare <= '0';
                    current_state <= idle;
                    
            end case;
            
        end if;
    end process;
    
end Behavioral;
