library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity temporary_register is
    port(
        clock, reset: in std_logic; 
        temp_write : in std_logic_vector(15 downto 0);
        temp_read : out std_logic_vector(15 downto 0);
        temp_W : in std_logic);
end entity temporary_register;
-- temp_write is input port for writing and temp_read is output port for temp reg
architecture behav of temporary_register is

signal dummy: std_logic_vector(15 downto 0);

begin 

temp_read <= dummy;

-- writing is synchronous and teemp_W high enable
temp_writing : process(temp_w,clock,reset)
    begin
        if (reset = '1') then
            dummy <= "0000000000000000";
        
        elsif(clock' event and clock = '1') then
            if (temp_w='1') then
                dummy <= temp_write;
            else
                null;
            end if;
        else
            null;   
        end if;
    end process temp_writing;
end architecture behav;