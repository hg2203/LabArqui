LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED. all;

ENTITY maq IS 
PORT( clk: IN STD_LOGIC;
		Reset: IN STD_LOGIC;
		Wout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		Cout: OUT STD_LOGIC;
		estado_out: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		m_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		PCout: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE e_maq OF maq IS 

--estados
TYPE tipo_estado IS (uno, dos, tres);
SIGNAL estado: tipo_estado:=uno;
SIGNAL prox_estado:tipo_estado;

--registros 
SIGNAL TempB: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TempS: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL W: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TempR: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TempA: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL PC: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL PCr: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Memdata: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL IR: STD_LOGIC_VECTOR (11 DOWNTO 0);
SIGNAL TempC: STD_LOGIC;
SIGNAL Cr: STD_LOGIC;
SIGNAL TempZ: STD_LOGIC;
SIGNAL TempZz: STD_LOGIC;

BEGIN 

Mem: ENTITY work.mem	PORT MAP (	address=> PCr,
											data=>Memdata
										);
										
ALU: ENTITY work.Alu PORT MAP (	r=>TempR,
											a=>TempA,
											b=>TempB,
											op=>TempS,
											Co=>TempC,
											Ci=>Cr,
											z=>TempZ
										);

	PROCESS(estado)		
	BEGIN
		
		IF Reset='0' THEN
			PC<="0000";
			W<="00000000";
			Cr<='0';
		ELSE
			CASE (estado) IS 
				WHEN uno=>
					IR<=Memdata;
					prox_estado<= dos;	
				
				WHEN dos=>
					TempB<= IR(7 DOWNTO 0);
					TempS<= IR (11 DOWNTO 8);
					TempA<=W;
					PCr<= PC + "0001"	;
					prox_estado<= tres;
					
				WHEN tres=>
					W<=TempR;
					prox_estado<= uno;
					Cr<=TempC;
					TempZz<=TempZ;
					PC<=PCr;
			END CASE;
		END IF;
	END PROCESS;
	Wout<=W;
	Cout<=TempC;
	PCout<= PC;
	
	PROCESS(estado)
	BEGIN
		CASE (estado) IS 
			WHEN uno =>
				estado_out<="001";
			WHEN dos =>
				estado_out<="010";
			WHEN tres=>
				estado_out<="100";
			
		END CASE;
	
	END PROCESS;
	
	
	PROCESS (clk,prox_estado,Reset)
		BEGIN 
			IF(Reset='0') then
				estado<=uno;
			
			ELSIF clk'event AND clk='1' THEN
				estado<=prox_estado;
				
			END IF;
			
	END PROCESS flipflop;

END ARCHITECTURE;