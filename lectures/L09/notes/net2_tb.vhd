--------------------------------------------------------------------------------
-- Test bench for the 'net2' module.
--
-- The truth table is shown below.
--
-- | ABCD | XYZ |   
-- |------|-----|
-- | 0000 | 000 |
-- | 0001 | 001 |
-- | 0010 | 001 |
-- | 0011 | 010 |
-- | 0100 | 001 |
-- | 0101 | 010 |
-- | 0110 | 010 |
-- | 0111 | 011 |
-- | 1000 | 001 |
-- | 1001 | 010 |
-- | 1010 | 010 |
-- | 1011 | 011 |
-- | 1100 | 010 |
-- | 1101 | 011 |
-- | 1110 | 011 |
-- | 1111 | 110 |
--
-- Test each combination 0000-1111 of inputs ABCD during 10 ns.
-- Expect outputs XYZ to be set in accordance with the truth table.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity net2_tb is
end entity;

architecture behaviour of net2_tb is

--------------------------------------------------------------------------------
-- Create constants to clarify the code and avoid magic numbers.
--------------------------------------------------------------------------------
constant INPUT_SIZE: natural := 4;
constant INPUT_MIN : natural := 0;
constant INPUT_MAX : natural := (INPUT_SIZE ** 2) - 1;
constant WAIT_NS   : time := 10 ns;

--------------------------------------------------------------------------------
-- Create signals to connect to the UUT (Unit Under Test), i.e. 'net2'.
--------------------------------------------------------------------------------
signal abcd: std_logic_vector(3 downto 0);
signal xyz : std_logic_vector(2 downto 0);
begin

    --------------------------------------------------------------------------------
    -- Create an instance of the UUT (Unit Under Test), i.e. 'net2'.
    -- Connect the corresponding signals to its ports via port mapping.
    --------------------------------------------------------------------------------
    uut: entity work.net2
        port map(abcd, xyz);

    --------------------------------------------------------------------------------
    -- Test each combination 0000-1111 of inputs ABCD during 10 ns.
    -- Stop the simulation once all combinations have been tested.
    --------------------------------------------------------------------------------
    SIMULATION: process is
    begin
        for i in INPUT_MIN to INPUT_MAX loop
            abcd <= std_logic_vector(to_unsigned(i, INPUT_SIZE));
            wait for WAIT_NS;
        end loop;
        wait;
    end process;

end architecture;