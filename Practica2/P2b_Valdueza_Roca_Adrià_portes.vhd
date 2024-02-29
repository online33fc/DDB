ENTITY inv IS 
PORT( 
a: IN BIT; 
z: OUT BIT);
END inv;

--ARCHITECTURES OF INVERSOR:
--WITHOUT DELAY
ARCHITECTURE logica OF inv IS
BEGIN
z <= NOT a;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF inv IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

-----------------------AND-----------------------
--ENTITY AND2:
ENTITY and2 IS
PORT( 
a, b: IN BIT; 
z: OUT BIT);
END and2;

--ARCHITECTURES OF AND2:
--WITHOUT DELAY
ARCHITECTURE logica OF and2 IS
BEGIN
z <= a AND b;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF and2 IS
BEGIN
z <= a AND b AFTER 3 ns;
END logicaretard;

--ENTITY AND3:
ENTITY and3 IS
PORT( 
a, b, c: IN BIT; 
z: OUT BIT);
END and3;

--ARCHITECTURES OF AND3:
--WITHOUT DELAY
ARCHITECTURE logica OF and3 IS
BEGIN
z <= a AND b AND c;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF and3 IS
BEGIN
z <= a AND b AND c AFTER 3 ns;
END logicaretard;

--ENTITY AND4:
ENTITY and4 IS
PORT (
a, b, c, d: IN BIT; 
z: OUT BIT);
END and4;

--ARCHITECTURES OF AND4:
--WITHOUT DELAY
ARCHITECTURE logica OF and4 IS
BEGIN
z <= a AND b AND c AND d;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF and4 IS
BEGIN
z <= a AND b AND c AND d AFTER 3 ns;
END logicaretard;

-----------------------OR-----------------------
--ENTITY OR2:
ENTITY or2 IS
PORT( 
a, b: IN BIT; 
z: OUT BIT);
END or2;

--ARCHITECTURES OF OR2:
--WITHOUT DELAY
ARCHITECTURE logica OF or2 IS
BEGIN
z <= a OR b;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF or2 IS
BEGIN
z <= a OR b AFTER 3 ns;
END logicaretard;

--ENTITY OR3:
ENTITY or3 IS
PORT( 
a, b, c: IN BIT; 
z: OUT BIT);
END or3;

--ARCHITECTURES OF OR3:
--WITHOUT DELAY
ARCHITECTURE logica OF or3 IS
BEGIN
z <= a OR b OR c;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF or3 IS
BEGIN
z <= a OR b OR c AFTER 3 ns;
END logicaretard;

--ENTITY OR4:
ENTITY or4 IS
PORT (
a, b, c, d: IN BIT; 
z: OUT BIT);
END or4;

--ARCHITECTURES OF OR4:
--WITHOUT DELAY
ARCHITECTURE logica OF or4 IS
BEGIN
z <= a OR b OR c OR d;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF or4 IS
BEGIN
z <= a OR b OR c OR d AFTER 3 ns;
END logicaretard;

-----------------------XOR-----------------------
--ENTITY XOR2:
ENTITY xor2 IS
PORT (
a, b: IN BIT;
z: OUT BIT);
END xor2;

--ARCHITECTURES OF XOR2:
--WITHOUT DELAY
ARCHITECTURE logica OF xor2 IS
BEGIN
z <= a XOR b;
END logica;

--WITH DELAY
ARCHITECTURE logicaretard OF xor2 IS
BEGIN
z <= a XOR b AFTER 3 ns;
END logicaretard;
