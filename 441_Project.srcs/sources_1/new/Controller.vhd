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
  PORT ( clk            : in STD_LOGIC;
         data_in        : in STD_LOGIC_VECTOR(15 DOWNTO 0);
         data_button    : in STD_LOGIC;
         write_out      : out STD_LOGIC;
         x_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
         y_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
         z_out          : out STD_LOGIC_VECTOR(15 DOWNTO 0);
         state_out      : out INTEGER
        );
END Controller;

ARCHITECTURE behave of Controller IS
    SIGNAL trig     : STD_LOGIC := '0';
    SIGNAL state    : INTEGER   := 0;
    SIGNAL w        : STD_LOGIC := '0';

BEGIN
    p_get_inputs: PROCESS(clk, data_button) IS
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF data_button = '1' THEN
                IF state = 0 THEN       -- 0 is get input for x
                    x_out <= data_in;
                ELSIF state = 1 THEN    -- 1 is get input for y
                    y_out <= data_in;
                ELSIF state = 2 THEN    -- 2 is get input for z
                    z_out <= data_in;
                    w <= '1';   -- write out to reg_bank
                END IF;
                trig <= '1';            -- button triggered
                
            ELSIF data_button = '0' and trig = '1' THEN -- only change states when button released
                IF state = 0 THEN
                    state <= 1;
                ELSIF state = 1 THEN
                    state <= 2;
                ELSIF state = 2 THEN
                    state <= 0;
                    w <= '0';   -- disable writing
                END IF;
                trig <= '0';            -- button no longer triggered
                
            END IF;
        END IF;      
    END PROCESS p_get_inputs;
    
    state_out <= state;
    write_out <= w;
    
END behave;
