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
-- Simulation Library File for EC/XP
--
-- $Header: /home/rlp/Orfdry/env_rcs/vhdl/pkg/vhdsclibs/data/orca5mg/src/RCS/ORCA_MEM.vhd,v 1.10 2005/09/23 18:48:54 pradeep Exp $ 
--


 
--
----- package mem1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE mem1 IS
   TYPE mem_type_1 IS array (natural range <>) OF std_logic;
   TYPE mem_type_2 IS array (natural range <>) OF std_logic_vector(1 downto 0);
   TYPE mem_type_4 IS array (natural range <>) OF std_logic_vector(3 downto 0);
   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR;
   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector;
   FUNCTION init_ram (hex: string) RETURN mem_type_4;
   FUNCTION init_ram (hex: string) RETURN mem_type_2;
   FUNCTION init_ram_1 (hex: string) RETURN mem_type_1;
END mem1;
 
PACKAGE BODY mem1 IS

   FUNCTION init_ram (hex: string) RETURN mem_type_2 IS
        -- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_2 (length-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result (length-1-i) := hex2bin_2 (hex(i+3));
        END LOOP;
        RETURN result;
   END;

   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (1 downto 0);
   begin
        case hex is
          when '0' =>
             result := "00";
          when '1' =>
             result := "01";
          when '2' =>
             result := "10";
          when '3' =>
             result := "11";
          when '4' =>
             result := "00";
          when '5' =>
             result := "01";
          when '6' =>
             result := "10";
          when '7' =>
             result := "11";
          when '8' =>
             result := "00";
          when '9' =>
             result := "01";
          when 'A'|'a' =>
             result := "10";
          when 'B'|'b' =>
             result := "11";
          when 'C'|'c' =>
             result := "00";
          when 'D'|'d' =>
             result := "01";
          when 'E'|'e' =>
             result := "10";
          when 'F'|'f' =>
             result := "11";
          when others =>
             null;
        end case;
        return result;
   end;

   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector IS
        VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
        CASE hex IS
          WHEN '0' => 
             result := "0000";
          WHEN '1' => 
             result := "0001";
          WHEN '2' => 
             result := "0010";
          WHEN '3' => 
             result := "0011";
          WHEN '4' => 
             result := "0100";
          WHEN '5' => 
             result := "0101";
          WHEN '6' => 
             result := "0110";
          WHEN '7' => 
             result := "0111";
          WHEN '8' => 
             result := "1000";
          WHEN '9' => 
             result := "1001";
          WHEN 'A'|'a' => 
             result := "1010";
          WHEN 'B'|'b' => 
             result := "1011";
          WHEN 'C'|'c' => 
             result := "1100";
          WHEN 'D'|'d' => 
             result := "1101";
          WHEN 'E'|'e' => 
             result := "1110";
          WHEN 'F'|'f' => 
             result := "1111";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END; 
 
   FUNCTION init_ram (hex: string) RETURN mem_type_4 IS
	-- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_4 (length-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result (length-1-i) := hex2bin_4 (hex(i+3));
        END LOOP;
        RETURN result;
   END;

   FUNCTION init_ram_1 (hex: string) RETURN mem_type_1 IS
        -- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_1 ((4*length)-1 downto 0);
        VARIABLE result1 : std_logic_vector((4*length)-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result1 ((4*(length-i))-1 downto (4*(length-1-i))) := hex2bin_4 (hex(i+3));

           FOR j in 0 to 3 LOOP
             result(((4*length)-1)-j-(4*i)) := result1(((4*length)-1)-j-(4*i)); 
           END LOOP;

        END LOOP;
        RETURN result;
   END;

END mem1;



--
----- PACKAGE mem2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
package mem2 is
   function hex2bin (hex: String) return STD_LOGIC_VECTOR;
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR;
end mem2;
 
package body mem2 is
 
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (3 downto 0);
   begin
        case hex is
          when '0' =>
             result := "0000";
          when '1' =>
             result := "0001";
          when '2' =>
             result := "0010";
          when '3' =>
             result := "0011";
          when '4' =>
             result := "0100";
          when '5' =>
             result := "0101";
          when '6' =>
             result := "0110";
          when '7' =>
             result := "0111";
          when '8' =>
             result := "1000";
          when '9' =>
             result := "1001";
          when 'A'|'a' =>
             result := "1010";
          when 'B'|'b' =>
             result := "1011";
          when 'C'|'c' =>
             result := "1100";
          when 'D'|'d' =>
             result := "1101";
          when 'E'|'e' =>
             result := "1110";
          when 'F'|'f' =>
             result := "1111";
          when others =>
             null;
        end case;
        return result;
   end;
 
   function hex2bin (hex: String) return STD_LOGIC_VECTOR is
        -- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : STD_LOGIC_VECTOR (4*length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3));
        end loop;
        return result;
   end;
 
end mem2;

--
----- package mem3 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE mem3 IS
   TYPE mem_type_5 IS array (Integer range <>) OF std_logic_vector(17 downto 0);
   TYPE mem_type_6 IS array (Integer range <>) OF std_logic_vector(15 downto 0);
   FUNCTION hex2bin (hex: character) RETURN std_logic_vector;
   FUNCTION str3_slv12 (hex: string) RETURN std_logic_vector;
   FUNCTION data2data (data_w: integer) RETURN integer;
   FUNCTION data2addr_w (data_w: integer) RETURN integer;
   FUNCTION data2data_w (data_w: integer) RETURN integer;
   FUNCTION init_ram (hex: string; DATA_WIDTH_A : integer; DATA_WIDTH_B : integer) RETURN std_logic_vector;
   FUNCTION init_ram1 (hex: string) RETURN mem_type_6;
   FUNCTION str2slv (str: in string) RETURN std_logic_vector;
   FUNCTION Valid_Address (IN_ADDR : in std_logic_vector) return boolean;
END mem3;
PACKAGE BODY mem3 IS

   FUNCTION hex2bin (hex: character) RETURN std_logic_vector IS
        VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
        CASE hex IS
          WHEN '0' =>
             result := "0000";
          WHEN '1' =>
             result := "0001";
          WHEN '2' =>
             result := "0010";
          WHEN '3' =>
             result := "0011";
          WHEN '4' =>
             result := "0100";
          WHEN '5' =>
             result := "0101";
          WHEN '6' =>
             result := "0110";
          WHEN '7' =>
             result := "0111";
          WHEN '8' =>
             result := "1000";
          WHEN '9' =>
             result := "1001";
          WHEN 'A'|'a' =>
             result := "1010";
          WHEN 'B'|'b' =>
             result := "1011";
          WHEN 'C'|'c' =>
             result := "1100";
          WHEN 'D'|'d' =>
             result := "1101";
          WHEN 'E'|'e' =>
             result := "1110";
          WHEN 'F'|'f' =>
             result := "1111";
          WHEN 'X'|'x' =>
             result := "XXXX";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END;

   FUNCTION str5_slv18 (s : string(5 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(17 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
          result(17 downto 16) := hex2bin(s(5))(1 downto 0);
       RETURN result;
   END;

   FUNCTION str4_slv16 (s : string(4 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(15 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION str3_slv12 (hex: string) return std_logic_vector is
        VARIABLE result : std_logic_vector(11 downto 0);
   BEGIN
       FOR i in 0 to 2 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(hex(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION data2addr_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 13;
          WHEN 2 =>
             result := 12;
          WHEN 4 =>
             result := 11;
          WHEN 9 =>
             result := 10;
          WHEN 18 =>
             result := 9;
          WHEN 36 =>
             result := 8;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 1;
          WHEN 2 =>
             result := 2;
          WHEN 4 =>
             result := 4;
          WHEN 9 =>
             result := 9;
          WHEN 18 =>
             result := 18;
          WHEN 36 =>
             result := 18;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 8;
          WHEN 2 =>
             result := 4;
          WHEN 4 =>
             result := 2;
          WHEN 9 =>
             result := 36864;
          WHEN 18 =>
             result := 36864;
          WHEN 36 =>
             result := 36864;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION init_ram (hex: string; DATA_WIDTH_A : integer; DATA_WIDTH_B : integer) RETURN std_logic_vector IS
        CONSTANT length : integer := hex'length;
        VARIABLE result1 : mem_type_5 (0 to ((length/5)-1));
        VARIABLE result : std_logic_vector(((length*18)/5)-1 downto 0);
   BEGIN
       FOR i in 0 to ((length/5)-1) LOOP
         result1(i) := str5_slv18(hex((i+1)*5 downto (i*5)+1));
       END LOOP;
       IF (DATA_WIDTH_A >= 9 and DATA_WIDTH_B >= 9) THEN
          FOR j in 0 to 511 LOOP
            result(((j*18) + 17) downto (j*18)) := result1(j)(17 downto 0);
          END LOOP;
       ELSE
          FOR j in 0 to 511 LOOP
            result(((j*18) + 7) downto (j*18)) := result1(j)(7 downto 0);
            result((j*18) + 8) := '0';
            result(((j*18) + 16) downto ((j*18) + 9)) := result1(j)(15 downto 8);
            result((j*18) + 17) := '0';
          END LOOP;
       END IF;
       RETURN result;
   END;

   FUNCTION init_ram1 (hex: string) RETURN mem_type_6 IS
        CONSTANT length : integer := hex'length;
        VARIABLE result : mem_type_6 (0 to ((length/4)-1));
   BEGIN
       FOR i in 0 to ((length/4)-1) LOOP
         result(i) := str4_slv16(hex((i+1)*4 downto (i*4)+1));
       END LOOP;
       RETURN result;
   END;

-- String to std_logic_vector

  FUNCTION str2slv (
      str : in string
  ) return std_logic_vector is

  variable j : integer := str'length;
  variable slv : std_logic_vector (str'length downto 1);

  begin
      for i in str'low to str'high loop
          case str(i) is
              when '0' => slv(j) := '0';
              when '1' => slv(j) := '1';
              when 'X' => slv(j) := 'X';
              when 'U' => slv(j) := 'U';
              when others => slv(j) := 'X';
          end case;
          j := j - 1;
      end loop;
      return slv;
  end str2slv;

function Valid_Address (
    IN_ADDR : in std_logic_vector
 ) return boolean is

    variable v_Valid_Flag : boolean := TRUE;

begin

    for i in IN_ADDR'high downto IN_ADDR'low loop
        if (IN_ADDR(i) /= '0' and IN_ADDR(i) /= '1') then
            v_Valid_Flag := FALSE;
        end if;
    end loop;

    return v_Valid_Flag;
end Valid_Address;

END mem3 ;

--
----- cell rom256x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom256x1 IS
  GENERIC (
        initval : string := "0x0000000000000000000000000000000000000000000000000000000000000000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom256x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad5_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad6_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad7_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        ad6  : IN   std_logic;
        ad7  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom256x1 : ENTITY IS TRUE;
 
END rom256x1;
 
-- architecture body --
ARCHITECTURE v OF rom256x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
   SIGNAL ad5_ipd  : std_logic := 'X';
   SIGNAL ad6_ipd  : std_logic := 'X';
   SIGNAL ad7_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   VitalWireDelay(ad5_ipd, ad5, tipd_ad5);
   VitalWireDelay(ad6_ipd, ad6, tipd_ad6);
   VitalWireDelay(ad7_ipd, ad7, tipd_ad7);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd, ad5_ipd, ad6_ipd, ad7_ipd)
 
     VARIABLE memory   : std_logic_vector((2**8)-1 downto 0) := hex2bin(initval);
 
     -- functionality results
     VARIABLE do0_zd : std_logic :='X';
     
     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad7_ipd, ad6_ipd, ad5_ipd, ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
               4 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE),
               5 => (ad5_ipd'last_event, tpd_ad5_do0, TRUE),
               6 => (ad6_ipd'last_event, tpd_ad6_do0, TRUE),
               7 => (ad7_ipd'last_event, tpd_ad7_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, 
      MsgOn => MsgOn);

   end process;
 
end V; 
 

--
----- cell rom128x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom128x1 IS
  GENERIC (
        initval : string := "0x00000000000000000000000000000000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom128x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad5_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad6_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        ad6  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom128x1 : ENTITY IS TRUE;
 
END rom128x1;
 
-- architecture body --
ARCHITECTURE v OF rom128x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
   SIGNAL ad5_ipd  : std_logic := 'X';
   SIGNAL ad6_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   VitalWireDelay(ad5_ipd, ad5, tipd_ad5);
   VitalWireDelay(ad6_ipd, ad6, tipd_ad6);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd, ad5_ipd, ad6_ipd)
 
     VARIABLE memory   : std_logic_vector((2**7)-1 downto 0) := hex2bin(initval);
 
     -- functionality results
     VARIABLE do0_zd : std_logic :='X';
     
     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad6_ipd, ad5_ipd, ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
               4 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE),
               5 => (ad5_ipd'last_event, tpd_ad5_do0, TRUE),
               6 => (ad6_ipd'last_event, tpd_ad6_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, 
      MsgOn => MsgOn);

   end process;
 
end V; 
 


--
----- cell rom64x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom64x1 IS
  GENERIC (
        initval : string := "0x0000000000000000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom64x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad5_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom64x1 : ENTITY IS TRUE;
 
END rom64x1;
 
-- architecture body --
ARCHITECTURE v OF rom64x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
   SIGNAL ad5_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   VitalWireDelay(ad5_ipd, ad5, tipd_ad5);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd, ad5_ipd)
 
     VARIABLE memory   : std_logic_vector((2**6)-1 downto 0) := hex2bin(initval);
 
     -- functionality results
     VARIABLE do0_zd : std_logic :='X';
     
     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad5_ipd, ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
               4 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE),
               5 => (ad5_ipd'last_event, tpd_ad5_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, 
      MsgOn => MsgOn);

   end process;
 
end V; 
 


--
----- cell rom32x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom32x1 IS
  GENERIC (
        initval : string := "0x00000000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom32x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom32x1 : ENTITY IS TRUE;
 
END rom32x1;
 
-- architecture body --
ARCHITECTURE v OF rom32x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd)
 
     VARIABLE memory   : std_logic_vector((2**5)-1 downto 0) := hex2bin(initval);
 
     -- functionality results
     VARIABLE do0_zd : std_logic :='X';
     
     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
               4 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, 
      MsgOn => MsgOn);

   end process;
 
end V; 
 


--
----- cell rom16x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom16x1 IS
  GENERIC (
        initval : string := "0x0000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "rom16x1";

        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.01 ns, 0.01 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom16x1 : ENTITY IS TRUE;
 
END rom16x1;

-- architecture body --
ARCHITECTURE v OF rom16x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd)
 
     VARIABLE memory   : std_logic_vector((2**4)-1 downto 0) := hex2bin(initval);
 
     -- functionality results
     VARIABLE do0_zd : std_logic :='X';
 
     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;
 
BEGIN
 
   ------------------------
   -- functionality section
   ------------------------
 
      do0_zd := VitalMUX (data => memory,
                         dselect => (ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));
 
   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn,
      MsgOn => MsgOn);
 
   end process;
 
end V;

----- cell dpr16x2b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY dpr16x2b IS
  GENERIC (

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "dpr16x2b";

        -- input SIGNAL delays
        tipd_rad0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wre  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wck  : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        tsetup_wad0_wck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_wad1_wck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_wad2_wck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_wad3_wck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_wre_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        tsetup_di0_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        tsetup_di1_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wad0_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wad1_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wad2_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wad3_wck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wre_wck_noedge_posedge   : VitalDelayType := 0.0 ns;
        thold_di0_wck_noedge_posedge   : VitalDelayType := 0.0 ns;
        thold_di1_wck_noedge_posedge   : VitalDelayType := 0.0 ns;

        -- pulse width constraints
        tperiod_wre             : VitalDelayType := 0.001 ns;
        tpw_wre_posedge : VitalDelayType := 0.001 ns;
        tpw_wre_negedge : VitalDelayType := 0.001 ns;
        tperiod_wck              : VitalDelayType := 0.001 ns;
        tpw_wck_posedge         : VitalDelayType := 0.001 ns;
        tpw_wck_negedge         : VitalDelayType := 0.001 ns;

        -- propagation delays
        tpd_wck_wdo0    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_wck_wdo1    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad0_rdo0    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad1_rdo0   : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad2_rdo0    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad3_rdo0    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad0_rdo1    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad1_rdo1   : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad2_rdo1    : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_rad3_rdo1    : VitalDelayType01 := (0.001 ns, 0.001 ns));

  port (di0  : IN std_logic;
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
        rdo1 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF dpr16x2b : ENTITY IS TRUE;

END dpr16x2b;


-- architecture body --
ARCHITECTURE v OF dpr16x2b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL di0_ipd  : std_logic := 'X';
   SIGNAL di1_ipd  : std_logic := 'X';
   SIGNAL rad0_ipd : std_logic := 'X';
   SIGNAL rad1_ipd : std_logic := 'X';
   SIGNAL rad2_ipd : std_logic := 'X';
   SIGNAL rad3_ipd : std_logic := 'X';
   SIGNAL wad0_ipd : std_logic := 'X';
   SIGNAL wad1_ipd : std_logic := 'X';
   SIGNAL wad2_ipd : std_logic := 'X';
   SIGNAL wad3_ipd : std_logic := 'X';
   SIGNAL wre_ipd  : std_logic := 'X';
   SIGNAL wck_ipd  : std_logic := 'X';

BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(di0_ipd, di0, tipd_di0);
   VitalWireDelay(di1_ipd, di1, tipd_di1);
   VitalWireDelay(rad0_ipd, rad0, tipd_rad0);
   VitalWireDelay(rad1_ipd, rad1, tipd_rad1);
   VitalWireDelay(rad2_ipd, rad2, tipd_rad2);
   VitalWireDelay(rad3_ipd, rad3, tipd_rad3);
   VitalWireDelay(wad0_ipd, wad0, tipd_wad0);
   VitalWireDelay(wad1_ipd, wad1, tipd_wad1);
   VitalWireDelay(wad2_ipd, wad2, tipd_wad2);
   VitalWireDelay(wad3_ipd, wad3, tipd_wad3);
   VitalWireDelay(wre_ipd, wre, tipd_wre);
   VitalWireDelay(wck_ipd, wck, tipd_wck);
   END BLOCK;

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (wck_ipd, wre_ipd, wad0_ipd,
     wad1_ipd, wad2_ipd, wad3_ipd, rad0_ipd, rad1_ipd, rad2_ipd,
     rad3_ipd, di0_ipd, di1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0);
     VARIABLE radr_reg, wadr_reg, wadr_reg1 : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(1 downto 0) := "00";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex, windex1 : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- timing check results
     VARIABLE tviol_di0   : x01 := '0';
     VARIABLE tviol_di1   : x01 := '0';
     VARIABLE tviol_wad0  : x01 := '0';
     VARIABLE tviol_wad1  : x01 := '0';
     VARIABLE tviol_wad2  : x01 := '0';
     VARIABLE tviol_wad3  : x01 := '0';
     VARIABLE tviol_wre  : x01 := '0';
     VARIABLE tsviol_wre : x01 := '0';
     VARIABLE tviol_wck    : x01 := '0';
     VARIABLE PeriodCheckInfo_wre : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_wck   : VitalPeriodDataType;
     VARIABLE wad0_wck_TimingDatash : VitalTimingDataType;
     VARIABLE wad1_wck_TimingDatash : VitalTimingDataType;
     VARIABLE wad2_wck_TimingDatash : VitalTimingDataType;
     VARIABLE wad3_wck_TimingDatash : VitalTimingDataType;
     VARIABLE wre_wck_TimingDatash : VitalTimingDataType;
     VARIABLE di0_wck_TimingDatash  : VitalTimingDataType;
     VARIABLE di1_wck_TimingDatash  : VitalTimingDataType;

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS wdo0_zd       : std_ulogic IS results(0);
     ALIAS wdo1_zd       : std_ulogic IS results(1);
     ALIAS rdo0_zd       : std_ulogic IS results(2);
     ALIAS rdo1_zd       : std_ulogic IS results(3);

     -- output glitch results
     VARIABLE wdo0_GlitchData  : VitalGlitchDataType;
     VARIABLE wdo1_GlitchData  : VitalGlitchDataType;
     VARIABLE rdo0_GlitchData  : VitalGlitchDataType;
     VARIABLE rdo1_GlitchData  : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

           -- setup and hold checks on the write address lines
           VitalSetupHoldCheck (
                TestSignal => wad0_ipd,
                TestSignalName => "wad0",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_wad0_wck_noedge_posedge,
                setuplow => tsetup_wad0_wck_noedge_posedge,
                HoldHigh => thold_wad0_wck_noedge_posedge,
                HoldLow => thold_wad0_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wad0_wck_timingdatash,
                Violation => tviol_wad0,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => wad1_ipd,
                TestSignalName => "wad1",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_wad1_wck_noedge_posedge,
                setuplow => tsetup_wad1_wck_noedge_posedge,
                HoldHigh => thold_wad1_wck_noedge_posedge,
                HoldLow =>  thold_wad1_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wad1_wck_timingdatash,
                Violation => tviol_wad1,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => wad2_ipd,
                TestSignalName => "wad2",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_wad2_wck_noedge_posedge,
                setuplow => tsetup_wad2_wck_noedge_posedge,
                HoldHigh => thold_wad2_wck_noedge_posedge,
                HoldLow => thold_wad2_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wad2_wck_timingdatash,
                Violation => tviol_wad2,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => wad3_ipd,
                TestSignalName => "wad3",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_wad3_wck_noedge_posedge,
                setuplow => tsetup_wad3_wck_noedge_posedge,
                HoldHigh => thold_wad3_wck_noedge_posedge,
                HoldLow => thold_wad3_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wad3_wck_timingdatash,
                Violation => tviol_wad3,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => wre_ipd,
                TestSignalName => "wre",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_wre_wck_noedge_posedge,
                setuplow => tsetup_wre_wck_noedge_posedge,
                HoldHigh => thold_wre_wck_noedge_posedge,
                HoldLow => thold_wre_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wre_wck_timingdatash,
                Violation => tsviol_wre,
                MsgSeverity => warning);
           -- setup and hold checks on data
           VitalSetupHoldCheck (
                TestSignal => di0_ipd,
                TestSignalName => "di0",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_di0_wck_noedge_posedge,
                setuplow => tsetup_di0_wck_noedge_posedge,
                HoldHigh => thold_di0_wck_noedge_posedge,
                HoldLow => thold_di0_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_wck_timingdatash,
                Violation => tviol_di0,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => di1_ipd,
                TestSignalName => "di1",
                RefSignal => wck_ipd,
                RefSignalName => "wck",
                SetupHigh => tsetup_di1_wck_noedge_posedge,
                setuplow => tsetup_di1_wck_noedge_posedge,
                HoldHigh => thold_di1_wck_noedge_posedge,
                HoldLow => thold_di1_wck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_wck_timingdatash,
                Violation => tviol_di1,
                MsgSeverity => warning);

           -- Period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => wck_ipd,
               TestSignalName => "wck",
               Period => tperiod_wck,
               PulseWidthHigh => tpw_wck_posedge,
               PulseWidthLow => tpw_wck_posedge,
               Perioddata => periodcheckinfo_wck,
               Violation => tviol_wck,
               MsgOn => MsgOn, XOn => XOn,
               HeaderMsg => InstancePath,
               CheckEnabled => TRUE,
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wre_ipd,
               TestSignalName => "wre",
               Period => tperiod_wre,
               PulseWidthHigh => tpw_wre_posedge,
               PulseWidthLow => tpw_wre_posedge,
               Perioddata => periodcheckinfo_wre,
               Violation => tviol_wre,
               MsgOn => MsgOn, XOn => XOn,
               HeaderMsg => InstancePath,
               CheckEnabled => TRUE,
               MsgSeverity => warning);
        END IF;

   ------------------------
   -- functionality section
   ------------------------
--    IF (disabled_gsr =  1) THEN
--       set_reset := purnet;
--    ELSE
--       set_reset := purnet AND gsrnet;
--    END IF;

--   IF (set_reset= '0') THEN
--      wre_reg := '0';
--      wadr_reg := "0000";
--   END IF;

   Violation := tviol_di0 or tviol_di1 or tviol_wad0 or tviol_wad1 or tviol_wad2 or
                tviol_wad3 or tviol_wre or tviol_wck or tsviol_wre ;


   IF ((is_x(wre_ipd)) and (set_reset='1')) THEN
      assert FALSE
        report "dpr16x2b memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF (is_x(rad0_ipd) or is_x(rad1_ipd) or is_x(rad2_ipd)
        or is_x(rad3_ipd)) THEN
      assert FALSE
        report "dpr16x2b memory hazard read address unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF ((is_x(wad0_ipd) or is_x(wad1_ipd) or is_x(wad2_ipd)
        or is_x(wad3_ipd)) and (set_reset='1')) THEN
      assert FALSE
        report "dpr16x2b memory hazard write address unknown!"
        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((wck_ipd'event and wck_ipd = '1') and (set_reset= '1')) THEN
         wre_reg := (wre_ipd);
         din_reg := (di1_ipd, di0_ipd);
         wadr_reg := (wad3_ipd, wad2_ipd, wad1_ipd, wad0_ipd);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (rad3_ipd, rad2_ipd, rad1_ipd, rad0_ipd);
      rindex := conv_integer(radr_reg);
      wadr_reg1 := (wad3_ipd, wad2_ipd, wad1_ipd, wad0_ipd);
      windex1 := conv_integer(wadr_reg1);

      -- at the falling edge of wck, write to memory at address
      IF (wre_reg = '1') THEN
         IF (wck_ipd'event and wck_ipd = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
         results(3 downto 2) := memory(rindex);
         results(1 downto 0) := memory(windex1);
      ELSE
         results := (others => 'X');
      END IF;
 
   END IF;

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => wdo0,
     OutSignalName => "wdo0",
     OutTemp => wdo0_zd,
     Paths => (0 => (wck_ipd'last_event, tpd_wck_wdo0, TRUE)),
      GlitchData => wdo0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => wdo1,
     OutSignalName => "wdo1",
     OutTemp => wdo1_zd,
     Paths => (0 => (wck_ipd'last_event, tpd_wck_wdo1, TRUE)),
      GlitchData => wdo1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => rdo0,
     OutSignalName => "rdo0",
     OutTemp => rdo0_zd,
     Paths => (0 => (rad0_ipd'last_event, tpd_rad0_rdo0, TRUE),
               1 => (rad1_ipd'last_event, tpd_rad1_rdo0, TRUE),
               2 => (rad2_ipd'last_event, tpd_rad2_rdo0, TRUE),
               3 => (rad3_ipd'last_event, tpd_rad3_rdo0, TRUE)),
      GlitchData => rdo0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => rdo1,
     OutSignalName => "rdo1",
     OutTemp => rdo1_zd,
     Paths => (0 => (rad0_ipd'last_event, tpd_rad0_rdo1, TRUE),
               1 => (rad1_ipd'last_event, tpd_rad1_rdo1, TRUE),
               2 => (rad2_ipd'last_event, tpd_rad2_rdo1, TRUE),
               3 => (rad3_ipd'last_event, tpd_rad3_rdo1, TRUE)),
      GlitchData => rdo1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);

   END PROCESS;

END v;



--
----- cell spr16x2b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY spr16x2b IS
  GENERIC (

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "spr16x2b";

        -- input SIGNAL delays
        tipd_ad0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wre  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        tsetup_ad0_ck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ad1_ck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ad2_ck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ad3_ck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_wre_ck_noedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_di0_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        tsetup_di1_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_ad0_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_ad1_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_ad2_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_ad3_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_wre_ck_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_di0_ck_noedge_posedge   : VitalDelayType := 0.0 ns;
        thold_di1_ck_noedge_posedge   : VitalDelayType := 0.0 ns;

        -- pulse width constraints
        tperiod_wre             : VitalDelayType := 0.001 ns;
        tpw_wre_posedge : VitalDelayType := 0.001 ns;
        tpw_wre_negedge : VitalDelayType := 0.001 ns;
        tperiod_ck              : VitalDelayType := 0.001 ns;
        tpw_ck_posedge          : VitalDelayType := 0.001 ns;
        tpw_ck_negedge          : VitalDelayType := 0.001 ns;

        -- propagation delays
        tpd_ck_do0     : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_ck_do1     : VitalDelayType01 := (0.001 ns, 0.001 ns));

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        ck   : IN std_logic;
        wre  : IN std_logic;
        ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF spr16x2b : ENTITY IS TRUE;

END spr16x2b;


-- architecture body --
ARCHITECTURE v OF spr16x2b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL di0_ipd  : std_logic := 'X';
   SIGNAL di1_ipd  : std_logic := 'X';
   SIGNAL ad0_ipd : std_logic := 'X';
   SIGNAL ad1_ipd : std_logic := 'X';
   SIGNAL ad2_ipd : std_logic := 'X';
   SIGNAL ad3_ipd : std_logic := 'X';
   SIGNAL wre_ipd : std_logic := 'X';
   SIGNAL ck_ipd   : std_logic := 'X';

BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(di0_ipd, di0, tipd_di0);
   VitalWireDelay(di1_ipd, di1, tipd_di1);
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(wre_ipd, wre, tipd_wre);
   VitalWireDelay(ck_ipd, ck, tipd_ck);
   END BLOCK;

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ck_ipd, wre_ipd, ad0_ipd,
     ad1_ipd, ad2_ipd, ad3_ipd, di0_ipd, di1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(1 downto 0) := "00";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- timing check results
     VARIABLE tviol_di0   : x01 := '0';
     VARIABLE tviol_di1   : x01 := '0';
     VARIABLE tviol_ad0  : x01 := '0';
     VARIABLE tviol_ad1  : x01 := '0';
     VARIABLE tviol_ad2  : x01 := '0';
     VARIABLE tviol_ad3  : x01 := '0';
     VARIABLE tviol_wre  : x01 := '0';
     VARIABLE tsviol_wre : x01 := '0';
     VARIABLE tviol_ck    : x01 := '0';
     VARIABLE PeriodCheckInfo_wre : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_ck   : VitalPeriodDataType;
     VARIABLE ad0_ck_TimingDatash : VitalTimingDataType;
     VARIABLE ad1_ck_TimingDatash : VitalTimingDataType;
     VARIABLE ad2_ck_TimingDatash : VitalTimingDataType;
     VARIABLE ad3_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wre_ck_TimingDatash : VitalTimingDataType;
     VARIABLE di0_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di1_ck_TimingDatash  : VitalTimingDataType;

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (1 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);

     -- output glitch results
     VARIABLE do0_GlitchData  : VitalGlitchDataType;
     VARIABLE do1_GlitchData  : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

           -- setup and hold checks on the write address lines
           VitalSetupHoldCheck (
                TestSignal => ad0_ipd,
                TestSignalName => "ad0",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_ad0_ck_noedge_posedge,
                setuplow => tsetup_ad0_ck_noedge_posedge,
                HoldHigh => thold_ad0_ck_noedge_posedge,
                HoldLow => thold_ad0_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => ad0_ck_timingdatash,
                Violation => tviol_ad0,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => ad1_ipd,
                TestSignalName => "ad1",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_ad1_ck_noedge_posedge,
                setuplow => tsetup_ad1_ck_noedge_posedge,
                HoldHigh => thold_ad1_ck_noedge_posedge,
                HoldLow =>  thold_ad1_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => ad1_ck_timingdatash,
                Violation => tviol_ad1,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => ad2_ipd,
                TestSignalName => "ad2",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_ad2_ck_noedge_posedge,
                setuplow => tsetup_ad2_ck_noedge_posedge,
                HoldHigh => thold_ad2_ck_noedge_posedge,
                HoldLow => thold_ad2_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => ad2_ck_timingdatash,
                Violation => tviol_ad2,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => ad3_ipd,
                TestSignalName => "ad3",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_ad3_ck_noedge_posedge,
                setuplow => tsetup_ad3_ck_noedge_posedge,
                HoldHigh => thold_ad3_ck_noedge_posedge,
                HoldLow => thold_ad3_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => ad3_ck_timingdatash,
                Violation => tviol_ad3,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => wre_ipd,
                TestSignalName => "wre",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_wre_ck_noedge_posedge,
                setuplow => tsetup_wre_ck_noedge_posedge,
                HoldHigh => thold_wre_ck_noedge_posedge,
                HoldLow => thold_wre_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => wre_ck_timingdatash,
                Violation => tsviol_wre,
                MsgSeverity => warning);
           -- setup and hold checks on data
           VitalSetupHoldCheck (
                TestSignal => di0_ipd,
                TestSignalName => "di0",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_di0_ck_noedge_posedge,
                setuplow => tsetup_di0_ck_noedge_posedge,
                HoldHigh => thold_di0_ck_noedge_posedge,
                HoldLow => thold_di0_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_ck_timingdatash,
                Violation => tviol_di0,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => di1_ipd,
                TestSignalName => "di1",
                RefSignal => ck_ipd,
                RefSignalName => "ck",
                SetupHigh => tsetup_di1_ck_noedge_posedge,
                setuplow => tsetup_di1_ck_noedge_posedge,
                HoldHigh => thold_di1_ck_noedge_posedge,
                HoldLow => thold_di1_ck_noedge_posedge,
                CheckEnabled => (set_reset='1'),
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_ck_timingdatash,
                Violation => tviol_di1,
                MsgSeverity => warning);

           -- Period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => ck_ipd,
               TestSignalName => "ck",
               Period => tperiod_ck,
               PulseWidthHigh => tpw_ck_posedge,
               PulseWidthLow => tpw_ck_posedge,
               Perioddata => periodcheckinfo_ck,
               Violation => tviol_ck,
               MsgOn => MsgOn, XOn => XOn,
               HeaderMsg => InstancePath,
               CheckEnabled => TRUE,
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wre_ipd,
               TestSignalName => "wre",
               Period => tperiod_wre,
               PulseWidthHigh => tpw_wre_posedge,
               PulseWidthLow => tpw_wre_posedge,
               Perioddata => periodcheckinfo_wre,
               Violation => tviol_wre,
               MsgOn => MsgOn, XOn => XOn,
               HeaderMsg => InstancePath,
               CheckEnabled => TRUE,
               MsgSeverity => warning);
        END IF;

   ------------------------
   -- functionality section
   ------------------------
 --   IF (disabled_gsr =  1) THEN
 --      set_reset := purnet;
 --   ELSE
 --      set_reset := purnet AND gsrnet;
 --   END IF;

 --  IF (set_reset= '0') THEN
 --     wre_reg := '0';
 --     wadr_reg := "0000";
 --  END IF;

   Violation := tviol_di0 or tviol_di0 or tviol_ad0 or tviol_ad1 or tviol_ad2 or
                tviol_ad3 or tviol_wre or tviol_ck or tsviol_wre;


   IF ((is_x(wre_ipd)) and (set_reset='1')) THEN
      assert FALSE
        report "spr16x2b memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF (is_x(ad0_ipd) or is_x(ad1_ipd) or is_x(ad2_ipd)
        or is_x(ad3_ipd)) THEN
      assert FALSE
        report "spr16x2b memory hazard read address unknown!"
        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((ck_ipd'event and ck_ipd = '1') and (set_reset= '1')) THEN
         wre_reg := (wre_ipd);
         din_reg := (di1_ipd, di0_ipd);
         wadr_reg := (ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd);
      rindex := conv_integer(radr_reg);

      -- at the falling edge of ck, write to memory at address
      IF (wre_reg = '1') THEN
         IF (ck_ipd'event and ck_ipd = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
         results(1 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;
 
   END IF;

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do1, TRUE)),
      GlitchData => do1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);

   END PROCESS;

END v;


--
-----cell dp8ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY dp8ka IS
   GENERIC (
        DATA_WIDTH_A               : Integer  := 18;
        DATA_WIDTH_B               : Integer  := 18;
        REGMODE_A                  : String   := "NOREG";
        REGMODE_B                  : String   := "NOREG";
        RESETMODE                  : String   := "SYNC";
        CSDECODE_A                 : String   := "000";
        CSDECODE_B                 : String   := "000";
        WRITEMODE_A                : String   := "NORMAL";
        WRITEMODE_B                : String   := "NORMAL";
        GSR                        : String   := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "dp8ka";

        -- input SIGNAL delays
        tipd_ada12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clka  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cea  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wea : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rsta : VitalDelayType01 := (0.0 ns, 0.0 ns);

        tipd_adb12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clkb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ceb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_web : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rstb : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays

        -- setup and hold constraints

        -- pulse width constraints
        tperiod_clka            : VitalDelayType := 0.001 ns;
        tpw_clka_posedge        : VitalDelayType := 0.001 ns;
        tpw_clka_negedge        : VitalDelayType := 0.001 ns;
        tperiod_clkb            : VitalDelayType := 0.001 ns;
        tpw_clkb_posedge        : VitalDelayType := 0.001 ns;
        tpw_clkb_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic := 'X';
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic := 'X';
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic := 'X';
        ada9, ada10, ada11, ada12                                       : in std_logic := 'X';
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic := 'X';
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic := 'X';
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic := 'X';
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic := 'X';
        adb9, adb10, adb11, adb12                                       : in std_logic := 'X';
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic := 'X';

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic := 'X';
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic := 'X';
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic := 'X';
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF dp8ka : ENTITY IS TRUE;

END dp8ka ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dp8ka IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

--SIGNAL DECLARATIONS----

    SIGNAL ada_ipd   : std_logic_vector(12 downto 0) := (others => '0');
    SIGNAL dia_ipd   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL clka_ipd  : std_logic := '0';
    SIGNAL cea_ipd   : std_logic := '0';
    SIGNAL wrea_ipd  : std_logic := '0';
    SIGNAL csa_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rsta_ipd  : std_logic := '0';
    SIGNAL adb_ipd   : std_logic_vector(12 downto 0) := "XXXXXXXXXXXXX";
    SIGNAL dib_ipd   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
    SIGNAL clkb_ipd  : std_logic := '0';
    SIGNAL ceb_ipd   : std_logic := '0';
    SIGNAL wreb_ipd  : std_logic := '0';
    SIGNAL csb_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rstb_ipd  : std_logic := '0';
    SIGNAL csa_en    : std_logic := '0';
    SIGNAL csb_en    : std_logic := '0';
    SIGNAL g_reset   : std_logic := '0';
    CONSTANT ADDR_WIDTH_A : integer := data2addr_w(DATA_WIDTH_A); 
    CONSTANT ADDR_WIDTH_B : integer := data2addr_w(DATA_WIDTH_B); 
    CONSTANT new_data_width_a : integer := data2data_w(DATA_WIDTH_A); 
    CONSTANT new_data_width_b : integer := data2data_w(DATA_WIDTH_B); 
    CONSTANT div_a    : integer := data2data(DATA_WIDTH_A); 
    CONSTANT div_b    : integer := data2data(DATA_WIDTH_B); 
    SIGNAL dia_node   : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_node   : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_node   : std_logic_vector((ADDR_WIDTH_A - 1) downto 0) := (others => '0');
    SIGNAL adb_node   : std_logic_vector((ADDR_WIDTH_B - 1) downto 0) := (others => '0');
    SIGNAL diab_node  : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL rsta_int   : std_logic := '0';
    SIGNAL rstb_int   : std_logic := '0';
    SIGNAL rsta_reg   : std_logic := '0';
    SIGNAL rstb_reg   : std_logic := '0';
    SIGNAL reseta     : std_logic := '0';
    SIGNAL resetb     : std_logic := '0';
    SIGNAL dia_reg    : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_reg    : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_reg    : std_logic_vector((ADDR_WIDTH_A - 1) downto 0);
    SIGNAL adb_reg    : std_logic_vector((ADDR_WIDTH_B - 1) downto 0);
    SIGNAL diab_reg   : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL wrena_reg  : std_logic := '0';
    SIGNAL clka_valid : std_logic := '0';
    SIGNAL clkb_valid : std_logic := '0';
    SIGNAL clka_valid1 : std_logic := '0';
    SIGNAL clkb_valid1 : std_logic := '0';
    SIGNAL last_clka_valid1 : std_logic := '0';
    SIGNAL last_clkb_valid1 : std_logic := '0';
    SIGNAL wrenb_reg  : std_logic := '0';
    SIGNAL rena_reg   : std_logic := '0';
    SIGNAL renb_reg   : std_logic := '0';
    SIGNAL rsta_sig   : std_logic := '0';
    SIGNAL rstb_sig   : std_logic := '0';
    SIGNAL doa_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doab_reg   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_int    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_int    : std_logic_vector(17 downto 0) := (others => '0');

	 --write & read/write collision flags
	 signal wr_a_wr_b_coll : std_logic := '0';
	 signal wr_a_rd_b_coll : std_logic := '0';
	 signal rd_a_wr_b_coll : std_logic := '0';
	 --lower & upper collision addresses
    signal dn_coll_addr, up_coll_addr : integer;

    CONSTANT initval   : string(2560 downto 1) := (
      initval_1f(3 to 82)&initval_1e(3 to 82)&initval_1d(3 to 82)&initval_1c(3 to 82)&
      initval_1b(3 to 82)&initval_1a(3 to 82)&initval_19(3 to 82)&initval_18(3 to 82)&
      initval_17(3 to 82)&initval_16(3 to 82)&initval_15(3 to 82)&initval_14(3 to 82)&
      initval_13(3 to 82)&initval_12(3 to 82)&initval_11(3 to 82)&initval_10(3 to 82)&
      initval_0f(3 to 82)&initval_0e(3 to 82)&initval_0d(3 to 82)&initval_0c(3 to 82)&
      initval_0b(3 to 82)&initval_0a(3 to 82)&initval_09(3 to 82)&initval_08(3 to 82)&
      initval_07(3 to 82)&initval_06(3 to 82)&initval_05(3 to 82)&initval_04(3 to 82)&
      initval_03(3 to 82)&initval_02(3 to 82)&initval_01(3 to 82)&initval_00(3 to 82));
    SIGNAL MEM       : std_logic_vector(9215 downto 0) := init_ram (initval, DATA_WIDTH_A, DATA_WIDTH_B);
    SIGNAL j         : integer := 0;
BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ada_ipd(0), ada0, tipd_ada0);
   VitalWireDelay(ada_ipd(1), ada1, tipd_ada1);
   VitalWireDelay(ada_ipd(2), ada2, tipd_ada2);
   VitalWireDelay(ada_ipd(3), ada3, tipd_ada3);
   VitalWireDelay(ada_ipd(4), ada4, tipd_ada4);
   VitalWireDelay(ada_ipd(5), ada5, tipd_ada5);
   VitalWireDelay(ada_ipd(6), ada6, tipd_ada6);
   VitalWireDelay(ada_ipd(7), ada7, tipd_ada7);
   VitalWireDelay(ada_ipd(8), ada8, tipd_ada8);
   VitalWireDelay(ada_ipd(9), ada9, tipd_ada9);
   VitalWireDelay(ada_ipd(10), ada10, tipd_ada10);
   VitalWireDelay(ada_ipd(11), ada11, tipd_ada11);
   VitalWireDelay(ada_ipd(12), ada12, tipd_ada12);
   VitalWireDelay(dia_ipd(0), dia0, tipd_dia0);
   VitalWireDelay(dia_ipd(1), dia1, tipd_dia1);
   VitalWireDelay(dia_ipd(2), dia2, tipd_dia2);
   VitalWireDelay(dia_ipd(3), dia3, tipd_dia3);
   VitalWireDelay(dia_ipd(4), dia4, tipd_dia4);
   VitalWireDelay(dia_ipd(5), dia5, tipd_dia5);
   VitalWireDelay(dia_ipd(6), dia6, tipd_dia6);
   VitalWireDelay(dia_ipd(7), dia7, tipd_dia7);
   VitalWireDelay(dia_ipd(8), dia8, tipd_dia8);
   VitalWireDelay(dia_ipd(9), dia9, tipd_dia9);
   VitalWireDelay(dia_ipd(10), dia10, tipd_dia10);
   VitalWireDelay(dia_ipd(11), dia11, tipd_dia11);
   VitalWireDelay(dia_ipd(12), dia12, tipd_dia12);
   VitalWireDelay(dia_ipd(13), dia13, tipd_dia13);
   VitalWireDelay(dia_ipd(14), dia14, tipd_dia14);
   VitalWireDelay(dia_ipd(15), dia15, tipd_dia15);
   VitalWireDelay(dia_ipd(16), dia16, tipd_dia16);
   VitalWireDelay(dia_ipd(17), dia17, tipd_dia17);
   VitalWireDelay(clka_ipd, clka, tipd_clka);
   VitalWireDelay(wrea_ipd, wea, tipd_wea);
   VitalWireDelay(cea_ipd, cea, tipd_cea);
   VitalWireDelay(csa_ipd(0), csa0, tipd_csa0);
   VitalWireDelay(csa_ipd(1), csa1, tipd_csa1);
   VitalWireDelay(csa_ipd(2), csa2, tipd_csa2);
   VitalWireDelay(rsta_ipd, rsta, tipd_rsta);
   VitalWireDelay(adb_ipd(0), adb0, tipd_adb0);
   VitalWireDelay(adb_ipd(1), adb1, tipd_adb1);
   VitalWireDelay(adb_ipd(2), adb2, tipd_adb2);
   VitalWireDelay(adb_ipd(3), adb3, tipd_adb3);
   VitalWireDelay(adb_ipd(4), adb4, tipd_adb4);
   VitalWireDelay(adb_ipd(5), adb5, tipd_adb5);
   VitalWireDelay(adb_ipd(6), adb6, tipd_adb6);
   VitalWireDelay(adb_ipd(7), adb7, tipd_adb7);
   VitalWireDelay(adb_ipd(8), adb8, tipd_adb8);
   VitalWireDelay(adb_ipd(9), adb9, tipd_adb9);
   VitalWireDelay(adb_ipd(10), adb10, tipd_adb10);
   VitalWireDelay(adb_ipd(11), adb11, tipd_adb11);
   VitalWireDelay(adb_ipd(12), adb12, tipd_adb12);
   VitalWireDelay(dib_ipd(0), dib0, tipd_dib0);
   VitalWireDelay(dib_ipd(1), dib1, tipd_dib1);
   VitalWireDelay(dib_ipd(2), dib2, tipd_dib2);
   VitalWireDelay(dib_ipd(3), dib3, tipd_dib3);
   VitalWireDelay(dib_ipd(4), dib4, tipd_dib4);
   VitalWireDelay(dib_ipd(5), dib5, tipd_dib5);
   VitalWireDelay(dib_ipd(6), dib6, tipd_dib6);
   VitalWireDelay(dib_ipd(7), dib7, tipd_dib7);
   VitalWireDelay(dib_ipd(8), dib8, tipd_dib8);
   VitalWireDelay(dib_ipd(9), dib9, tipd_dib9);
   VitalWireDelay(dib_ipd(10), dib10, tipd_dib10);
   VitalWireDelay(dib_ipd(11), dib11, tipd_dib11);
   VitalWireDelay(dib_ipd(12), dib12, tipd_dib12);
   VitalWireDelay(dib_ipd(13), dib13, tipd_dib13);
   VitalWireDelay(dib_ipd(14), dib14, tipd_dib14);
   VitalWireDelay(dib_ipd(15), dib15, tipd_dib15);
   VitalWireDelay(dib_ipd(16), dib16, tipd_dib16);
   VitalWireDelay(dib_ipd(17), dib17, tipd_dib17);
   VitalWireDelay(clkb_ipd, clkb, tipd_clkb);
   VitalWireDelay(wreb_ipd, web, tipd_web);
   VitalWireDelay(ceb_ipd, ceb, tipd_ceb);
   VitalWireDelay(csb_ipd(0), csb0, tipd_csb0);
   VitalWireDelay(csb_ipd(1), csb1, tipd_csb1);
   VitalWireDelay(csb_ipd(2), csb2, tipd_csb2);
   VitalWireDelay(rstb_ipd, rstb, tipd_rstb);
   END BLOCK;

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (GSR =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

  rsta_sig <= rsta_ipd or (not g_reset);
  rstb_sig <= rstb_ipd or (not g_reset);

--   set_reset <= g_reset and (not reset_ipd);
  ada_node <= ada_ipd(12 downto (13 - ADDR_WIDTH_A));
  adb_node <= adb_ipd(12 downto (13 - ADDR_WIDTH_B));

-- chip select A decode
  P1 : PROCESS(csa_ipd)
  BEGIN
     IF (csa_ipd = "000" and CSDECODE_A = "000") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "001" and CSDECODE_A = "001") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "010" and CSDECODE_A = "010") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "011" and CSDECODE_A = "011") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "100" and CSDECODE_A = "100") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "101" and CSDECODE_A = "101") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "110" and CSDECODE_A = "110") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "111" and CSDECODE_A = "111") THEN
        csa_en <= '1';
     ELSE
        csa_en <= '0';
     END IF;
  END PROCESS;

  P2 : PROCESS(csb_ipd)
  BEGIN
     IF (csb_ipd = "000" and CSDECODE_B = "000") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "001" and CSDECODE_B = "001") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "010" and CSDECODE_B = "010") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "011" and CSDECODE_B = "011") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "100" and CSDECODE_B = "100") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "101" and CSDECODE_B = "101") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "110" and CSDECODE_B = "110") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "111" and CSDECODE_B = "111") THEN
        csb_en <= '1';
     ELSE
        csb_en <= '0';
     END IF;
  END PROCESS;

  P3 : PROCESS(dia_ipd)
  BEGIN
     CASE DATA_WIDTH_A IS
       WHEN 1 =>
        dia_node <= dia_ipd(11 downto 11);
       WHEN 2 =>
        dia_node <= (dia_ipd(1), dia_ipd(11));
       WHEN 4 =>
        dia_node <= dia_ipd(3 downto 0); 
       WHEN 9 =>
        dia_node <= dia_ipd(8 downto 0);
       WHEN 18 =>
        dia_node <= dia_ipd;
       WHEN 36 =>
        dia_node <= dia_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  P4 : PROCESS(dib_ipd)
  BEGIN
     CASE DATA_WIDTH_B IS
       WHEN 1 =>
        dib_node <= dib_ipd(11 downto 11);
       WHEN 2 =>
        dib_node <= (dib_ipd(1), dib_ipd(11));
       WHEN 4 =>
        dib_node <= dib_ipd(3 downto 0); 
       WHEN 9 =>
        dib_node <= dib_ipd(8 downto 0);
       WHEN 18 =>
        dib_node <= dib_ipd;
       WHEN 36 =>
        dib_node <= dib_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  diab_node <= (dib_ipd & dia_ipd);

  P107 : PROCESS(clka_ipd)
  BEGIN
     IF (clka_ipd'event and clka_ipd = '1' and clka_ipd'last_value = '0') THEN
        IF ((g_reset = '0') or (rsta_ipd = '1')) THEN
           clka_valid <= '0';
        ELSE
           IF (cea_ipd = '1') THEN
              IF (csa_en = '1') THEN
                 clka_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clka_valid <= '0';
              END IF;
           ELSE
              clka_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;
 
  P108 : PROCESS(clkb_ipd)
  BEGIN
     IF (clkb_ipd'event and clkb_ipd = '1' and clkb_ipd'last_value = '0') THEN
        IF ((g_reset = '0') or (rstb_ipd = '1')) THEN
           clkb_valid <= '0';
        ELSE
           IF (ceb_ipd = '1') THEN
              IF (csb_en = '1') THEN 
                 clkb_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clkb_valid <= '0';
              END IF;
           ELSE
              clkb_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;

  clka_valid1 <= clka_valid;
  clkb_valid1 <= clkb_valid;
  last_clka_valid1 <= clka_valid1;
  last_clkb_valid1 <= clkb_valid1;

  P7 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        dia_reg <= (others => '0');
        diab_reg <= (others => '0');
        ada_reg <= (others => '0');
        wrena_reg <= '0';
        rena_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           dia_reg <= (others => '0');
           diab_reg <= (others => '0');
           ada_reg <= (others => '0');
           wrena_reg <= '0';
           rena_reg <= '0';
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              dia_reg <= dia_node;
              diab_reg <= diab_node;
              ada_reg <= ada_node;
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN 
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (rsta_ipd = '1') THEN
              dia_reg <= (others => '0');
              diab_reg <= (others => '0');
              ada_reg <= (others => '0');
              wrena_reg <= '0';
              rena_reg <= '0';
           ELSIF (cea_ipd = '1') THEN
              dia_reg <= dia_node; 
              diab_reg <= diab_node; 
              ada_reg <= ada_node;
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dib_reg <= (others => '0');
        adb_reg <= (others => '0');
        wrenb_reg <= '0';
        renb_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dib_reg <= (others => '0');
           adb_reg <= (others => '0');
           wrenb_reg <= '0';
           renb_reg <= '0';
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (rstb_ipd = '1') THEN
              dib_reg <= (others => '0');
              adb_reg <= (others => '0');
              wrenb_reg <= '0';
              renb_reg <= '0';
           ELSIF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     END IF;
  END PROCESS;

-- Warning for collision

  PW : PROCESS(ada_reg, adb_reg, wrena_reg, wrenb_reg, clka_valid, clkb_valid, rena_reg, 
       renb_reg) 
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE ADDR_A : integer := 0;
  VARIABLE ADDR_B : integer := 0;
  VARIABLE DN_ADDR_A : integer := 0;
  VARIABLE UP_ADDR_A : integer := 0;
  VARIABLE DN_ADDR_B : integer := 0;
  VARIABLE UP_ADDR_B : integer := 0;
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        ADDR_A := conv_integer(ada_reg);
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        ADDR_B := conv_integer(adb_reg);
     END IF;
  
     --DN_ADDR_A := (ADDR_A * DATA_WIDTH_A);
     --UP_ADDR_A := (((ADDR_A + 1) * DATA_WIDTH_A) - 1);
     --DN_ADDR_B := (ADDR_B * DATA_WIDTH_B); 
     --UP_ADDR_B := (((ADDR_B + 1) * DATA_WIDTH_B) - 1);

	  DN_ADDR_A := (ADDR_A * DATA_WIDTH_A) + (ADDR_A / div_a);
	  UP_ADDR_A := DN_ADDR_A + (DATA_WIDTH_A - 1);
	  DN_ADDR_B := (ADDR_B * DATA_WIDTH_B) + (ADDR_B / div_b);
	  UP_ADDR_B := DN_ADDR_B + (DATA_WIDTH_B - 1);

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_wr_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_rd_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_rd_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_rd_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
             IF (rd_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   rd_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             rd_a_wr_b_coll <= '0';
          END IF;

	  if (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) then
		  if ((DN_ADDR_A > DN_ADDR_B) and (UP_ADDR_A < UP_ADDR_B)) then
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_A;
		  elsif ((DN_ADDR_B > DN_ADDR_A) and (UP_ADDR_B < UP_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_B;
		  elsif ((UP_ADDR_A - DN_ADDR_B) <= (UP_ADDR_B - DN_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_A;
		  else
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_B;
		  end if;
	  end if;

     IF ((wrena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write collision! Writing in the same memory location using Port A and Port B will cause the memory content invalid."
--           severity warning;
			  wr_a_wr_b_coll <= '1';
        END IF;
     END IF;

     IF ((wrena_reg = '1' and clka_valid = '1') and (renb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port A and reading through Port B from the same memory location may give wrong output."
--           severity warning;
			  wr_a_rd_b_coll <= '1';
        END IF;
     END IF;

     IF ((rena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port B and reading through Port A from the same memory location may give wrong output."
--           severity warning;
			  rd_a_wr_b_coll <= '1';
        END IF;
     END IF;
  END PROCESS;



-- Writing to the memory

  P8 : PROCESS(ada_reg, dia_reg, diab_reg, wrena_reg, dib_reg, adb_reg,
               wrenb_reg, clka_valid, clkb_valid,
					wr_a_wr_b_coll)
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE WADDR_A : integer := 0;
  VARIABLE WADDR_B : integer := 0;
  VARIABLE dout_node_rbr : std_logic_vector(35 downto 0);
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        WADDR_A := conv_integer(ada_reg); 
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        WADDR_B := conv_integer(adb_reg); 
     END IF;
    
     IF (DATA_WIDTH_A = 36) THEN
        IF (wrena_reg = '1' and clka_valid = '1') THEN
           FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              dout_node_rbr(i) := MEM((WADDR_A * DATA_WIDTH_A) + i);
           END LOOP;
           doa_node_rbr <= dout_node_rbr(17 downto 0);
           dob_node_rbr <= dout_node_rbr(35 downto 18);

              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= diab_reg(i);
              END LOOP;

              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= diab_reg(i + 9);
              END LOOP;

              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 18) <= diab_reg(i + 18);
              END LOOP;

              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 27) <= diab_reg(i + 27);
              END LOOP;
        END IF;
     ELSE
        IF (DATA_WIDTH_A = 18) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
								 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
						  end if;
                 END LOOP;

                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= dia_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) >= dn_coll_addr) and 
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) <= up_coll_addr) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= 'X';
						  end if;
                 END LOOP;
           END IF;
        ELSIF (DATA_WIDTH_A = 9) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
					  if ( (wr_a_wr_b_coll = '1') and
							 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
							 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) ) then
						  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);      
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                  MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= dia_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) >= dn_coll_addr) and
							  (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= up_coll_addr) ) then
						   MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        END IF;

        IF (DATA_WIDTH_B = 18) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);      
              END LOOP;

                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						  end if;
                 END LOOP;

                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= dib_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) <= up_coll_addr) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= 'X';
						  end if;
                 END LOOP;
           END IF;
        ELSIF (DATA_WIDTH_B = 9) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);      
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);      
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= up_coll_addr) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P9 : PROCESS(ada_reg, rena_reg, adb_reg, renb_reg, MEM, clka_valid1, clkb_valid1, rsta_sig, rstb_sig,
               doa_node_rbr, dob_node_rbr,
					wr_a_rd_b_coll, rd_a_wr_b_coll) 
  VARIABLE RADDR_A_VALID : boolean := TRUE;
  VARIABLE RADDR_B_VALID : boolean := TRUE;
  VARIABLE RADDR_A : integer := 0;
  VARIABLE RADDR_B : integer := 0;
  VARIABLE dout_node_tr : std_logic_vector(35 downto 0);
  VARIABLE dout_node_wt : std_logic_vector(35 downto 0);
  BEGIN
     RADDR_A_VALID := Valid_Address (ada_reg);
     RADDR_B_VALID := Valid_Address (adb_reg);

     IF (RADDR_A_VALID = TRUE) THEN
        RADDR_A := conv_integer(ada_reg);
     END IF;
     IF (RADDR_B_VALID = TRUE) THEN
        RADDR_B := conv_integer(adb_reg);
     END IF;

     IF (DATA_WIDTH_B = 36) THEN
        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 doa_node <= (others => '0'); 
                 dob_node <= (others => '0'); 
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1'event and clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                 dout_node_tr(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) ) then
						  dout_node_tr(i) := 'X';
					  end if;
              END LOOP;
              doa_node <= dout_node_tr(17 downto 0);
              dob_node <= dout_node_tr(35 downto 18);
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                    dout_node_wt(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
                 END LOOP;
                 doa_node <= dout_node_wt(17 downto 0);
                 dob_node <= dout_node_wt(35 downto 18);
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 doa_node <= doa_node_rbr;
                 dob_node <= dob_node_rbr;
              END IF;
           END IF;
        END IF;
     ELSE
        IF (rsta_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clka_ipd = '1') THEN
                 doa_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
           END IF;
        ELSIF (clka_valid1 = '1') THEN
           IF (rena_reg = '1') THEN
              IF ( last_clka_valid1 = '0') THEN
                 FOR i IN 0 TO (new_data_width_a - 1)  LOOP
                    doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
					  if ( (rd_a_wr_b_coll = '1') and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) >= dn_coll_addr) and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) <= up_coll_addr) ) then
						  doa_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (rena_reg = '0') THEN
              IF (WRITEMODE_A = "WRITETHROUGH") THEN
                 FOR i IN 0 TO (new_data_width_a - 1) LOOP
                    doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                 END LOOP;
              ELSIF (WRITEMODE_A = "READBEFOREWRITE") THEN
                 IF ( last_clka_valid1 = '0') THEN
                    doa_node <= doa_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;

        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 dob_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              IF ( last_clkb_valid1 = '0') THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                    dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) <= up_coll_addr) ) then
						  dob_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                    dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                 END LOOP;
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 IF ( last_clkb_valid1 = '0') THEN
                    dob_node <= dob_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P10 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        doa_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           doa_reg <= (others => '0');
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              doa_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              IF (rsta_ipd = '1') THEN
                 doa_reg <= (others => '0');
              ELSIF (rsta_ipd = '0') THEN
                 doa_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dob_reg <= (others => '0');
        doab_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dob_reg <= (others => '0');
           doab_reg <= (others => '0');
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dob_reg <= dob_node;
              doab_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              IF (rstb_ipd = '1') THEN
                 dob_reg <= (others => '0');
                 doab_reg <= (others => '0');
              ELSIF (rstb_ipd = '0') THEN
                 dob_reg <= dob_node;
                 doab_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P11 : PROCESS(doa_node, dob_node, doa_reg, dob_reg, doab_reg)
  BEGIN
     IF (REGMODE_A = "OUTREG") THEN 
        IF (DATA_WIDTH_B = 36) THEN
           doa_int <= doab_reg;
        ELSE
           doa_int <= doa_reg;
        END IF;
     ELSE
        doa_int <= doa_node;
     END IF;

     IF (REGMODE_B = "OUTREG") THEN 
        dob_int <= dob_reg;
     ELSE
        dob_int <= dob_node;
     END IF;
  END PROCESS;

  (doa17, doa16, doa15, doa14, doa13, doa12, doa11, doa10, doa9, doa8, doa7, doa6,
   doa5, doa4, doa3, doa2, doa1, doa0) <= doa_int;

  (dob17, dob16, dob15, dob14, dob13, dob12, dob11, dob10, dob9, dob8, dob7, dob6,
   dob5, dob4, dob3, dob2, dob1, dob0) <= dob_int;

END V;


--
-----cell sp8ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY sp8ka IS
   GENERIC (
        DATA_WIDTH               : Integer  := 18;
        REGMODE                  : String  := "NOREG";
        RESETMODE                : String  := "SYNC";
        CSDECODE                 : String  := "000";
        WRITEMODE                : String  := "NORMAL";
        GSR                      : String  := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000");

   PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12                                  : in std_logic := 'X';
        ce, clk, we, cs0, cs1, cs2, rst                        : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF sp8ka : ENTITY IS TRUE;

END sp8ka ;

architecture V of sp8ka is

signal lo: std_logic := '0';
signal hi: std_logic := '1';

component dp8ka
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in String;
        CSDECODE_B   : in String;
        WRITEMODE_A  : in String;
        WRITEMODE_B  : in String;
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12                                       : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                          : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12                                       : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                          : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp8ka_inst : dp8ka
  generic map (DATA_WIDTH_A => DATA_WIDTH,
               DATA_WIDTH_B => DATA_WIDTH,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE,
               CSDECODE_B   => CSDECODE,
               WRITEMODE_A  => WRITEMODE,
               WRITEMODE_B  => WRITEMODE,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => lo,
  dib1 => lo, dib2 => lo, dib3 => lo, dib4 => lo, dib5 => lo,
  dib6 => lo, dib7 => lo, dib8 => lo, dib9 => lo, dib10 => lo,
  dib11 => lo, dib12 => lo, dib13 => lo, dib14 => lo, dib15 => lo,
  dib16 => lo, dib17 => lo,
  cea => ce, clka => clk, wea => we, csa0 => cs0, csa1 => cs1, csa2 => cs2,
  rsta => rst, ada0 => ad0, ada1 => ad1, ada2 => ad2, ada3 => ad3,
  ada4 => ad4, ada5 => ad5, ada6 => ad6, ada7 => ad7, ada8 => ad8,
  ada9 => ad9, ada10 => ad10, ada11 => ad11, ada12 => ad12,
  ceb => lo, clkb => lo, web => lo, csb0 => lo, csb1 => lo, csb2 => lo,
  rstb => hi, adb0 => lo, adb1 => lo, adb2 => lo, adb3 => lo,
  adb4 => lo, adb5 => lo, adb6 => lo, adb7 => lo, adb8 => lo,
  adb9 => lo, adb10 => lo, adb11 => lo, adb12 => lo, 
  dob0 => open, dob1 => open, dob2 => open, dob3 => open,
  dob4 => open, dob5 => open, dob6 => open, dob7 => open, dob8 => open,
  dob9 => open, dob10 => open, dob11 => open, dob12 => open, dob13 => open,
  dob14 => open, dob15 => open, dob16 => open, dob17 => open, doa0 => do0,
  doa1 => do1, doa2 => do2, doa3 => do3, doa4 => do4, doa5 => do5,
  doa6 => do6, doa7 => do7, doa8 => do8, doa9 => do9, doa10 => do10,
  doa11 => do11, doa12 => do12, doa13 => do13, doa14 => do14, doa15 => do15,
  doa16 => do16, doa17 => do17);

end V;

--
-----cell pdp8ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY pdp8ka IS
   GENERIC (
        DATA_WIDTH_W              : Integer  := 18;
        DATA_WIDTH_R              : Integer  := 18;
        REGMODE                   : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_W                 : String  := "000";
        CSDECODE_R                 : String  := "000";
        GSR               : String  := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000");

   PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        adw0, adw1, adw2, adw3, adw4, adw5, adw6, adw7, adw8   : in std_logic := 'X';
        adw9, adw10, adw11, adw12                              : in std_logic := 'X';
        cew, clkw, we, csw0, csw1, csw2                        : in std_logic := 'X';
        adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8   : in std_logic := 'X';
        adr9, adr10, adr11, adr12                              : in std_logic := 'X';
        cer, clkr, csr0, csr1, csr2, rst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF pdp8ka : ENTITY IS TRUE;

END pdp8ka ;

architecture V of pdp8ka is

signal lo: std_logic := '0';

component dp8ka
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in String;
        CSDECODE_B   : in String;
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12                                       : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                          : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12                                       : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                          : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp8ka_inst : dp8ka
  generic map (DATA_WIDTH_A => DATA_WIDTH_W,
               DATA_WIDTH_B => DATA_WIDTH_R,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE_W,
               CSDECODE_B   => CSDECODE_R,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => di18,
  dib1 => di19, dib2 => di20, dib3 => di21, dib4 => di22, dib5 => di23,
  dib6 => di24, dib7 => di25, dib8 => di26, dib9 => di27, dib10 => di28,
  dib11 => di29, dib12 => di30, dib13 => di31, dib14 => di32, dib15 => di33,
  dib16 => di34, dib17 => di35,
  cea => cew, clka => clkw, wea => we, csa0 => csw0, csa1 => csw1, csa2 => csw2,
  rsta => rst, ada0 => adw0, ada1 => adw1, ada2 => adw2, ada3 => adw3,
  ada4 => adw4, ada5 => adw5, ada6 => adw6, ada7 => adw7, ada8 => adw8,
  ada9 => adw9, ada10 => adw10, ada11 => adw11, ada12 => adw12,
  ceb => cer, clkb => clkr, web => lo, csb0 => csr0, csb1 => csr1, csb2 => csr2,
  rstb => rst, adb0 => adr0, adb1 => adr1, adb2 => adr2, adb3 => adr3,
  adb4 => adr4, adb5 => adr5, adb6 => adr6, adb7 => adr7, adb8 => adr8,
  adb9 => adr9, adb10 => adr10, adb11 => adr11, adb12 => adr12, 
  dob0 => do0, dob1 => do1, dob2 => do2, dob3 => do3,
  dob4 => do4, dob5 => do5, dob6 => do6, dob7 => do7, dob8 => do8,
  dob9 => do9, dob10 => do10, dob11 => do11, dob12 => do12, dob13 => do13,
  dob14 => do14, dob15 => do15, dob16 => do16, dob17 => do17, doa0 => do18,
  doa1 => do19, doa2 => do20, doa3 => do21, doa4 => do22, doa5 => do23,
  doa6 => do24, doa7 => do25, doa8 => do26, doa9 => do27, doa10 => do28,
  doa11 => do29, doa12 => do30, doa13 => do31, doa14 => do32, doa15 => do33,
  doa16 => do34, doa17 => do35);

end V;


