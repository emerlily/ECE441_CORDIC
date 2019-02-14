----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2019 10:49:08 AM
-- Design Name: 
-- Module Name: Controller - Behavioral
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

ENTITY Controller IS
  PORT ( clk        : in STD_LOGIC;
         data_in    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
         data_rdy   : in STD_LOGIC;
         x_out      : out STD_LOGIC_VECTOR(15 DOWNTO 0);
         y_out      : out STD_LOGIC_VECTOR(15 DOWNTO 0);
         z_out      : out STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
END Controller;

ARCHITECTURE behave of Controller IS
    SIGNAL w        : STD_LOGIC;
    SIGNAL state    : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

BEGIN
    p_get_inputs: PROCESS(clk, data_rdy) IS
    BEGIN
        IF RISING_EDGE(clk) and RISING_EDGE(data_rdy) THEN
            IF state = "00" THEN -- 00 is get input for x
                w <= '1';
                x_out <= data_in;
                state <= "01";
            ELSIF state = "01" THEN -- 01 is get input for y
                w <= '1';
                y_out <= data_in;
                state <= "10";
            ELSIF state = "01" THEN -- 10 is get input for z
                w <= '1';
                z_out <= data_in;
                state <= "11";
            END IF;
        END IF;      
    END PROCESS p_get_inputs;
END behave;