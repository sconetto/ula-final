library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modo_calc is
    Port ( mode  : in  STD_LOGIC_VECTOR(3 downto 0);
           A0, A1, A2, A3  : in  STD_LOGIC;
           B0, B1, B2, B3  : in STD_LOGIC;
           bitvalue : out STD_LOGIC_VECTOR(7 downto 0));
end modo_calc;

architecture Behavioral of modo_calc is
    signal A : STD_LOGIC_VECTOR(3 downto 0);        -- Sinal para o Vetor A
    signal B : STD_LOGIC_VECTOR(3 downto 0);        -- Sinal para o Vetor B
    signal AORB   : STD_LOGIC_VECTOR(3 downto 0);   -- Sinal para a operação A or B bit a bit
    signal AANDB  : STD_LOGIC_VECTOR(3 downto 0);   -- Sinal para a operação A and B bit a bit
    signal AXORB  : STD_LOGIC_VECTOR(3 downto 0);   -- Sinal para a operação A xor B bit a bit
    signal NOTA   : STD_LOGIC_VECTOR(3 downto 0);   -- Sinal para a operação not A
    signal NUMA   : INTEGER RANGE 0 to 255 := 0;    -- Inteiro para o valor A
    signal NUMB   : INTEGER RANGE 0 to 255 := 0;    -- Inteiro para o valor B
    signal RESULT : INTEGER RANGE 0 to 255 := 0;    -- Inteiro para o resultado de operações entre A e B
begin

   A(0) <= A0;
   A(1) <= A1;
   A(2) <= A2;
   A(3) <= A3;
   
   B(0) <= B0;
   B(1) <= B1;
   B(2) <= B2;
   B(3) <= B3;
   
   NUMA <= TO_INTEGER(unsigned(A));
   NUMB <= TO_INTEGER(unsigned(B));
   
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
   
   process(mode)
   begin
        if mode = "0000" then bitvalue <= "00000000";
        elsif mode = "0001" then bitvalue <= "11111111";
        elsif mode = "0010" then bitvalue <= "0000" & A;
        elsif mode = "0011" then bitvalue <= "0000" & B;
        elsif mode = "0100" then bitvalue <= "0000" & AORB;
        elsif mode = "0101" then bitvalue <= "0000" & AANDB;
        elsif mode = "0110" then bitvalue <= "0000" & AXORB;
        elsif mode = "0111" then bitvalue <= "0000" & NOTA;
        elsif mode = "1000" then RESULT <= NUMA + NUMB;
        elsif mode = "1001" then RESULT <= NUMA - NUMB;
        elsif mode = "1010" then RESULT <= NUMA * NUMB;
        elsif mode = "1011" then RESULT <= NUMA / NUMB;
        elsif mode = "1100" then RESULT <= NUMA mod NUMB;
        elsif mode = "1101" then RESULT <= NUMA * NUMA;
        elsif mode = "1110" then RESULT <= NUMA * (-1);
        elsif mode = "1111" then RESULT <= NUMA + 1;
        else bitvalue <= "ZZZZZZZZ";
        end if;
    end process;
    
    bitvalue <= STD_LOGIC_VECTOR(TO_UNSIGNED(RESULT, bitvalue'length));
    

end Behavioral;
