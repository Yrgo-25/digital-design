--------------------------------------------------------------------------------
-- Design of a D flip flop.
--
-- Inputs:
--     - clock  : 50 MHz system clock.
--     - reset_n: Asynchronous reset with active low ('0' = system reset).
--     - d      : Flip flop input (data).
--     - enable : Flip flop enablement signal ('1' = open, '0' = locked).
-- Outputs:
--     - q  : Flip flop output.
--     - q_n: The inverse of the flip flop output (q_n = q').
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is
    port(clock, reset_n, d, enable: in std_logic;
         q, q_n                   : out std_logic);
end entity;

architecture behaviour of d_flip_flop is
--------------------------------------------------------------------------------
-- Internal representation of q: Use this internally instead of q.
--------------------------------------------------------------------------------
signal q_s: std_logic;

begin
    --------------------------------------------------------------------------------
    -- Create a process that is triggered on change of 'reset_n' or 'clock'.
    -- If reset_n = '0' => set q_s to '0' (reset).
    -- Else if rising edge on the clock:
    --     if enable = '1' => Set q_s to d, else do nothing.
    --------------------------------------------------------------------------------
    process (clock, reset_n) is
    begin
        if (reset_n = '0') then
            q_s <= '0';
        elsif (rising_edge(clock)) then
            if (enable = '1') then
                q_s <= d;
            end if;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- Connect 'q' to its internal representation 'q_s'.
    -- Assign the inverse of 'q_s' to q_n'.
    --------------------------------------------------------------------------------
    q   <= q_s;
    q_n <= not q_s;
   
end architecture;
