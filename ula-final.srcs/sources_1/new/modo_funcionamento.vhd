----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2016 16:35:56
-- Design Name: 
-- Module Name: modo_funcionamento - Behavioral
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

entity modo_funcionamento is
    Port ( modo  : in  STD_LOGIC_VECTOR(3 downto 0);
           A0, A1, A2, A3  : in  STD_LOGIC;
           B0, B1, B2, B3  : in STD_LOGIC;
           valor : out STD_LOGIC_VECTOR(3 downto 0));
end modo_funcionamento;

architecture Behavioral of modo_funcionamento is
    signal A : STD_LOGIC_VECTOR(3 downto 0);
    signal B : STD_LOGIC_VECTOR(3 downto 0);
    signal AORB  : STD_LOGIC_VECTOR(3 downto 0);
    signal AANDB : STD_LOGIC_VECTOR(3 downto 0);
    signal AXORB : STD_LOGIC_VECTOR(3 downto 0);
    signal NOTA  : STD_LOGIC_VECTOR(3 downto 0);
    signal COMP1 : STD_LOGIC_VECTOR(3 downto 0);

begin
   A(0) <= A0;
   A(1) <= A1;
   A(2) <= A2;
   A(3) <= A3;
   
   B(0) <= B0;
   B(1) <= B1;
   B(2) <= B2;
   B(3) <= B3;
   
   AORB(0) <= A0 or B0;
   AORB(1) <= A1 or B1;
   AORB(2) <= A2 or B2;
   AORB(3) <= A3 or B3;
   
   AANDB(0) <= A0 and B0;
   AANDB(1) <= A1 and B1;
   AANDB(2) <= A2 and B2;
   AANDB(3) <= A3 and B3;
   
   AXORB(0) <= A0 xor B0;
   AXORB(1) <= A1 xor B1;
   AXORB(2) <= A2 xor B2;
   AXORB(3) <= A3 xor B3;
   
   NOTA(0) <= not A0;
   NOTA(1) <= not A1;
   NOTA(2) <= not A2;
   NOTA(3) <= not A3;
   
   with modo select
        valor <= "0000" when "0000",
                 "1111" when "0001",
                    A   when "0010",
                    B   when "0011",
                  AORB  when "0100",
                 AANDB  when "0101",
                 AXORB  when "0110",
                  NOTA  when "0111",
                 "1010" when others;

end Behavioral;
