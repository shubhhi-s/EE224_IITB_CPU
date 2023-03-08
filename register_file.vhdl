library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity register_file is 
-- PC is R7 so incorporating it in register file itself
-- A1,A2,A3 are reg addresses, D1,D2,D3 are reg data PC_w is write enable for PC and and RF_W is write enable for writing on reg
-- PC_write is input port for PC and PC_read is output port for PC
port(
    clock, reset, PC_w, RF_W : in std_logic;
    A1, A2, A3 : in std_logic_vector(2 downto 0);
    D3, PC_write : in std_logic_vector(15 downto 0);
    D1, D2, PC_read: out std_logic_vector(15 downto 0));
end entity register_file;

architecture behav of register_file is

-- defining RF as an array of 8 regs storing 16 bit data
type reg_array_type is array (7 downto 0) of std_logic_vector(15 downto 0);
signal registers : reg_array_type := (0 => "0000000000000001",1 => "0000000000000010",2 => "0000000000000011",3 => "0000000000000100",
4 => "0000000000000101",5 => "0000000000000110",6 => "0000000000000111",7 => "0000000000000000", others => "0000000000000000");

begin 

-- RF writing is synchronous
RF_writing : process(PC_w, RF_W,clock,reset)
    begin
        if (reset = '1') then
            L1 : for i in 0 to 7 loop
                registers(i) <= "0000000000000000";
            end loop L1;

        elsif(rising_edge(clock)) then
				if (RF_W = '1') then
                registers(to_integer(unsigned(A3))) <= D3;
            else
                null;
            end if;
            if (PC_w = '1') then
                registers(7) <= PC_write;
            else
                null;
            end if;
        else
            null;
        end if;
    end process RF_writing;

-- RF reading is asynchronous 
D1 <= registers(to_integer(unsigned(A1)));
D2 <= registers(to_integer(unsigned(A2)));
PC_read <= registers(7);

end architecture behav;
