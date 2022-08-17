----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 25.01.2022
-- Design Name: Unita_Operativa
-- Module Name: Unita_Operativa - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unita_Operativa is
	generic(N : integer := 8);
	port(
		CLOCK 		: IN std_logic;
		RESET 		: IN std_logic;
		SAQ			: IN std_logic_vector(N*2-2 downto 0);
		M				: IN std_logic_vector(N-1 downto 0);
		INIT	 		: IN std_logic;
		ENABLE_M 	: IN std_logic;
		ENABLE_C 	: IN std_logic;
		INIT_C	 	: IN std_logic;
		LOAD_SA 		: IN std_logic;
		LOAD_Q 		: IN std_logic;
		SHIFT 		: IN std_logic;  
		SUB			: IN std_logic;
		Q				: OUT std_logic_vector(N-1 downto 0);
		R				: OUT std_logic_vector(N-1 downto 0);
		S 				: OUT std_logic_vector(1 downto 0);
		COUNT			: OUT std_logic
		);
end Unita_Operativa;

architecture Structural of Unita_Operativa is

	COMPONENT RegisterM
	generic( N:	integer);
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		ENABLE : IN std_logic;
		X : IN std_logic_vector(N-1 downto 0);          
		Y : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RegisterSAQ
	generic( N	: integer);
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		X_INIT : IN std_logic_vector(2*N-2 downto 0);
		X_SA : IN std_logic_vector(N downto 0);
		X_Q : IN std_logic;
		INIT : IN std_logic;
		LOAD_SA : IN std_logic;
		LOAD_Q : IN std_logic;
		SHIFT : IN std_logic;          
		Y : OUT std_logic_vector(2*N+1 downto 0)
		);
	END COMPONENT;


	COMPONENT ADDER_SUBTRACTOR_Nbit
	generic( N	: integer);	
	PORT(
		OP_0 : IN std_logic_vector(N-1 downto 0);
		OP_1 : IN std_logic_vector(N-1 downto 0);
		SUB : IN std_logic;          
		RIS : OUT std_logic_vector(N-1 downto 0);
		C_OUT : OUT std_logic
		);
	END COMPONENT;

	COMPONENT Counter
	generic( M : integer;
				N : integer);
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		INIT	: in STD_LOGIC;
		ENABLE : IN std_logic;    
		COUNT : OUT std_logic
		);
	END COMPONENT;

	signal Y_TEMP : std_logic_vector(N*2+1 downto 0);
	signal M_TEMP : std_logic_vector(N-1 downto 0);
	signal OP_1_TEMP : std_logic_vector(N downto 0);
	signal RIS_TEMP : std_logic_vector(N downto 0);
	signal X_Q_TEMP : std_logic;

begin
	Inst_RegisterM: RegisterM
	generic map(	N => N)
	PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		ENABLE => ENABLE_M,
		X => M,
		Y => M_TEMP
	);

	X_Q_TEMP <= not(RIS_TEMP(N));
	
	Inst_RegisterSAQ: RegisterSAQ
	generic map(	N => N)
	PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		X_INIT => SAQ,
		X_SA => RIS_TEMP,
		X_Q => X_Q_TEMP,
		INIT => INIT,
		LOAD_SA => LOAD_SA,
		LOAD_Q => LOAD_Q,
		SHIFT => SHIFT,
		Y => Y_TEMP(N*2+1 downto 0)
	);
	
	OP_1_TEMP <= "0" & M_TEMP;
	Inst_ADDER_SUBTRACTOR_Nbit: ADDER_SUBTRACTOR_Nbit 
	generic map(	N => N+1)
	PORT MAP(
		OP_0 => Y_TEMP(N*2 downto N),
		OP_1 => OP_1_TEMP,
		SUB => SUB,
		RIS => RIS_TEMP
	);

	Inst_Counter: Counter
	GENERIC MAP(M => 8,
					N => 3)
	PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		ENABLE => ENABLE_C,
		COUNT => COUNT,
		INIT => INIT_C
	);

	Q <= Y_TEMP(N-1 downto 0);
	R <= Y_TEMP(2*N-1 downto N);
	S <= Y_TEMP(2*N+1 downto 2*N);

end Structural;

