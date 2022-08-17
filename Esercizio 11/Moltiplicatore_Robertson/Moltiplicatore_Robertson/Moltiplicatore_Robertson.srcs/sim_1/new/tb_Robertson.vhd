library ieee;
use ieee.std_logic_1164.all;

entity tb_Robertson is
end tb_Robertson;

architecture tb of tb_Robertson is

    component Robertson
        port (clock   : in std_logic;
              reset   : in std_logic;
              start   : in std_logic;
              X       : in std_logic_vector (7 downto 0);
              Y       : in std_logic_vector (7 downto 0);
              stop    : out std_logic;
              P       : out std_logic_vector (15 downto 0);
              stop_cu : out std_logic);
    end component;

    signal clock   : std_logic;
    signal reset   : std_logic;
    signal start   : std_logic;
    signal X       : std_logic_vector (7 downto 0);
    signal Y       : std_logic_vector (7 downto 0);
    signal stop    : std_logic;
    signal P       : std_logic_vector (15 downto 0);
    signal stop_cu : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Robertson
    port map (clock   => clock,
              reset   => reset,
              start   => start,
              X       => X,
              Y       => Y,
              stop    => stop,
              P       => P,
              stop_cu => stop_cu);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clock is really your main clock signal
    clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        -- Inizializzazione, si mette tutto a 0
        start <= '0';
        Y <= "00000000";
        X <= "00000000";

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- Si inizializza l'automa
        wait for 10 ns;
        start <= '1';

        wait for 100 ns;
        start <= '0';

        ---- Attesa

        wait for 200 ns;
        
        -------------------
        
        -- Si fa 7 x 7 = 49
        start <= '0';
        Y <= "00000111";
        X <= "00000111";

        -- Si resetta per nuovi operandi
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- Si restarta l'automa
        wait for 10 ns;
        start <= '1';

        wait for 100 ns;
        -- Si spegne l'automa
        start <= '0';
        
        ---- Attesa
        
        wait for 200 ns;
        
        -------------------
        
        -- Si fa un X < 0 e un Y > 0 
        start <= '0';
        Y <= "00001000";
        X <= "11111110";

        -- Si resetta per nuovi operandi
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- Si restarta l'automa
        wait for 10 ns;
        start <= '1';

        wait for 100 ns;
        -- Si spegne l'automa
        start <= '0';
        
        ---- Attesa
        
        wait for 200 ns;
        
        -------------------
        
        -- Si fa un X < 0 e un Y < 0 
        start <= '0';
        Y <= "11111101";
        X <= "11111100";

        -- Si resetta per nuovi operandi
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- Si restarta l'automa
        wait for 10 ns;
        start <= '1';

        wait for 100 ns;
        -- Si spegne l'automa
        start <= '0';
        
        wait for 1000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        
        wait;
    end process;

end tb;