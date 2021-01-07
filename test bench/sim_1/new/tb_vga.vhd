----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 15:43:54
-- Design Name: 
-- Module Name: tb_vga - Behavioral
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_vga is
--  Port ( );
end tb_vga;

architecture Behavioral of tb_vga is
component VGA is Port ( 
pclck,rst: in std_logic;
red      : out std_logic_vector(4 downto 0); 
green    : out std_logic_vector(5 downto 0); 
blue     : out std_logic_vector(4 downto 0); 
h_sync   : out std_logic;
v_sync   : out std_logic;
sw       : in std_logic_vector(2 downto 0)
); end component;
signal pclck,rst: std_logic:='0';
signal red      : std_logic_vector(4 downto 0); 
signal green    : std_logic_vector(5 downto 0); 
signal blue     : std_logic_vector(4 downto 0); 
signal  h_sync  : std_logic;
signal v_sync   : std_logic;
signal sw       :  std_logic_vector(2 downto 0):= (others=>'0');
signal locked,clk : std_logic:='0';
signal counter : integer range 0 to 1000:=0;
component  design_1 is
  port (
    clk : out STD_LOGIC;
    locked_0 : out STD_LOGIC;
    pclk : in STD_LOGIC
  ); end component;
begin
c1: design_1 port map(pclk=>pclck,locked_0=>locked,clk=>clk);
p1: VGA port map(pclck => pclck,rst=>rst,red=>red,green=>green,blue=>blue,h_sync=>h_sync,v_sync=>v_sync,sw=>sw);
process
begin
pclck <= '0';
wait for 5 ns;
pclck <= '1';
wait for 5 ns;
end process;
process(clk)
begin
if(rising_edge(clk)) then

  if(counter > 999) then
  sw <= sw + 1;
  counter <= 0;
  if(sw>"111") then
  sw <= "000";
  end if;
  else
      counter <= counter + 1;
  end if;
end if;
end process;
end Behavioral;
