----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: Entity_B
-- Module Name: Entity_B - Behavioral
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

entity Entity_B is
        generic (
            M : integer := 8
        );   
        PORT (
            -- ingressi
            SR: in std_logic;
            RDA: in std_logic;
            CLK: in std_logic;
            RST: in std_logic;
            -- dato da scrivere in RAM
            data_in: in STD_LOGIC_VECTOR(M-1 downto 0); 
            --uscite
            REQACK: out std_logic;
            DONE: out std_logic
        );
end Entity_B;

architecture Behavioral of Entity_B is

component Memory is
    generic (
        N : integer := 8;
        M : integer := 8
        );
    port(
        ADDR : in std_logic_vector(2 downto 0); -- Address to write/read MEM
        MEM_DATA_IN : in std_logic_vector(M-1 downto 0); -- Data to write into MEM
        MEM_WE : in std_logic; -- Write enable 
        MEM_CLOCK : in std_logic; -- clock input for MEM
        MEM_RST : in std_logic -- reset for MEM
);
end component;

component Counter is
 port( 
       CLK : in std_logic;
       RST : in std_logic; 
       cont_addr : out std_logic_vector(2 downto 0);
       ---dall'unita' di controllo
       cont_start : in std_logic
    );
end component;

component UC_B is
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
end component;


    --segnali interni
    signal address_in: std_logic_vector(2 downto 0):= "000";
    signal cont_in: std_logic := '0';
    signal we: std_logic := '0';

begin

    MEM : Memory
    generic map (
       N => 8,
       M => 8
    )
    port map(
        ADDR => address_in, 
        MEM_DATA_IN => DATA_IN, 
        MEM_WE => we,
        MEM_CLOCK => CLK,
        MEM_RST => RST
    );

    
    UC: UC_B
    port map(
        CLK_UC_B => CLK,
        RST_UC_B => RST,
        RDA => RDA,
        SR => SR,
        REQACK => REQACK,
        DONE => DONE,
        count_start_UC_B => cont_in,
        write_enable => we
    );
    
    
    CONT : counter
    port map (
        CLK => CLK,
        RST => RST,
        cont_addr => address_in,
        cont_start => cont_in
    );

end Behavioral;
