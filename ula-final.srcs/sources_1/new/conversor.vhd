library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity conversor is
    Port ( resultado_in :  in STD_LOGIC_VECTOR (7 downto 0);
           modo         :  in STD_LOGIC_VECTOR (1 downto 0);   -- apresentação display -> '00' decimal - '01' Hexa - '10' binario - 11 octal
           disp_und     : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display unidades
           disp_dez     : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display dezenas
           disp_cen     : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display centenas
           disp_mil     : out STD_LOGIC_VECTOR (3 downto 0);   -- digito BCD display 
           led_bin      : out STD_LOGIC_VECTOR (7 downto 0));
end conversor;

architecture Behavioral of conversor is

begin
    process (resultado_in, modo) 
        variable v_cont               : integer range 0 to 255 := 0;
        variable v_und, v_dez, v_cen  : integer range 0 to 9   := 0;
    begin
    
        if ( modo = "00") then -- 00 Decimal
            
            if ( resultado_in(7) = '1' ) then v_cont := v_cont + 128; end if;
            if ( resultado_in(6) = '1' ) then v_cont := v_cont +  64; end if;
            if ( resultado_in(5) = '1' ) then v_cont := v_cont +  32; end if;
            if ( resultado_in(4) = '1' ) then v_cont := v_cont +  16; end if;
            if ( resultado_in(3) = '1' ) then v_cont := v_cont +   8; end if;
            if ( resultado_in(2) = '1' ) then v_cont := v_cont +   4; end if;
            if ( resultado_in(1) = '1' ) then v_cont := v_cont +   2; end if;
            if ( resultado_in(0) = '1' ) then v_cont := v_cont +   1; end if;
            
            v_und := 0; 
            v_dez := 0;
            v_cen := 0;
            
            for i in 0 to 2 loop
                exit when  (v_cont >= 0 and v_cont < 100);
                v_cen := v_cen + 1;
                v_cont := v_cont - 100;
             end loop;
             
            for i in 0 to 9 loop
                exit when  (v_cont >= 0 and v_cont < 10);
                v_dez := v_dez + 1;
                v_cont := v_cont - 10;
             end loop;
             
             v_und := v_cont;
    
                disp_mil   <=  (others => '0');
      
             case v_cen is
                 when 0 => disp_cen <= "0000";   
                 when 1 => disp_cen <= "0001";
                 when 2 => disp_cen <= "0010";
                 when 3 => disp_cen <= "0011";      -- não será usado com 8 bits - valor maximo 255
                 when 4 => disp_cen <= "0100";      -- não será usado com 8 bits - valor maximo 255
                 when 5 => disp_cen <= "0101";      -- não será usado com 8 bits - valor maximo 255
                 when 6 => disp_cen <= "0110";      -- não será usado com 8 bits - valor maximo 255
                 when 7 => disp_cen <= "0111";      -- não será usado com 8 bits - valor maximo 255
                 when 8 => disp_cen <= "1000";      -- não será usado com 8 bits - valor maximo 255
                 when 9 => disp_cen <= "1001";      -- não será usado com 8 bits - valor maximo 255
                 when others => disp_cen <= "0000";
             end case;
              
             case v_dez is
                 when 0 => disp_dez <= "0000";
                 when 1 => disp_dez <= "0001";
                 when 2 => disp_dez <= "0010";
                 when 3 => disp_dez <= "0011";
                 when 4 => disp_dez <= "0100";
                 when 5 => disp_dez <= "0101";
                 when 6 => disp_dez <= "0110";
                 when 7 => disp_dez <= "0111";
                 when 8 => disp_dez <= "1000";
                 when 9 => disp_dez <= "1001";
                 when others => disp_dez <= "0000";
              end case; 
                 
              case v_und is
                  when 0 => disp_und <= "0000";
                  when 1 => disp_und <= "0001";
                  when 2 => disp_und <= "0010";
                  when 3 => disp_und <= "0011";
                  when 4 => disp_und <= "0100";
                  when 5 => disp_und <= "0101";
                  when 6 => disp_und <= "0110";
                  when 7 => disp_und <= "0111";
                  when 8 => disp_und <= "1000";
                  when 9 => disp_und <= "1001";
             when others => disp_und <= "0000";
               end case;
               
         elsif ( modo = "01") then -- 01 Hexadecimal
             disp_mil   <=  (others => '0');
             disp_cen   <=  (others => '0');
             disp_dez   <=  resultado_in (7 downto 4);
             disp_und   <=  resultado_in (3 downto 0);

         elsif ( modo = "11") then -- 11 Octal
            
            disp_mil               <=  (others => '0');
            
            disp_cen (3 downto 0)  <=  ( "00" & resultado_in (7 downto 6));
            
            disp_dez (3 downto 0)  <=  ( '0' & resultado_in (5 downto 3));
            
            disp_und (3 downto 0)  <=  ( '0' & resultado_in (2 downto 0));      
         
         else       
         led_bin <= resultado_in;
         
          
         end if;
    end process;
    
end Behavioral;
