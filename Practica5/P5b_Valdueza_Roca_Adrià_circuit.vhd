-----------------------CIRCUIT-------------------------

--ENTITY CIRCUIT
entity CIRCUIT is
  port(
    X, Y, Ck: in bit;
    Z: out bit);
end CIRCUIT;

--ARCHITECUTRE ESTRUCTURAL OF CIRCUIT
architecture estructural of CIRCUIT is 
  
 
  component FF_JK_pujada is
    port(
      J, K, CK: in bit;
      Q: out bit);
  end component;
  
  component FF_T_baixada is
    port(
      T, CK, Pre: in bit;
      Q: out bit);
  end component;
  
  component sumador_1_bit is
    port(
      a, b, Cin: in bit;
      Cout, S: out bit);
  end component;
  
  --defining internal signals
  signal Cout_int, S_int, Q1_int: bit;
  
  for dut1: FF_T_baixada use entity work.FF_T_baixada(ifthen);
  for dut2: FF_JK_pujada use entity work.FF_JK_pujada(ifthen);
  for dut3: sumador_1_bit use entity work.sumador_1_bit(estructural);
  
  
  begin
    
    dut1: FF_T_baixada port map(X, CK, Y, Q1_int);
    dut2: FF_JK_pujada port map(S_int, Cout_int, CK, Z);
    dut3: sumador_1_bit port map(CK, CK, Q1_int, Cout_int, S_int);
      
end estructural;


----------------------------TESTBENCH---------------------------

--ENTITY BANC_PROVES
entity bdp_Pr05b is
end bdp_Pr05b;

--ARCHITECTURE TEST OF BANC_PROVES
architecture test_Pr05b of bdp_Pr05b is
  
  --components that we are going to test out
  component circuit is
    port(
      X, Y, CK: in bit;
      Z: out bit);
  end component;
  
  --assigning signals of input and output:
  --inputs:
  signal X, Y, CK: bit;
  --outputs:
  signal Z: bit;
  
  for dut1: circuit use entity work.circuit(estructural);
  
  
  begin
    dut1: circuit port map(X, Y, CK, Z);
      
    CK <= not CK after 50 ns;
    X <= '1', '0' after 110 ns, '1' after 150 ns, '0' after 240 ns,
      '1' after 310 ns, '0' after 340 ns, '1' after 420 ns, '0' after 520 ns,
      '1' after 540 ns, '0' after 560 ns, '1' after 590 ns, '0' after 660 ns, '1' after 710 ns;
    Y <= '1', '0' after 60 ns, '1' after 80 ns, '0' after 360 ns, '1' after 440 ns,
      '0' after 610 ns, '1' after 670 ns, '0' after 740 ns, '1' after 760 ns;
      
end test_Pr05b;
