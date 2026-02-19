--------------------------------------------------------------------------------
-- Test bench for the 'priority_encoder' module.
--
-- Test each input combination 000-111 of inputs 'abc'.
-- Expect the output 'xy' to be as follows:
--
-- Function ('x' in the input pattern means don't care):
--    - xy = 11 when abc = 1xx
--    - xy = 10 when abc = 01x
--    - xy = 01 when abc = 001
--    - xy = 00 when abc = 000
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder_tb is
end entity;

architecture behaviour of priority_encoder_tb is
--------------------------------------------------------------------------------
-- Test parameters.
--------------------------------------------------------------------------------
constant INPUT_SIZE: natural := 3;
constant INPUT_MIN : natural := 0;
constant INPUT_MAX : natural := (2 ** INPUT_SIZE) - 1;
constant WAIT_NS   : time := 10 ns;

--------------------------------------------------------------------------------
-- Signals to connect to the UUT (Unit Under Test) for simulation.
-- Use vectors to simplify visual verification in ModelSim.
--------------------------------------------------------------------------------
signal abc: std_logic_vector(2 downto 0);
signal xy : std_logic_vector(1 downto 0);
begin

    --------------------------------------------------------------------------------
    -- Create an instance of the UUT. Connect local signals to it's ports for
    -- simulation.
    --------------------------------------------------------------------------------
    uut: entity work.priority_encoder
        port map(a => abc(2), 
                 b => abc(1), 
                 c => abc(0),
                 x => xy(1), 
                 y => xy(0));

    --------------------------------------------------------------------------------
    -- Test each combination 000-111 of inputs 'abc' for 10 ns each.
    -- Halt the process once finished.
    --------------------------------------------------------------------------------
    SIMULATION: process is
    begin
        for i in INPUT_MIN to INPUT_MAX loop
            abc <= std_logic_vector(to_unsigned(i, INPUT_SIZE));
            wait for WAIT_NS;
        end loop;
        wait;
    end process;
end architecture;
