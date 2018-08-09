LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED. all;

ENTITY mem IS 
PORT (address: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Data: OUT STD_LOGIC_VECTOR (13 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE e_mem OF mem IS
BEGIN
	PROCESS (address)
	BEGIN
		CASE(address) IS
		
			WHEN "0000"=>
				data<="11100100010100";
			WHEN "0001"=>
				data<="00100010000101";
			WHEN "0010"=>
				data<="11100100001111";
			WHEN "0011"=>
				data<="00100010000110";
			
			WHEN "0100"=>
				data<="11110000001010";
			WHEN "0101"=>
				data<="00100010000111";
			WHEN "0110"=>
				data<="11110000010100";
			WHEN "0111"=>
				data<="00100010001000";
			
			WHEN "1000"=>
				data<="00100100000111";
			WHEN "1001"=>
				data<="00110000000111";
			WHEN "1010"=>
				data<="00100100000111";
			WHEN "1011"=>
				data<="00110010000110";
			
			WHEN "1100"=>
				data<="00100100000110";
			WHEN "1101"=>
				data<="00000000000000";
			WHEN "1110"=>
				data<="00000000000000";
			WHEN "1111"=>
				data<="00000000000000";
				
		END CASE;
	END PROCESS;	

END ARCHITECTURE;
