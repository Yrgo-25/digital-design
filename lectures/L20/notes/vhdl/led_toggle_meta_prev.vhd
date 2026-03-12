--------------------------------------------------------------------------------
-- Generic LED toggle system with metastability prevention.
--
-- Generics:
--    - DEVICE_COUNT: Number of LEDs/buttons in the system (1-3, default = 3).
--                    Note: MSB = DEVICE_COUNT - 1 below.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n[MSB:0]: Active-low buttons used to toggle the LED.
--
-- Outputs:
--    - led[MSB:0]: LEDs toggled on the falling edge of button_n.
--
-- Function:
--    - Toggle a given LED when the associated button is pressed.
--    - Turn off all LEDs during reset.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle_meta_prev is
    generic(DEVICE_COUNT: natural range 1 to 3 := 3);
    port(clock, reset_n: in std_logic;
         button_n: in std_logic_vector((DEVICE_COUNT - 1) downto 0);
         led     : out std_logic_vector((DEVICE_COUNT - 1) downto 0));
end entity;

architecture behaviour of led_toggle_meta_prev is

--------------------------------------------------------------------------------
-- Most significant index for all device vectors.
--------------------------------------------------------------------------------
constant MSB: natural := DEVICE_COUNT - 1;

--------------------------------------------------------------------------------
-- Stable reset signal synchronized using a two-flip-flop synchronizer.
--------------------------------------------------------------------------------
signal reset_s2_n: std_logic;

--------------------------------------------------------------------------------
-- Pulse indicating a falling edge on button_n, synchronized through a 
-- two-flip-flop synchronizer.
--------------------------------------------------------------------------------
signal button_edge_s2: std_logic_vector(MSB downto 0);

--------------------------------------------------------------------------------
-- Internal LED states.
--------------------------------------------------------------------------------
signal led_state: std_logic_vector(MSB downto 0);

begin

    --------------------------------------------------------------------------------
    -- Connect the output LEDs to the internal LED states.
    --------------------------------------------------------------------------------
    led <= led_state;
    
    --------------------------------------------------------------------------------
    -- Instantiate meta_prev and connect its ports.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
        generic map(BUTTON_COUNT => DEVICE_COUNT)
        port map(clock, reset_n, button_n, reset_s2_n, button_edge_s2);
    
    --------------------------------------------------------------------------------
    -- LED control process:
    --    - If reset_s2_n = '0', turn off the LEDs.
    --    - On each rising edge of clock:
    --         - Check button_edge_s2(i) for each device i.
    --             - Toggle led_state(i) when button_edge_s2(i) = '1'.
    --             - Equivalent operation: led_state(i) <= not led_state(i);
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_state <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to MSB loop
                if (button_edge_s2(i) = '1') then
                    led_state(i) <= not led_state(i);
                end if;
            end loop;
        end if;
    end process;

end architecture;
