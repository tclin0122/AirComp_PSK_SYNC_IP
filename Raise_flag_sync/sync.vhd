library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync is
Port (
    rst: in std_logic;
    clk: in std_logic;
    RX:  in std_logic_vector(7 downto 0);
    TX_enable: out std_logic
);
end sync;

architecture Behavioral of sync is
constant CONSTANT_8_BIT : STD_LOGIC_VECTOR(7 downto 0) := "11001010";

signal en: std_logic :='0';

begin
process(clk,rst)
begin
    if rst = '1' then
        en <= '0';
    else
        if rising_edge(clk) then
            if (CONSTANT_8_BIT = RX) then
                en <= '1';
            else
                en <= '0';
            end if;
        end if;
    end if;    
end process;
TX_enable <= en;

end Behavioral;
