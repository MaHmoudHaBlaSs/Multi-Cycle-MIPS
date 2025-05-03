library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tempreg_tb is
end entity;

architecture tb of tempreg_tb is

    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal enable  : std_logic := '0';
    signal reg_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal reg_out : std_logic_vector(31 downto 0);

begin

    DUT : entity tempreg
        port map (clk,reset,enable,reg_in,reg_out);

    clk <= not clk after 10ns;

    process
    begin
        reset   <= '1';
        enable  <= '0';
        reg_in  <= (others => '0');
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        reg_in <= x"AAAAAAAA";
        enable <= '1';
        wait for 20 ns;
        enable <= '0';
        reg_in <= x"55555555";
        wait for 20 ns;
        enable <= '1';
        wait for 20 ns;
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        wait;
    end process;

end architecture;
