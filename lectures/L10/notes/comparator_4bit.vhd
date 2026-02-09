--------------------------------------------------------------------------------
-- Implementation of a 4-bit comparator.
--
-- Inputs:
--     - abcd[3:0]: Comparator inputs, where
--         ab = abcd[3:2], 
--         cd = abcd[1:0].
-- Outputs:
--     - xyz[2:0]: Comparator outputs, where
--         x = xyz[2], 
--         y = xyz[1], 
--         z = xyz[0].
-- 
-- Function:
--     - x = 1 when ab > cd, else 0.
--     - y = 1 when ab = cd, else 0.
--     - z = 1 when ab < cd, else 0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
    port(abcd: in std_logic_vector(3 downto 0);
         xyz : out std_logic_vector(2 downto 0));
end entity;

architecture behaviour of comparator_4bit is
begin
    --------------------------------------------------------------------------------
    -- Create a process that is triggered by change of the inputs (abcd).
    --
    -- Handle each combination 0000-1111 of the inputs in accordance with the 
    -- function description. 
    --------------------------------------------------------------------------------
    process (abcd) is
    begin
        case (abcd) is
            when "0000" =>
                xyz <= "010";
            when "0001" =>
                xyz <= "001";
            when "0010" =>
                xyz <= "001";
            when "0011" =>
                xyz <= "001";
            when "0100" =>
                xyz <= "100";
            when "0101" =>
                xyz <= "010";
            when "0110" =>
                xyz <= "001";
            when "0111" =>
                xyz <= "001";
            when "1000" =>
                 xyz <= "100";
            when "1001" =>
                xyz <= "100";
            when "1010" =>
                xyz <= "010";
            when "1011" =>
                xyz <= "001";
            when "1100" =>
                xyz <= "100";
            when "1101" =>
                xyz <= "100";
            when "1110" =>
                xyz <= "100";
            when "1111" =>
                xyz <= "010";
            when others =>
                xyz <= "000";
        end case;
    end process;

end architecture;