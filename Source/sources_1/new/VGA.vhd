----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 10:25:01
-- Design Name: 
-- Module Name: VGA - Behavioral
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

entity VGA is
Port ( 
pclck,rst: in std_logic;
red      : out std_logic_vector(4 downto 0); 
green    : out std_logic_vector(5 downto 0); 
blue     : out std_logic_vector(4 downto 0); 
h_sync   : out std_logic;
v_sync   : out std_logic;
sw       : in std_logic_vector(2 downto 0)
);
end VGA;

architecture Behavioral of VGA is
signal active_h: std_logic := '0';
signal active_v: std_logic := '0'; 
signal h_end   : std_logic := '0';
signal v_end   : std_logic := '0';
signal clk,locked: std_logic := '0';
signal counter_h : integer range 0 to 1000;
signal counter_v : integer range 0 to 1000;
component  design_1 is
  port (
    clk : out STD_LOGIC;
    locked_0 : out STD_LOGIC;
    pclk : in STD_LOGIC
  ); end component;
begin
c1: design_1 port map(pclk=>pclck,locked_0=>locked,clk=>clk);
p1: process(clk) 
begin
if(rising_edge(clk)) then
   if(rst = '1') and (locked ='0') then
      counter_h <= 0;
   elsif(h_end = '1') then
     counter_h <= 0;
   else
     counter_h <= counter_h +1;
   end if; 
end if;
end process p1;
p2:process(clk)
begin
if(rising_edge(clk)) then
if(rst = '1') and (locked = '0') then
     counter_v <= 0;
elsif(v_end = '1') then
    counter_v <= 0;
else
   counter_v <= counter_v + 1;
end if;
end if;
end process p2;

p3: process(counter_h)
begin
if(counter_h>=0 and counter_h<=96) then 
  h_sync <= '1';
else
  h_sync <= '0';
end if;
if(counter_h >= 144 and counter_h <= 799) then
   active_h <= '1';
else 
   active_h <= '0';
end if;
if(counter_h = 799) then
  h_end <= '1';
else
 h_end <= '0';
end if; 
end process p3;
p4:process(counter_v)
begin
if(counter_v>=0 and counter_v<=2) then 
  v_sync <= '1';
else
  v_sync <= '0';
end if;
if(counter_v >= 35 and counter_v <= 515) then
   active_v <= '1';
else 
   active_v <= '0';
end if;
if(counter_v = 524) then
  v_end <= '1';
else
 v_end <= '0';
end if; 
end process p4;
p5 : process(active_v,active_h)
begin
if(active_v = '1') and (active_h = '1') then
case sw is 
   when "000" => 
				red <= (others => '0');
				green <= (others => '0');
				blue <= (others => '0');
   when "001" => 
				red <= (others => '0');
				green <= (others => '0');
				blue <= (others => '1');
   when "010" => 
				red <= (others => '0');
				green <= (others => '1');
				blue <= (others => '0');
   when "011" => 
				red <= (others => '0');
				green <= (others => '1');
				blue <= (others => '1');
   when "100" => 
				red <= (others => '1');
				green <= (others => '0');
				blue <= (others => '0');
	when "101" => 
				red <= (others => '1');
				green <= (others => '0');
				blue <= (others => '1');
	when "110" => 
				red <= (others => '1');
				green <= (others => '1');
				blue <= (others => '0');
	when "111" => 
				red <= (others => '1');
			    green <= (others => '1');
				blue <= (others => '1');
	when others =>
				null; 

  
end case;
else
 red <= (others=>'0');
 green <= (others => '0');
 blue  <= (others => '0');
end if;
end process p5;
end Behavioral;
