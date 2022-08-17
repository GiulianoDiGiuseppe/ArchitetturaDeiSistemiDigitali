----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.01.2022
-- Design Name: Entity_A
-- Module Name: Entity_A - Structural
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

entity Entity_A is
        generic (
            M : integer := 8
        );    
        PORT (
        --ingressi
        CLK: in std_logic;
        RST: in std_logic;
        WR_IN: in std_logic;
        SR_ACK: in std_logic;
        DONE: in std_logic;
        --uscite
        LOAD: out std_logic;
        SR: out std_logic;
        --data out ROM
        data_out: out std_logic_vector(M-1 downto 0)				
        );
end Entity_A;

architecture Structural of Entity_A is

component Counter is
 port( 
       CLK : in std_logic;
       RST : in std_logic; 
       cont_addr : out std_logic_vector(2 downto 0);
       ---dall'unita' di controllo
       cont_start : in std_logic
    );
end component;

component ROM_A is
    generic (
        M : integer := 8
    );
    PORT (
        CLK : in std_logic; -- clock della board
        RST: in std_logic;
        READ : in std_logic := '0'; -- segnale da uc
        ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                                --sono inseriti tramite gli switch (DA VEDERE LOG2N)
        DATA : out std_logic_vector(M-1 downto 0) -- dato su 8 bit letto dalla ROM
    );
end component;

COMPONENT UC_A is
PORT (
        CLK_UC_A : in std_logic;
        RST_UC_A: in std_logic;
        SR_ACK: in std_logic;
        DONE: in std_logic;
        WR_IN: in std_logic;
        CONT_START_UC_A: out std_logic;
        SR : out std_logic;
        LOAD : out std_logic
    );
end COMPONENT;

--segnali interni
signal address_in: std_logic_vector(2 downto 0):= "000";
signal cont_in: std_logic := '0';

begin
    
    ROM : ROM_A
    port map(
        CLK => CLK,
        RST => RST,
        ADDR => address_in,
        DATA => DATA_OUT,
        READ => WR_IN
    );
        
    CONT : Counter
    port map (
        CLK => CLK,
        RST => RST,
        cont_addr => address_in,
        cont_start => cont_in
    );
    
    UC : UC_A
    port map (
        CLK_UC_A => CLK,
        RST_UC_A => RST,
        CONT_START_UC_A => cont_in,
        SR_ACK => SR_ACK,
        WR_IN => WR_IN,
        DONE => DONE,
        SR => SR,
        LOAD => LOAD
    );


end Structural;
