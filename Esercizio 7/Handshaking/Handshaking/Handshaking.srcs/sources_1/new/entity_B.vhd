----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 15.12.2021
-- Design Name: B_Entity
-- Module Name: B_Entity - Structural
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

entity entity_B is
    generic (
       N : integer := 8;
       M : integer := 8
    );
    Port ( 
        clk_B : in STD_LOGIC;
        rst_B : in STD_LOGIC;
        --dall'interfaccia
        out_received : out STD_LOGIC;
        --verso l'interfaccia
        out_data : in std_logic_vector(M-1 downto 0);
        out_ready : in std_logic
    );
end entity_B;

architecture Structural of entity_B is

--componenti
component MemoriaB is
    generic (
       N : integer := 8;
       M : integer := 8
    );
port(
    ADDR: in std_logic_vector(2 downto 0); -- Indirizzo a cui leggere o scrivere dalla memoria
    MEM_SOMMA_IN: in std_logic_vector(M-1 downto 0); -- Dato da scrivere nella memoria
    MEM_WE: in std_logic; -- Write enable della memoria
    MEM_CLOCK: in std_logic;
    MEM_DATA_OUT: out std_logic_vector(M-1 downto 0) -- Dato in uscita dalla memoria
);
end component;

component UC_B
PORT (
    CLK_UC_B : in std_logic;
    RST_UC_B: in std_logic;
    ---segnali di controllo
    out_received_UC_B : out STD_LOGIC;
    out_ready_UC_B : in STD_LOGIC;
    ---gestione del contatore
    count_in_UC_B : out STD_LOGIC;
    count_end_UC_B : in STD_LOGIC; --termine comunicazione stringhe esaurite (arrivato a 7)
    write_enable : out STD_LOGIC;
    enable_ALU : out STD_LOGIC;
    end_somma_in : in std_logic;
    bit_overflow : in STD_LOGIC
);
END component;

component cont_A_B
GENERIC (
        N : integer := 8
    );
       port( 
         CLK: in std_logic;
         RST: in std_logic;
         cont:     out std_logic_vector(2 downto 0);
         ---dall'unità di controllo
         cont_in : in std_logic;
         cont_end : out std_logic
        );
END component;

component UO_B
generic (
       N : integer := 8;
       M : integer := 8
    );
PORT (
    CLK_UO_B : in std_logic;
    RST_UO_B: in std_logic;
    out_data_UO_B: in STD_LOGIC_VECTOR(M-1 downto 0);
    out_data_MEM_B: in STD_LOGIC_VECTOR(M-1 downto 0);
    bit_overflow: out STD_LOGIC;
    enable_ALU : in STD_LOGIC;
    end_somma_out : out std_logic;
    sum_data: out STD_LOGIC_VECTOR(M-1 downto 0) --bit di overflow della somma
);
END component;


--segnali interni
signal address_in: std_logic_vector(2 downto 0):= (others => '0');
signal cont_in: std_logic := '0';
signal cont_end: std_logic := '0';
signal somma: std_logic_vector(M-1 downto 0);
signal end_somma : std_logic := '0';
signal out_data_MEMb: std_logic_vector(M-1 downto 0);
signal we: std_logic := '0';
signal overflow: std_logic := '0';
signal enable: std_logic := '0';


begin

    Mem : MemoriaB
    generic map (
       N => 8,
       M => 8
    )
    port map(
        ADDR => address_in,
        MEM_SOMMA_IN => somma,
        MEM_WE => we,
        MEM_CLOCK => clk_b,
        MEM_DATA_OUT => out_data_MEMb
    );
    
    UC : UC_B
    port map (
        CLK_UC_B => clk_B,
        RST_UC_B => rst_B,
        out_received_UC_B => out_received,
        out_ready_UC_B => out_ready,
        count_in_UC_B => cont_in,
        count_end_UC_B => cont_end,
        enable_ALU => enable,
        bit_overflow => overflow,
        end_somma_in => end_somma,
        write_enable => we
    );
    
    CONT : cont_A_B
    generic map (
        N => 8
    )
    port map (
        CLK => clk_B,
        RST => rst_B,
        cont_in => cont_in,
        cont_end => cont_end,
        cont => address_in
    );
    
    UO : UO_B
    port map (
        CLK_UO_B => clk_B,
        RST_UO_B => rst_B,
        out_data_UO_B => out_data,
        out_data_MEM_B => out_data_MEMb,
        sum_data => somma,
        bit_overflow => overflow,
        end_somma_out => end_somma,
        enable_ALU => enable
    );

end Structural;
