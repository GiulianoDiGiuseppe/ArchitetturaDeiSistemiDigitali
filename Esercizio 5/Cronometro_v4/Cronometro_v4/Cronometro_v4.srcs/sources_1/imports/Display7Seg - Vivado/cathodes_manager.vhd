----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:17 22/10/2012 
-- Design Name: 
-- Module Name:    cathode_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cathodes_manager is
    Port ( counter : in  STD_LOGIC_VECTOR (2 downto 0);
           value : in  STD_LOGIC_VECTOR (31 downto 0); --dato di mostrare sugli 8 display
           dots : in  STD_LOGIC_VECTOR (7 downto 0); --configurazione punti da accendere
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0)); --sono i 7 catodi pi� il punto
end cathodes_manager;

architecture Behavioral of cathodes_manager is

-- si vanno a definire i valori che si possono mostrare sul visore (dallo 0, fino all'F, in esadecimale)
constant zero   : std_logic_vector(6 downto 0) := "1000000"; 
constant one    : std_logic_vector(6 downto 0) := "1111001"; 
constant two    : std_logic_vector(6 downto 0) := "0100100"; 
constant three  : std_logic_vector(6 downto 0) := "0110000"; 
constant four   : std_logic_vector(6 downto 0) := "0011001"; 
constant five   : std_logic_vector(6 downto 0) := "0010010"; 
constant six    : std_logic_vector(6 downto 0) := "0000010"; 
constant seven  : std_logic_vector(6 downto 0) := "1111000"; 
constant eight  : std_logic_vector(6 downto 0) := "0000000"; 
constant nine   : std_logic_vector(6 downto 0) := "0010000"; 
constant a   	: std_logic_vector(6 downto 0) := "0001000"; 
constant b      : std_logic_vector(6 downto 0) := "0000011"; 
constant c      : std_logic_vector(6 downto 0) := "1000110"; 
constant d      : std_logic_vector(6 downto 0) := "0100001"; 
constant e      : std_logic_vector(6 downto 0) := "0000110"; 
constant f      : std_logic_vector(6 downto 0) := "0001110";

-- questo alias serve per andare a multiplexare la cifra da mostrare, nel senso che, essendo che 
-- le cifre da definire sono 16, allora ho la necessit� di definire che ogni cifra del visore dovr� mostrare 2^4 simboli e quindi in tutto 32/8 = 4
-- dico che ogni digit_X rappresenta una cifra LED
-- perch� divido i digit? prendo una locazione di memoria: suppongo 21F08602 in binario sar�: 0010 0001 1111 0000 1000 0110 0000 0010 
alias digit_0 is value (3 downto 0); --4
alias digit_1 is value (7 downto 4); --8
alias digit_2 is value (11 downto 8); --12 e cos� via
alias digit_3 is value (15 downto 12);
alias digit_4 is value (19 downto 16);
alias digit_5 is value (23 downto 20);
alias digit_6 is value (27 downto 24);
alias digit_7 is value (31 downto 28);

signal cathodes_for_digit : std_logic_Vector(6 downto 0) := (others => '0');
signal nibble :std_logic_vector(3 downto 0) := (others => '0');
signal dot :std_logic := '0'; --stabilisce se il punto relativo alla cifra visualizzata deve essere acceso o spento
                              --nota: dot=1 significa che deve essere acceso, ma il segnale deve essere negato per andare sui catodi 

begin 

-- questo processo multiplexa le cifre da mostrare
-- se counter = 000, conto nel digit_0, se counter = 001 conto nel digit_1 e cos� via...
digit_switching: process(counter)

begin
	case counter is
		when "000" =>
			nibble <= digit_0;
			dot <= dots(0);
		when "001" =>
			nibble <= digit_1;
			dot <= dots(1);
		when "010" =>
			nibble <= digit_2;
			dot <= dots(2);
		when "011" =>
			nibble <= digit_3;
			dot <= dots(3);
		when "100" =>
			nibble <= digit_4;
			dot <= dots(4);
		when "101" =>
			nibble <= digit_5;
			dot <= dots(5);
		when "110" =>
			nibble <= digit_6;
			dot <= dots(6);
		when "111" =>
			nibble <= digit_7;
			dot <= dots(7);
		when others =>
			nibble <= (others => '0');
			dot <= '0';
	end case;
end process;

--qui vado a determinare il valore di digit passato a nibble			 
seven_segment_decoder_process: process(nibble) 
  begin 
    case nibble is 
      when "0000" => cathodes_for_digit <= zero; 
      when "0001" => cathodes_for_digit <= one; 
      when "0010" => cathodes_for_digit <= two; 
      when "0011" => cathodes_for_digit <= three; 
      when "0100" => cathodes_for_digit <= four; 
      when "0101" => cathodes_for_digit <= five; 
      when "0110" => cathodes_for_digit <= six; 
      when "0111" => cathodes_for_digit <= seven; 
      when "1000" => cathodes_for_digit <= eight; 
      when "1001" => cathodes_for_digit <= nine; 
      when "1010" => cathodes_for_digit <= a; 
      when "1011" => cathodes_for_digit <= b; 
      when "1100" => cathodes_for_digit <= c; 
      when "1101" => cathodes_for_digit <= d; 
      when "1110" => cathodes_for_digit <= e; 
      when "1111" => cathodes_for_digit <= f;
		when others => cathodes_for_digit <= (others => '0');
    end case; 
  end process seven_segment_decoder_process;
  
cathodes <= (not dot)&cathodes_for_digit; 



end Behavioral;