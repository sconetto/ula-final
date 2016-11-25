library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity bcd is
   Port ( number   : in  std_logic_vector (7 downto 0);
          hundreds : out std_logic_vector (3 downto 0);
          tens     : out std_logic_vector (3 downto 0);
          ones     : out std_logic_vector (3 downto 0));
end bcd;
 
architecture Behavioral of bcd is
 
begin
 
   bin_to_bcd : process (number)
      variable shift : unsigned(19 downto 0);
      
      alias num is shift(7 downto 0);
      alias one is shift(11 downto 8);
      alias ten is shift(15 downto 12);
      alias hun is shift(19 downto 16);
   begin
      num := unsigned(number);
      one := X"0";
      ten := X"0";
      hun := X"0";
      
      for i in 1 to num'Length loop
         if one >= 5 then
            one := one + 3;
         end if;
         
         if ten >= 5 then
            ten := ten + 3;
         end if;
         
         if hun >= 5 then
            hun := hun + 3;
         end if;
         
         shift := shift_left(shift, 1);
      end loop;
      
      hundreds <= std_logic_vector(hun);
      tens     <= std_logic_vector(ten);
      ones     <= std_logic_vector(one);
   end process;
 
end Behavioral;