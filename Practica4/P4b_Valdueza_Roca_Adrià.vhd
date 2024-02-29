--------------------LOGIC PORTS------------------
--ENTITY INVERSOR
ENTITY inv IS
  PORT(
    a: IN BIT;
    f: OUT BIT);
END inv;

--ARCHITECTURE LOGICA_RETARD OF INVERSOR
ARCHITECTURE logica_retard OF inv IS
  BEGIN
    f <= NOT a AFTER 2 ns;
END logica_retard;

--ENTITY AND2
ENTITY and2 IS
  PORT(
    a, b: IN BIT;
    f: OUT BIT);
END and2;

--ARCHITECTURE LOGICA_RETARD OF AND2
ARCHITECTURE logica_retard of and2 IS
  BEGIN
    f <= a AND b AFTER 2 ns;
END logica_retard;

--ENTITY NAND3
ENTITY nand3 IS
  PORT(
    a, b, c: IN BIT;
    f: OUT BIT);
END nand3;

--ARCHITECTURE LOGICA_RETARD OF NAND3
ARCHITECTURE logica_retard OF nand3 IS
  BEGIN
    f <= NOT (a AND b AND c) AFTER 2 ns;
END logica_retard;

--ENTITY OR2
ENTITY or2 IS
  PORT(
    a, b: IN BIT;
    f: OUT BIT);
END or2;

--ARCHITECTURE LOGICA_REATARD OF OR2
ARCHITECTURE logica_retard OF or2 IS
  BEGIN
    f <= a OR b AFTER 2 ns;
END logica_retard;


--------------------FLIP-FLOP--------------------
--ENTITY FF_D_POSITIVE EDGE-TRIGGERING
ENTITY FF_T IS
  PORT(
    T, clock, Clr: IN BIT;
    Q, noQ: OUT BIT);
END FF_T;

--ARCHITECTURE IFTHEN OF FF_D
ARCHITECTURE ifthen OF FF_T IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (T, clock, Clr)
      BEGIN
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        --FF T POSITIVE EDGE-TRIGGERED
        ELSIF CLOCK'EVENT AND clock = '1' THEN 
          IF T = '1' THEN qint <= NOT qint AFTER 2 ns;
	  ELSE qint <= qint;
          END IF;
        END IF;
    END PROCESS;
    Q <= qint;
    noQ <= NOT qint;
END ifthen;

-----------------MULTIPLEXOR 2 A 1-----------------
--ENTITY MUX2A1
ENTITY mux2a1 IS
  PORT(
    a, b, S: IN BIT;
    f: OUT BIT);
END mux2a1;

--ARCHITECTURE LOGICA_RETARD OF MUX2A1
ARCHITECTURE logica_retard OF mux2a1 IS
  BEGIN
    f <= ((NOT S) AND a) OR (S AND b) AFTER 2 ns;
END logica_retard;

--ARCHITECTURE IFTHEN OF MUX4A1
ARCHITECTURE ifthen OF mux2a1 IS
  BEGIN
    PROCESS(a, b, S)
      BEGIN
        IF S = '0' THEN f <= a AFTER 2 ns;
	ELSE f <= b AFTER 2 ns;
	END IF;
    END PROCESS;
END ifthen;

--ARCHITECTURE ESTRUCTURAL OF MUX2A1
ARCHITECTURE estructural of mux2a1 IS

--COMPONENTS THAT WE WILL NEED TO MAKE ESTRUCTURAL OF MUX2A1
  COMPONENT and2 IS
    PORT(
      a, b: IN BIT;
      f: OUT BIT);
  END COMPONENT;

  COMPONENT or2 IS
    PORT(
      a, b: IN BIT;
      f: OUT BIT);
  END COMPONENT;

  COMPONENT inv IS
    PORT(
      a: IN BIT;
      f: OUT BIT);
  END COMPONENT;

  --DEFINING INTERNAL SIGNALS
  SIGNAL sort1_and2, sort0_and2, invS, sortida: BIT;   

  FOR DUT0: and2 USE ENTITY WORK.and2(logica_retard); 
  FOR DUT1: and2 USE ENTITY WORK.and2(logica_retard);
  FOR DUT2: or2 USE ENTITY WORK.or2(logica_retard);
  FOR DUT3: inv USE ENTITY WORK.inv(logica_retard);

  --LEST'S ASSIGN INTERNAL SIGNALS
  BEGIN
    DUT0: and2 PORT MAP(a, invS, sort1_and2);
    DUT1: and2 PORT MAP(S, b, sort0_and2);
    DUT2: or2 PORT MAP(sort1_and2, sort0_and2, sortida);
    DUT3: inv PORT MAP(S, invS);

  --ASSIGNING THE VALUE OF OUTPUT OF ESTRUCTURAL STRUCTURE    
  f <= sortida AFTER 2 ns;
END estructural;

----------------------CIRCUIT--------------------
--ENTITY CIRCUIT
ENTITY circuit4 IS
  PORT(
    sel, clock: IN BIT;
    Q2, Q1, Q0: OUT BIT);
END circuit4;

--ARCHITECTURE ESTRUCTURAL OF CIRCUIT
ARCHITECTURE estructural OF circuit4 IS
  
  --COMPONENTS THAT WE WILL NEED TO MAKE OUR ESTRUCTURAL CIRCUIT:
  --THREE FLIP-FLOP T, THREE MUX2A1 AND ONE NAND3
  COMPONENT FF_T IS
    PORT(
      T, clock, Clr: IN BIT;
      Q, noQ: OUT BIT);
  END COMPONENT;

  COMPONENT mux2a1 IS
    PORT(
      a, b, S: IN BIT;
      f: OUT BIT);
  END COMPONENT;

  COMPONENT inv IS
    PORT(
      a: IN BIT;
      f: OUT BIT);
  END COMPONENT;

  COMPONENT nand3 IS
    PORT(
      a, b, c: IN BIT;
      f: OUT BIT);
  END COMPONENT;
  
  --DEFINING INTERNAL SIGNALS
  SIGNAL T0, T1, T2, sort_nand3: BIT;
  SIGNAL q_0, q_1, q_2, noQ_0, noQ_1, noQ_2: BIT;

  FOR DUT1: mux2a1 USE ENTITY WORK.mux2a1(logica_retard);
  FOR DUT2: FF_T USE ENTITY WORK.FF_T(ifthen);
  FOR DUT3: mux2a1 USE ENTITY WORK.mux2a1(ifthen);
  FOR DUT4: FF_T USE ENTITY WORK.FF_T(ifthen);
  FOR DUT5: mux2a1 USE ENTITY WORK.mux2a1(estructural);
  FOR DUT6: FF_T USE ENTITY WORK.FF_T(ifthen);
  FOR DUT7: nand3 USE ENTITY WORK.nand3(logica_retard);
  
  --LET'S ASSIGN INTERNAL SIGNALS
  BEGIN

    DUT1: mux2a1 PORT MAP('1', '0', sel, T0);
    DUT2: FF_T PORT MAP(T0, clock, sort_nand3, q_0, noQ_0); 
    DUT3: mux2a1 PORT MAP('1', '0', sel, T1);
    DUT4: FF_T PORT MAP(T1, noQ_0, sort_nand3, q_1, noQ_1);
    DUT5: mux2a1 PORT MAP('1', '0', sel, T2);  
    DUT6: FF_T PORT MAP(T2, noQ_1, sort_nand3, q_2, noQ_2);
    DUT7: nand3 PORT MAP(q_0, noQ_1, q_2, sort_nand3);

  --ASSIGNING THE VALUES OF OUTPUTS OF ESTRUCTURAL STRUCTURE
  Q2 <= q_2;
  Q1 <= q_1;
  Q0 <= q_0;
END estructural;

-------------------------TESTBENCH------------------------
--ENTITY OF TESTBENCH
ENTITY bdp_circuit4 IS
END bdp_circuit4;

--ARCHITECTURE OF TESTBENCH
ARCHITECTURE test_circuit4  OF bdp_circuit4 IS
  
  --COMPONENT THAT WE ARE GOING TO TEST OUT
  COMPONENT circuit4 IS
    PORT(
      sel, clock: IN BIT;
      Q2, Q1, Q0: OUT BIT);
  END COMPONENT;
  
  --ASSIGNING SIGNALS OF INPUT AND OUTPUT
  --INPUTS
  SIGNAL sel, clock: BIT;
  --OUTPUTS 
  SIGNAL Q2, Q1, Q0: BIT; 
    
  FOR DUT1: circuit4 USE ENTITY WORK.circuit4(estructural);
  
  --LET'S BEGIN WITH THE TEST
  BEGIN
    DUT1: circuit4 PORT MAP(sel, clock, Q2, Q1, Q0); 
      
      --SETTING UP INPUT VARIATION TIMES
      sel <= '0', '1' AFTER 500 ns;
      clock <= NOT clock AFTER 50 ns;
END test_circuit4 ;
--Aquest circuit és un comptador, quan sel = 0, y clock està a la franja
--de pujada, augmenta el comptador 1, i quan el comptador arriba a 5 (101 en binari)
--reseteja el comptador i torna a començar des d'ú. Si sel = 1, aleshores
--la sortida es manté els valors.