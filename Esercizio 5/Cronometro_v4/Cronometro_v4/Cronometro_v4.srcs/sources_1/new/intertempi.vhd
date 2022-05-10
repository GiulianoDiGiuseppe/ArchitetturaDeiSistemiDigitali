----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 23.11.2021
-- Design Name: Intertempi
-- Module Name: Intertempi - Structural
-- Project Name: Cronometro_v4
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity intertempi is
	generic (
		n_register : positive := 2
	);
	port (
		stop : in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		sel : in std_logic;
		current_time : in std_logic_vector(31 downto 0);
		intertime : out std_logic_vector(31 downto 0)
	);
end intertempi;

architecture Structural of intertempi is

component mux is
    generic (
        n	: positive := 1
    );
    
    port (
        x	: in std_logic_vector(32*(2**n) downto 1);
        sel	: in std_logic_vector(n-1 downto 0);
        y	: out std_logic_vector(31 downto 0)
    );
end component;

component unita_controllo is
    port (
        stop : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        sel : in std_logic;
        reg_en : out std_logic;
        op : out std_logic	-- op=0 shift circolare, op=1 inserisci nuovo dato
    );
end component;

component Memoria
    port (
        x		: in std_logic_vector(31 downto 0);
        en		: in std_logic;
        clk	    : in std_logic;
        reset	: in std_logic;
        y		: out std_logic_vector(31 downto 0)
    );
end component;


signal s_sel_mux : std_logic := '0';
signal s_reg_en : std_logic := '0';
signal s_temp : std_logic_vector(1 to 32*(n_register+1));
signal var : std_logic_vector(1 to 64);


begin
	
	intertime <= s_temp(33 to 64);
	var <= s_temp(32*n_register + 1 to 32*(n_register+1)) & current_time;

	mux21 : mux 
	port map (
		x => var,
		sel(0) => s_sel_mux,
		y => s_temp(1 to 32)
	);
	
	uc : unita_controllo
	port map(
		stop => stop,
		reset => reset,
		clk => clk,
		sel => sel,
		reg_en => s_reg_en,
		op => s_sel_mux
	);
	
	mem_temps : for i in 0 to n_register - 1 generate
		reg_temp : Memoria 
			port map(
				x => s_temp(32*i + 1 to 32*(i+1)),
				en => s_reg_en,
				clk => clk,
				reset => reset,
				y => s_temp(32*(i+1) + 1 to 32*(i+2))
			);
	end generate;
	

end Structural;
