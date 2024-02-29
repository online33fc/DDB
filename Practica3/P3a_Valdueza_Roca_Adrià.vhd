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
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <= '1' AFTER 2 ns;
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
    --He afegit qint al PROCESS perquè a la teoria ens
    --vam explicar que el latch de tipus JK i T, la sortida
    --es canvia infinitament sempre i quan clock=T=1,
    --per tant he tingut que afegir la senyal interna (qint)
    --al process per a que cada vegada que el qint canvia
    --d'estat, torni a comprovar els casos(ja que els casos
    --que venen desprès del PROCESS només es comproven
    --quan els senyals dins del PROCESS canvien d'estat).
    --L'exemple donat per l'enunciat de la P3 no inclou qint
    --dins del process i es possible que l'estigui fent malament,
    --per això estic fent aquest comentari.
    PROCESS (J, K, Clk, Pre, Clr, qint)
      BEGIN
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <='1' AFTER 2 ns;
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
    --He afegit qint al PROCESS perquè a la teoria ens
    --vam explicar que el latch de tipus JK i T, la sortida
    --es canvia infinitament sempre i quan clock=T=1,
    --per tant he tingut que afegir la senyal interna (qint)
    --al process per a que cada vegada que el qint canvia
    --d'estat, torni a comprovar els casos(ja que els ifthen
    --que venen desprès del PROCESS només es comproven
    --quan els senyals dins del PROCESS canvien d'estat).
    --L'exemple donat per l'enunciat de la P3 no inclou qint
    --dins del process i es possible que l'estigui fent malament,
    --per això estic fent aquest comentari.
    PROCESS(T, Clk, Pre, Clr, qint)
      BEGIN
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <= '1' AFTER 2 ns;
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
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <= '1' AFTER 2 ns;
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
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <='1' AFTER 2 ns;
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
        IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
        ELSIF Pre = '0' THEN qint <= '1' AFTER 2 ns;
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

        

--------------------TESTBENCH--------------------
--ENTITY BANC DE PROVES
ENTITY bdp IS
END bdp;

--ARCHITECTURE TEST OF BANC DE PROVES
ARCHITECTURE test OF bdp IS
  
--COMPONENTS LATCH THAT WE ARE GOING TO TEST OUT
  COMPONENT Latch_D IS
    PORT (
      D, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
    END COMPONENT;
    
  COMPONENT Latch_jk IS
    PORT (
      J, K, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;
  
  COMPONENT Latch_T IS
    PORT (
      T, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;

--COMPONENTS OF FLIP-FLIP THAT WE ARE GOING TO TEST OUT
  COMPONENT FF_D IS
    PORT (
      D, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;
  
  COMPONENT FF_JK IS
    PORT (
      J, K, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;
  
  COMPONENT FF_T IS
    PORT (
      T, Clk, Pre, Clr: IN BIT;
      Q, NO_Q: OUT BIT);
  END COMPONENT;
  
  --ASSIGNING SIGNALS OF INPUT AND OUTPUT:
  SIGNAL ent1, ent2, clock, preset, clear, FFD_sort_Q, FFD_sort_noQ, FFJK_sort_Q, FFJK_sort_noQ, FFT_sort_Q, FFT_sort_noQ,
    LD_sort_Q, LD_sort_noQ, LJK_sort_Q, LJK_sort_noQ, LT_sort_Q, LT_sort_noQ: BIT;

  FOR DUT1: Latch_D USE ENTITY WORK.Latch_D(ifthen);
  FOR DUT2: Latch_JK USE ENTITY WORK.Latch_JK(ifthen);
  FOR DUT3: Latch_T USE ENTITY WORK.Latch_T(ifthen);
  FOR DUT4: FF_D USE ENTITY WORK.FF_D(ifthen);
  FOR DUT5: FF_JK USE ENTITY WORK.FF_JK(ifthen);
  FOR DUT6: FF_T USE ENTITY WORK.FF_T(ifthen);
  
  BEGIN
  --ASSIGNING SIGNALS
    DUT1: Latch_D PORT MAP(ent1, clock, preset, clear, LD_sort_Q, LD_sort_noQ);
    DUT2: Latch_JK PORT MAP(ent1, ent2, clock, preset, clear, LJK_sort_Q, LJK_sort_noQ);
    DUT3: Latch_T PORT MAP(ent1, clock, preset, clear, LT_sort_Q, LT_sort_noQ);
    DUT4: FF_D PORT MAP(ent1, clock, preset, clear, FFD_sort_Q, FFD_sort_noQ);
    DUT5: FF_JK PORT MAP(ent1, ent2, clock, preset, clear, FFJK_sort_Q, FFJK_sort_noQ);
    DUT6: FF_T PORT MAP(ent1, clock, preset, clear, FFT_sort_Q, FFT_sort_noQ);
    
    ent1 <= NOT ent1 AFTER 800 ns;
    ent2 <= NOT ent2 AFTER 400 ns;
    clock <= NOT clock AFTER 500 ns;
    preset <= '0', '1' AFTER 600 ns;
    clear <= '1', '0' AFTER 200 ns, '1' AFTER 400 ns;
END test;
