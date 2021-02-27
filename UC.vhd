----------------------------------------------------------------------------------
-- Company: 		 ITESM - Campus Qro.
-- Engineer: 		 A01705935 - Oscar E. Delgadillo Ochoa
-- 
-- Create Date:    16:43:34 02/22/2021 
-- Design Name: 
-- Module Name:    Top - Behavioral 
-- Project Name: 	 Control Unit 
-- Target Devices: Max LITE-10 FPGA Board
-- Tool versions:  Quartus Prime Lite 18.1
-- Description: 	 Design a Control Unit 
--
-- Dependencies: 	 None
--
-- Revision: 		 V1.0
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity UC is
	port ( Clk   : in  STD_LOGIC;
			 Rst   : in  STD_LOGIC;
			 ClkEn : in  STD_LOGIC;
			 Input	: in STD_LOGIC;
			 Output	: out STD_LOGIC_VECTOR(5 downto 0));
end UC;

architecture rtl of UC is
  -- State name declaration as binary state
  -- User defined type as an enumeration list giving the State names
  type state_values is (Start,ROM,RI,ROM_aux,RD,AccT,AccP);

  signal pres_state: state_values;
  signal next_state: state_values;
  
  -- single signal data
  signal Data: std_logic;
  
begin
  -- Put input in a signal data
  Data <= Input;
  
  -- State Register definition process.
  -- Is Sequential based of D-type FFs
  Statereg: process(Clk, Rst)
  begin
    if (Rst = '0') then
	   pres_state <= Start;
	 elsif rising_edge(Clk) then
	   if (ClkEn = '1') then
		  pres_state <= next_state;
		end if;
	 end if;
  end process Statereg;
  
  -- Next State Logic definition.
  -- This is a combinatorial process
  -- Put in statements the State Diagram		
  FSM: process(Data, pres_state)
  begin
		if (Data = '1') then 
			PassData: case pres_state is
				when Start => next_state <= ROM;
				when ROM  => next_state <= RI;
				when RI   => next_state <= ROM_aux;
				when ROM_aux => next_state <= RD;
				when RD	 => next_state <= AccT;
				when AccT => next_state <= AccP;
				when others => next_state <= Start;
			end case PassData;	
		else
			NotData: case pres_state is
				when Start => next_state <= ROM;
				when ROM  => next_state <= RI;
				when RI   => next_state <= AccT;
				when AccT => next_state <= AccP;
				when others => next_state <= Start;
			end case NotData;
	   end if;	
  end process FSM;
 
 
  -- Output Logic Definitions of a Moore State MAchine.
  -- Outputs depend only on the current state
  -- This is a combinatorial process
  outputs: process(pres_state)
  begin
    case pres_state is 
	   when Start  => Output <= "000000";
	   when ROM	    => Output <= "100000";
	   when RI      => Output <= "011000";
	   when ROM_aux => Output <= "100000";
		when RD      => Output <= "010100";
	   when AccT    => Output <= "000010";   
	   when AccP    => Output <= "000001";   
      when others  => Output <= "000000";
	end case;
  end process outputs;
end rtl;