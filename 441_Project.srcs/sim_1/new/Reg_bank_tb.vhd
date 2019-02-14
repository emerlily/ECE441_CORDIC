----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2019 02:58:20 PM
-- Design Name: 
-- Module Name: Reg_bank_tb - Behavioral
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

ENTITY Reg_bank_tb IS
END Reg_bank_tb;

ARCHITECTURE behave of Reg_bank_tb IS
    CONSTANT c_clock_period : time := 10 ns;

    SIGNAL r_clock  : STD_LOGIC := '0';
    SIGNAL r_write  : STD_LOGIC := '0';
    SIGNAL r_x_in   : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_y_in   : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_z_in   : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL r_x_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_y_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_z_out  : STD_LOGIC_VECTOR(15 DOWNTO 0);

    COMPONENT Reg_bank IS
        PORT (
           clk          : in STD_LOGIC;
           write        : in STD_LOGIC;
           x_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           y_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           z_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           x_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           y_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           z_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
           );
    END COMPONENT Reg_bank;

BEGIN
    UUT : Reg_bank
        PORT MAP(
           clk          => r_clock,
           write        => r_write,
           x_data_in    => r_x_in,
           y_data_in    => r_y_in,
           z_data_in    => r_z_in,
           x_data_out   => r_x_out,
           y_data_out   => r_y_out,
           z_data_out   => r_z_out
           );
           
    p_clock_gen : PROCESS IS
    BEGIN
        WAIT FOR c_clock_period/2;
        r_clock <= NOT r_clock;
    END PROCESS p_clock_gen;
    
    PROCESS
    BEGIN
        r_write <= '1';
               
        r_x_in    <= x"1111";
        r_y_in    <= x"1111";
        wait for 100 ns;
        r_y_in    <= x"1111";
        wait for 100 ns;
        r_z_in    <= x"1111";
        wait for 1 sec;
    END PROCESS;

END behave;
