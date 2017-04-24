----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:23:59 03/28/2017 
-- Design Name: 
-- Module Name:    UDCounterModule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.std_logic_unsigned.all; -- cheat


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UDCounterModule is
  port(Cin,Clk,PE,Res,UD: in std_logic;
       P: in std_logic_vector(4 downto 1);
       Cout: out std_logic;
       Q: out std_logic_vector(4 downto 1));
end UDCounterModule;

architecture behaviorofUDCounter of UDCounterModule is

--function countQ(Q: in std_logic_vector, UD: in std_logic) return std_logic_vector(4 downto 1) is
--  begin
--    if (UD = '1') then --up counting
--      if (Q < 9) or (Q = 10) or (Q = 12) or (Q = 14) then
--        return Q + 1;
--      elsif (Q = 9) then
--        return 0;
--      elsif (Q = 11) then
--        return 6;
--      elsif (Q = 13) then
--        return 4;
--      elsif (Q = 15) then
--        return 2;
--    else                --down counting
--      if (Q<10 and Q>0) then
--        return Q-1;
--      elsif (Q=0) then
--        return 9;
--      else
--        return Q-1;
--  end countQ;
      
signal Qs: std_logic_vector(4 downto 1);
	
begin
  
	Q <= Qs;
	
  SetCout: process(Q,UD,Cin) is
  begin
    if Cin = '1' then
      Cout <= '1';
    elsif (UD = '1' and Q(1) = '1' and Q(4) = '1') then
      Cout <= '0';
    elsif (UD = '0' and Q = "0000") then
      Cout <= '0';
    else
      Cout <= '1';
    end if;
  end process;
      
  SetQ: process(Cin,PE,Res,Clk) is
    
  begin
    if Res = '1' then
      Qs <= "0000";
    elsif PE = '1' then
      Qs <= P;
    elsif Cin = '1' then
      null;
    elsif rising_edge(Clk) then
--     Qs = countQ(Qs,UD);

  		if UD = '1' then --up counting
  			if Qs < 9 or Qs = 10 or Qs = 12 or Qs = 14 then
  				Qs <= Qs + 1;
  			elsif Qs = 9 then
  				Qs <=  "0000";
  			elsif Qs = 11 then
  				Qs <=  "0110";
  			elsif Qs = 13 then
  				Qs <=  "0100";
  			elsif Qs = 15 then
  				Qs <=  "0010";
  			end if;
  		else                --down counting
  			if Qs < 10 and Qs > 0 then
  				Qs <=  Qs - 1;
  			elsif Qs = 0 then
  				Qs <=  "1001";
  			else
  				Qs <=  Qs - 1;
  			end if;
  		end if;
    end if;
	 
  end process;
      
end behaviorOfUDCounter;

