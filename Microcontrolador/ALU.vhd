LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED. all;

ENTITY Alu IS
PORT (a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		op: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ci: IN STD_LOGIC; 
		r: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		co: OUT STD_LOGIC;
		z: OUT STD_LOGIC
		); 
END ENTITY;

ARCHITECTURE c_alu OF Alu IS
SIGNAL s_r: STD_LOGIC_VECTOR (8 DOWNTO 0);
BEGIN 	
	PROCESS (a,b,op,ci)
	BEGIN
		
		s_r(8) <= '0';
		CASE op Is
			WHEN "0000"=>
				s_r<="000000000";
				
			WHEN "0001"=>
				s_r<="000000000";
				
			WHEN "0010"=>
			--RL
				s_r(0)<=ci;
				s_r(1)<=a(0);
				s_r(2)<=a(1);
				s_r(3)<=a(2);
				s_r(4)<=a(3);
				s_r(5)<=a(4);
				s_r(6)<=a(5);
				s_r(7)<=a(6);
				s_r(8)<=a(7);
				
			WHEN "0011"=>
			--RR
				s_r(8)<=a(0);
				s_r(0)<=a(1);
				s_r(1)<=a(2);
				s_r(2)<=a(3);
				s_r(3)<=a(4);
				s_r(4)<=a(5);
				s_r(5)<=a(6);
				s_r(6)<=a(7);
				s_r(7)<=ci;
				
			WHEN "0100"=>
				s_r(7 DOWNTO 0)<= a AND b;
				
			WHEN "0101"=>
				s_r(7 DOWNTO 0)<= a OR b;
				
				
			WHEN "0110"=>
				s_r(7 DOWNTO 0)<=a XOR b;
				
				
			WHEN "0111"=>
				s_r(7 DOWNTO 0)<= NOT a;
			
			
			WHEN "1000"=>
				s_r(7 DOWNTO 0)<= a;
			
				
			WHEN "1001"=>
				s_r(7 DOWNTO 0)<= b;
				
				
			WHEN "1010"=>
				s_r<= a + "000000001";
				
			WHEN "1011"=>
				s_r<= a - "000000001";
				
			WHEN "1100"=>
				s_r<= ('0' & a) + ('0' & b);
				
				
			WHEN "1101"=>
				s_r<= a - b + "000000000";
				
			WHEN "1110"=>
				s_r<="011111111";
				
			WHEN "1111"=>
				s_r<="011111111";
				
		END CASE;
		r<= s_r (7 DOWNTO 0);
		co<=s_r(8);
			
		IF (s_r (7 DOWNTO 0)= "00000000") THEN 
			z<='1'; 
		ELSE
			z<='0';
		END IF;	
	END PROCESS;	
END ARCHITECTURE;
	