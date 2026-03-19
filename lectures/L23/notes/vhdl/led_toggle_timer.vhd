--------------------------------------------------------------------------------
-- LED toggle system with metastability prevention and timers.
--
-- Generics:
--     - DEVICE_COUNT: Number of LEDs/buttons, and timers in the system.
--                     Valid range = 1-3, default = 3.
--                     Note: MSB = DEVICE_COUNT - 1 below.
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n[MSB:0]: Active-low buttons used to toggle internal timers.
--
-- Outputs:
--    - led[MSB:0]: LEDs toggled via timers.
--
-- Function:
--    - Toggle an internal timer when the associated button is pressed.
--    - Toggle an LED on timeout.
--    - Turn off all LEDs during reset of if the associated timer is disabled.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity led_toggle_timer is
    generic(DEVICE_COUNT: natural range 1 to 3 := 3);
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(DEVICE_COUNT-1 downto 0);
         led           : out std_logic_vector(DEVICE_COUNT-1 downto 0));
end entity;

architecture behaviour of led_toggle_timer is

--------------------------------------------------------------------------------
-- Most significant bit of each device vector.
--------------------------------------------------------------------------------
constant MSB: natural := DEVICE_COUNT - 1;

--------------------------------------------------------------------------------
-- Enable all bits in a vector.
--------------------------------------------------------------------------------
constant ENABLE_ALL: std_logic_vector(MSB downto 0) := (others => '1');

--------------------------------------------------------------------------------
-- Tick count for each timer (equivalent to 100 ms).
--------------------------------------------------------------------------------
constant TIMER_TICK_COUNT: natural := 5000000; 

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
-- Enablement signals for the timers.
--------------------------------------------------------------------------------
signal timer_enable: std_logic_vector(MSB downto 0);

--------------------------------------------------------------------------------
-- Timeout signals for the timers.
--------------------------------------------------------------------------------
signal timer_timeout: std_logic_vector(MSB downto 0);

begin
    --------------------------------------------------------------------------------
    -- Instantiate meta_prev and connect its ports.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
        generic map(DEVICE_COUNT)
        port map(clock, reset_n, button_n, reset_s2_n, button_edge_s2);

    --------------------------------------------------------------------------------
    -- Instantiate device controller for the timers.
    --------------------------------------------------------------------------------
    timer_controller: entity work.device_controller
        generic map(DEVICE_COUNT)
        port map(clock, reset_s2_n, ENABLE_ALL, button_edge_s2, timer_enable);
        
    --------------------------------------------------------------------------------
    -- Instantiate device controller for the LEDs.
    --------------------------------------------------------------------------------
    led_controller: entity work.device_controller
        generic map(DEVICE_COUNT)
        port map(clock, reset_s2_n, timer_enable, timer_timeout, led);

    --------------------------------------------------------------------------------
    -- Generate timer instances.
    --------------------------------------------------------------------------------
    GENERATE_TIMERS: for i in 0 to MSB generate
    begin
        timer_instance: entity work.timer
            generic map(TIMER_TICK_COUNT)
            port map(clock, reset_s2_n, timer_enable(i), timer_timeout(i));
    end generate;
    
end architecture;
