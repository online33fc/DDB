--------------------FLIP-FLOP--------------------
--ENTITY FF_JK_POSITIVE EDGE-TRIGGERING
ENTITY FF_JK IS
  PORT(
    J, K, clock: IN BIT;
    Q: OUT BIT);
END FF_JK;

--ARCHITECTURE IFTHEN OF FF_D
ARCHITECTURE ifthen OF FF_JK IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (J, K, clock)
      BEGIN
        --FF D POSITIVE EDGE-TRIGGERED
        IF CLOCK'EVENT AND clock = '1' THEN 
          IF J = '0' AND K = '0' THEN qint <= qint AFTER 4 ns;
          ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 4 ns;
          ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 4 ns;
          ELSE qint <= NOT qint AFTER 4 ns;
          END IF;
        END IF;
    END PROCESS;
    Q <= qint;
END ifthen;

--------------------LOGIC PORTS------------------
--ENTITY XNOR2
ENTITY xnor2 IS
  PORT(
    a, b: IN BIT; 
    z: OUT BIT);
END xnor2;

--ARCHITECTURE LOGICA_RETARD OF XNOR2
ARCHITECTURE logica_retard OF xnor2 IS
  BEGIN
    z <= a XNOR b AFTER 4 ns;
END logica_retard;

--ENTITY AND2
ENTITY and2 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END and2;

--ARCHITECTURE LOGICA_RETARD OF AND2
ARCHITECTURE logica_retard OF and2 IS
  BEGIN
    z <= a AND b AFTER 4 ns;
END logica_retard;

----------------------CIRCUIT--------------------
--ENTITY CIRCUIT
ENTITY circuit IS
  PORT(
    clock, X: IN BIT;
    Z2, Z1, Z0: OUT BIT);
END circuit;

--ARCHITECTURE ESTRUCTURAL OF circuit
ARCHITECTURE estructural OF circuit IS
  
  --COMPONENTS THAT WE WILL NEED TO MAKE OUR ESTRUCTURAL CIRCUIT:
  --THREE FLIP-FLOP JK, ONE XNOR2 AND ONE AND2 PORT. 
  COMPONENT FF_JK IS
    PORT(
      J, K, clock: IN BIT;
      Q: OUT BIT);
  END COMPONENT;

  COMPONENT and2 IS
    PORT(
      a, b: IN BIT;
      z: OUT BIT);
  END COMPONENT;
  
  COMPONENT xnor2 IS
    PORT(
      a, b: IN BIT;
      z: OUT BIT);
  END COMPONENT;
  
  --DEFINING INTERNAL SIGNALS
  SIGNAL xnor2_sort, and2_sort: BIT; 
  SIGNAL q_2, q_1, q_0: BIT;

  FOR DUT1: xnor2 USE ENTITY WORK.xnor2(logica_retard);
  FOR DUT2: and2 USE ENTITY WORK.and2(logica_retard);
  FOR DUT3: FF_JK USE ENTITY WORK.FF_JK(ifthen);
  FOR DUT4: FF_JK USE ENTITY WORK.FF_JK(ifthen);
  FOR DUT5: FF_JK USE ENTITY WORK.FF_JK(ifthen);
  
  --LET'S ASSIGN INTERNAL SIGNALS
  BEGIN
    DUT1: xnor2 PORT MAP(X, q_0, xnor2_sort);
    DUT2: and2 PORT MAP(q_1, xnor2_sort, and2_sort); 
    DUT3: FF_JK PORT MAP(and2_sort, and2_sort, clock, q_2);
    DUT4: FF_JK PORT MAP(xnor2_sort, xnor2_sort, clock, q_1);
    DUT5: FF_JK PORT MAP(X, '1', clock, q_0);  
    
  --ASSIGNING THE VALUES OF OUTPUTS OF ESTRUCTURAL STRUCTURE
  Z2 <= q_2;
  Z1 <= q_1;
  Z0 <= q_0;
END estructural;

-------------------------TESTBENCH------------------------
--ENTITY OF TESTBENCH
ENTITY bdp IS
END bdp;

--ARCHITECTURE OF TESTBENCH
ARCHITECTURE test OF bdp IS
  
  --COMPONENT THAT WE ARE GOING TO TEST OUT
  COMPONENT circuit IS
    PORT(
      clock, X: IN BIT;
      Z2, Z1, Z0: OUT BIT);
  END COMPONENT;
  
  --ASSIGNING SIGNALS OF INPUT AND OUTPUT
  --INPUTS
  SIGNAL clock, X: BIT;
  --OUTPUTS 
  SIGNAL Z2, Z1, Z0: BIT; 
    
  FOR DUT1: circuit USE ENTITY WORK.circuit(estructural);
  
  --LET'S BEGIN WITH THE TEST
  BEGIN
    DUT1: circuit PORT MAP(clock, X, Z2, Z1, Z0); 
      
      --SETTING UP INPUT VARIATION TIMES
      clock <= NOT clock AFTER 25 ns;
      X <= NOT X AFTER 150 ns;
END test;
