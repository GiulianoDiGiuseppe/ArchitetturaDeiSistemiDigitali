----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: UART_A_B
-- Module Name: UART_A_B - Structural
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

entity UART_A_B is
    generic (
        M : integer := 8
    );
    Port (
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        ENABLE : IN STD_LOGIC
    );
end UART_A_B;

architecture Structural of UART_A_B is

component Entity_A is
    generic (
        M : integer := 8
    );    
    PORT (
        WR_IN: in std_logic;
        SR_ACK: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        DONE: in std_logic;
        --uscite
        LOAD: out std_logic;
        SR: out std_logic;
        --data out ROM
        data_out: OUT STD_LOGIC_VECTOR(M-1 downto 0)					
    );
end component;


component Entity_B is
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
end component;


component UART_On_Board is
    port(
        CLOCK		: in	STD_LOGIC;	-- Clock
        RESET 	    : in	STD_LOGIC;	-- Reset
        LOAD		: in	STD_LOGIC;	-- Segnale di caricamento byte nel trasmettitore
        DATA_IN 	: in 	STD_LOGIC_VECTOR (7 downto 0);
        DATA_OUT	: out 	STD_LOGIC_VECTOR (7 downto 0);
        RDA_OUT	    : out	STD_LOGIC
        );
end component;


signal SR_ACK_TEMP : STD_LOGIC;
signal DONE_TEMP : STD_LOGIC;
signal SR_TEMP : STD_LOGIC;
signal RDA_TEMP : STD_LOGIC;
signal RD_TEMP : STD_LOGIC;
signal LOAD_TEMP : STD_LOGIC;
signal DATA_IN_TEMP : std_logic_vector(M-1 downto 0);
signal DATA_OUT_TEMP : std_logic_vector(M-1 downto 0);

    
begin

    A_ENTITY : ENTITY_A
    PORT MAP(
        WR_IN => ENABLE,
        SR_ACK => SR_ACK_TEMP,
        CLK => CLK,
        RST => RST,
        DONE => DONE_TEMP,
        --uscite
        LOAD => LOAD_TEMP,
        SR => SR_TEMP,
        --data out ROM
        data_out => DATA_OUT_TEMP
    );
    
    
    B_ENTITY : ENTITY_B
    PORT MAP(
        -- ingressi
        SR => SR_TEMP,
        RDA => RDA_TEMP,
        CLK => CLK,
        RST => RST,
        -- dato da scrivere in RAM
        data_in => DATA_IN_TEMP, 
        --uscite
        REQACK => SR_ACK_TEMP,
        DONE => DONE_TEMP
    );
    
    UART : UART_On_Board
    port map(
        CLOCK => CLK,		
        RESET => RST,	
        LOAD => LOAD_TEMP,		
        DATA_IN => DATA_OUT_TEMP,	
        DATA_OUT => DATA_IN_TEMP,
        RDA_OUT => RDA_TEMP
    );

end Structural;
