----------------------------------------------------------------------------------
-- Company: Università Degli Studi di Napoli "Federico II"
-- Engineer: Gruppo 21 - Antonio Romano, Giuliano di Giuseppe, Giuseppe Riccio e Sossio Cirillo
-- 
-- Create Date: 19.11.2021
-- Design Name: Shift_Register - Structural
-- Module Name: Shift_Register - Structural
-- Project Name: Shift_Register_S
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

entity Shift_Register is
  Port (  input : in  STD_LOGIC;
          outs : out  STD_LOGIC;
          clk_1 : in  STD_LOGIC;
          sel : in  STD_LOGIC_VECTOR (2 downto 0);
          clr_1 : in  STD_LOGIC
          );
end Shift_Register;

architecture Structural of Shift_Register is

    component D_and_Mux is
      Port (  in_put : in  STD_LOGIC_VECTOR (4 downto 0);
              Sel : in  STD_LOGIC_VECTOR (2 downto 0);
              clk :	in STD_LOGIC;
              clearN : in STD_LOGIC;
              Output : out  STD_LOGIC);
    end component;
    
    
    component Flip_Flop_D is
      Port (   D : in  STD_LOGIC;
               Clock : in  STD_LOGIC;
               Reset_N : in  STD_LOGIC;
               Q : out  STD_LOGIC);
      end component Flip_Flop_D;


    
    signal sh_left: STD_LOGIC_VECTOR (6 downto 0);
	signal sh_right: STD_LOGIC_VECTOR (7 downto 0);
	signal store: STD_LOGIC_VECTOR (7 downto 0);
    signal uscita: STD_LOGIC;   --viene inserito questo segnale per inserire il valore di uscita all'interno di un flip flop che lo tiene memorizzato.

begin


           stage7 : D_and_Mux port map ( in_put(0) => store(7),
                                         in_put(1) => input,
                                         in_put(2) => sh_left(6),
                                         in_put(3) => input,
                                         in_put(4) => sh_left(5),
                                         clk => clk_1, 
                                         Sel => sel, 
                                         clearN => clr_1, 
                                         Output => sh_right(7));
                                         
         stage6 : D_and_Mux port map ( in_put(0) => store(6), 
                                       in_put(1) => sh_right(7),
                                       in_put(2) => sh_left(5), 
                                       in_put(3) => sh_right(1),
                                       in_put(4) => sh_left(4),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(6));
                                       
         stage5 : D_and_Mux port map ( in_put(0) => store(5),
                                       in_put(1) => sh_right(6),
                                       in_put(2) => sh_left(4), 
                                       in_put(3) => sh_right(7),
                                       in_put(4) => sh_left(3),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(5));
                                       
         stage4 : D_and_Mux port map ( in_put(0) => store(4),
                                       in_put(1) => sh_right(5),
                                       in_put(2) => sh_left(3), 
                                       in_put(3) => sh_right(6),
                                       in_put(4) => sh_left(2),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(4));
                                      
         stage3 : D_and_Mux port map ( in_put(0) => store(3),
                                       in_put(1) => sh_right(4),
                                       in_put(2) => sh_left(2), 
                                       in_put(3) => sh_right(5),
                                       in_put(4) => sh_left(1),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(3));
                                       
         stage2 : D_and_Mux port map ( in_put(0) => store(2),
                                       in_put(1) => sh_right(3),
                                       in_put(2) => sh_left(1), 
                                       in_put(3) => sh_right(4),
                                       in_put(4) => sh_left(0),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(2));
                                       
         stage1 : D_and_Mux port map ( in_put(0) => store(1),
                                       in_put(1) => sh_right(2),
                                       in_put(2) => sh_left(0), 
                                       in_put(3) => sh_right(3),
                                       in_put(4) => sh_left(6),
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(1)); 
                                       
         stage0 : D_and_Mux port map ( in_put(0) => store(0),
                                       in_put(1) => sh_right(1),
                                       in_put(2) => input, 
                                       in_put(3) => sh_right(2),
                                       in_put(4) => input,
                                       clk => clk_1, 
                                       Sel => sel, 
                                       clearN => clr_1, 
                                       Output => sh_right(0));      
                                       
                                       
         ff_uscita : Flip_Flop_D port map( D => uscita,         --si inserisce questo FLipFlop per tenere memorizzato il valore di uscita in modo che questo possa essere
                                           Clock => clk_1,      --in output al successivo colpo di clock
                                           Reset_N => clr_1,
                                           Q => outs);                       
                            
                           

            store(7) <= sh_right(7);

            store(6) <= sh_right(6);
            sh_left(6) <= sh_right(6);
            
            store(5) <= sh_right(5);
            sh_left(5) <= sh_right(5);
            
            store(5) <= sh_right(5);
            sh_left(5) <= sh_right(5);
            
            store(4) <= sh_right(4);
            sh_left(4) <= sh_right(4);
            
            store(3) <= sh_right(3);
            sh_left(3) <= sh_right(3);
            
            store(2) <= sh_right(2);
            sh_left(2) <= sh_right(2);
            
            store(1) <= sh_right(1);
            sh_left(1) <= sh_right(1);
            
            store(0) <= sh_right(0);
            sh_left(0) <= sh_right(0);
            
            
--            outs <= sh_right(0) when sel = "001" or sel = "101"
--            else sh_right(7) when sel = "010" or sel = "110"
--            else 'U';
            
            --uscita
              uscita <= sh_right(0) when sel = "001" or sel = "101"
              else sh_right(7) when sel = "010" or sel = "110"
              else 'U';
              
            
            
            
end Structural;
