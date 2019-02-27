----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2019 04:49:34 PM
-- Design Name: 
-- Module Name: Reg_bank - Behavioral
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

ENTITY Reg_bank IS
    PORT ( clk          : in STD_LOGIC;
           write        : in STD_LOGIC;
           x_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           y_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           z_data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           x_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           y_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           z_data_out   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
           );
END Reg_bank;

ARCHITECTURE behave OF Reg_bank IS
    SIGNAL x_reg    : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL y_reg    : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL z_reg    : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
BEGIN
    p1: PROCESS(clk, write) IS
    BEGIN
        IF RISING_EDGE(clk) AND write = '1' THEN
            x_reg <= x_data_in;
            y_reg <= y_data_in;
            z_reg <= z_data_in;
        END IF;      
    END PROCESS p1;
    -- always display reg vals on output
    x_data_out <= x_reg;
    y_data_out <= y_reg;
    z_data_out <= z_reg;
END behave;
