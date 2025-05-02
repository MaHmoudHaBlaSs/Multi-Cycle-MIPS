-------------------------------------------------------------------------------
--
-- Title       : mux4_1
-- Design      : ALU
-- Author      : Dell
-- Company     : student
--
-------------------------------------------------------------------------------
--
-- File        : C:/My_Designs/hardware/ALU/src/MUX4_1.vhd
-- Generated   : Fri May  2 23:38:23 2025
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--    and may be overwritten
--{entity {mux4_1} architecture {Behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4_1 is
	port(
		B : in STD_LOGIC_VECTOR(31 downto 0);
		immedaite : in STD_LOGIC_VECTOR(31 downto 0);
		imm_shifted : in STD_LOGIC_VECTOR(31 downto 0);
		no : in STD_LOGIC_VECTOR(31 downto 0);
		sel : in STD_LOGIC_VECTOR(1 downto 0);
		output : out STD_LOGIC_VECTOR(31 downto 0)
	);
end mux4_1;

--}} End of automatically maintained section

architecture Behavioral of mux4_1 is
begin
	  process(B,no,immedaite,imm_shifted , sel)
    begin
        case sel is
            when "00" => output <=B ;
            when "01" => output <= no;
            when "10" => output <=immedaite ;
            when "11" => output <= imm_shifted ;
            when others => output <= (others => '0');
        end case;
    end process;

end Behavioral;
