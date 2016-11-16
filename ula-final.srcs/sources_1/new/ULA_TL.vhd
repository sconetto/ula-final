----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2016 12:36:34
-- Design Name: 
-- Module Name: ULA_TL - Behavioral
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

entity ULA_TL is
--  Port ( );
end ULA_TL;

architecture Behavioral of ULA_TL is
component decoder_BCD
    port( entrada  : in  STD_LOGIC_VECTOR(3 downto 0);
          saida    : out STD_LOGIC_VECTOR(6 downto 0));
    end component;
begin


end Behavioral;
