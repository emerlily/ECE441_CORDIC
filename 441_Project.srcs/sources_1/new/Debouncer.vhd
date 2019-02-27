----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 03:00:17 PM
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

ENTITY Debouncer IS
    PORT ( clk      : in STD_LOGIC;
           input    : in STD_LOGIC;
           output   : out STD_LOGIC
         );
END Debouncer;

ARCHITECTURE behave OF Debouncer IS
    CONSTANT    delay       :   INTEGER :=  10000;
    SIGNAL      delay_count :   INTEGER :=  0;
    
    TYPE db_state IS (ready_for_push, button_down, ready_for_release, button_up);
    SIGNAL state    :   db_state    := ready_for_push;

BEGIN

    p_db : PROCESS(clk, input) IS
    BEGIN
        IF RISING_EDGE(clk) THEN
            CASE (state) IS
                WHEN ready_for_push =>
                    IF input = '1' THEN
                        state <= button_down;
                    END IF;
                WHEN button_down =>
                    IF delay_count = delay THEN
                        delay_count <= 0;
                        state <= ready_for_release;
                    ELSE
                        delay_count <= delay_count + 1;
                    END IF;
                WHEN ready_for_release =>
                    IF input = '0' THEN
                        state <= button_up;
                    END IF;
                WHEN button_up =>
                    IF delay_count = delay THEN
                        delay_count <= 0;
                        state <= ready_for_push;
                    ELSE
                        delay_count <= delay_count + 1;
                    END IF;
            END CASE;
        END IF;
    END PROCESS;
    
    P_out : PROCESS(state) IS
    BEGIN
        CASE (state) IS
            WHEN ready_for_push     => output <= '0';
            WHEN button_down        => output <= '0';
            WHEN ready_for_release  => output <= '1';
            WHEN button_up          => output <= '0';
        END CASE;
    END PROCESS;
    
END behave;
