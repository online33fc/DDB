--------------------FLIP-FLOP--------------------
--ENTITY FF_D_POSITIVE EDGE-TRIGGERING
ENTITY FF_D IS
  PORT(
    D, clock, Pre: IN BIT;
    Q: OUT BIT);
END FF_D;

--ARCHITECTURE IFTHEN OF FF_D
ARCHITECTURE ifthen OF FF_D IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (D, clock, Pre)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        --FF D POSITIVE EDGE-TRIGGERED
        ELSIF CLOCK'EVENT AND clock = '1' THEN 
          qint <= D AFTER 2 ns;
        END IF;
    END PROCESS;
    Q <= qint;
END ifthen;

-----------------MULTIPLEXOR 4 A 1-----------------
--ENTITY MUX4A1
ENTITY mux4a1 IS
	PORT(
		a, b, c, d, sel1, sel0: IN BIT;
		f: OUT BIT);
END mux4a1;

--ARCHITECTURE LOGICA_RETARD OF MUX4A1
ARCHITECTURE logica_retard OF mux4a1 IS
	BEGIN
		f <= ((( NOT sel1) AND (NOT sel0)) AND a) OR 
					((NOT sel1) AND sel0 AND b) OR 
					(sel1 AND (NOT sel0) AND c) OR 
					(sel1 AND sel0 AND d) AFTER 2 ns;
END logica_retard;

--ARCHITECTURE IFTHEN OF MUX4A1
ARCHITECTURE ifthen OF mux4a1 IS
	BEGIN
	  PROCESS(a, b, c, d, sel1, sel0)
	    BEGIN
		    IF sel1 = '0' AND sel0 = '0' THEN f <= a AFTER 2 ns;
		    ELSIF sel1 = '0' AND sel0 = '1' THEN f <= b AFTER 2 ns;
		    ELSIF sel1 = '1' AND sel0 = '0' THEN f <= c AFTER 2 ns; 
		    ELSE f <= d AFTER 2 ns;
		    END IF;
		 END PROCESS;
END ifthen;
--S'ha comprovat el funcionament de logica_retard i ifthen 
--en un testbench a part, ambdòs funcionen correctament.

----------------------REGISTRE--------------------
--ENTITY REGISTRE
ENTITY registre IS
  PORT(
    a2, a1, a0, sel1, sel0, E, clock: IN BIT;
    Q2, Q1, Q0: OUT BIT);
END registre;

--ARCHITECTURE ESTRUCTURAL OF REGISTRE
ARCHITECTURE estructural OF registre IS
  
  --COMPONENTS THAT WE WILL NEED TO MAKE OUR ESTRUCTURAL CIRCUIT:
  --THREE FLIP-FLOP D AND THREE MUX4A1
  COMPONENT FF_D IS
    PORT(
      D, clock, Pre: IN BIT;
      Q: OUT BIT);
  END COMPONENT;

  COMPONENT mux4a1 IS
    PORT(
      a, b, c, d, sel1, sel0: IN BIT;
      f: OUT BIT);
  END COMPONENT;
  
  --DEFINING INTERNAL SIGNALS
  SIGNAL q_2, q_1, q_0: BIT; 
  SIGNAL mux4a1_d2, mux4a1_d1, mux4a1_d0: BIT;

  FOR DUT1: mux4a1 USE ENTITY WORK.mux4a1(ifthen);
  FOR DUT2: FF_D USE ENTITY WORK.FF_D(ifthen);
  FOR DUT3: mux4a1 USE ENTITY WORK.mux4a1(ifthen);
  FOR DUT4: FF_D USE ENTITY WORK.FF_D(ifthen);
  FOR DUT5: mux4a1 USE ENTITY WORK.mux4a1(ifthen);
  FOR DUT6: FF_D USE ENTITY WORK.FF_D(ifthen);
  
  

  --LET'S ASSIGN INTERNAL SIGNALS
  BEGIN
    --WE SET PRESET TO '1' BY DEFAULT SINCE WE 
    --DON'T HAVE AN INPUT OF PRESET IN OUR REGISTRE ENTITY
    DUT1: mux4a1 PORT MAP('1', q_2, a2, E, sel1, sel0, mux4a1_d2);
    DUT2: FF_D PORT MAP(mux4a1_d2, clock, '1', q_2); 
    DUT3: mux4a1 PORT MAP('1', q_1, a1, q_2, sel1, sel0, mux4a1_d1);
    DUT4: FF_D PORT MAP(mux4a1_d1, clock, '1', q_1);
    DUT5: mux4a1 PORT MAP('1', q_0, a0, q_1, sel1, sel0, mux4a1_d0);  
    DUT6: FF_D PORT MAP(mux4a1_d0, clock, '1', q_0);
    
  --ASSIGNING THE VALUES OF OUTPUTS OF ESTRUCTURAL STRUCTURE
  Q2 <= q_2;
  Q1 <= q_1;
  Q0 <= q_0;
END estructural;

-------------------------TESTBENCH------------------------
--ENTITY OF TESTBENCH
ENTITY bdp IS
END bdp;

--ARCHITECTURE OF TESTBENCH
ARCHITECTURE test OF bdp IS
  
  --COMPONENT THAT WE ARE GOING TO TEST OUT
  COMPONENT registre IS
    PORT(
      a2, a1, a0, sel1, sel0, E, clock: IN BIT;
      Q2, Q1, Q0: OUT BIT);
  END COMPONENT;
  
  --ASSIGNING SIGNALS OF INPUT AND OUTPUT
  --INPUTS
  SIGNAL a2, a1, a0, sel1, sel0, E, clock: BIT;
  --OUTPUTS 
  SIGNAL Q2, Q1, Q0: BIT; 
    
  FOR DUT1: registre USE ENTITY WORK.registre(estructural);
  
  --LET'S BEGIN WITH THE TEST
  BEGIN
    DUT1: registre PORT MAP(a2, a1, a0, sel1, sel0, E, clock, Q2, Q1, Q0); 
      
      --SETTING UP INPUT VARIATION TIMES
      a2 <= not a2 after 80 ns;
      a1 <= not a1 after 40 ns;
      a0 <= not a0 after 20 ns;
      E <= not E after 200 ns;
      sel1 <= not sel1 after 32 ns; 
      sel0 <= not sel0 after 16 ns;
      clock <= not clock after 10 ns;
END test;
