library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2_1 is
	port(
		a0 	: in std_logic_vector(1 downto 0);
		a1 	: in std_logic_vector(1 downto 0);
		sel	: in std_logic;
--		en 	: in std_logic;
		u  	: out std_logic_vector(1 downto 0)
	);
end Mux2_1;

architecture dataflow of Mux2_1 is

begin

	u <=   a0 when sel = '0' else 
           a1 when sel = '1' else
		   "00";

end dataflow;
