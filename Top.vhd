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

entity Top is
port ( Clk		: in STD_LOGIC;
		 Rst		: in STD_LOGIC;
		 Input	: in STD_LOGIC;
		 Output	: out STD_LOGIC_VECTOR(5 downto 0));
end Top;

architecture rtl of Top is
	-- Component declaration
	component FreqDiv
	port (
		Clk   : in  STD_LOGIC;
		Rst   : in  STD_LOGIC;
		ClkEn	: out  STD_LOGIC);
	end component;
	
	component UC
	port (
		Clk   : in  STD_LOGIC;
		Rst   : in  STD_LOGIC;
		ClkEn : in  STD_LOGIC;
		Input	: in STD_LOGIC;
		Output	: out STD_LOGIC_VECTOR(5 downto 0));
	end component;
	
	-- Embedded signal declaration
	signal ClkEn_emb	:	STD_LOGIC;
	
begin 
	-- Intantiate Components
	   I1 : FreqDiv
		port map (
			Clk 	=> Clk,
			Rst 	=> Rst,
			ClkEn => ClkEn_emb);
			
		Is2 : UC
		port map (
			Clk    => Clk,
			Rst    => Rst,
			ClkEn  => ClkEn_emb,
			Input	 => Input,
			Output => Output);  
			
end rtl;
