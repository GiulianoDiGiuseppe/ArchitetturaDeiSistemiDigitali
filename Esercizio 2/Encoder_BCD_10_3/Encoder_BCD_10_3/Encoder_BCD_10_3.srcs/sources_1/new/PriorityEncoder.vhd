----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 10.11.2021
-- Design Name: PriorityEncoder - Structural
-- Module Name: PriorityEncoder - Structural
-- Project Name: Encoder_BCD
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

entity PriorityEncoder is
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        CAT : out STD_LOGIC_VECTOR(7 downto 0);
        AN : out STD_LOGIC_VECTOR(7 downto 0)
       );
end PriorityEncoder;

architecture Structural of PriorityEncoder is
    COMPONENT Arbiter IS
        Port(
            X : in STD_LOGIC_VECTOR(9 downto 0);
            Y : out STD_LOGIC_VECTOR(9 downto 0)
           );
    END COMPONENT;
    
    COMPONENT Encoder IS
        Port(
            X : in STD_LOGIC_VECTOR(9 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
           );
    END COMPONENT;
    
    COMPONENT display is
        Port(
            number: in STD_LOGIC_VECTOR(3 downto 0);
            anodi: out STD_LOGIC_VECTOR(7 downto 0);
            catodi: out STD_LOGIC_VECTOR(7 downto 0)
            );

    END COMPONENT;
    

    signal u : STD_LOGIC_VECTOR(9 downto 0);
    signal uu : STD_LOGIC_VECTOR(3 downto 0);
    
begin

    A : Arbiter 
        PORT MAP( 
            X => X,
            Y => u
        );
    
    E : Encoder 
        PORT MAP(
            X => u,
            Y => uu
        );
        
    D : display
        PORT MAP(
            number => uu,
            anodi => AN,
            catodi => CAT
            );

end Structural;
