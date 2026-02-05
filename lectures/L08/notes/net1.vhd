--------------------------------------------------------------------------------
-- Digital circuit consisting of four inputs ABCD and three outputs XYZ.
--
-- Truth table:
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
-- 
--
-- Boolean equations (derived using Karnaugh maps):
--    - X = A ^ B
--    - Y = D
--    - Z = B'D' + CD
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity net1 is
    port(a, b, c, d: in std_logic;
         x, y, z   : out std_logic);
end entity;

architecture behaviour of net1 is
signal b_n, d_n: std_logic;
begin
    -- Implement inverted signals.
    b_n <= not b;
    d_n <= not d;
    
    -- Implement logic functions.
    x <= a xor b;
    y <= d;
    z <= (b_n and d_n) or (c and d);

end architecture;
