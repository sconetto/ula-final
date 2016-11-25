library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA_TL is
    port (  prog_calc  : in  STD_LOGIC;                    -- Se é modo calculador ou programação
            modo_func  : in  STD_LOGIC_VECTOR(3 downto 0); -- Qual operação será feita
            modo_dados : in STD_LOGIC_VECTOR(1 downto 0);  -- Qual o tipo de apresentação do dado HEX, OCT, BIN e DEC
            N0, M0, N1, M1, N2, M2, N3, M3 : in STD_LOGIC; -- 4 Bits dos operandos A e B
            resultado  : out STD_LOGIC_VECTOR(7 downto 0); -- resultado das operações
            display    : out STD_LOGIC_VECTOR(6 downto 0); -- saída do display
            anodes     : inout STD_LOGIC_VECTOR(0 to 3));  -- Os 4 displays de 7 segmentos
end ULA_TL;

architecture Behavioral of ULA_TL is
component decoder_bcd
    port( dados    : in  std_logic_vector(3 downto 0);
          saida    : out std_logic_vector(6 downto 0));
    end component;

component modo_calc
    port(  mode  : in  STD_LOGIC_VECTOR(3 downto 0);
          A0, A1, A2, A3  : in  STD_LOGIC;
          B0, B1, B2, B3  : in STD_LOGIC;
          value : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component conversor
    port( resultado_in :  in STD_LOGIC_VECTOR (7 downto 0);
           modo         :  in STD_LOGIC_VECTOR (1 downto 0);
           disp_und     : out STD_LOGIC_VECTOR (3 downto 0);
           disp_dez     : out STD_LOGIC_VECTOR (3 downto 0);
           disp_cen     : out STD_LOGIC_VECTOR (3 downto 0);
           disp_mil     : out STD_LOGIC_VECTOR (3 downto 0);
           led_bin      : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal transfer : STD_LOGIC_VECTOR(3 downto 0);
    signal numero   : STD_LOGIC_VECTOR(7 downto 0);
    
begin

        anodes <= "0000";
        Decodificador : decoder_bcd port map(dados => numero, saida => display);
        Modo_calculadora : modo_calc port map(mode => modo_func, A0 => N0, A1 => N1, A2 => N2, A3 => N3, B0 => M0, B1 => M1, B2 => M2, B3 => M3, value => resultado);
end Behavioral;
