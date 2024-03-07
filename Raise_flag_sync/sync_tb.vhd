library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sync_TB is
end Sync_TB;

architecture TB of Sync_TB is
    
    component sync 
    port( rst:       in std_logic;
          clk:       in std_logic;
          RX:        in std_logic_vector(7 downto 0);
          TX_enable: out std_logic
    );
    end component;

    signal T_rst, T_clk : std_logic := '0';
    signal T_RX : std_logic_vector(7 downto 0) := (others => '0');
    signal T_TX_enable : std_logic := '0';

    constant CLOCK_PERIOD : time := 10 ns;  -- Adjust as needed


begin
    -- Instantiate the Sync component
    u_Sync: sync port map(T_rst,T_clk,T_RX,T_TX_enable);

    -- Clock process
    process
    begin
        while now < 300 ns loop  -- Simulate for 1000 ns, adjust as needed
            T_clk <= '0';
            wait for CLOCK_PERIOD / 2;
            T_clk <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        T_rst <= '1';  -- Apply reset
        wait for 20 ns;
        T_rst <= '0';  -- Deassert reset

        -- Provide some input values for RX
        T_RX <= "10010101";  -- Matches the CONSTANT_8_BIT
        wait for CLOCK_PERIOD;
        T_RX <= "11001010";  -- Matches the CONSTANT_8_BIT
        wait for CLOCK_PERIOD;
        T_RX <= "11100101";  -- Matches the CONSTANT_8_BIT
        wait for 100 ns;  -- Allow some time for processing
        T_rst <= '1';  -- Apply reset
        T_RX <= "11001010";  -- Matches the CONSTANT_8_BIT
        wait for 20 ns;
        T_rst <= '0';  -- Deassert reset
        
        T_RX <= "10010101";  -- Matches the CONSTANT_8_BIT
        wait for CLOCK_PERIOD;
        T_RX <= "11001010";  -- Matches the CONSTANT_8_BIT
        wait for CLOCK_PERIOD;
        T_RX <= "11100101";  -- Matches the CONSTANT_8_BIT
        wait for 10 ns;
        

        -- Check the output
        assert T_TX_enable = '1' report "Error: TX_enable should be asserted" severity ERROR;

        wait;

    end process;

end TB;

