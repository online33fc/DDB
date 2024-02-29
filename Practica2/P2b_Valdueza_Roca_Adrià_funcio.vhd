-------------------------FUNCIO_2------------------------
--ENTITY FUNCIO_2:
ENTITY funcio_2 IS
PORT(
a, b, c, d: IN BIT; 
f: OUT BIT);
END funcio_2;

--ARCHITECTURES OF FUNCIO_2:
--LOGICAL STRUCTURE WITHOUT DELAY
ARCHITECTURE logica OF funcio_2 IS
BEGIN
f <= (((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) XOR (a OR (NOT d));
END logica;

ARCHITECTURE logica_retard of funcio_2 IS
BEGIN
f <= (((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) XOR (a OR (NOT d)) AFTER 3 ns;
END logica_retard;

--DEFINING STRUCTURE OF FUNCIO_2
ARCHITECTURE estructural of funcio_2 IS

-------------------------COMPONENTS----------------------
--Given the function:
--f <= a AND c AND (a XOR d ) OR ((NOT B) AND C)
--we will need the following components:
--AND2, AND3, OR2, XOR2 and INVERSOR
COMPONENT portainv IS
PORT (
a: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT portaand2 IS
PORT (
a, b: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT portaand3 IS
PORT (
a, b, c: IN BIT;
z: OUT BIT);
END COMPONENT;

COMPONENT portaor2 IS
PORT (
a, b: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT portaor4 IS
PORT (
a, b, c, d: IN BIT;
z: OUT BIT);
END COMPONENT;

COMPONENT portaxor2 IS
PORT (
a, b: IN BIT; 
z: OUT BIT);
END COMPONENT;

--ASSIGNING SIGNALS OF INPUT AND OUTPUT:
--f <= a AND c AND (a XOR d ) OR ((NOT b) AND c)
--We have to see how many of each components we will need:
--one inversor port for (NOT b)
--one xor2 port for (a XOR d)
--one and2 port for ((NOT b) AND c)
--one and3 port for (a AND c AND (a XOR d))
--one or2 port for (a AND c AND (a XOR d)) or ((NOT b) AND c)
--So in total, we will need 5 ports, so we have to make 5 DUT
SIGNAL inva, invc, invd, abc, bd, acd, ad, abcORbdORacdORad, aORd: BIT;

FOR DUT1: portainv USE ENTITY WORK.inv(logica);
FOR DUT2: portainv USE ENTITY WORK.inv(logica);
FOR DUT3: portainv USE ENTITY WORK.inv(logica);
FOR DUT4: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT5: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT6: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT7: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT8: portaor2 USE ENTITY WORK.or2(logica);
FOR DUT9: portaor4 USE ENTITY WORK.or4(logica);
FOR DUT10: portaxor2 USE ENTITY WORK.xor2(logica);

BEGIN
--ASSIGNNING SIGNALS
DUT1: portainv PORT MAP(a, inva);
DUT2: portainv PORT MAP(c, invc);
DUT3: portainv PORT MAP(d, invd);
DUT4: portaand2 PORT MAP(b, invd, bd);
DUT5: portaand2 PORT MAP(a, invd, ad);
DUT6: portaand3 PORT MAP(inva, b, invc, abc);
DUT7: portaand3 PORT MAP (a, c, d, acd);
DUT8: portaor2 PORT MAP(a, invd, aORd);
DUT9: portaor4 PORT MAP(bd, ad, abc, acd, abcORbdORacdORad);
DUT10: portaxor2 PORT MAP(abcORbdORacdORad, aORd, f);

END estructural;

-------------------------TESTBENCH---------------------
--ENTITY BANDEPROVES:
ENTITY banc_de_proves IS
END banc_de_proves;

ARCHITECTURE test OF banc_de_proves IS
--COMPONENT TO TEST
COMPONENT bloc_que_simulem IS
PORT (
a, b, c, d: IN BIT; 
f: OUT BIT);
END COMPONENT;

--ASSIGNING SIGNALS TO TEST OUT LOGICA AND ESTRUCTURAL STRUCTURES
SIGNAL ent0, ent1, ent2, ent3, sort_logica, sort_logica_retard, sort_estructural: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_2(logica);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural);
FOR DUT3: bloc_que_simulem USE ENTITY WORK.funcio_2(logica_retard);

BEGIN
DUT1: bloc_que_simulem PORT MAP(ent0, ent1, ent2, ent3, sort_logica);
DUT2: bloc_que_simulem PORT MAP(ent0, ent1, ent2, ent3, sort_estructural);
DUT3: bloc_que_simulem PORT MAP(ent0, ent1, ent2, ent3, sort_logica_retard);

--START WITH THE TEST
PROCESS (ent0, ent1, ent2 ,ent3)
BEGIN
ent0 <= NOT ent0 AFTER 400 ns;
ent1 <= NOT ent1 AFTER 200 ns;
ent2 <= NOT ent2 AFTER 100 ns;
ent3 <= NOT ent3 AFTER 50 ns;
END PROCESS;
END test;
------------------Comentaris sobre les preguntes------------------
--APARTAT D)
--La diferència al executar les dues arquitectures es que en l'arquitectura retardada 'logica_retard', 
--les sortides estan endarrerits i l'arquitectura 'logica', els resultats surt a l'hora.
--Aquest endarriment només afecta a l'aqruitectura estructural perquè utilitzem les funcions
--amb endarriments de les portes, per tant, no afecta a la funció 'logica', ja que utilitza
--les arquitectures sense retras.

-- APARTAT E) 	
--Quan posem les senyals d'entrada en 5 ns, la funció amb retras no pot calcular bé els resultats
--deguda a que el temps que varien les senyals d'entrada es de només 5 ns i tenim 3 ns de retras.
--Per aquesta raò, a la funció no li dona el temps suficient a que calculi alguns valors correctament.
