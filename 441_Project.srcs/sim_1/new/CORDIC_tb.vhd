----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2019 02:11:18 PM
-- Design Name: 
-- Module Name: CORDIC_tb - Behavioral
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

ENTITY CORDIC_tb IS
END CORDIC_tb;

ARCHITECTURE behave OF CORDIC_tb IS
    CONSTANT c_clock_period : time := 10 ns;

    SIGNAL r_clock  : STD_LOGIC := '0';
    SIGNAL r_enter  : STD_LOGIC := '0';
    SIGNAL r_cycle  : STD_LOGIC := '0';
    SIGNAL r_in     : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_out    : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    SIGNAL r_t1     : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_t2     : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_t3     : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_t4     : INTEGER;
    
    COMPONENT CORDIC IS
        PORT ( clk          : in STD_LOGIC;
               cordic_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
               enter_button : in STD_LOGIC;
               cycle_button : in STD_LOGIC;
               data_out     : out STD_LOGIC_VECTOR(15 DOWNTO 0);
               
               temp1     : out STD_LOGIC_VECTOR(15 DOWNTO 0);
               temp2     : out STD_LOGIC_VECTOR(15 DOWNTO 0);
               temp3     : out STD_LOGIC_VECTOR(15 DOWNTO 0);
               temp4     : out INTEGER
             );
    END COMPONENT CORDIC;

BEGIN

    UUT : CORDIC
        PORT MAP(
           clk          => r_clock,
           cordic_in      => r_in,
           enter_button => r_enter,
           cycle_button => r_cycle,
           data_out     => r_out,
           temp1        => r_t1,
           temp2        => r_t2,
           temp3        => r_t3,
           temp4        => r_t4
           );
           
    p_clock_gen : PROCESS IS
       BEGIN
           WAIT FOR c_clock_period/2;
           r_clock <= NOT r_clock;
    END PROCESS p_clock_gen;
    
    PROCESS
    BEGIN
    r_in     <= x"0001";
    wait for 20 ns;
    r_enter <= '1';
    wait for 20 ns;
    r_enter <= '0';
    wait for 20 ns;
    
    r_in     <= x"0011";
    wait for 20 ns;
    r_enter <= '1';
    wait for 20 ns;
    r_enter <= '0';
    wait for 20 ns;
    
    r_in     <= x"0111";
    wait for 20 ns;
    r_enter <= '1';
    wait for 20 ns;
    r_enter <= '0';
    wait for 20 ns;
    
    r_cycle <= '1';
    wait for 20 ns;
    r_cycle <= '0';
    wait for 20 ns;
    
    r_cycle <= '1';
    wait for 20 ns;
    r_cycle <= '0';
    wait for 20 ns;
        
    r_cycle <= '1';
    wait for 20 ns;
    r_cycle <= '0';
    wait for 20 ns;
    
    wait for 2 sec;

    END PROCESS;

END behave;
