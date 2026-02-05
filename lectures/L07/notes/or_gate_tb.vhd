---------------------------------------------------------------------------
-- Test bench for the OR gate implementation.
--
-- Test each combination 00-11 of inputs {a, b} during 10 ns.
-- Expect the output x to be set if a or b is high (x = a + b).
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_gate_tb is
end entity;

architecture behaviour of or_gate_tb is

---------------------------------------------------------------------------
-- Create signals to test the OR gate module by connecting to its ports.
-- Name the signals the same as the ports to which they will be connected.
---------------------------------------------------------------------------
signal a, b, x: std_logic;
begin

     ---------------------------------------------------------------------------
     -- Create an instance of the OR gate, name it or_gate1.
     -- Connect signals {a, b, x} to the corresponding ports via port mapping.
     --
     -- Note: work is our own local library.
     ---------------------------------------------------------------------------
     or_gate1: entity work.or_gate
         port map(a, b, x);   
     
     ---------------------------------------------------------------------------
     -- Test each combination 00-11 of inputs {a, b} during 10 ns.
     ---------------------------------------------------------------------------
     SIMULATION: process is
     begin
          -- Generate a loop with iterator i, use range 0 to 3 (corresponds to 00-11).
          for i in 0 to 3 loop
               -- Convert i to a 2-bit binary value, assign to {a, b}.
               (a, b) <= std_logic_vector(to_unsigned(i, 2));
               -- Hold the current state for 10 ns.
               wait for 10 ns;
          end loop;
          -- Stop the simulation once all combinations have been tested.
          wait;
     end process;
end architecture;
