library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tempreg is
	port (
		clk,reset,enable: in std_logic;
		reg_in   : in std_logic_vector(31 downto 0);
		reg_out  : out std_logic_vector(31 downto 0)
		);
end entity;

architecture reg of tempreg is
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset='1') then reg_out <=(others => '0');
			elsif (enable ='1') then reg_out <= reg_in;
			end if;
			
		end if;
		
	end process;
	
	
end architecture ;