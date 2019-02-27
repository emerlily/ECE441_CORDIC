----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2019 11:29:13 AM
-- Design Name: 
-- Module Name: Controller_tb - Behavioral
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

ENTITY Controller_tb IS
END Controller_tb;

ARCHITECTURE behave OF Controller_tb IS
    CONSTANT c_clock_period : time := 10 ns;

    SIGNAL r_clock  : STD_LOGIC := '0';
    SIGNAL r_button : STD_LOGIC := '0';
    SIGNAL r_write  : STD_LOGIC := '0';
    SIGNAL r_in     : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_x_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_y_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_z_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_s_out  : INTEGER;
    
    COMPONENT Controller IS
      PORT ( clk            : in STD_LOGIC;
             data_in        : in STD_LOGIC_VECTOR(15 DOWNTO 0);
             data_button    : in STD_LOGIC;
             write_out      : out STD_LOGIC;
             x_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
             y_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
             z_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
             state_out      : out INTEGER
             );
    END COMPONENT Controller;
    
BEGIN
    UUT : Controller
        PORT MAP(
           clk          => r_clock,
           data_button  => r_button,
           data_in      => r_in,
           write_out    => r_write,
           x_out        => r_x_out,
           y_out        => r_y_out,
           z_out        => r_z_out,
           state_out    => r_s_out
           );
           
   p_clock_gen : PROCESS IS
   BEGIN
       WAIT FOR c_clock_period/2;
       r_clock <= NOT r_clock;
   END PROCESS p_clock_gen;
   
   PROCESS
   BEGIN
      r_in     <= x"0001";
      wait for 50 ns;
      r_button <= '1';
      wait for 50 ns;
      r_button <= '0';
      wait for 50 ns;
      
      r_in     <= x"0010";
      wait for 50 ns;
      r_button <= '1';
      wait for 50 ns;
      r_button <= '0';
      wait for 50 ns;
       
      r_in     <= x"0011";
      wait for 50 ns;
      r_button <= '1';
      wait for 50 ns;
      r_button <= '0';
      
      wait for 2 sec;
   END PROCESS;

END behave;
