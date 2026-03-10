--------------------------------------------------------------------------------
-- LED toggle system with metastability prevention.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n: Active-low button input used to toggle the LED.
-- Outputs:
--    - led: LED toggled on the falling edge of button_n.
--
-- Function:
--    - Toggle the LED when the button is pressed.
--    - Turn off the LED during reset.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle2 is
    port(clock, reset_n, button_n: in std_logic;
         led                     : out std_logic);
end entity;

architecture behaviour of led_toggle2 is

--------------------------------------------------------------------------------
-- Stable reset signal synchronized using a two-flip-flop synchronizer.
--------------------------------------------------------------------------------
signal reset_s2_n: std_logic;

--------------------------------------------------------------------------------
-- Pulse indicating a falling edge on button_n, synchronized using
-- a two-flip-flop synchronizer.
--------------------------------------------------------------------------------
signal button_edge_s2: std_logic;

--------------------------------------------------------------------------------
-- Internal LED state.
--------------------------------------------------------------------------------
signal led_state: std_logic;

begin
    --------------------------------------------------------------------------------
    -- Connect the output LED to the internal LED state.
    --------------------------------------------------------------------------------
    led <= led_state;
    
    --------------------------------------------------------------------------------
    -- Instantiate meta_prev and connect its ports.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
       port map(clock, reset_n, button_n, reset_s2_n, button_edge_s2);
       
    --------------------------------------------------------------------------------
    -- LED control process:
    --    - If reset_s2_n = '0', turn off the LED.
    --    - On each rising edge of clock:
    --         - Toggle the LED when button_edge_s2 = '1'.
    --         - Equivalent operation: led_state <= not led_state;
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_state <= '0';
        elsif (rising_edge(clock)) then
            if (button_edge_s2 = '1') then
                led_state <= not led_state;
            end if;
        end if;
    end process;

end architecture;
