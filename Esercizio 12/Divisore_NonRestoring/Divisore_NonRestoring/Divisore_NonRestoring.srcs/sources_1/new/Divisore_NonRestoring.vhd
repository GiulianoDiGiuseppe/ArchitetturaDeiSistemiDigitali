----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Divisore_NonRestoring
-- Module Name: Divisore_NonRestoring - Structural
-- Project Name: Divisore_NonRestoring
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

entity Divisore_NonRestoring is
	GENERIC(	N : integer := 8);
	port(	CLOCK : in  STD_LOGIC;
			RESET : in STD_LOGIC;
			X : in  std_logic_vector(7 downto 0);
			Y : in  std_logic_vector(7 downto 0);
			BTN_START : in STD_LOGIC;
			Q : out std_logic_vector(7 downto 0)
    );
end Divisore_NonRestoring;

architecture Structural of Divisore_NonRestoring is
	COMPONENT Unita_Operativa
	GENERIC(	N : integer := 8);
	PORT(
		CLOCK 		: IN std_logic;
		RESET 		: IN std_logic;
		SAQ			: IN std_logic_vector(N*2-2 downto 0);
		M			: IN std_logic_vector(N-1 downto 0);
		INIT	 	: IN std_logic;
		ENABLE_M 	: IN std_logic;
		ENABLE_C 	: IN std_logic;
		INIT_C	 	: IN std_logic;
		LOAD_SA 	: IN std_logic;
		LOAD_Q 		: IN std_logic;
		SHIFT 		: IN std_logic;  
		SUB			: IN std_logic;
		Q			: OUT std_logic_vector(N-1 downto 0);
		R			: OUT std_logic_vector(N-1 downto 0);
		S 			: OUT std_logic_vector(1 downto 0);
		COUNT		: OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Unita_Controllo
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		START : IN std_logic;
		S_BUF : IN std_logic_vector(1 downto 0);
		COUNT : IN std_logic;          
		LOAD_SA : OUT std_logic;
		LOAD_Q : OUT std_logic;
		SHIFT : OUT std_logic;
		ENABLE_C : OUT std_logic;
		ENABLE_EXIT : OUT std_logic;
		SUB : OUT std_logic;
		INIT_COUNT		: out STD_LOGIC
		);
	END COMPONENT;

	COMPONENT StartDivisione
	generic (N : integer);
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		X : IN std_logic_vector(N-1 downto 0);
		Y : IN std_logic_vector(N-1 downto 0);
		BTN_START : IN std_logic;          
		SAQ : OUT std_logic_vector(2*N-2 downto 0);
		M : OUT std_logic_vector(N-1 downto 0);
		START : OUT std_logic;
		ENABLE_SAQ : OUT std_logic;
		ENABLE_M : OUT std_logic;
		ERR : out STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT D_Latch is 
    port(
        Q : out std_logic_vector(7 downto 0);    
        ENABLE :in std_logic;  
        RESET : in std_logic;  
        D : in  std_logic_vector(7 downto 0)    
    );
    END COMPONENT;


	signal SAQ_TEMP : std_logic_vector(N*2-2 downto 0);
	signal M_TEMP : std_logic_vector(N-1 downto 0);
	signal INIT_TEMP : std_logic;
	signal ENABLE_M_TEMP : std_logic;
	signal LOAD_SA_TEMP : std_logic;
	signal LOAD_Q_TEMP : std_logic;
	signal SHIFT_TEMP : std_logic;
	signal SUB_TEMP : std_logic;
	signal START_TEMP : std_logic;
	signal ENABLE_C_TEMP : std_logic;
	signal COUNT_TEMP : std_logic;
	signal S_BUF_TEMP : std_logic_vector(1 downto 0);
	signal Q_TEMP : std_logic_vector(N-1 downto 0);
	signal R_TEMP : std_logic_vector(N-1 downto 0);
	signal Q_CONV : std_logic_vector(11 downto 0);
	signal R_CONV : std_logic_vector(11 downto 0);
	signal ENABLE_EXIT : std_logic;
	signal INIT_COUNT_TEMP	: STD_LOGIC;
	signal ERR_TEMP	: STD_LOGIC;

	
begin

    Inst_D_Latch: D_Latch
    Port map(
        Q => Q,
        ENABLE => INIT_COUNT_TEMP,
        RESET => RESET,
        D => Q_TEMP
    );
        

	Inst_UO: Unita_Operativa 
	GENERIC MAP(N => 8)
	PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		SAQ => SAQ_TEMP,
		M => M_TEMP,
		INIT => INIT_TEMP,
		ENABLE_M => ENABLE_M_TEMP,
		LOAD_SA => LOAD_SA_TEMP,
		LOAD_Q => LOAD_Q_TEMP,
		SHIFT => SHIFT_TEMP,
		SUB => SUB_TEMP,
		ENABLE_C => ENABLE_C_TEMP,
		INIT_C => INIT_COUNT_TEMP,
		Q => Q_TEMP,
		R => R_TEMP,
		S => S_BUF_TEMP,
		COUNT => COUNT_TEMP
	);
	
	Inst_UC: Unita_Controllo 
	PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		START => START_TEMP,
		S_BUF => S_BUF_TEMP,
		COUNT => COUNT_TEMP,
		LOAD_SA => LOAD_SA_TEMP,
		LOAD_Q => LOAD_Q_TEMP,
		SHIFT => SHIFT_TEMP,
		ENABLE_C => ENABLE_C_TEMP,
		ENABLE_EXIT => ENABLE_EXIT,
		SUB => SUB_TEMP,
		INIT_COUNT => INIT_COUNT_TEMP
	);
	
	
	Inst_StartDivisione: StartDivisione 
	GENERIC MAP(N => 8)
	PORT MAP( 
		CLOCK => CLOCK,
		RESET => RESET,
		X => X,
		Y => Y,
		BTN_START => BTN_START,
		SAQ => SAQ_TEMP,
		M => M_TEMP,
		START => START_TEMP,
		ENABLE_SAQ => INIT_TEMP,
		ENABLE_M => ENABLE_M_TEMP,
		ERR => ERR_TEMP
	);

end Structural;
