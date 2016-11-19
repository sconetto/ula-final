----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2016 12:40:59
-- Design Name: 
-- Module Name: decoder_bcd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_bcd is
Port (
      dados    : in  std_logic_vector(3 downto 0);
      saida    : out std_logic_vector(0 to 6));
end decoder_bcd;

architecture Behavioral of decoder_bcd is
begin
    with dados select
        saida <= "0000001" when "0000",-- 0
		         "1001111" when "0001",-- 1
		         "0010010" when "0010",-- 2
		         "0000110" when "0011",-- 3
		         "1001100" when "0100",-- 4
	    	     "0100100" when "0101",-- 5
	    	     "0100000" when "0110",-- 6
	    	     "0001111" when "0111",-- 7
	    	     "0000000" when "1000",-- 8
	    	     "0000100" when "1001",-- 9
	    	     "0001000" when "1010",-- A
                 "1100000" when "1011",-- B
                 "0110001" when "1100",-- C
                 "1000010" when "1101",-- D
                 "0110000" when "1110",-- E
                 "0111000" when "1111",-- F
	    	     "1111110" when others;-- ERRO
end Behavioral;
