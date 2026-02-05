--------------------------------------------------------------------------------
-- Test bench for the `net1` module.
--
-- Test each combination 0000 - 1111 of inputs ABCD during 10 ns each.
-- Expect the outputs to be set according to the truth table below:
--
-- | ABCD | XYZ |   
-- |------|-----|
-- | 0000 | 001 |
-- | 0001 | 010 |
-- | 0010 | 001 |
-- | 0011 | 011 |
-- | 0100 | 100 |
-- | 0101 | 110 |
-- | 0110 | 100 |
-- | 0111 | 111 |
-- | 1000 | 101 |
-- | 1001 | 110 |
-- | 1010 | 101 |
-- | 1011 | 111 |
-- | 1100 | 000 |
-- | 1101 | 010 |
-- | 1110 | 000 |
-- | 1111 | 011 |
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity net1_tb is
end entity;

architecture behaviour of net1_tb is

-- Test parameters.
constant INPUT_SIZE: natural := 4;
constant INPUT_MAX : natural := (INPUT_SIZE ** 2) - 1;
constant WAIT_NS   : time := 10 ns;

-- Test signals (corresponds to the ports of the UUT (Unit Under Test).
signal abcd: std_logic_vector(3 downto 0);
signal xyz : std_logic_vector(2 downto 0);

begin

    --------------------------------------------------------------------------------
    -- Create an instance of the UUT (Unit Under Test). Connect its ports to the 
    -- corresponding signals.
    --------------------------------------------------------------------------------
    uut: entity work.net1
        port map(abcd(3), abcd(2), abcd(1), abcd(0),
             xyz(2), xyz(1), xyz(0));
             
    --------------------------------------------------------------------------------
    -- Test each combination 0000-1111 of inputs abcd during 10 ns.
    --------------------------------------------------------------------------------
    SIMULATION: process is
    begin
        for i in 0 to INPUT_MAX loop
            abcd <= std_logic_vector(to_unsigned(i, INPUT_SIZE));
            wait for WAIT_NS;
        end loop;
        wait;
    end process;

end architecture;
