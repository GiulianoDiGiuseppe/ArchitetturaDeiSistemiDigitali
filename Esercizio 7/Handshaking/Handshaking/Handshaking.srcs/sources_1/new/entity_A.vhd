----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: A_Entity
-- Module Name: A_Entity - Structural
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

entity entity_A is
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port ( 
        clk_A : in STD_LOGIC;
        rst_A : in STD_LOGIC;
        --dall'interfaccia
        in_received : in STD_LOGIC := '0';
        --verso l'interfaccia
        in_data : out std_logic_vector(M-1 downto 0);
        in_ready : out std_logic := '0'
    );
end entity_A;

architecture Structural of entity_A is

--componenti
component ROM_A
generic (
       M : integer := 8
    );
PORT (
    CLK : in std_logic;
    RST: in std_logic;
    READ : in std_logic := '0'; -- segnale da uc
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM
    DATA : out std_logic_vector(M-1 downto 0) -- dato su 8 bit letto dalla ROM
);
END component;

component UC_A
PORT (
    CLK_UC_A : in std_logic;
    RST_UC_A: in std_logic;
    ---segnali di controllo
    in_received_UC_A : in STD_LOGIC;
    in_ready_UC_A : out STD_LOGIC;
    ---gestione del contatore
    count_in_UC_A : out STD_LOGIC;
    count_end_UC_A : in STD_LOGIC; --termine comunicazione stringhe esaurite (arrivato a 7) 
    ---leggo dalla ROM
    read_mem : out STD_LOGIC
);
END component;

component cont_A_B
GENERIC (
    N : integer := 8
);
port( 
   CLK : in std_logic;
   RST : in std_logic; 
   cont : out std_logic_vector(2 downto 0);
   ---dall'unita' di controllo
   cont_in : in std_logic;
   cont_end : out std_logic
);
END component;

--segnali interni
signal address_in: std_logic_vector(2 downto 0):= "000";
signal cont_in: std_logic := '0';
signal cont_end: std_logic := '0';
signal read: std_logic := '0';

begin
    
    ROM : ROM_A
    generic map (
        M => 8
    )
    port map (
        CLK => clk_A,
        RST => rst_A,
        ADDR => address_in,
        DATA => in_data,
        READ => read
    );
    
    UC : UC_A
    port map (
        CLK_UC_A => clk_A,
        RST_UC_A => rst_A,
        in_received_UC_A => in_received,
        in_ready_UC_A => in_ready,
        count_in_UC_A => cont_in,
        count_end_UC_A => cont_end,
        read_mem => read
    );
    
    CONT : cont_A_B
    generic map (
        N => 8
    )
    port map (
        CLK => clk_A,
        RST => rst_A,
        cont_in => cont_in,
        cont_end => cont_end,
        cont => address_in
    );

end Structural;
