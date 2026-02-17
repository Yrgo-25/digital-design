--------------------------------------------------------------------------------
-- 8-to-1 multiplexer.
--
-- Inputs:
--     - inputs[7:0]: MUX input values connected to slide switches.
--     - sel[2:0]   : Button selector signals (inverted in hardware).
-- Outputs:
--     - x: MUX output value.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux_8_to_1 is
    port(inputs: in std_logic_vector(7 downto 0);
         sel   : in std_logic_vector(2 downto 0);
         x     : out std_logic);
end entity;

architecture behaviour of mux_8_to_1 is

--------------------------------------------------------------------------------
-- Non-inverted selector signals to compensate for the inverted button signals.
--------------------------------------------------------------------------------
signal s: std_logic_vector(2 downto 0);

begin
     -- Invert the selector signals from the buttons.
     s <= not sel;
     
     --------------------------------------------------------------------------------
     -- Create a process that is triggered by changes in the inputs or
     -- the selector signals (we use 's' instead of 'sel' from now on).
     --------------------------------------------------------------------------------
     MUX_PROCESS: process (inputs, s) is
     begin
         -- Check the selector combination, update the output accordingly.
         -- Safety default: drive output low if an invalid selector occurs.
         case (s) is
             when "000" => 
                 x <= inputs(7);
             when "001" =>
                 x <= inputs(6);
             when "010" =>
                 x <= inputs(5);
             when "011" => 
                 x <= inputs(4);
             when "100" =>
                 x <= inputs(3);
             when "101" =>
                 x <= inputs(2);
             when "110" =>
                 x <= inputs(1);
             when "111" =>
                 x <= inputs(0);
             when others =>
                 x <= '0';
         end case;
     end process;

end architecture;