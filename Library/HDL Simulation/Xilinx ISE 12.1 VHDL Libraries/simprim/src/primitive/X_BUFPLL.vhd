-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  I/O Clock Buffer/Divider for the Spartan Series
-- /___/   /\     Filename : X_BUFPLL.vhd
-- \   \  /  \    Timestamp : Wed Jun 11 13:36:50 PDT 2008
--  \___\/\___\
--
-- Revision:
--    06/11/08 - Initial version.
--    08/19/08 - IR 479918 -- added 100 ps latency to sequential paths. 
--    03/10/09 - IR 505709 -- correlate SERDESSTROBE to GLCK
--    03/24/09 - CR 514119 -- sync output to LOCKED high signal
--    06/16/09 - CR 525221 -- added ENABLE_SYNC attribute
-- End Revision


----- CELL X_BUFPLL -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.Vcomponents.all;
use simprim.VPACKAGE.all;

entity X_BUFPLL is

  generic(

      TimingChecksOn : boolean := true;
      InstancePath   : string  := "*";
      Xon            : boolean := true;
      MsgOn          : boolean := true;
      LOC            : string  := "UNPLACED";

--  VITAL input Pin path delay variables
      tipd_GCLK     : VitalDelayType01 := (0 ps, 0 ps);
      tipd_LOCKED   : VitalDelayType01 := (0 ps, 0 ps);
      tipd_PLLIN    : VitalDelayType01 := (0 ps, 0 ps);

--  VITAL clk-to-output path delay variables
      tpd_PLLIN_LOCK        : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLIN_IOCLK        : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLIN_SERDESSTROBE : VitalDelayType01 := (100 ps, 100 ps);

--  VITAL ticd & tisd variables
      ticd_GCLK      : VitalDelayType   := 0 ps;
      ticd_LOCKED    : VitalDelayType   := 0 ps;
      ticd_PLLIN     : VitalDelayType   := 0 ps;

-- VITAL Setup/Hold delay variables

-- VITAL pulse width variables

-- VITAL period variables
      tperiod_PLLIN_posedge     : VitalDelayType := 0 ps;

-- VITAL recovery time variables

-- VITAL removal time variables

      DIVIDE        : integer := 1;    -- {1..8}
      ENABLE_SYNC   : boolean := TRUE
      );

  port(
      IOCLK        : out std_ulogic;
      LOCK         : out std_ulogic;
      SERDESSTROBE : out std_ulogic;

      GCLK         : in  std_ulogic;
      LOCKED       : in  std_ulogic;
      PLLIN        : in  std_ulogic
    );

  attribute VITAL_LEVEL0 of
    X_BUFPLL : entity is true;

end X_BUFPLL;

architecture X_BUFPLL_V OF X_BUFPLL is

  attribute VITAL_LEVEL0 of
    X_BUFPLL_V : architecture is true;


--  constant SYNC_PATH_DELAY : time := 100 ps;

  signal GCLK_ipd   : std_ulogic := '0';
  signal GCLK_dly   : std_ulogic := '0';
  signal LOCKED_ipd : std_ulogic := '0';
  signal LOCKED_dly : std_ulogic := '0';
  signal PLLIN_ipd  : std_ulogic := '0';
  signal PLLIN_dly  : std_ulogic := '0';

  signal IOCLK_zd        : std_ulogic := '0';
  signal LOCK_zd         : std_ulogic := '0';
  signal SERDESSTROBE_zd : std_ulogic := '0';

  signal IOCLK_viol        : std_ulogic := '0';
  signal LOCK_viol         : std_ulogic := '0';
  signal SERDESSTROBE_viol : std_ulogic := '0';

  signal STROBE_OUT             : std_ulogic := '0';
  signal ENABLE_SYNC_STROBE_OUT : std_ulogic := '0';

  signal Violation : std_ulogic := '0';
-- Counters
  signal ce_count         : std_logic_vector(2 downto 0) := (others => '0');
  signal edge_count       : std_logic_vector(2 downto 0) := (others => '0');
  signal RisingEdgeCount  : std_logic_vector(2 downto 0) := (others => '0');
  signal FallingEdgeCount : std_logic_vector(2 downto 0) := (others => '0');
  signal TriggerOnRise    : std_ulogic := '0';

-- Flags
  signal allEqual         : std_ulogic := '0';
  signal RisingEdgeMatch  : std_ulogic := '0';
  signal FallingEdgeMatch : std_ulogic := '0';

-- Attribute settings 

-- Internal signals
  signal DIVCLK_int	: std_ulogic := '0';
  signal match		: std_ulogic := '0';
  signal nmatch		: std_ulogic := '0';

-- other signals
  signal time_cal		: boolean := false;
  signal start_wait_time	: time := 0 ps;
  signal end_wait_time		: time := 0 ps;
begin

  ---------------------
  --  INPUT PATH DELAYs
  --------------------

  WireDelay : block
  begin
    VitalWireDelay (GCLK_ipd,     GCLK,    tipd_GCLK);
    VitalWireDelay (LOCKED_ipd,   LOCKED,  tipd_LOCKED);
    VitalWireDelay (PLLIN_ipd,    PLLIN,   tipd_PLLIN);
  end block;

  SignalDelay : block
  begin
    VitalSignalDelay (GCLK_dly,     GCLK_ipd,    ticd_GCLK);
    VitalSignalDelay (LOCKED_dly,   LOCKED_ipd,  ticd_LOCKED);
    VitalSignalDelay (PLLIN_dly,    PLLIN_ipd,   ticd_PLLIN);
  end block;

  --------------------
  --  BEHAVIOR SECTION
  --------------------


--####################################################################
--#####                     Initialize                           #####
--####################################################################
  prcs_init:process

  begin

-------------------------------------------------
------ DIVIDE Check
-------------------------------------------------

      if((DIVIDE = 1) or (DIVIDE = 2) or  (DIVIDE = 3) or
         (DIVIDE = 4) or (DIVIDE = 5) or  (DIVIDE = 6) or
         (DIVIDE = 7) or (DIVIDE = 8)) then
         case DIVIDE is
            when 1 => 
                       RisingEdgeCount  <= "000"; 
                       FallingEdgeCount <= "000"; 
                       TriggerOnRise    <= '1'; 
            when 2 => 
                       RisingEdgeCount  <= "001"; 
                       FallingEdgeCount <= "000"; 
                       TriggerOnRise    <= '1'; 
	    when 3 => 
                       RisingEdgeCount  <= "010"; 
                       FallingEdgeCount <= "000"; 
                       TriggerOnRise    <= '0'; 
            when 4 => 
                       RisingEdgeCount  <= "011"; 
                       FallingEdgeCount <= "001"; 
                       TriggerOnRise    <= '1'; 
            when 5 => 
                       RisingEdgeCount  <= "100"; 
                       FallingEdgeCount <= "001"; 
                       TriggerOnRise    <= '0'; 
            when 6 => 
                       RisingEdgeCount  <= "101"; 
                       FallingEdgeCount <= "010"; 
                       TriggerOnRise    <= '1'; 
            when 7 => 
                       RisingEdgeCount  <= "110"; 
                       FallingEdgeCount <= "010"; 
                       TriggerOnRise    <= '0'; 
            when 8 => 
                       RisingEdgeCount  <= "111"; 
                       FallingEdgeCount <= "011"; 
                       TriggerOnRise    <= '1'; 
            when others=>
                       null; 
         end case;
      else
         GenericValueCheckMessage
          (  HeaderMsg  => " Attribute Syntax Error ",
             GenericName => " DIVIDE ",
             EntityName => "/X_BUFPLL",
             GenericValue => DIVIDE,
             Unit => "",
             ExpectedValueMsg => " The Legal values for this attribute are ",
             ExpectedGenericValue => " 1, 2, 3, 4, 5, 6, 7, or 8 ",
             TailMsg => "",
             MsgSeverity => Failure
         );
--         attr_err_flag <= '1';
      end if;

----------- Check for ENABLE_SYNC ----------------------

     case ENABLE_SYNC is
       when true | false => null;
       when others =>
          assert false
          report "Attribute Syntax Error: The allowed values for ENABLE_SYNC are TRUE or FALSE"
          severity Failure;
     end case;

     wait;
  end process prcs_init;

--####################################################################
--#####         Count the rising edges of the clk                #####
--####################################################################
  prcs_RiseEdgeCount:process(PLLIN_dly)
  begin
     if(rising_edge(PLLIN_dly)) then
         if(allEqual = '1') then
            edge_count <= "000";
         else
            edge_count <= edge_count + 1;
         end if;
     end if;
  end process prcs_RiseEdgeCount;

-- Generate synchronous reset after DIVIDE number of counts

  prcs_allEqual:process(edge_count)
  variable ce_count_var  : std_logic_vector(2 downto 0) :=  CONV_STD_LOGIC_VECTOR(DIVIDE -1, 3);
  begin
     if(edge_count = ce_count_var) then
        allEqual <= '1'; 
     else
        allEqual <= '0'; 
     end if;
  end process prcs_allEqual;

--####################################################################
--#####          Generate STROBE_OUT                             #####
--####################################################################

  prcs_StrobeOut:process(PLLIN_dly)
  begin
     if(rising_edge(PLLIN_dly)) then
        STROBE_OUT <= allEqual;
     end if;
  end process prcs_StrobeOut;


--####################################################################
--#####          Generate ENABLE_SYNC_STROBE_OUT                 #####
--####################################################################

  prcs_calc_period:process(PLLIN_dly)
  variable pre_clk_edge_var : time := 0 ps;
  variable cur_clk_edge_var : time := 0 ps;
  variable clk_period_var : time := 0 ps;
  begin
     if((not time_cal) and (LOCKED_dly = '1'))  then
        if(rising_edge(PLLIN_dly)) then
           pre_clk_edge_var := cur_clk_edge_var;   
           cur_clk_edge_var := now;   
           if(pre_clk_edge_var > 0 ps) then
               clk_period_var := cur_clk_edge_var - pre_clk_edge_var;
               time_cal <= true;
               start_wait_time <= clk_period_var * ((2.0 * real (DIVIDE -1)) / 4.0) * 1.0 ;
               end_wait_time   <= clk_period_var;
           end if;
        end if;
     end if;
  end process prcs_calc_period;

  prcs_EnableSyncSerdesStrobe:process(GCLK_dly)
  begin
     if(time_cal) then
        if(rising_edge(GCLK_dly)) then
           ENABLE_SYNC_STROBE_OUT <= transport '1' after start_wait_time, '0' after (start_wait_time+end_wait_time);
        end if;
     end if;
  end process prcs_EnableSyncSerdesStrobe;

--####################################################################
--#####          Generate Divided clk                            #####
--####################################################################
  prcs_EdgeMatch:process(edge_count)
  variable FIRST_TIME : boolean := true;
  begin
     if(FIRST_TIME) then
       FIRST_TIME := false;
     else
        if(edge_count = RisingEdgeCount) then
            RisingEdgeMatch <= '1';
        else
            RisingEdgeMatch <= '0';
        end if;

        if(edge_count = FallingEdgeCount) then
            FallingEdgeMatch <= '1';
        else
            FallingEdgeMatch <= '0';
        end if;
     end if;
  end process prcs_EdgeMatch;

  prcs_match_nmatch:process(PLLIN_dly)
  begin
     if(rising_edge(PLLIN_dly)) then
-- FP
         match <= RisingEdgeMatch OR (match AND (NOT FallingEdgeMatch));
     elsif falling_edge(PLLIN_dly) then
         if(TriggerOnRise = '0') then 
             nmatch <= match;
          else
             nmatch <= '0';
          end if;
     end if;
  end process prcs_match_nmatch;

  DIVCLK_int <= match or nmatch;

--####################################################################
--#####          Generate SERDESSTROBE_zd                        #####
--####################################################################

  SERDESSTROBE_zd <= ENABLE_SYNC_STROBE_OUT when (ENABLE_SYNC = true)  
                     else STROBE_OUT;

--####################################################################
--#####          Generate IOCLK                                  #####
--####################################################################

  IOCLK_zd <= PLLIN_dly;

--####################################################################
--#####          Generate LOCK                                   #####
--####################################################################

  LOCK_zd <= LOCKED_dly;
     

--####################################################################
--#####                   TIMING CHECKS & OUTPUT                 #####
--####################################################################
  prcs_tmngchk:process

    variable PViol_PLLIN : std_ulogic          := '0';
    variable PInfo_PLLIN : VitalPeriodDataType := VitalPeriodDataInit;

  begin
    if (TimingChecksOn) then
       VitalPeriodPulseCheck (
         Violation            => PViol_PLLIN,
         PeriodData           => PInfo_PLLIN,
         TestSignal           => PLLIN_dly,
         TestSignalName       => "PLLIN",
         TestDelay            => 0 ps,
         Period               => tperiod_PLLIN_posedge,
         PulseWidthHigh       => 0 ps,
         PulseWidthLow        => 0 ps,
         CheckEnabled         => true,
         HeaderMsg            => "/X_BUFPLL",
         Xon                  => Xon,
         MsgOn                => true,
         MsgSeverity          => warning);
    end if;

    Violation <= PViol_PLLIN;

    wait on PLLIN_dly;

  end process prcs_tmngchk;

--####################################################################
--#####                           OUTPUT                         #####
--####################################################################
  prcs_output:process
    variable  IOCLK_GlitchData        : VitalGlitchDataType;
    variable  LOCK_GlitchData         : VitalGlitchDataType;
    variable  SERDESSTROBE_GlitchData : VitalGlitchDataType;
  begin
     VitalPathDelay01
       (
         OutSignal     => IOCLK,
         GlitchData    => IOCLK_GlitchData,
         OutSignalName => "IOCLK",
         OutTemp       => IOCLK_zd,
         Paths         => (0 => (PLLIN_dly'last_event,   tpd_PLLIN_IOCLK, true)),
         Mode          => VitalTransport,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );

     VitalPathDelay01
       (
         OutSignal     => LOCK,
         GlitchData    => LOCK_GlitchData,
         OutSignalName => "LOCK",
         OutTemp       => LOCK_zd,
         Paths         => (0 => (PLLIN_dly'last_event,   tpd_PLLIN_LOCK, true)),
         Mode          => VitalTransport,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );

     VitalPathDelay01
       (
         OutSignal     => SERDESSTROBE,
         GlitchData    => SERDESSTROBE_GlitchData,
         OutSignalName => "SERDESSTROBE",
         OutTemp       => SERDESSTROBE_zd,
         Paths         => (0 => (PLLIN_dly'last_event,   tpd_PLLIN_SERDESSTROBE, true)),
         Mode          => VitalTransport,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );

    wait on IOCLK_zd, LOCK_zd, SERDESSTROBE_zd;

  end process prcs_output;


end X_BUFPLL_V;

