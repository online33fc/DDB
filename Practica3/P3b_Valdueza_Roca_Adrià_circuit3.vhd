----------------------LATCH----------------------
--ENTITY LATCH_D
ENTITY Latch_D IS
  PORT(
    D, Clk, Pre, Clr: IN BIT;
    Q, NO_Q: OUT BIT);
END Latch_D; 

--ARCHITECTURE OF LATCH_D
ARCHITECTURE ifthen OF Latch_D IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (D, Clk, Pre, Clr)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        ELSIF Clk = '1' THEN qint <= D AFTER 2 ns;
        END IF;
    END PROCESS;
  Q <= qint;
  NO_Q <= NOT qint;
END ifthen;
  
--ENTITY LATCH_JK
ENTITY Latch_JK IS
  PORT(
    J, K, Clk, Pre, Clr: IN BIT;
    Q, NO_Q: OUT BIT);
END Latch_JK;

--ARCHITECTURE OF LATCH_JK
ARCHITECTURE ifthen OF Latch_JK IS
  SIGNAL qint: BIT;
  BEGIN
 
    PROCESS (J, K, Clk, Pre, Clr, qint)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        ELSIF Clk = '1' THEN
          IF J = '0' AND K = '0' THEN qint <= qint AFTER 2 ns;
          ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 2 ns;
          ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 2 ns;
          ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 2 ns;
          END IF;
        END IF;
    END PROCESS;
  Q <= qint; 
  NO_Q <= NOT qint;
END ifthen;
 
--ENTITY LATCH TOGGLE
ENTITY Latch_T IS
  PORT(
    T, Clk, Pre, Clr: IN BIT;
    Q, NO_Q: OUT BIT);
END LATCH_T;

--ARCHITECTURE OF LATCH_T
ARCHITECTURE ifthen OF Latch_T IS
  SIGNAL qint: BIT;
  BEGIN

    PROCESS(T, Clk, Pre, Clr, qint)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        ELSIF Clk = '1' THEN
          IF T = '1' THEN qint <= NOT qint AFTER 2 ns;
          ELSIF T = '0' THEN qint <= qint AFTER 2 ns;
          END IF;
        END IF;
    END PROCESS;
  Q <= qint;
  NO_Q <= NOT qint;
END ifthen;  

--------------------FLIP-FLOP--------------------
--ENTITY FF_D
ENTITY FF_D IS
  PORT(
    D, Clk, Pre, CLR: IN BIT;
    Q, NO_Q: OUT BIT);
END FF_D;

--ARCHITECTURE OF FF_D
ARCHITECTURE ifthen OF FF_D IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (D, Clk, Pre, Clr)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        --FF D POSITIVE EDGE-TRIGGERED
        ELSIF CLK'EVENT AND Clk = '1' THEN 
          qint <= D AFTER 2 ns;
        END IF;
    END PROCESS;
    Q <= qint; NO_Q <= NOT qint;
END ifthen;
 
--ENTITY FF_JK
ENTITY FF_JK IS
  PORT(
    J, K, Clk, Pre, Clr: IN BIT;
    Q, NO_Q: OUT BIT);
END FF_JK;

--ARCHITECTURE OF FF_JK
ARCHITECTURE ifthen OF FF_JK IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS (J, K, Clk, Pre, Clr)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        --FF JK POSITIVE EDGE-TRIGGERED
        ELSIF Clk'EVENT AND Clk = '1' THEN
            IF J = '0' AND K = '0' THEN qint <= qint AFTER 2 ns;
            ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 2 ns;
            ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 2 ns;
            ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 2 ns;
            END IF;
        END IF;
    END PROCESS;
  Q <= qint;
  NO_Q <= NOT qint;
END ifthen;

--ENTITY FF TOGGLE
ENTITY FF_T IS
  PORT(
    T, Clk, Pre, Clr: IN BIT;
    Q, NO_Q: OUT BIT);
END FF_T;

--ARCHITECTURE OF FF TOGGLE
ARCHITECTURE ifthen OF FF_T IS
  SIGNAL qint: BIT;
  BEGIN
    PROCESS(T, Clk, Pre, Clr)
      BEGIN
        IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
        ELSIF Clr = '0' THEN qint <='0' AFTER 2 ns;
        --FF TOGGLE POSITIVE EDGE-TRIGGERED
        ELSIF Clk'EVENT AND Clk = '1' THEN
            IF T = '1' THEN qint <= NOT qint AFTER 2 ns;
            ELSIF T = '0' THEN qint <= qint AFTER 2 ns;
            END IF;
        END IF;
    END PROCESS;
    Q <= qint;
    NO_Q <= NOT qint;
END ifthen;      

---------------------CIRCUIT---------------------
--ENTITY CIRCUIT3
ENTITY circuit3 IS
  PORT(
    x, Ck: IN BIT;
    z: OUT BIT);
END circuit3;

--ARCHITECTURE OF CIRCUIT
ARCHITECTURE estructural OF circuit3 IS
  
--COMPONENTS THAT WE ARE GOING TO TEST OUT:
--INVERSOR, AND2 PORT, OR2 PORT, LATCH D AND FLIP-FLOP JK.
  COMPONENT inv IS
    PORT(
      a: IN BIT;
      z: OUT BIT);
  END COMPONENT;

  COMPONENT and2 IS
    PORT(
      a, b: IN BIT;
      z: OUT BIT);
  END COMPONENT;
  
  COMPONENT or2 IS
    PORT(
      a, b: IN BIT;
      z: OUT BIT);
  END COMPONENT;
      
  COMPONENT Latch_D IS
    PORT (
      D, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;

  COMPONENT FF_JK IS
    PORT (
      J, K, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;

   --ASSIGNING SIGNALS OF INPUT AND OUTPUT:
  SIGNAL invb, and2_sort, or2_sort, LD_sort_Q, LD_sort_noQ, FFJK_noQ: BIT; 
  FOR DUT1: inv USE ENTITY work.inv(logicaretard);
  FOR DUT2: Latch_D USE ENTITY work.Latch_D(ifthen);
  FOR DUT3: or2 USE ENTITY work.or2(logicaretard);
  FOR DUT4: and2 USE ENTITY work.and2(logicaretard);
  FOR DUT5: FF_JK USE ENTITY work.FF_JK(ifthen);
  
  BEGIN
  --ASSIGNING SIGNALS
    DUT1: inv PORT MAP(x, invb);
    DUT2: Latch_D PORT MAP(x, Ck, '1', '1', LD_sort_Q, LD_sort_noQ);
    DUT3: or2 PORT MAP(invb, LD_sort_noQ, or2_sort);
    DUT4: and2 PORT MAP(x, LD_sort_Q, and2_sort);
    DUT5: FF_JK PORT MAP(and2_sort, or2_sort, Ck, '1', '1', z, FFJK_noQ);
      
END estructural;
----------------------TESTBENCH-----------------------
ENTITY bdp_circuit3 IS
END bdp_circuit3;

ARCHITECTURE test_circuit3 OF bdp_circuit3 IS
  
  COMPONENT circuit3 IS
    PORT (
    x, Ck: IN BIT;
    z: OUT BIT);
  END COMPONENT;
  
  SIGNAL x, Ck, z: BIT;
  
FOR DUT1: circuit3 USE ENTITY work.circuit3(estructural);
  
  BEGIN
    
    DUT1: circuit3 PORT MAP(x, Ck, z);
    
    Ck <= NOT Ck AFTER 50 ns;
    x <= '0', '1' AFTER 75 ns, '0' AFTER 180 ns, 
    '1' AFTER 215 ns, '0' AFTER 225 ns,
    '1' AFTER 245 ns, '0' AFTER 255 ns,
    '1' AFTER 275 ns, '0' AFTER 285 ns,
    '1' AFTER 315 ns, '0' AFTER 365 ns;
END test_circuit3;
