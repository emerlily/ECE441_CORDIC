----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2019 02:09:40 PM
-- Design Name: 
-- Module Name: LED - Behavioral
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

ENTITY LED IS
    PORT ( clk      : in STD_LOGIC;
           cycle    : in STD_LOGIC;
           x_data   : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           y_data   : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           z_data   : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           led_out  : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
END LED;

ARCHITECTURE behave OF LED IS
    SIGNAL disp     : INTEGER := 0;
    SIGNAL trig     : STD_LOGIC := '0';
    SIGNAL d_out    : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";

BEGIN
    p1: PROCESS(clk, cycle) IS
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF cycle = '1' THEN
                IF disp = 0 THEN -- 0 is x
                    d_out <= x_data;
                ELSIF disp = 1 THEN -- 1 is y
                    d_out <= y_data;
                ELSIF disp = 2 THEN -- 2 is z
                    d_out <= z_data;                 
                END IF;
                trig <= '1'; -- button triggered (clean button expected)
            ELSIF cycle = '0' and trig = '1' THEN -- only change states when button released
                IF disp = 0 THEN
                    disp <= 1;
                ELSIF disp = 1 THEN
                    disp <= 2;
                ELSIF disp = 2 THEN
                    disp <= 0;
                END IF;
                trig <= '0'; -- button no longer triggered
            END IF;
        END IF;
    END PROCESS;
    led_out <= d_out;
END behave;
