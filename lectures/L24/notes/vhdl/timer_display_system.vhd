-------------------------------------------------------------------------------------
-- Timer display system with metastability prevention and timers.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n: Active-low button used to toggle internal timers.
--
-- Outputs:
--    - hex[6:0]: Hex display displaying a hexadecimal digit 0-F.
--
-- Function:
--    - Toggle an internal timer when the button is pressed.
--    - Increment an internal 4-bit counter on timeout (every 500 ms when
--      the timer is running).
--    - Display the counter value 0-F on the hex display.
--    - Reset the counter and disable the internal timer on reset.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_display_system is
    port(clock, reset_n, button_n: in std_logic;
         hex                     : out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of timer_display_system is

--------------------------------------------------------------------------------
-- Tick count for each timer (equivalent to 500 ms).
--------------------------------------------------------------------------------
constant TIMER_TICK_COUNT: natural := 25000000; 

--------------------------------------------------------------------------------
-- Synchronized input signals after two-flip-flop metastability protection.
--------------------------------------------------------------------------------
signal reset_s2_n, button_edge_s2: std_logic;

--------------------------------------------------------------------------------
-- Timer signals.
--------------------------------------------------------------------------------
signal timer_enable, timer_timeout: std_logic;

--------------------------------------------------------------------------------
-- Internal 4-bit counter.
--------------------------------------------------------------------------------
signal counter: natural range 0 to 15;

--------------------------------------------------------------------------------
-- Counter value in the form of a 4-bit vector.
--------------------------------------------------------------------------------
signal number: std_logic_vector(3 downto 0);

begin

    --------------------------------------------------------------------------------
    -- Convert the counter value to a 4-bit vector.
    --------------------------------------------------------------------------------
    number <= std_logic_vector(to_unsigned(counter, 4));

    --------------------------------------------------------------------------------
    -- Instantiate input synchronizer and edge detector.
    --------------------------------------------------------------------------------
    meta_prev: entity work.meta_prev
        port map(clock             => clock, 
                 reset_n           => reset_n, 
                 button_n(0)       => button_n, 
                 reset_s2_n        => reset_s2_n, 
                 button_edge_s2(0) => button_edge_s2);

    --------------------------------------------------------------------------------
    -- Instantiate 500 ms timer.
    --------------------------------------------------------------------------------
    timer: entity work.timer
        generic map(TICK_COUNT => TIMER_TICK_COUNT)
        port map(clock, reset_s2_n, timer_enable, timer_timeout);

    --------------------------------------------------------------------------------
    -- Instantiate hex display decoder.
    --------------------------------------------------------------------------------
    display: entity work.display
        port map(number, hex);

    --------------------------------------------------------------------------------
    -- Create a synchronous timer control process.
    --
    -- On reset:
    --    - Disable the timer.
    -- On rising clock edge:
    --     - Toggle the timer when a falling button edge is detected.
    --------------------------------------------------------------------------------
    TIMER_STATE_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            timer_enable <= '0';
        elsif (rising_edge(clock)) then
            if (button_edge_s2 = '1') then
                timer_enable <= not timer_enable;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------------------
    -- Create a synchronous counter process.
    --
    -- On reset:
    --    - Reset the internal counter to 0.
    -- On rising clock edge:
    --     - Increment the internal counter on timer timeout.
    --     - The counter will overflow naturally when incrementing to 16.
    --------------------------------------------------------------------------------
    COUNTER_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            counter <= 0;
        elsif (rising_edge(clock)) then
            if (timer_timeout = '1') then
                counter <= counter + 1;
            end if;
        end if;
    end process;

end architecture;
