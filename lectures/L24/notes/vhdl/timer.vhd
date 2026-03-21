--------------------------------------------------------------------------------
-- Timer module.
--
-- Generics:
--    - TICK_COUNT: Number of ticks to reach timeout (default = 50 000 000).
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_s2_n: Active-low reset, synchronized using two flip flops.
--    - enable: Timer enablement flag (1 = enabled, 0 = disabled).
--
-- Outputs:
--    - timeout: Timeout flag.
--
-- Function:
--     - Disable and reset the timer on reset.
--     - Increment the internal counter on rising clock edge when enabled.
--     - Set the timeout flag and clear the internal counter after counting 
--       up to TICK_COUNT.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity timer is
    generic(TICK_COUNT: natural := 50000000);
    port(clock, reset_s2_n, enable: in std_logic;
         timeout                  : out std_logic);
end entity;

architecture behaviour of timer is
--------------------------------------------------------------------------------
-- Internal 32-bit counter.
--------------------------------------------------------------------------------
signal counter: natural;

begin
    --------------------------------------------------------------------------------
    -- Counter process:
    --    - If reset_s2_n = 0:
    --        - Clear the internal counter.
    --        - Clear the timeout flag.
    --    - On each rising edge of clock:
    --         - If enabled = 1:
    --             - Increment the internal counter until TICK_COUNT is reached.
    --             - If timeout (TICK_COUNT == counter):
    --                 - Clear the internal counter.
    --                 - Set the timeout flag.
    --         - Clear the timeout flag except on timeout.
    --------------------------------------------------------------------------------
    process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            timeout <= '0';
            counter <= 0;
        elsif (rising_edge(clock)) then
            timeout <= '0';
            if (enable = '1') then
                if (TICK_COUNT > counter) then
                    counter <= counter + 1;
                else
                    timeout <= '1';
                    counter <= 0;
                end if;
            end if;
        end if;
    end process;
end architecture;
