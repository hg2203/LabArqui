LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all; 
USE ieee.std_logic_unsigned.all; 

ENTITY ram IS 
	PORT (addr: IN std_logic_vector (6 downto 0); 
			nwe: IN std_logic; 
			clk: IN std_logic; 
			data_in: IN std_logic_vector (7 downto 0); 
			data_out: OUT std_logic_vector (7 downto 0)); 
END ENTITY; 

ARCHITECTURE a_ram of ram IS 

TYPE ram_table IS array (0 to 127) of std_logic_vector (7 downto 0); 
SIGNAL rammemory: ram_table; 

BEGIN 
	PROCESS (nwe, clk, addr) 
	BEGIN 
		IF clk'event AND clk='1' THEN 
			IF nwe='0' THEN 
				rammemory (conv_integer(addr))<=data_in; 
			END IF; 
		END IF; 
	END PROCESS; 
	data_out<=rammemory(conv_integer(addr)); 

END ARCHITECTURE; 