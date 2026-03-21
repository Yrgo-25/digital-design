--------------------------------------------------------------------------------
-- Metastability prevention and edge detection.
--
-- Generics:
--     - BUTTON_COUNT: Number of buttons to synchronize.
--                     Note: MSB = BUTTON_COUNT - 1 below.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n[MSB:0]: Active-low asynchronous push buttons.
--
-- Outputs:
--    - reset_s2_n: Stable, synchronized reset signal.
--    - button_edge_s2[MSB:0]: Pulses indicating a falling edge on button_n.
--
-- Function:
--     - Use a two-flip-flop synchronizer for asynchronous inputs:
--         - Each asynchronous input, except the clock, passes through two
--           flip-flops connected in series.
--         - The output of the second flip-flop is significantly less likely
--           to be metastable.
--     - Use a third flip-flop stage to detect a falling edge on button_n:
--         - button_edge_s2 = '1' when button_s2_n = '0' and button_s3_n = '1'.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity meta_prev is
    generic(BUTTON_COUNT: natural range 1 to 3 := 1);
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector((BUTTON_COUNT - 1) downto 0);
         reset_s2_n    : out std_logic;
         button_edge_s2: out std_logic_vector((BUTTON_COUNT - 1) downto 0));
end entity;

architecture behaviour of meta_prev is

--------------------------------------------------------------------------------
-- Most significant index for all button vectors.
--------------------------------------------------------------------------------
constant MSB: natural := BUTTON_COUNT - 1;

--------------------------------------------------------------------------------
-- Signals representing the reset synchronizer flip-flops.
-- 
-- Use reset_s2_n_s as an internal signal instead of reading the output port.
--------------------------------------------------------------------------------
signal reset_s1_n, reset_s2_n_s: std_logic;

--------------------------------------------------------------------------------
-- Signals representing the button synchronizer and edge-detection flip-flops.
--------------------------------------------------------------------------------
signal button_s1_n, button_s2_n, button_s3_n: std_logic_vector(MSB downto 0);
begin

    --------------------------------------------------------------------------------
    -- Connect the internal reset signal to the output port.
    --------------------------------------------------------------------------------
    reset_s2_n <= reset_s2_n_s;
    
    --------------------------------------------------------------------------------
    -- Generate a pulse when a falling edge is detected on the synchronized
    -- button signal:
    --    - button_edge_s2 = '1' when button_s2_n = '0' and button_s3_n = '1'.
    --------------------------------------------------------------------------------
    button_edge_s2 <= (not button_s2_n) and button_s3_n;

    --------------------------------------------------------------------------------
    -- Create a process to synchronize the reset signal:
    --     - If reset_n = '0':
    --         - Set all reset synchronizer stages to '0'.
    --     - Else if rising_edge(clock):
    --         - Update the flip-flop stages in sequence.
    --         - Drive the first flip-flop stage to '1'.
    --------------------------------------------------------------------------------
    RESET_PROCESS: process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            reset_s1_n   <= '0';
            reset_s2_n_s <= '0';
        elsif (rising_edge(clock)) then
            reset_s1_n   <= '1';
            reset_s2_n_s <= reset_s1_n;
        end if;
    end process;

    --------------------------------------------------------------------------------
    -- Create a process to synchronize the button signals:
    --     - If reset_s2_n_s = '0':
    --         - Set all button synchronizer stages to ones.
    --     - Else if rising_edge(clock):
    --         - Update the flip-flop stages in sequence.
    --         - Sample button_n into the first flip-flop stage.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process(clock, reset_s2_n_s) is
    begin
        if (reset_s2_n_s = '0') then
            button_s1_n <= (others => '1');
            button_s2_n <= (others => '1');
            button_s3_n <= (others => '1');
        elsif (rising_edge(clock)) then
            button_s1_n <= button_n;
            button_s2_n <= button_s1_n;
            button_s3_n <= button_s2_n;
        end if;
    end process;
end architecture;
