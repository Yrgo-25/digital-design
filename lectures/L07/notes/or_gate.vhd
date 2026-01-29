--------------------------------------------------------------------------------
-- Design of a 2-bit OR-gate.
--
-- Inputs:
--      a: First input.
--      b: Second input.
--
-- Outputs:
--     x: output.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; -- Contains data type 'std_logic'.

--------------------------------------------------------------------------------
-- Entity is the outside of the module.
-- Here the ports (inputs and outputs) are defined.
--------------------------------------------------------------------------------
entity or_gate is
    port(a, b: in std_logic;
         x   : out std_logic);
end entity;

--------------------------------------------------------------------------------
-- The architecture is the inside of the module.
-- Here we describe the behaviour of the circuit.
--------------------------------------------------------------------------------
architecture behaviour of or_gate is
begin
    x <= a or b;
end architecture;
