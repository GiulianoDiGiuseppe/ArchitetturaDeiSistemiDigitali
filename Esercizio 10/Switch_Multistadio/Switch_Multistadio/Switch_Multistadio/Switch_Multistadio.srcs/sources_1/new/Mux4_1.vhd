library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4_1 is
	port(
		a0 	: in std_logic_vector(1 downto 0);
		a1 	: in std_logic_vector(1 downto 0);
		a2 	: in std_logic_vector(1 downto 0);
		a3 	: in std_logic_vector(1 downto 0);
		sel	: in std_logic_vector(1 downto 0);
		u  	: out std_logic_vector(1 downto 0)
	);
end Mux4_1;

architecture dataflow of Mux4_1 is

begin
	u <= a0 when sel = "00" else 
			a1 when sel = "01" else
			a2 when sel = "10" else
			a3 when sel = "11" else
			"00";
end dataflow;