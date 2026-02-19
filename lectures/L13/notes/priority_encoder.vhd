--------------------------------------------------------------------------------
-- 3-to-2 priority encoder.
--
-- Inputs:
--    - a, b, c: Inputs.
-- Outputs:
--    - x, y: Outputs.
--
-- Priority: 
--     - a > b > c.
--
-- Function ('x' in the input pattern means don't care):
--    - xy = 11 when abc = 1xx
--    - xy = 10 when abc = 01x
--    - xy = 01 when abc = 001
--    - xy = 00 when abc = 000
--
-- Boolean equations:
--    - x = a + b
--    - y = a + b'c
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder is
    port(a, b, c: in std_logic;
         x, y   : out std_logic);
end entity;

architecture behaviour of priority_encoder is
signal b_n: std_logic;
begin
    --------------------------------------------------------------------------------
    -- Implement b'.
    --------------------------------------------------------------------------------
    b_n <= not b;
    
    --------------------------------------------------------------------------------
    -- Implement x and y.
    --------------------------------------------------------------------------------
    x <= a or b;
    y <= a or (b_n and c);
end architecture;
