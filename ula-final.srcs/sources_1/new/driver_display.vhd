library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity driver_display is
    Port (  clk         : in  STD_LOGIC;                        -- Clock da placa
            modo_a      : in  STD_LOGIC_VECTOR (1 downto 0);    -- Apresentação display -> '00' decimal - '01' Hexa - '10' binario - 11 octal
            result      : in  STD_LOGIC_VECTOR (7 downto 0);    -- Resultado das operações (8 bits)
            disp_en     : out STD_LOGIC_VECTOR (3 downto 0);    -- controle enable displays (4 bits)
            bar_7seg    : out STD_LOGIC_VECTOR (6 downto 0);    -- Saída 7 bits BCD
            saida       : out STD_LOGIC_VECTOR (7 downto 0); 
            bin         : out STD_LOGIC_VECTOR (7 downto 0));
            
end driver_display;

architecture Behavioral of driver_display is

component clock_divisor
        Port ( clock_in  :  in STD_LOGIC;
               clock_out : out STD_LOGIC);

end component;
component conversor
        Port ( resultado_in  :  in STD_LOGIC_VECTOR (7 downto 0);
               modo          :  in STD_LOGIC_VECTOR (1 downto 0);   -- apresentação display -> '00' decimal - '01' Hexa - '10' binario - 11 octal
               disp_und      : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display unidades
               disp_dez      : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display dezenas
               disp_cen      : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display centenas
               disp_mil      : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display 
               led_bin       : out STD_LOGIC_VECTOR (7 downto 0));

end component;

signal clk_disp    : STD_LOGIC;
signal disp_1      : STD_LOGIC_VECTOR (3 downto 0);
signal disp_2      : STD_LOGIC_VECTOR (3 downto 0);
signal disp_3      : STD_LOGIC_VECTOR (3 downto 0);
signal disp_4      : STD_LOGIC_VECTOR (3 downto 0);

signal bitvalue8  : STD_LOGIC_VECTOR (7 downto 0);

signal count_sel   : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal bcd         : STD_LOGIC_VECTOR (3 downto 0);

begin

saida <= result;

div_clock: clock_divisor port map ( clock_in  =>  clk,
                                    clock_out =>  clk_disp);

converter: conversor port map (  resultado_in  =>  result, 
                                 modo          =>  modo_a,
                                 disp_und      =>  disp_1,
                                 disp_dez      =>  disp_2,
                                 disp_cen      =>  disp_3,
                                 disp_mil      =>  disp_4,
                                 led_bin       =>  bin);

process (clk_disp) 
begin
    if (rising_edge (clk_disp)) then
        count_sel <= count_sel + 1;
    end if;
end process;

disp_en   <=  "1110" WHEN count_sel = "00" else     --(liga display unidades)
              "1101" WHEN count_sel = "01" else     --(liga display dezenas)
              "1011" WHEN count_sel = "10" else     --(liga display centenas)
              "0111" WHEN count_sel = "11" else     --(liga display milhar)
              "1111";
             
bcd     <=     disp_1 WHEN count_sel = "00" else     --(envia o valor do display 1 para o conversor BCD)
               disp_2 WHEN count_sel = "01" else     --(envia o valor do display 2 para o conversor BCD)
               disp_3 WHEN count_sel = "10" else     --(envia o valor do display 3 para o conversor BCD)
               disp_4 WHEN count_sel = "11" else     --(envia o valor do display 4 para o conversor BCD)
               "1110"; 
            
bar_7seg <=    "0000001" when bcd = "0000" else  -- 0
               "1001111" when bcd = "0001" else  -- 1
               "0010010" when bcd = "0010" else  -- 2
               "0000110" when bcd = "0011" else  -- 3
               "1001100" when bcd = "0100" else  -- 4
               "0100100" when bcd = "0101" else  -- 5
               "0100000" when bcd = "0110" else  -- 6
               "0001111" when bcd = "0111" else  -- 7 
               "0000000" when bcd = "1000" else  -- 8
               "0000100" when bcd = "1001" else  -- 9
               "0001000" when bcd = "1010" else  -- A
               "1100000" when bcd = "1011" else  -- B
               "0110001" when bcd = "1100" else  -- C
               "1000010" when bcd = "1101" else  -- D
               "0110000" when bcd = "1110" else  -- E
               "0111000" when bcd = "1111" else  -- F
               "1111110";                        -- ERRO
                                       

end Behavioral;