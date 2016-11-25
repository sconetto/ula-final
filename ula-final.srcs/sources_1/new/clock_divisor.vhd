library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity clock_divisor is
    Port ( clock_in  : IN STD_LOGIC;
           clock_out : OUT STD_LOGIC);
end clock_divisor;
 
architecture Behavioral of clock_divisor is
signal count : integer range 0 to 100000001;

begin
  clock_out <= '1' when count = 100000000 else
               '0';
 
  process(clock_in)
  begin

    if rising_edge(clock_in) then
      count <= count + 1;
    end if;
 
    if(count = 100000001) then
      count <= 0;
    end if;
  end process;
end Behavioral;