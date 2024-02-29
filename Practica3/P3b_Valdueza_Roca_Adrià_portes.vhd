-----------------INVERSOR PORT-------------------
ENTITY inversor IS
  PORT(
    a: IN BIT;
    z: OUT BIT);
END inversor;

ARCHITECTURE logica OF inversor IS
  BEGIN
    z <= NOT a AFTER 2 ns; 
END logica;

ARCHITECTURE logicaretard OF inversor IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------AND2 PORT--------------------
ENTITY and2 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END and2;

ARCHITECTURE logica OF and2 IS
  BEGIN
    z <= a AND b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF and2 IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------AND3 PORT--------------------
ENTITY and3 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END and3;

ARCHITECTURE logica OF and3 IS
  BEGIN
    z <= a AND b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF and3 IS
  BEGIN
    z <= a AND b AFTER 3 ns;
END logicaretard;

--------------------AND4 PORT--------------------
ENTITY and4 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END and4;

ARCHITECTURE logica OF and4 IS
  BEGIN
    z <= a AND b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF and4 IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------OR2 PORT---------------------
ENTITY or2 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END or2;

ARCHITECTURE logica OF or2 IS
  BEGIN
    z <= a OR b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF or2 IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------OR3 PORT---------------------
ENTITY or3 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END or3;

ARCHITECTURE logica OF or3 IS
  BEGIN
    z <= a OR b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF or3 IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------OR4 PORT---------------------
ENTITY or4 IS
  PORT(
    a, b: IN BIT;
    z: OUT BIT);
END or4;

ARCHITECTURE logica OF or4 IS
  BEGIN
    z <= a OR b AFTER 2 ns;
END logica;

ARCHITECTURE logicaretard OF or4 IS
BEGIN
z <= NOT a AFTER 3 ns;
END logicaretard;

--------------------xor2 PORT--------------------
ENTITY xor2 IS
PORT (
a, b: IN BIT;
z: OUT BIT);
END xor2;

ARCHITECTURE logica OF xor2 IS
BEGIN
z <= a XOR b;
END logica;

ARCHITECTURE logicaretard OF xor2 IS
BEGIN
z <= a XOR b AFTER 3 ns;
END logicaretard;