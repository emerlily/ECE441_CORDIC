----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2019 12:41:29 PM
-- Design Name: 
-- Module Name: CORDIC - Behavioral
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
--use work.ALL

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY CORDIC IS
    PORT ( clk          : in STD_LOGIC;
           cordic_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           enter_button : in STD_LOGIC; -- enter data
           cycle_button : in STD_LOGIC; -- switch between xyz
           data_out     : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           temp1        : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           temp2        : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           temp3        : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           temp4        : out INTEGER
         );
END CORDIC;

ARCHITECTURE behave OF CORDIC IS
    SIGNAL db1  : STD_LOGIC;
    SIGNAL db2  : STD_LOGIC;
    SIGNAL w    : STD_LOGIC;
    SIGNAL x1   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL y1   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL z1   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s    : INTEGER;
    SIGNAL x2   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL y2   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL z2   : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    brian   : ENTITY work.Controller
        PORT MAP (
            clk         => clk,
            data_in     => cordic_in,
            data_button => db1,
            write_out   => w,
            x_out       => x1,
            y_out       => y1,
            z_out       => z1,
            state_out   => s
            );
    
    reggie  : ENTITY work.Reg_bank
        PORT MAP (
            clk         => clk,
            write       => w,
            x_data_in   => x1,
            y_data_in   => y1,
            z_data_in   => z1,
            x_data_out  => x2,
            y_data_out  => y2,
            z_data_out  => z2
            );
    lights  : ENTITY work.LED
        PORT MAP (
            clk     => clk,
            cycle   => db2,
            x_data  => x2,
            y_data  => y2,
            z_data  => z2,
            led_out => data_out
            );
    debbie1 : ENTITY work.Debouncer
        PORT MAP (
            clk     => clk,
            input   => enter_button,
            output  => db1
            );
    debbie2 : ENTITY work.Debouncer
        PORT MAP (
            clk     => clk,
            input   => cycle_button,
            output  => db2
            );
    --temp1 <= x2;
    --temp2 <= y2;
    --temp3 <= z2;
    --temp4 <= s;
END behave;
