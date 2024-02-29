--ENTITY AND2
entity and2 is
  port(
    a, b: in bit;
    z: out bit);
end and2;

--ARCHITECTURE LOGICA_RETARD OF AND2
architecture logica_retard of and2 is
  begin
    z <= a and b after 3 ns;
end logica_retard;

--ARCHITECTURE INVERSOR
entity inversor is
  port(
    a: in bit;
    z: out bit);
end inversor;

--ARCHITECTURA LOGICA_RETARD OF INVERSOR
architecture logica_retard of inversor is
  begin
    z <= not a after 3 ns;
end logica_retard;

--ENTITY XOR2
entity xor2 is
  port(
    a, b: in bit;
    z: out bit);
end xor2;

--ARCHITECTURE ESTRUCTURAL OF XOR2
architecture estructural of xor2 is
  
 
  component and2 is
    port(
      a, b: in  bit;
      z: out bit);
  end component;


  component inversor is
    port(
      a: in bit;
      z: out bit);
  end component;

  --defining internal signals
  signal sort1_and2, sort2_and2, inva, invb: bit;

  for dut1: inversor use entity work.inversor(logica_retard);
  for dut2: inversor use entity work.inversor(logica_retard);
  for dut3: and2 use entity work.and2(logica_retard);
  for dut4: and2 use entity work.and2(logica_retard);
  

  begin
  
    dut1: inversor port map (a, inva);
    dut2: inversor port map(b, invb);
    dut3: and2 port map(inva, b, sort1_and2);
    dut4: and2 port map(invb, a, sort2_and2);
    

end estructural;
    

------------------------FLIP-FLOP----------------------

--ENTITY FF_JK_PUJADA
entity FF_JK_pujada is
  port(
    J, K, CK: in bit;
    Q: out bit);
end FF_JK_pujada;

--ARCHITECTURE IFTHEN OF FF_JK_PUJADA
architecture ifthen of FF_JK_pujada is
  signal qint: bit;
  begin
    process(J, K, CK)
      begin
        if CK'event and CK = '1' then
          if J = '0' and K = '0' then qint <= qint after 3 ns;
          elsif J = '0' and K = '1' then qint <= '0' after 3 ns;
          elsif J = '1' and K = '0' then qint <= '1' after 3 ns;
          else qint <= not qint after 3 ns;
          end if;
        end if;
    end process;
  Q <= qint;
end ifthen;

--ENTITY FF_T_BAIXADA
entity FF_T_baixada is
  port(
    T, CK, Pre: in bit;
    Q: out bit);
end FF_T_baixada;

--ARCHITECTURE IFTHEN OF FF_T_BAIXADA
architecture ifthen of FF_T_baixada is
  signal qint: bit;
  begin
    process(T, CK, Pre)
      begin
        if Pre = '0' then qint <= '1' after 3 ns;
        elsif CK'event and CK = '0' then
          if T = '0' then qint <= qint after 3 ns;
          else qint <= not qint after 3 ns;
          end if;
        end if;
    end process;
  Q <= qint;
end ifthen;

-------------------------SUMADOR 1 BIT-------------------------
--ENTITY SUMADOR_1_BIT
entity sumador_1_bit is
  port(
    a, b, Cin: in bit;
    Cout, S: out bit);
end sumador_1_bit;

--ARCHITECTURE ESTRUCTURAL OF SUMADOR_1_BIT
architecture estructural of sumador_1_bit is
  
  
  component and2 is
    port(
      a, b: in bit;
      z: out bit);
  end component;
  

  component xor2 is
    port(
      a, b: in bit;
      z: out bit);
  end component;
  
  --defining internal signals
  signal sort1_and2, sort2_and2: bit;
  signal sort1_xor2: bit;
  
  for dut1: and2 use entity work.and2(logica_retard);
  for dut2: and2 use entity work.and2(logica_retard);
  for dut3: xor2 use entity work.xor2(estructural);
  for dut4: xor2 use entity work.xor2(estructural);
  
  
  begin
    
    dut1: and2 port map(a, b, sort1_and2);
    dut2: and2 port map(Cin, sort2_and2);
    dut3: xor2 port map(a, b, sort1_xor2);
    dut4: xor2 port map(sort1_xor2, Cin, S);
      
end estructural;
