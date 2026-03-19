--------------------------------------------------------------------------------
-- Device controller module.
--
-- Generics:
--    DEVICE_COUNT[1:0]: Number of devices to control (default = 1).
--                       Note: MSB = DEVICE_COUNT - 1 below.
--
-- Inputs:
--    - clock: 50 MHz system clock.
--    - reset_s2_n: Active-low reset, synchronized using two flip flops.
--    - enable[MSB:0]: Enablement flags for each device.
--    - toggle[MSB:0]: Bits indicating whether to toggle the devices.
--
-- Outputs:
--    - device[MSB:0]: Devices to control.
--
-- Function:
--     - Disable all devices on reset.
--     - Toggle a device on rising edge of the clock if the associated 
--       toggle bit is set.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity device_controller is
    generic(DEVICE_COUNT: natural range 1 to 3 := 1);
    port(clock, reset_s2_n: in std_logic;
         enable, toggle   : in std_logic_vector(DEVICE_COUNT-1 downto 0);
         devices          : out std_logic_vector(DEVICE_COUNT-1 downto 0));
end entity;

architecture behaviour of device_controller is
--------------------------------------------------------------------------------
-- Most significant bit of device vectors.
--------------------------------------------------------------------------------
constant MSB: natural := DEVICE_COUNT - 1;

--------------------------------------------------------------------------------
-- Device states.
--------------------------------------------------------------------------------
signal dev_state: std_logic_vector(MSB downto 0);

begin
    --------------------------------------------------------------------------------
    -- Continuously assign the device states to the devices.
    --------------------------------------------------------------------------------
    devices <= dev_state;

    --------------------------------------------------------------------------------
    -- Device control process:
    --    - If reset_s2_n = 0:
    --        - Turn off all devices.
    --    - On each rising edge of clock:
    --         - Iterate through each device i.
    --             - Disable devices[i] if enabled[i] = 0.
    --             - Else toggle devices[i] when toggle[i] = 1.
    --------------------------------------------------------------------------------
    process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            dev_state <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to MSB loop
                if (enable(i) = '1') then
                    if (toggle(i) = '1') then
                        dev_state(i) <= not dev_state(i);
                    end if;
                else
                    dev_state(i) <= '0';
                end if;
            end loop;
        end if;
    end process;
end architecture;
   