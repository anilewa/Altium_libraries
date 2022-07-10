-- --------------------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
-- --------------------------------------------------------------------
-- Copyright (c) 2005 by Lattice Semiconductor Corporation
-- --------------------------------------------------------------------
--
--
--                     Lattice Semiconductor Corporation
--                     5555 NE Moore Court
--                     Hillsboro, OR 97214
--                     U.S.A.
--
--                     TEL: 1-800-Lattice  (USA and Canada)
--                          1-408-826-6000 (other locations)
--
--                     web: http://www.latticesemi.com/
--                     email: techsupport@latticesemi.com
--
-- --------------------------------------------------------------------
--
-- Simulation Library File for XO
--
-- $Header: /home/rel01/env5_1a.34/vhdl/pkg/vhdsclibs/data/orca5mj/src/RCS/MACHXOCOMP.vhd,v 1.7 2005/05/19 20:37:52 pradeep Exp $ 
--

--- 
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
PACKAGE components IS 
-- 
COMPONENT ageb2
PORT(
        a0, a1: IN std_logic := 'X';
        b0, b1: IN std_logic := 'X';
        ci: IN std_logic := 'X';
        ge: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT aleb2
PORT( 
	a0, a1: IN std_logic := 'X';
	b0, b1: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	le: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT aneb2
PORT(
        a0, a1: IN std_logic := 'X';
        b0, b1: IN std_logic := 'X';
        ci: IN std_logic := 'X';
        ne: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT and2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT and3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT and4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT JTAGD
    GENERIC (ER1 : string := "ENABLED";
             ER2 : string := "ENABLED");
PORT(
      TCK                : IN    std_logic := 'X';
      TMS                : IN    std_logic := 'X';
      TDI                : IN    std_logic := 'X';
      JTDO1              : IN    std_logic := 'X';
      JTDO2              : IN    std_logic := 'X';
      TDO                :      OUT  std_logic;
      JTCK               :      OUT  std_logic;
      JTDI               :      OUT  std_logic;
      JSHIFT             :      OUT  std_logic;
      JUPDATE            :      OUT  std_logic;
      JRST               :      OUT  std_logic;
      JCE1               :      OUT  std_logic;
      JCE2               :      OUT  std_logic;
      JRTI1              :      OUT  std_logic;
      JRTI2              :      OUT  std_logic);

END COMPONENT;
--
component CCU2
   generic (
      inject1_0 : string := "YES";
      inject1_1 : string := "YES";
      init0: string := "0x0000";
      init1: string := "0x0000"
   );
   port (
      A0,A1 : in std_ulogic;
      B0,B1 : in std_ulogic;
      C0,C1 : in std_ulogic;
      D0,D1 : in std_ulogic;
      CIN : in std_ulogic;
      S0,S1 : out std_ulogic;
      COUT0,COUT1 : out std_ulogic
   );
end component;
--
COMPONENT and5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cu2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cb2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        con: IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadd2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        cout0, cout1 : OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fsub2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        bi: IN std_logic := 'X';
        bout0, bout1 : OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadsu2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        bci: IN std_logic := 'X';
        con: IN std_logic := 'X';
        bco: OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fd1s1a
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1b
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1d
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1i
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1j
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ix
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3jx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ix
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3jx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3az
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3iy
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3jy
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1a
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1b
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1d
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1i
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1j
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT gsr
PORT( 
      gsr: IN std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT inv
PORT( 
	a: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux21
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT l6mux21
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux41
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	d2: IN std_logic := 'X';
	d3: IN std_logic := 'X';
	sd1: IN std_logic := 'X';
	sd2: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux81
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	d2: IN std_logic := 'X';
	d3: IN std_logic := 'X';
	d4: IN std_logic := 'X';
	d5: IN std_logic := 'X';
	d6: IN std_logic := 'X';
	d7: IN std_logic := 'X';
	sd1: IN std_logic := 'X';
	sd2: IN std_logic := 'X';
	sd3: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux161
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        d2: IN std_logic := 'X';
        d3: IN std_logic := 'X';
        d4: IN std_logic := 'X';
        d5: IN std_logic := 'X';
        d6: IN std_logic := 'X';
        d7: IN std_logic := 'X';
        d8: IN std_logic := 'X';
        d9: IN std_logic := 'X';
        d10: IN std_logic := 'X';
        d11: IN std_logic := 'X';
        d12: IN std_logic := 'X';
        d13: IN std_logic := 'X';
        d14: IN std_logic := 'X';
        d15: IN std_logic := 'X';
        sd1: IN std_logic := 'X';
        sd2: IN std_logic := 'X';
        sd3: IN std_logic := 'X';
        sd4: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT mux321
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        d2: IN std_logic := 'X';
        d3: IN std_logic := 'X';
        d4: IN std_logic := 'X';
        d5: IN std_logic := 'X';
        d6: IN std_logic := 'X';
        d7: IN std_logic := 'X';
        d8: IN std_logic := 'X';
        d9: IN std_logic := 'X';
        d10: IN std_logic := 'X';
        d11: IN std_logic := 'X';
        d12: IN std_logic := 'X';
        d13: IN std_logic := 'X';
        d14: IN std_logic := 'X';
        d15: IN std_logic := 'X';
        d16: IN std_logic := 'X';
        d17: IN std_logic := 'X';
        d18: IN std_logic := 'X';
        d19: IN std_logic := 'X';
        d20: IN std_logic := 'X';
        d21: IN std_logic := 'X';
        d22: IN std_logic := 'X';
        d23: IN std_logic := 'X';
        d24: IN std_logic := 'X';
        d25: IN std_logic := 'X';
        d26: IN std_logic := 'X';
        d27: IN std_logic := 'X';
        d28: IN std_logic := 'X';
        d29: IN std_logic := 'X';
        d30: IN std_logic := 'X';
        d31: IN std_logic := 'X';
        sd1: IN std_logic := 'X';
        sd2: IN std_logic := 'X';
        sd3: IN std_logic := 'X';
        sd4: IN std_logic := 'X';
        sd5: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT nd2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT or2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT oscc
PORT(
        osc: OUT std_logic := 'X');
END COMPONENT;
--
COMPONENT pfumx
PORT( 
	alut: IN std_logic := 'X';
	blut: IN std_logic := 'X';
	c0  : IN std_logic := 'X';
	z   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT pur
   GENERIC (
      RST_PULSE          : Integer   := 1);
PORT(
      pur: IN std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dpr16x2b
PORT(   di0  : IN std_logic;
        di1  : IN std_logic;
        wck  : IN std_logic;
        wre  : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        wdo0 : OUT std_logic;
        wdo1 : OUT std_logic;
        rdo0 : OUT std_logic;
        rdo1 : OUT std_logic
  );
END COMPONENT;
--
COMPONENT spr16x2b
PORT(   di0  : IN std_logic;
        di1  : IN std_logic;
        ck   : IN std_logic;
        wre  : IN std_logic;
        ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic
  );
END COMPONENT;
--
COMPONENT rom32x1
GENERIC(
        initval : string := "0x00000000"
  );
PORT( 
	ad0, ad1, ad2, ad3, ad4: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom16x1
GENERIC(
        initval : string := "0x0000"
  );
PORT( 
	ad0, ad1, ad2, ad3: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom64x1
GENERIC(
        initval : string := "0x0000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom128x1
GENERIC(
        initval : string := "0x00000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom256x1
GENERIC(
        initval : string := "0x0000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT tsall
PORT( 
       tsall: IN std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT vhi
PORT( 
	 z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT vlo
PORT( 
	 z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor11
PORT( 
        a, b, c, d, e, f, g, h, i, j, k: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor21
PORT( 
	a, b, c, d, e, f, g, h, i, j, k: IN std_logic := 'X';
	l, m, n, o, p, q, r, s, t, u: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT bufba
PORT(
        a: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dp8kb
GENERIC(
        DATA_WIDTH_A : in Integer := 18;
        DATA_WIDTH_B : in Integer := 18;
        REGMODE_A    : String  := "NOREG";
        REGMODE_B    : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_A   : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_B   : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE_A  : String  := "NORMAL";
        WRITEMODE_B  : String  := "NORMAL";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic := 'X';
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic := 'X';
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic := 'X';
        ada9, ada10, ada11, ada12                                : in std_logic := 'X';
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic := 'X';
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic := 'X';
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic := 'X';
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic := 'X';
        adb9, adb10, adb11, adb12                                : in std_logic := 'X';
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic := 'X';

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic := 'X';
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic := 'X';
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic := 'X';
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pdp8kb
GENERIC(
        DATA_WIDTH_W : in Integer := 18;
        DATA_WIDTH_R : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_W   : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_R   : std_logic_vector(2 downto 0)  := "000";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        adw0, adw1, adw2, adw3, adw4, adw5, adw6, adw7, adw8   : in std_logic := 'X';
        adw9, adw10, adw11, adw12                       : in std_logic := 'X';
        cew, clkw, we, csw0, csw1, csw2                        : in std_logic := 'X';
        adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8   : in std_logic := 'X';
        adr9, adr10, adr11, adr12                       : in std_logic := 'X';
        cer, clkr, csr0, csr1, csr2, rst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fifo8ka
GENERIC(
        DATA_WIDTH_W               : Integer  := 18;
        DATA_WIDTH_R               : Integer  := 18;
        REGMODE                    : String  := "NOREG";
        RESETMODE                  : String  := "ASYNC";
        CSDECODE_W                 : std_logic_vector(1 downto 0)  := "00";
        CSDECODE_R                 : std_logic_vector(1 downto 0)  := "00";
        AEPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AEPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER                : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER1               : std_logic_vector(14 downto 0)  := "000000000000000";
        gsr                        : String    := "DISABLED"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        fulli, csw0, csw1, emptyi, csr0, csr1                     : in std_logic := 'X';
        we, re, clkw, clkr, rst, rprst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X';
        ef, aef, aff, ff                                       : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sp8kb
GENERIC(
        DATA_WIDTH   : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE     : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE    : String  := "NORMAL";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12                            : in std_logic := 'X';
        ce, clk, we, cs0, cs1, cs2                             : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X'
  );
END COMPONENT;
--

COMPONENT bbw
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obw
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ilvds
PORT(
        a : IN std_logic := 'X';
        an: IN std_logic := 'X';
        z : OUT std_logic
 );
END COMPONENT;
--
COMPONENT olvds
PORT(
        a  : IN std_logic := 'X';
        z  : OUT std_logic ;
        zn : OUT std_logic
 );
END COMPONENT;
--
COMPONENT bb
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bbpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bbpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ib
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibpd
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibpu
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ob
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obzpd
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obzpu
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT dcs
PORT(
        clk0              : IN std_logic;
        clk1              : IN std_logic;
        sel               : IN std_logic;
        dcsout            : OUT std_logic);
END COMPONENT;
--
COMPONENT ehxpllc
GENERIC(
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 1;
      CLKOK_DIV          : Integer   := 1;
      PHASEADJ           : Integer   := 0;
      FDEL               : Integer   := 0;
      DUTY               : Integer   := 4;
      DELAY_CNTL         : String    := "STATIC";
      WAKE_ON_LOCK       : String    := "ON";
      LOCK_DELAY         : Integer   := 100;
      LOCK_CYC           : Integer   := 2
   );
   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      ddamode               : in std_logic;
      ddaizr                : in std_logic;
      ddailag               : in std_logic;
      ddaidel0              : in std_logic;
      ddaidel1              : in std_logic;
      ddaidel2              : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);
END COMPONENT;
--
------Component ORCALUT4------
component ORCALUT4
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT5------
component ORCALUT5
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT6------
component ORCALUT6
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT7------
component ORCALUT7
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          G             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT8------
component ORCALUT8
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          G             :       in      STD_ULOGIC;
          H             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;
--
END components;
