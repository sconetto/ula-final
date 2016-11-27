library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divisor is
    Port ( clock_in      :  in STD_LOGIC;
           clock_out : out STD_LOGIC);
end clock_divisor;

architecture Behavioral of clock_divisor is

   constant count_disp : integer := (220000);
   signal tmp_clk_disp : std_logic := '0';
   
begin
process (clock_in, tmp_clk_disp)
    variable count : integer := 0;
begin
      if (rising_edge(clock_in)) then
         if (count = count_disp) then
            tmp_clk_disp <= not tmp_clk_disp;
            count := 0;
         else
            count := count + 1;
         end if;          
      end if;
      clock_out <= tmp_clk_disp;
      end process;
end Behavioral;