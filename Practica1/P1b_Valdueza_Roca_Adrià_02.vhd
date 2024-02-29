--TESTBENCH:
ENTITY bdp_portes IS 
END bdp_portes;

--ARCHITECTURE OF TESTBENCH:
ARCHITECTURE test OF bdp_portes IS

--COMPONENTS:
COMPONENT inversor IS
PORT(
a: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT and2 
PORT(
a, b: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT and3
PORT(
a, b, c: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT and4
PORT(
a, b, c, d: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT or2
PORT(
a, b: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT or3
PORT(
a, b, c: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT or4
PORT(
a, b, c, d: IN BIT; 
z: OUT BIT);
END COMPONENT;

COMPONENT xor2
PORT (
a, b: IN BIT;
z: OUT BIT);
END COMPONENT;


--ASSIGNING SIGNALS OF INPUT AND OUTPUT:
SIGNAL ent1, ent2, ent3, ent4, sort_inv_logica, sort_inv_logicaretard, sort_and2_logica, sort_and2_logicaretard, sort_and3_logica, sort_and3_logicaretard, sort_and4_logica, sort_and4_logicaretard, sort_or2_logica, sort_or2_logicaretard, sort_or3_logica, sort_or3_logicaretard, sort_or4_logica, sort_or4_logicaretard, sort_xor2_logica, sort_xor2_logicaretard : BIT;
FOR DUTINV: inversor USE ENTITY WORK.inversor(logica);
FOR DUTAND2: and2 USE ENTITY WORK.and2(logica);
FOR DUTAND3: and3 USE ENTITY WORK.and3(logica);
FOR DUTAND4: and4 USE ENTITY WORK.and4(logica);
FOR DUTOR2: or2 USE ENTITY WORK.or2(logica);
FOR DUTOR3: or3 USE ENTITY WORK.or3(logica);
FOR DUTOR4: or4 USE ENTITY WORK.or4(logica);
FOR DUTXOR2: xor2 USE ENTITY WORK.xor2(logica);
FOR DUTINVRET: inversor USE ENTITY WORK.inversor(logicaretard);
FOR DUTAND2RET: and2 USE ENTITY WORK.and2(logicaretard);
FOR DUTAND3RET: and3 USE ENTITY WORK.and3(logicaretard);
FOR DUTAND4RET: and4 USE ENTITY WORK.and4(logicaretard);
FOR DUTOR2RET: or2 USE ENTITY WORK.or2(logicaretard);
FOR DUTOR3RET: or3 USE ENTITY WORK.or3(logicaretard);
FOR DUTOR4RET: or4 USE ENTITY WORK.or4(logicaretard);
FOR DUTXOR2RET: xor2 USE ENTITY WORK.xor2(logicaretard);

--DONE WITH ASSIGNMENT, PROCEED WITH THE TESTS:
BEGIN
DUTINV: inversor PORT MAP (ent1, sort_inv_logica);
DUTAND2: and2 PORT MAP (ent1, ent2, sort_and2_logica);
DUTAND3: and3 PORT MAP (ent1, ent2, ent3, sort_and3_logica);
DUTAND4: and4 PORT MAP (ent1, ent2, ent3, ent4, sort_and4_logica);
DUTOR2: or2 PORT MAP (ent1, ent2, sort_or2_logica);
DUTOR3: or3 PORT MAP (ent1, ent2, ent3, sort_or3_logica);
DUTOR4: or4 PORT MAP (ent1, ent2, ent3, ent4, sort_or4_logica);
DUTXOR2: xor2 PORT MAP (ent1, ent2, sort_xor2_logica);
DUTINVRET: inversor PORT MAP (ent1, sort_inv_logicaretard);
DUTAND2RET: and2 PORT MAP (ent1, ent2, sort_and2_logicaretard);
DUTAND3RET: and3 PORT MAP (ent1, ent2, ent3, sort_and3_logicaretard);
DUTAND4RET: and4 PORT MAP (ent1, ent2, ent3, ent4, sort_and4_logicaretard);
DUTOR2RET: or2 PORT MAP (ent1, ent2, sort_or2_logicaretard);
DUTOR3RET: or3 PORT MAP (ent1, ent2, ent3, sort_or3_logicaretard);
DUTOR4RET: or4 PORT MAP (ent1, ent2, ent3, ent4, sort_or4_logicaretard);
DUTXOR2RET: xor2 PORT MAP (ent1, ent2, sort_xor2_logicaretard);

PROCESS (ent1, ent2, ent3, ent4)
BEGIN
ent1 <= NOT ent1 AFTER 50 ns;
ent2 <= 1 ent2 AFTER 100 ns;
ent3 <= 0 ent3 AFTER 200 ns;
ent4 <= 1 ent4 AFTER 400 ns;
END PROCESS;
END test;

