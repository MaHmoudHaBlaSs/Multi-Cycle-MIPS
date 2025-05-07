library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Memory is 
	port (
        clk: in std_logic;
        -- We only have 2048 address available so 11 bits would be enough
        -- But we use 32 bit because we are dealing with other registers and gates
        -- that work with 32-bit format.
        address : in std_logic_vector(31 downto 0);
        dataIn : in std_logic_vector(31 downto 0); -- Data to write [used only with "SW"]

        -- Control Signals
        MemWrite : in std_logic;
        MemRead : in std_logic;
        
        -- Output Data [Data or Instructions]
        dataOut : out std_logic_vector(31 downto 0)
	);
					   			   
end entity;
-- Our Memory is a simple array of 2048 8-bits words [Byte]
architecture Behavioral of Memory is
    type memArray is array(0 to 2047) of std_logic_vector(7 downto 0); -- Creating custom type

	 signal Memory: memArray := (
        0  => x"8C", 1  => x"05", 2  => x"00", 3  => x"00", -- lw $5, 0($0)
        4  => x"8C", 5  => x"06", 6  => x"00", 7  => x"04", -- lw $6, 4($0)
        8  => x"00", 9  => x"A6", 10 => x"38", 11 => x"20", -- add $7, $5, $6
        12 => x"AC", 13 => x"07", 14 => x"00", 15 => x"08", -- sw $7, 8($0)
        16 => x"08", 17 => x"00", 18 => x"00", 19 => x"00", -- j 0x00000000
        others => (others => '0')
    );

begin
		
	-- Clocked process (for writes only)
    process (clk)
        variable addr_ind : Integer; 
    begin
        if (rising_edge(clk)) then
            if (MemWrite = '1') then
                addr_ind := to_integer(unsigned(address));
                Memory(addr_ind)   <= dataIn(31 downto 24); 
                Memory(addr_ind+1) <= dataIn(23 downto 16);  
                Memory(addr_ind+2) <= dataIn(15 downto 8);  
                Memory(addr_ind+3) <= dataIn(7 downto 0); 
            end if;
        end if;
    end process;

    -- Combinational read (immediate)
    process (MemRead, address)
        variable addr_ind : Integer; 
    begin
        if (MemRead = '1') then
            addr_ind := to_integer(unsigned(address));
            dataOut(31 downto 24) <= Memory(addr_ind); 
            dataOut(23 downto 16) <= Memory(addr_ind+1); 
            dataOut(15 downto 8)  <= Memory(addr_ind+2); 
            dataOut(7 downto 0)   <= Memory(addr_ind+3); 
        else
            dataOut <= (others => '0'); -- Default output
        end if;
    end process;
end architecture;
