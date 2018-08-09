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
SIGNAL TempR: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TempA: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TempC: STD_LOGIC;
SIGNAL TempZ: STD_LOGIC;
SIGNAL TempZz: STD_LOGIC;
SIGNAL Cr: STD_LOGIC;

SIGNAL W: STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL PC: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL PCr: STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL Memdata: STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL IR: STD_LOGIC_VECTOR (13 DOWNTO 0);

SIGNAL Temp_ram_addr: STD_LOGIC_VECTOR (6 DOWNTO 0);
SIGNAL Temp_ram_dataout: STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Temp_ram_datain: STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Temp_ram_nwe:  STD_LOGIC;
SIGNAL Temp_ram_clk: STD_LOGIC;

BEGIN 

--Port MAP

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
										
RAM: ENTITY work.ram PORT MAP (	data_in=> Temp_ram_datain,
											addr=> Temp_ram_addr,
											data_out=> Temp_ram_dataout,
											nwe=>Temp_ram_nwe,
											clk=>Temp_ram_clk
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
					Temp_ram_nwe<='1';
					prox_estado<= dos;	
				
				WHEN dos =>
					TempS<=IR(11 DOWNTO 8);
					IF IR (13 DOWNTO 12)<="11" THEN 
						TempB<= IR(7 DOWNTO 0);
					ELSIF IR (13 DOWNTO 12)<= "00" THEN 
						TempB<= Temp_ram_dataout;
					ELSE 
						TempB<="00000000";
					END IF; 
					TempA<=W;
					PCr<= PC + "0001"	;
					Temp_ram_nwe<='1';
					prox_estado<= tres;
		
				WHEN tres=>
					IF IR(13 DOWNTO 12)<="11" THEN 
						W<=TempR;
						Temp_ram_nwe<='1';
					ELSIF IR(13 DOWNTO 12)<="00" THEN 
						IF IR(7)<='0' THEN 
							W<=TempR;
							Temp_ram_nwe<='1';
						ELSE
							Temp_ram_nwe<='0';
						END IF;
					ELSE
					Temp_ram_nwe<='1';
					END IF;
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
			ELSIF clk'event AND clk='0' THEN
				Temp_ram_clk<='0';
			END IF;
			
	END PROCESS flipflop;

END ARCHITECTURE;