library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ULA_TL is
    port (  clk_tl     : in STD_LOGIC;                     -- Clock para funcionamento do display
            prog_calc  : in  STD_LOGIC;                    -- Se é modo calculador ou programação
            modo_func  : in  STD_LOGIC_VECTOR(3 downto 0); -- Qual operação será feita
            modo_dados : in STD_LOGIC_VECTOR(1 downto 0);  -- Qual o tipo de apresentação do dado HEX, OCT, BIN e DEC
            N0, M0, N1, M1, N2, M2, N3, M3 : in STD_LOGIC; -- 4 Bits dos operandos A e B
            display    : out STD_LOGIC_VECTOR(6 downto 0); -- saída do display
            anodes     : inout STD_LOGIC_VECTOR(0 to 3));  -- Os 4 displays de 7 segmentos
end ULA_TL;

architecture Behavioral of ULA_TL is

component modo_calc
    port(  mode  : in  STD_LOGIC_VECTOR(3 downto 0);       -- Modo de operação
          A0, A1, A2, A3  : in  STD_LOGIC;                 -- Bits de Entrada A
          B0, B1, B2, B3  : in STD_LOGIC;                  -- Bits de Entrada B
          bitvalue : out STD_LOGIC_VECTOR(7 downto 0));    -- Resultado da Operação (8 bits)
end component;

component driver_display
    port (  clk         : in  STD_LOGIC;                        -- Clock da placa
            modo_a      : in  STD_LOGIC_VECTOR (1 downto 0);    -- Apresentação display -> '00' decimal - '01' Hexa - '10' binario - 11 octal
            result      : in  STD_LOGIC_VECTOR (7 downto 0);    -- Resultado das operações (8 bits)
            disp_en     : out STD_LOGIC_VECTOR (3 downto 0);    -- Controle enable displays (4 bits)
            bar_7seg    : out STD_LOGIC_VECTOR (6 downto 0);    -- Saída 7 bits BCD
            saida       : out STD_LOGIC_VECTOR (7 downto 0);    -- Saída Auxiliar do resultado
            bin         : out STD_LOGIC_VECTOR (7 downto 0));   -- Resultado em binário
    end component;

    signal numero     : STD_LOGIC_VECTOR(7 downto 0);
    signal out_number : STD_LOGIC_VECTOR(7 downto 0);
    
begin

        Modo_calculadora : modo_calc port map(mode => modo_func, A0 => N0, A1 => N1, A2 => N2, A3 => N3, B0 => M0, B1 => M1, B2 => M2, B3 => M3, bitvalue => numero);
        Driver : driver_display port map(clk => clk_tl, modo_a => modo_dados, result => numero, disp_en => anodes, bar_7seg => display, saida => out_number);
        
end Behavioral;
