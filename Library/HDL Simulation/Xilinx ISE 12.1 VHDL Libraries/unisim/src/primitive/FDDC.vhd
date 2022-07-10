-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/unisims/cpld/VITAL/FDDC.vhd,v 1.1 2008/06/19 16:59:21 vandanad Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  Dual Edge Triggered D Flip-Flop with Asynchronous Clear
-- /___/   /\     Filename : FDDC.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:55:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL FDDC -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FDDC is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      INIT                           :  bit := '0'  ;
      tpd_CLR_Q : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Q : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_C_posedge_posedge : VitalDelayType := 0.000 ns;
      tsetup_D_C_negedge_posedge : VitalDelayType := 0.000 ns;
      thold_D_C_posedge_posedge : VitalDelayType := 0.000 ns;
      thold_D_C_negedge_posedge : VitalDelayType := 0.000 ns;
      trecovery_CLR_C_negedge_posedge : VitalDelayType := 0.000 ns;
      thold_CLR_C_negedge_posedge : VitalDelayType := 0.000 ns;
      tpw_C_posedge : VitalDelayType := 0.000 ns;
      tpw_CLR_posedge : VitalDelayType := 0.000 ns;
      tpw_C_negedge : VitalDelayType := 0.000 ns;
      tipd_D : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR : VitalDelayType01 := (0.000 ns, 0.000 ns)
      );

   port(
      Q                              :  out   STD_ULOGIC;
      
      C                              :  in    STD_ULOGIC;
      CLR                            :  in    STD_ULOGIC;      
      D                              :  in    STD_ULOGIC
      );
attribute VITAL_LEVEL0 of FDDC : entity is TRUE;
end FDDC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
library UNISIM;
use unisim.VPKG.all;
architecture FDDC_V of FDDC is
   --attribute VITAL_LEVEL1 of FDDC_V : architecture is TRUE;

   SIGNAL D_ipd  : STD_ULOGIC := 'X';
   SIGNAL C_ipd  : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd        : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process 

   -- timing check results
   VARIABLE Tviol_D_C_posedge   : STD_ULOGIC := '0';
   VARIABLE Tmkr_D_C_posedge    : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_C_posedge : STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_C_posedge  : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_C     : STD_ULOGIC := '0';
   VARIABLE PInfo_C     : VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR   : STD_ULOGIC := '0';
   VARIABLE PInfo_CLR   : VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE C_delayed : STD_ULOGIC := 'X';
   --VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   VARIABLE Q_zd : STD_ULOGIC := TO_X01(INIT);
   VARIABLE FIRST_TIME : boolean := True ;

   -- output glitch detection variables
   VARIABLE Q_GlitchData        : VitalGlitchDataType;

   begin
     
     
      if (FIRST_TIME = TRUE) then

       Q <= Q_zd;

       wait until (CLR_ipd = '1' or rising_edge(c_ipd));

       C_delayed := C_ipd'last_value;
       D_delayed := D_ipd;


       FIRST_TIME := FALSE;
      end if;

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_C_posedge,
          TimingData              => Tmkr_D_C_posedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => C_ipd,
          RefSignalName          => "C",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_C_posedge_posedge,
          SetupLow                => tsetup_D_C_negedge_posedge,
          HoldLow                => thold_D_C_posedge_posedge,
          HoldHigh                 => thold_D_C_negedge_posedge,
          CheckEnabled            => 
                           TO_X01((NOT CLR_ipd)) /= '0',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/FDDC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_C_posedge,
          TimingData              => Tmkr_CLR_C_posedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => C_ipd,
          RefSignalName          => "C",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_C_negedge_posedge,
          Removal                 => thold_CLR_C_negedge_posedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01(CLR_ipd ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/FDDC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_C,
          PeriodData              => PInfo_C,
          TestSignal              => C_ipd,
          TestSignalName          => "C",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_C_posedge,
          PulseWidthLow           => tpw_C_negedge,
          CheckEnabled            =>  TRUE,
          HeaderMsg               => InstancePath &"/FDDC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_CLR_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            =>  TRUE,
          HeaderMsg               => InstancePath &"/FDDC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_C_posedge or Tviol_CLR_C_posedge or Pviol_C or Pviol_CLR;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => FDDC_Q_tab,
        DataIn => (
               C_delayed, D_delayed, C_ipd, CLR_ipd));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      C_delayed := C_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (CLR_ipd'last_event, tpd_CLR_Q, TRUE),
                 1 => (C_ipd'last_event, tpd_C_Q, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

   wait on D_ipd, C_ipd, CLR_ipd;
end process;

end FDDC_V;


