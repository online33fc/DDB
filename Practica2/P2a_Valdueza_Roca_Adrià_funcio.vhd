ENTITY funcio_2 IS
PORT(
a, b, c, d: IN BIT; 
f: OUT BIT);
END funcio_2;

ARCHITECTURE logica OF funcio_2 IS
BEGIN
f <= (a AND c AND (a XOR d )) OR ((NOT b) AND c);
END logica;

--DEFINING STRUCTURE OF FUNCIO
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
SIGNAL invb, sort_aXORd, sort_acXORd, sort_bc, sort_or2: BIT;

FOR DUT1: portainv USE ENTITY WORK.inv(logicaretard);
FOR DUT2: portaxor2 USE ENTITY WORK.xor2(logicaretard);
FOR DUT3: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT5: portaor2 USE ENTITY WORK.or2(logicaretard);

BEGIN
--ASSIGNNING SIGNALS
DUT1: portainv PORT MAP(B, invb);
DUT2: portaxor2 PORT MAP(A, D, sort_aXORd);
DUT3: portaand2 PORT MAP(C, invb, sort_bc);
DUT4: portaand3 PORT MAP(A, sort_aXORd, C, sort_acXORd);
DUT5: portaor2 PORT MAP(sort_acXORd, sort_bc, sort_or2);

END estructural;

-------------------------TESTBENCH---------------------
--ENTITY BANDEPROVES:
ENTITY bancdeproves IS
END bancdeproves;

ARCHITECTURE test_de_proves OF bancdeproves IS

--COMPONENT TO TEST
COMPONENT bloc_que_simulem IS
PORT (
a, b, c, d: IN BIT; 
f: OUT BIT);
END COMPONENT;

--ASSIGNING SIGNALS TO TEST OUT LOGICA AND ESTRUCTURAL STRUCTURES
SIGNAL senyalA, senyalB, senyalC, senyalD, sort_logica, sort_estructural: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_2(logica);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural);

BEGIN
DUT1: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC, senyalD, sort_logica);
DUT2: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC, senyalD, sort_estructural);

--START WITH THE TEST
PROCESS (senyalA, senyalB, senyalC, senyalD)
BEGIN
senyalA <= NOT senyalA AFTER 400 ns;
senyalB <= NOT senyalB AFTER 200 ns;
senyalC <= NOT senyalC AFTER 100 ns;
senyalD <= NOT senyalD AFTER 50 ns;
END PROCESS;
END test_de_proves;
 
------------------Comentaris sobre les preguntes:
--Podem observar com la funcio te rebots en alguns temps determinats com del 209 al 212, es a dir,
--en alguns punts la funcio dona uns valors incorrectes que no estan lligats nomes
--al desplaçament de 3 ns al fer el calcul. A que es deu aixo?
--Com que els calculs es fan, cada un, amb un interval de 3 ns, durant aquest moment, 
--la funcio esta rebent unes dades teoricament "incorrectes".
--Es a dir, si necessitam tenir a la funcio 0, 0, 0, 0, 0 perque la funcio ens doni un 1 i les variables canvien
--i passen a ser totes 0, teoricament (!) la funcio hauria de donar un 1. Pero, en aquest moment, la funcio encara
--no ha calculat els inversos (perque duen 3 ns de retras), aixi que, practicament, no tenim el resultat que hauriem de tenir
--(per exemple, fer la AND de 1, 0, 1) perque l'inversor encara no ho ha calculat.
--A mes, aquest error es veu repetit perque tenim 4 nivells on generam retrasos.
--Resumint, en la funcio, degut als retrassos, hi ha moments on teoricament la funcio ens hauria de donar be
--pero a la practica estam calculant amb nombres que son incorrectes i aixo ens resulta un error.

--Per contestar l'altra pregunta, hem de veure que passa. Com que tenim 4 nivells on hi ha retras i
--tenim un retras de 3 ns, tendrem un total de 12 ns on la funcio calcula amb errors.
--Quan posam que variin les senyals d'entrada en 5 ns, no li donam temps a la funcio
--a que hi hagi un valor calculat practicament be (tot i que en la teoria, haurien de ser correctes).
--Haurien de passar, 12 ns entre canvi de variable i canvi de variable per, despres, tenir al menys 1 ns
--on segur que tendriem un valor de la funcio be (aquest es el minim). 
--Si varien en menys de 13 ns, la funcio no te temps a ser calculada practicament be
--i si algun valor coincideix (en la practica i en la teoria) no es degut a la logica que intentam que la nostra funcio segueixi.
