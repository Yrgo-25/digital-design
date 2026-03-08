--------------------------------------------------------------------------------
-- @brief Describe a digital system consisting of a clock, a reset button, 
--        two push buttons, and two LEDs. 
-- 
--        Toggle a given LED when the corresponding button is pressed. 
--
--        Turn off all LEDs immediately during a system reset.
--
-- @param clock         50 MHz system clock.
-- @param reset_n       Active-low reset signal for generating system reset.
-- @param button_n[1:0] Active-low push buttons for toggling the LEDs.
-- @param led[1:0]      LEDs that toggle when the corresponding push button 
--                      is pressed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle1 is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(1 downto 0);
         led           : out std_logic_vector(1 downto 0));
end entity;

architecture behaviour of led_toggle1 is
--------------------------------------------------------------------------------
-- Previous button values (for edge detection).
--------------------------------------------------------------------------------
signal button_prev_n: std_logic_vector(1 downto 0);

--------------------------------------------------------------------------------
-- Button pressdown indicators (falling edge).
--------------------------------------------------------------------------------
signal button_edge: std_logic_vector(1 downto 0);

--------------------------------------------------------------------------------
-- LED states used for toggling the LEDs.
-- These signals are needed, as output signals cannot be directly read.
--------------------------------------------------------------------------------
signal led_state: std_logic_vector(1 downto 0);

begin
    --------------------------------------------------------------------------------
    -- Derive button_edge by detecting a falling edge of button_n:
    --  A falling edge is identified when:
    --     - button_n(i) transitions from 1 (not pressed) to 0 (pressed),
    --     - while button_prev(i) still holds 1.
    --------------------------------------------------------------------------------
    button_edge <= (not button_n) and button_prev_n;
    
    --------------------------------------------------------------------------------
    -- Continuously assign the value of led_state to the output signal led.
    --------------------------------------------------------------------------------
    led <= led_state;

    --------------------------------------------------------------------------------
    -- Update button_prev_n on system reset or on rising edge of the system clock:
    --     - If reset_n = 0: Set button_prev_n to its preset value 11.
    --     - If rising_edge(clock): Update button_prev_n with button_n.
    --------------------------------------------------------------------------------
    process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            button_prev_n <= "11";
        elsif (rising_edge(clock)) then
            button_prev_n <= button_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- Update led_state on system reset or on rising edge of the system clock:
    --     - If reset_n = 0: Set led_state to its preset value 00.
    --     - If rising_edge(clock): Toggle led_state(i) if button_edge(i) = 1.
    --------------------------------------------------------------------------------
    process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            led_state <= "00";
        elsif (rising_edge(clock)) then
            for i in 0 to 1 loop
                if (button_edge(i) = '1') then
                    led_state(i) <= not led_state(i);
                end if;
            end loop;
        end if;
    end process;
end architecture;
