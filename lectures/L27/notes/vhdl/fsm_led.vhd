-------------------------------------------------------------------------------------
-- Finite State Machine (FSM) with input synchronization and a timer.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_n: Active-low asynchronous reset.
--    - button_n[1:0]: Active-low buttons used to change the internal state.
--
-- Outputs:
--    - led: LED to control.
--
-- Function:
--    - Implement the following states:
--        - STATE_OFF  : The LED is disabled.
--        - STATE_BLINK: The LED blinks every 100 ms.
--        - STATE_ON   : The LED is enabled.
--    - Update the state via button_n[1:0]:
--        - Falling edge on button_n[1] => previous state.
--        - Falling edge on button_n[0] => next state.
--    - Reset to STATE_OFF on system reset.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fsm_led is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(1 downto 0);
         led           : out std_logic);
end entity;

architecture behaviour of fsm_led is

--------------------------------------------------------------------------------
-- Enumeration of states.
--------------------------------------------------------------------------------
type state_t is (STATE_OFF, STATE_BLINK, STATE_ON);

--------------------------------------------------------------------------------
-- Timer tick count (equivalent to 100 ms).
--------------------------------------------------------------------------------
constant TIMER_TICK_COUNT: natural := 5000000; 

--------------------------------------------------------------------------------
-- Synchronized input signals after two-flip-flop metastability protection.
--------------------------------------------------------------------------------
signal reset_s2_n    : std_logic;
signal button_edge_s2: std_logic_vector(1 downto 0);

--------------------------------------------------------------------------------
-- Timer signals.
--------------------------------------------------------------------------------
signal timer_enable, timer_timeout: std_logic;

--------------------------------------------------------------------------------
-- Internal LED state.
--------------------------------------------------------------------------------
signal led_state: std_logic;

--------------------------------------------------------------------------------
-- Current state.
--------------------------------------------------------------------------------
signal state: state_t;

--------------------------------------------------------------------------------
-- Signals indicating whether to change state.
--------------------------------------------------------------------------------
signal to_prev_state, to_next_state: std_logic;

begin
    --------------------------------------------------------------------------------
    -- Assign the internal LED state.
    --------------------------------------------------------------------------------
    led <= led_state;
    
    --------------------------------------------------------------------------------
    -- Enable the timer in STATE_BLINK only.
    --------------------------------------------------------------------------------
    timer_enable <= '1' when STATE_BLINK = state else '0';
    
    --------------------------------------------------------------------------------
    -- Indicate change to previous state on falling edge on button_n[1].
    --------------------------------------------------------------------------------
    to_prev_state <= '1' when button_edge_s2(1) = '1' and button_edge_s2(0) = '0' else '0';

    --------------------------------------------------------------------------------
    -- Indicate change to next state on falling edge on button_n[0].
    --------------------------------------------------------------------------------
    to_next_state <= '1' when button_edge_s2(0) = '1' and button_edge_s2(1) = '0' else '0';

    --------------------------------------------------------------------------------
    -- Instantiate input synchronizer and edge detector.
    --------------------------------------------------------------------------------
    meta_prev: entity work.meta_prev
        generic map(BUTTON_COUNT => 2)
        port map(clock           => clock, 
                 reset_n         => reset_n, 
                 button_n        => button_n, 
                 reset_s2_n      => reset_s2_n, 
                 button_edge_s2  => button_edge_s2);

    --------------------------------------------------------------------------------
    -- Instantiate 100 ms timer.
    --------------------------------------------------------------------------------
    timer: entity work.timer
        generic map(TICK_COUNT => TIMER_TICK_COUNT)
        port map(clock, reset_s2_n, timer_enable, timer_timeout);
        
    --------------------------------------------------------------------------------
    -- Create a synchronous state machine process.
    --
    -- On reset:
    --    - Reset the internal state to STATE_OFF.
    -- On rising clock edge:
    --     - Update the current state when a falling button edge is detected.
    --------------------------------------------------------------------------------
    STATE_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            state <= STATE_OFF;
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_OFF =>
                    if (to_next_state = '1') then
                        state <= STATE_BLINK;
                    elsif (to_prev_state = '1') then
                        state <= STATE_ON;
                    end if;
                when STATE_BLINK =>
                    if (to_next_state = '1') then
                        state <= STATE_ON;
                    elsif (to_prev_state = '1') then
                        state <= STATE_OFF;
                    end if;
                when STATE_ON =>
                    if (to_next_state = '1') then
                        state <= STATE_OFF;
                    elsif (to_prev_state = '1') then
                        state <= STATE_BLINK;
                    end if;
                when others =>
                    state <= STATE_OFF;
            end case;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- Create a synchronous LED controller process.
    --
    -- On reset:
    --    - Disable the LED.
    -- On rising clock edge:
    --     - Update the LED based on the current state:
    --         - STATE_OFF  : Disable the LED.
    --         - STATE_BLINK: Toggle the LED on timeout.
    --         - STATE_ON   : Enable the LED.
    -------------------------------------------------------------------------------- 
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_state <= '0';
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_OFF =>
                    led_state <= '0';
                when STATE_BLINK =>
                    if (timer_timeout = '1') then
                        led_state <= not led_state;
                    end if;
                when STATE_ON =>
                    led_state <= '1';
                when others =>
                    led_state <= '0';
            end case;
        end if;
    end process;   
  
end architecture;
