LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED. all;

ENTITY mem IS 
PORT (address: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Data: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE e_mem OF mem IS
BEGIN
	PROCESS (address)
	BEGIN
		CASE(address) IS
		
			WHEN "0000"=>
				data<="100100001111";
			WHEN "0001"=>
				data<="110000001100";
			WHEN "0010"=>
				data<="010111110000";
			WHEN "0011"=>
				data<="011000000011";
			
			WHEN "0100"=>
				data<="010011111111";
			WHEN "0101"=>
				data<="110001100100";
			WHEN "0110"=>
				data<="110100010100";
			WHEN "0111"=>
				data<="110001100100";
			
			WHEN "1000"=>
				data<="010100001100";
			WHEN "1001"=>
				data<="010000000000";
			WHEN "1010"=>
				data<="101100010111";
			WHEN "1011"=>
				data<="000000000000";
			
			WHEN "1100"=>
				data<="000000000000";
			WHEN "1101"=>
				data<="000000000000";
			WHEN "1110"=>
				data<="000000000000";
			WHEN "1111"=>
				data<="000000000000";
				
		END CASE;
	END PROCESS;	

END ARCHITECTURE;
