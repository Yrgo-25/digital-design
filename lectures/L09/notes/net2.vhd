--------------------------------------------------------------------------------
-- Digital circuit consisting of four inputs ABCD and three outputs XYZ.
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
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity net2 is
    port(abcd: in std_logic_vector(3 downto 0);
         xyz : out std_logic_vector(2 downto 0));
end entity;

architecture behaviour of net2 is
begin

    --------------------------------------------------------------------------------
    -- Create a process that is triggered upon change of ABCD, i.e. if any of the
    -- bits in ABCD are changed. Use a case statement to implement the circuit
    -- in accordance with the truth table. Enable all outputs on error.
    --------------------------------------------------------------------------------
    process (abcd) is
    begin
       case (abcd) is
           when "0000" => 
               xyz <= "000";
           when "0001" => 
               xyz <= "001";
           when "0010" =>
               xyz <= "001";
           when "0011" =>
               xyz <= "010";
           when "0100" =>
               xyz <= "001";
           when "0101" =>
               xyz <= "010";
           when "0110" =>
               xyz <= "010";
           when "0111" =>
               xyz <= "011";
           when "1000" => 
               xyz <= "001";
           when "1001" => 
               xyz <= "010";
           when "1010" =>
               xyz <= "010";
           when "1011" =>
               xyz <= "011";
           when "1100" =>
               xyz <= "010";
           when "1101" =>
               xyz <= "011";
           when "1110" =>
               xyz <= "011";
           when "1111" =>
               xyz <= "110";
           when others =>
               xyz <= "111";
       end case;
    end process;

end architecture;

