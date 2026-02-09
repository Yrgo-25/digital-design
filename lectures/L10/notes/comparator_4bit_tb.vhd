--------------------------------------------------------------------------------
-- Test bench for the 'comparator_4bit' module.
-- 
-- Simulate each combination 0000-1111 of inputs abcd during 10 ns.
-- Expect outputs xyz to reflect the comparator function.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_4bit_tb is
end entity;

architecture behaviour of comparator_4bit_tb is

--------------------------------------------------------------------------------
-- Create constants to make the code more readable.
--------------------------------------------------------------------------------
constant INPUT_SIZE: natural := 4;
constant INPUT_MIN : natural := 0;
constant INPUT_MAX : natural := (2 ** INPUT_SIZE) - 1;
constant WAIT_NS   : time := 10 ns;

--------------------------------------------------------------------------------
-- Create signals used to connect to the UUT (Unit Under Test), i.e. the
-- 'comparator_4bit' module.
--------------------------------------------------------------------------------
signal abcd: std_logic_vector(3 downto 0);
signal xyz : std_logic_vector(2 downto 0);

begin
    --------------------------------------------------------------------------------
    -- Create the UUT. 
    -- Use port mapping to connect its ports to the signals with the same name.
    --
    -- Tell the compiler to look for entity 'comparator_4bit' inside the local
    -- library 'work'.
    --------------------------------------------------------------------------------
    uut: entity work.comparator_4bit
        port map(abcd, xyz);
        
    --------------------------------------------------------------------------------
    -- Create a process without a sensitivity list => basically a while (1) loop.
    -- Test each combination 0000-1111 (0-15) of inputs abcd during 10 ns.
    --
    -- Use iterator 'i' to generate numbers 0-15. 
    -- Cast the value of 'i' to 4-bit unsigned form, then to a 4-bit binary vector.
    -- Assign this value to 'abcd' => the input of the UUT is updated.
    -- Hold each combination for 10 ns.
    -- Halt the process once the simulation is complete.
    --------------------------------------------------------------------------------
    process is
    begin
         for i in INPUT_MIN to INPUT_MAX loop  
             abcd <= std_logic_vector(to_unsigned(i, INPUT_SIZE));
             wait for WAIT_NS;
         end loop;
         wait;
    end process;

end architecture;