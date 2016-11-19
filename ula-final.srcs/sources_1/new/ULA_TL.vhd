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
    port (  numero     : in  STD_LOGIC_VECTOR(3 downto 0);
            modo_func  : in  STD_LOGIC_VECTOR(3 downto 0); -- Qual operação será feita
            modo_dados : in STD_LOGIC_VECTOR(1 downto 0); -- Qual o tipo de apresentação do dado HEX, OCT, BIN e DEC
            N0, M0, N1, M1, N2, M2, N3, M3 : in STD_LOGIC; -- 4 Bits dos operandos A e B
            resultado  : out STD_LOGIC_VECTOR(3 downto 0); -- resultado das operações
            display    : out STD_LOGIC_VECTOR(6 downto 0)); -- saída do display
end ULA_TL;

architecture Behavioral of ULA_TL is
component decoder_bcd
    port( dados  : in  STD_LOGIC_VECTOR(3 downto 0);
          saida    : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

component modo_funcionamento
    port( modo  : in  STD_LOGIC_VECTOR(3 downto 0);
          A0, A1, A2, A3  : in  STD_LOGIC;
          B0, B1, B2, B3  : in STD_LOGIC;
          valor : out STD_LOGIC_VECTOR(3 downto 0));
end component;
begin
        Decodificador : decoder_bcd port map(dados => numero, saida => display);
        Resultado_modo : modo_funcionamento port map(modo => modo_func, A0 => N0, A1 => N1, A2 => N2, A3 => N3, B0 => M0, B1 => M1, B2 => M2, B3 => M3, valor => resultado);
end Behavioral;
