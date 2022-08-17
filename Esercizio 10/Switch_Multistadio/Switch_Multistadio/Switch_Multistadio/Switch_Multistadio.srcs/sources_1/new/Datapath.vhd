library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
	PORT(
--		en : IN std_logic;
--		dst0 : IN std_logic_vector(1 downto 0);
--		dst1 : IN std_logic_vector(1 downto 0);
--		dst2 : IN std_logic_vector(1 downto 0);
		dst   : IN std_logic_vector(1 downto 0);
		src   : IN std_logic_vector(1 downto 0);
		data0 : IN std_logic_vector(1 downto 0);
		data1 : IN std_logic_vector(1 downto 0);
		data2 : IN std_logic_vector(1 downto 0);
		data3 : IN std_logic_vector(1 downto 0);
		out0  : OUT std_logic_vector(1 downto 0);
		out1  : OUT std_logic_vector(1 downto 0);
		out2  : OUT std_logic_vector(1 downto 0);
		out3  : OUT std_logic_vector(1 downto 0)
--		u : OUT std_logic_vector(1 downto 0)
	);
end Datapath;

architecture structural of Datapath is

--	COMPONENT Mux4_1
--	PORT(
--		a0 : IN std_logic_vector(1 downto 0);
--		a1 : IN std_logic_vector(1 downto 0);
--		a2 : IN std_logic_vector(1 downto 0);
--		a3 : IN std_logic_vector(1 downto 0);
--		sel : IN std_logic_vector(1 downto 0);
--		u : OUT std_logic_vector(1 downto 0)
--		);
--	END COMPONENT;

	COMPONENT Cell
	PORT(
--		en  : IN std_logic;
		a0  : IN std_logic_vector(1 downto 0);
		a1  : IN std_logic_vector(1 downto 0);
		src : IN std_logic;
		dst : IN std_logic;          
		u0  : OUT std_logic_vector(1 downto 0);
		u1  : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

--	signal d 		: std_logic_vector(1 downto 0);
	signal temp0 	: std_logic_vector(1 downto 0);
	signal temp1 	: std_logic_vector(1 downto 0);
	signal temp2 	: std_logic_vector(1 downto 0);
	signal temp3 	: std_logic_vector(1 downto 0);
	
begin

--	Inst_Mux4_1: Mux4_1 PORT MAP(
--		a0 => dst0,
--		a1 => dst1,
--		a2 => dst2,
--		a3 => dst3,
--		sel => sel,
--		u => d
--	);

	Switch_1: Cell PORT MAP(
--		en  => en,
		a0  => data0,
		a1  => data1,
		src => src(0),
		dst => dst(1),
		u0  => temp0,
		u1  => temp1
	);
	
	Switch_3: Cell PORT MAP(
--		en  => en,
		a0  => temp0,
		a1  => temp2,
		src => src(1),
		dst => dst(0),
		u0  => out0,
		u1  => out1
	);
	
	Switch_2: Cell PORT MAP(
--		en  => en,
		a0  => data2,
		a1  => data3,
		src => src(0),
		dst => dst(1),
		u0  => temp2,
		u1  => temp3
	);
	
	Switch_4: Cell PORT MAP(
--		en  => en,
		a0  => temp1,
		a1  => temp3,
		src => src(1),
		dst => dst(0),
		u0  => out2,
		u1  => out3
	);
	
end structural;
