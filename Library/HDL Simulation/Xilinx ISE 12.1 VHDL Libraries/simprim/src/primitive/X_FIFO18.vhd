-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/rainier/VITAL/X_FIFO18.vhd,v 1.5 2010/01/14 19:38:17 fphillip Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2005 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  18K-Bit FIFO
-- /___/   /\     Filename : X_FIFO18.vhd
-- \   \  /  \    Timestamp : Tues October 18 16:43:59 PST 2005
--  \___\/\___\
--
-- Revision:
--    10/18/05 - Initial version.
--    08/17/06 - Fixed vital delay for vcs_mx (CR 419867).
--    27/05/08 - CR 472154 Removed Vital GSR constructs
--    04/30/09 - Fixed timing violation for asynchronous reset (CR 519016).
-- End Revision

----- CELL X_FIFO18 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.Vcomponents.all;
use simprim.VPACKAGE.all;

entity X_FIFO18 is
generic (

    TimingChecksOn : boolean := true;
    InstancePath   : string  := "*";
    Xon            : boolean := true;
    MsgOn          : boolean := true;

----- VITAL input wire delays
    tipd_DI    : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
    tipd_DIP   : VitalDelayArrayType01(1 downto 0)  := (others => (0 ps, 0 ps));
    tipd_RDCLK : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_RDEN  : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_RST   : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_WRCLK : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_WREN  : VitalDelayType01                   := ( 0 ps, 0 ps);

----- VITAL pin-to-pin propagation delays

    tpd_RDCLK_DO          : VitalDelayArrayType01 (15 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDCLK_DOP         : VitalDelayArrayType01 (1 downto 0)  := (others => (100 ps, 100 ps));
    tpd_RDCLK_EMPTY       : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDCLK_ALMOSTEMPTY : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDCLK_RDCOUNT     : VitalDelayArrayType01 (11 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDCLK_RDERR       : VitalDelayType01                    := ( 100 ps, 100 ps);

    tpd_WRCLK_FULL        : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_WRCLK_ALMOSTFULL  : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_WRCLK_WRCOUNT     : VitalDelayArrayType01 (11 downto 0) := (others => (100 ps, 100 ps));
    tpd_WRCLK_WRERR       : VitalDelayType01                    := ( 100 ps, 100 ps);


    tpd_RST_EMPTY              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_EMPTY_RDCLK       : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_ALMOSTEMPTY        : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_ALMOSTEMPTY_RDCLK : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_FULL               : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_FULL_WRCLK        : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_ALMOSTFULL         : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_ALMOSTFULL_WRCLK  : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_RDCOUNT            : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));
    tbpd_RST_RDCOUNT_RDCLK     : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));    
    tpd_RST_RDERR              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_RDERR_RDCLK       : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_WRCOUNT            : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));
    tbpd_RST_WRCOUNT_WRCLK     : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));
    tpd_RST_WRERR              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_WRERR_WRCLK       : VitalDelayType01                    := ( 0 ps, 0 ps);
    
----- VITAL recovery time


    trecovery_RST_WRCLK_negedge_posedge : VitalDelayType := 0 ps;
    trecovery_RST_RDCLK_negedge_posedge : VitalDelayType := 0 ps;

----- VITAL removal time


    tremoval_RST_WRCLK_negedge_posedge : VitalDelayType  := 0 ps;
    tremoval_RST_RDCLK_negedge_posedge : VitalDelayType  := 0 ps;

----- VITAL setup time

    tsetup_DI_WRCLK_posedge_posedge   : VitalDelayArrayType (15 downto 0) := (others => 0 ps);
    tsetup_DI_WRCLK_negedge_posedge   : VitalDelayArrayType (15 downto 0) := (others => 0 ps);
    tsetup_DIP_WRCLK_posedge_posedge  : VitalDelayArrayType (1 downto 0)  := (others => 0 ps);
    tsetup_DIP_WRCLK_negedge_posedge  : VitalDelayArrayType (1 downto 0)  := (others => 0 ps);
    tsetup_RDEN_RDCLK_posedge_posedge : VitalDelayType := 0 ps;
    tsetup_RDEN_RDCLK_negedge_posedge : VitalDelayType := 0 ps;
    tsetup_WREN_WRCLK_posedge_posedge : VitalDelayType := 0 ps;
    tsetup_WREN_WRCLK_negedge_posedge : VitalDelayType := 0 ps;

----- VITAL hold time

    thold_DI_WRCLK_posedge_posedge    : VitalDelayArrayType (15 downto 0) := (others => 0 ps);
    thold_DI_WRCLK_negedge_posedge    : VitalDelayArrayType (15 downto 0) := (others => 0 ps);
    thold_DIP_WRCLK_posedge_posedge   : VitalDelayArrayType (1 downto 0)  := (others => 0 ps);
    thold_DIP_WRCLK_negedge_posedge   : VitalDelayArrayType (1 downto 0)  := (others => 0 ps);
    thold_RDEN_RDCLK_posedge_posedge  : VitalDelayType := 0 ps;
    thold_RDEN_RDCLK_negedge_posedge  : VitalDelayType := 0 ps;
    thold_WREN_WRCLK_posedge_posedge  : VitalDelayType := 0 ps;
    thold_WREN_WRCLK_negedge_posedge  : VitalDelayType := 0 ps;

----- VITAL 
 
    tisd_DI_WRCLK    : VitalDelayArrayType(15 downto 0) := (others => 0 ps); 
    tisd_DIP_WRCLK   : VitalDelayArrayType(1 downto 0)  := (others => 0 ps);
    tisd_RST_WRCLK   : VitalDelayType                   := 0 ps;

    tisd_RST_RDCLK   : VitalDelayType                   := 0 ps;
    tisd_RDEN_RDCLK  : VitalDelayType                   := 0 ps;
    ticd_RDCLK       : VitalDelayType                   := 0 ps;
    
    tisd_WREN_WRCLK  : VitalDelayType                   := 0 ps;
    ticd_WRCLK       : VitalDelayType                   := 0 ps;

----- VITAL pulse width 
    tpw_RDCLK_negedge : VitalDelayType := 0 ps;
    tpw_RDCLK_posedge : VitalDelayType := 0 ps;
    
    tpw_RST_negedge : VitalDelayType := 0 ps;
    tpw_RST_posedge : VitalDelayType := 0 ps;

    tpw_WRCLK_negedge : VitalDelayType := 0 ps;
    tpw_WRCLK_posedge : VitalDelayType := 0 ps;

----- VITAL period
    tperiod_RDCLK_posedge : VitalDelayType := 0 ps;

    tperiod_WRCLK_posedge : VitalDelayType := 0 ps;
    
    ALMOST_FULL_OFFSET      : bit_vector := X"080";
    ALMOST_EMPTY_OFFSET     : bit_vector := X"080"; 
    DATA_WIDTH              : integer    := 4;
    DO_REG                  : integer    := 1;
    EN_SYN                  : boolean    := FALSE;
    FIRST_WORD_FALL_THROUGH : boolean    := FALSE;
    LOC                     : string     := "UNPLACED"
    
  );

port (

    ALMOSTEMPTY : out std_ulogic;
    ALMOSTFULL  : out std_ulogic;
    DO          : out std_logic_vector (15 downto 0);
    DOP         : out std_logic_vector (1 downto 0);
    EMPTY       : out std_ulogic;
    FULL        : out std_ulogic;
    RDCOUNT     : out std_logic_vector (11 downto 0);
    RDERR       : out std_ulogic;
    WRCOUNT     : out std_logic_vector (11 downto 0);
    WRERR       : out std_ulogic;

    DI          : in  std_logic_vector (15 downto 0);
    DIP         : in  std_logic_vector (1 downto 0);
    RDCLK       : in  std_ulogic;
    RDEN        : in  std_ulogic;
    RST         : in  std_ulogic;
    WRCLK       : in  std_ulogic;
    WREN        : in  std_ulogic    
  );

  attribute VITAL_LEVEL0 of
     X_FIFO18 : entity is true;

end X_FIFO18;
                                                                        
architecture X_FIFO18_V of X_FIFO18 is

  attribute VITAL_LEVEL0 of
    X_FIFO18_V : architecture is true;
  
  component X_AFIFO36_INTERNAL

      generic(
        ALMOST_FULL_OFFSET      : bit_vector := X"0080";
        ALMOST_EMPTY_OFFSET     : bit_vector := X"0080"; 
        DATA_WIDTH              : integer    := 4;
        DO_REG                  : integer    := 1;
        EN_ECC_READ : boolean := FALSE;
        EN_ECC_WRITE : boolean := FALSE;    
        EN_SYN                  : boolean    := FALSE;
        FIFO_SIZE               : integer    := 36;
        FIRST_WORD_FALL_THROUGH : boolean    := FALSE
        );

      port(
        ALMOSTEMPTY : out std_ulogic;
        ALMOSTFULL  : out std_ulogic;
        DBITERR       : out std_ulogic;
        DO          : out std_logic_vector (63 downto 0);
        DOP         : out std_logic_vector (7 downto 0);
        ECCPARITY   : out std_logic_vector (7 downto 0);
        EMPTY       : out std_ulogic;
        FULL        : out std_ulogic;
        RDCOUNT     : out std_logic_vector (12 downto 0);
        RDERR       : out std_ulogic;
        SBITERR     : out std_ulogic;
        WRCOUNT     : out std_logic_vector (12 downto 0);
        WRERR       : out std_ulogic;

        DI          : in  std_logic_vector (63 downto 0);
        DIP         : in  std_logic_vector (7 downto 0);
        RDCLK       : in  std_ulogic;
        RDRCLK       : in  std_ulogic;
        RDEN        : in  std_ulogic;
        RST         : in  std_ulogic;
        WRCLK       : in  std_ulogic;
        WREN        : in  std_ulogic
        );
  end component;

    
  constant SYNC_PATH_DELAY : time := 0 ps;
  signal GND_6 : std_logic_vector(5 downto 0) := (others => '0');
  signal GND_48 : std_logic_vector(47 downto 0) := (others => '0');
  signal OPEN_1 : std_logic_vector(0 downto 0);
  signal OPEN_6 : std_logic_vector(5 downto 0);
  signal OPEN_48 : std_logic_vector(47 downto 0);
  signal OPEN_8 : std_logic_vector(7 downto 0);

    constant MSB_MAX_DO  : integer    := 15;
    constant MSB_MAX_DOP : integer    := 1;
    constant MSB_MAX_RDCOUNT : integer    := 11;
    constant MSB_MAX_WRCOUNT : integer    := 11;

    constant MSB_MAX_DI  : integer    := 15;
    constant MSB_MAX_DIP : integer    := 1;

    signal DI_ipd    : std_logic_vector(MSB_MAX_DI downto 0)    := (others => 'X');
    signal DIP_ipd   : std_logic_vector(MSB_MAX_DIP downto 0)   := (others => 'X');
    signal GSR_ipd   : std_ulogic     :=    'X';
    signal RDCLK_ipd : std_ulogic     :=    'X';
    signal RDEN_ipd  : std_ulogic     :=    'X';
    signal RST_ipd   : std_ulogic     :=    'X';
    signal WRCLK_ipd : std_ulogic     :=    'X';
    signal WREN_ipd  : std_ulogic     :=    'X';

    signal DI_dly    : std_logic_vector(MSB_MAX_DI downto 0)    := (others => 'X');
    signal DIP_dly   : std_logic_vector(MSB_MAX_DIP downto 0)   := (others => 'X');
    signal GSR_dly   : std_ulogic     :=    '0';
    signal RDCLK_dly : std_ulogic     :=    'X';
    signal RDEN_dly  : std_ulogic     :=    'X';
    signal RST_dly   : std_ulogic     :=    'X';
    signal WRCLK_dly : std_ulogic     :=    'X';
    signal WREN_dly  : std_ulogic     :=    'X';

    signal DO_zd          : std_logic_vector(MSB_MAX_DO  downto 0)    := (others => '0');
    signal DOP_zd         : std_logic_vector(MSB_MAX_DOP downto 0)    := (others => '0');
    signal ALMOSTEMPTY_zd : std_ulogic     :=    '1';
    signal ALMOSTFULL_zd  : std_ulogic     :=    '0';
    signal EMPTY_zd       : std_ulogic     :=    '1';
    signal FULL_zd        : std_ulogic     :=    '0';
    signal RDCOUNT_zd     : std_logic_vector(MSB_MAX_RDCOUNT  downto 0)    := (others => '0');
    signal RDERR_zd       : std_ulogic     :=    '0';
    signal WRCOUNT_zd     : std_logic_vector(MSB_MAX_WRCOUNT  downto 0)    := (others => '0');
    signal WRERR_zd       : std_ulogic     :=    '0';
    signal violation : std_ulogic := '0';
    signal violation_rdclk : std_ulogic := '0';
    signal violation_wrclk : std_ulogic := '0';
  
begin

  GSR_dly <= GSR;

  ---------------------
  --  INPUT PATH DELAYs
  ---------------------

  WireDelay     : block
  begin
    DI_WireDelay : for i in MSB_MAX_DI downto 0 generate
        VitalWireDelay (DI_ipd(i),     DI(i),    tipd_DI(i));
    end generate DI_WireDelay;    

    DIP_WireDelay : for i in MSB_MAX_DIP downto 0 generate
        VitalWireDelay (DIP_ipd(i),     DIP(i),    tipd_DIP(i));
    end generate DIP_WireDelay;    

    VitalWireDelay (RDEN_ipd,       RDEN,       tipd_RDEN);
    VitalWireDelay (RDCLK_ipd,      RDCLK,      tipd_RDCLK);
    VitalWireDelay (RST_ipd,        RST,        tipd_RST);
    VitalWireDelay (WREN_ipd,       WREN,       tipd_WREN);
    VitalWireDelay (WRCLK_ipd,      WRCLK,      tipd_WRCLK);

  end block;


  SignalDelay : block
  begin

    DI_Delay : for i in MSB_MAX_DI downto 0 generate
        VitalSignalDelay (DI_dly(i),     DI_ipd(i),    tisd_DI_WRCLK(i));  -- FP ??
    end generate DI_Delay;    

    DIP_Delay : for i in MSB_MAX_DIP downto 0 generate
        VitalSignalDelay (DIP_dly(i),     DIP_ipd(i),    tisd_DIP_WRCLK(i));  -- FP ??
    end generate DIP_Delay;    

    VitalSignalDelay (RDEN_dly,     RDEN_ipd,   tisd_RDEN_RDCLK);          -- FP ??
    VitalSignalDelay (RDCLK_dly,    RDCLK_ipd,  ticd_RDCLK);
    VitalSignalDelay (RST_dly,      RST_ipd,    tisd_RST_WRCLK);           -- FP ??
    VitalSignalDelay (WREN_dly,     WREN_ipd,   tisd_WREN_WRCLK);          -- FP ??
    VitalSignalDelay (WRCLK_dly,    WRCLK_ipd,  ticd_WRCLK);

  end block;

  
X_FIFO18_inst : X_AFIFO36_INTERNAL
  generic map (
    ALMOST_FULL_OFFSET => ALMOST_FULL_OFFSET,
    ALMOST_EMPTY_OFFSET => ALMOST_EMPTY_OFFSET, 
    DATA_WIDTH => DATA_WIDTH,
    DO_REG => DO_REG,
    EN_SYN => EN_SYN,
    FIFO_SIZE => 18, 
    FIRST_WORD_FALL_THROUGH => FIRST_WORD_FALL_THROUGH
    )

  port map (
    DO(15 downto 0) => do_zd,
    DO(63 downto 16) => OPEN_48,
    DOP(1 downto 0) => dop_zd,
    DOP(7 downto 2) => OPEN_6,
    ALMOSTEMPTY => almostempty_zd,
    ALMOSTFULL => almostfull_zd,
    ECCPARITY => OPEN_8,
    EMPTY => empty_zd,
    FULL => full_zd,
    RDCOUNT(11 downto 0) => rdcount_zd,
    RDCOUNT(12 downto 12) => OPEN_1,
    WRCOUNT(11 downto 0) => wrcount_zd,
    WRCOUNT(12 downto 12) => OPEN_1,
    RDERR => rderr_zd,
    SBITERR => OPEN,
    DBITERR => OPEN,
    WRERR => wrerr_zd,
    DI(15 downto 0) => DI_dly,
    DI(63 downto 16) => GND_48,
    DIP(1 downto 0) => DIP_dly,
    DIP(7 downto 2) => GND_6,
    WREN => WREN_dly,
    RDEN => RDEN_dly,
    RDCLK => RDCLK_dly,
    RDRCLK => RDCLK_dly,
    WRCLK => WRCLK_dly,
    RST => RST_dly
    );


--####################################################################
--#####                   TIMING CHECKS                          #####
--####################################################################

  prcs_tmngchk:process

--  Pin Timing Violations (all input pins)
     variable Tviol_DI0_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI0_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI1_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI1_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI2_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI2_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI3_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI3_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI4_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI4_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI5_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI5_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI6_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI6_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI7_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI7_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI8_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI8_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI9_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI9_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI10_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI10_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI11_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI11_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI12_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI12_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI13_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI13_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI14_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI14_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI15_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI15_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI16_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI16_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI17_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI17_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI18_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI18_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI19_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI19_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI20_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI20_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI21_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI21_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI22_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI22_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI23_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI23_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI24_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI24_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI25_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI25_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI26_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI26_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI27_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI27_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI28_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI28_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI29_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI29_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI30_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI30_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI31_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI31_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP0_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP0_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP1_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP1_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP2_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP2_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP3_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP3_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RDEN_RDCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RDEN_RDCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_WREN_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_WREN_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_WRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_WRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_WRCLK_negedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_WRCLK_negedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_RDCLK_negedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_RDCLK_negedge : VitalTimingDataType := VitalTimingDataInit;
     
    variable PInfo_RDCLK : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RDCLK : std_ulogic := '0';
     
    variable PInfo_WRCLK : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_WRCLK : std_ulogic := '0';

    variable PInfo_RST : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RST : std_ulogic := '0';

begin

--  Setup/Hold Check Violations (all input pins)

     if (TimingChecksOn) then
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI0_WRCLK_posedge,
         TimingData     => Tmkr_DI0_WRCLK_posedge,
         TestSignal     => DI_dly(0),
         TestSignalName => "DI(0)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(0),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(0),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(0),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(0),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI1_WRCLK_posedge,
         TimingData     => Tmkr_DI1_WRCLK_posedge,
         TestSignal     => DI_dly(1),
         TestSignalName => "DI(1)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(1),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(1),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(1),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(1),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI2_WRCLK_posedge,
         TimingData     => Tmkr_DI2_WRCLK_posedge,
         TestSignal     => DI_dly(2),
         TestSignalName => "DI(2)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(2),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(2),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(2),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(2),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI3_WRCLK_posedge,
         TimingData     => Tmkr_DI3_WRCLK_posedge,
         TestSignal     => DI_dly(3),
         TestSignalName => "DI(3)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(3),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(3),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(3),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(3),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI4_WRCLK_posedge,
         TimingData     => Tmkr_DI4_WRCLK_posedge,
         TestSignal     => DI_dly(4),
         TestSignalName => "DI(4)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(4),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(4),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(4),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(4),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI5_WRCLK_posedge,
         TimingData     => Tmkr_DI5_WRCLK_posedge,
         TestSignal     => DI_dly(5),
         TestSignalName => "DI(5)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(5),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(5),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(5),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(5),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI6_WRCLK_posedge,
         TimingData     => Tmkr_DI6_WRCLK_posedge,
         TestSignal     => DI_dly(6),
         TestSignalName => "DI(6)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(6),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(6),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(6),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(6),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI7_WRCLK_posedge,
         TimingData     => Tmkr_DI7_WRCLK_posedge,
         TestSignal     => DI_dly(7),
         TestSignalName => "DI(7)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(7),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(7),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(7),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(7),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI8_WRCLK_posedge,
         TimingData     => Tmkr_DI8_WRCLK_posedge,
         TestSignal     => DI_dly(8),
         TestSignalName => "DI(8)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(8),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(8),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(8),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(8),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI9_WRCLK_posedge,
         TimingData     => Tmkr_DI9_WRCLK_posedge,
         TestSignal     => DI_dly(9),
         TestSignalName => "DI(9)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(9),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(9),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(9),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(9),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI10_WRCLK_posedge,
         TimingData     => Tmkr_DI10_WRCLK_posedge,
         TestSignal     => DI_dly(10),
         TestSignalName => "DI(10)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(10),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(10),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(10),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(10),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI11_WRCLK_posedge,
         TimingData     => Tmkr_DI11_WRCLK_posedge,
         TestSignal     => DI_dly(11),
         TestSignalName => "DI(11)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(11),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(11),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(11),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(11),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI12_WRCLK_posedge,
         TimingData     => Tmkr_DI12_WRCLK_posedge,
         TestSignal     => DI_dly(12),
         TestSignalName => "DI(12)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(12),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(12),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(12),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(12),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI13_WRCLK_posedge,
         TimingData     => Tmkr_DI13_WRCLK_posedge,
         TestSignal     => DI_dly(13),
         TestSignalName => "DI(13)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(13),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(13),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(13),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(13),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI14_WRCLK_posedge,
         TimingData     => Tmkr_DI14_WRCLK_posedge,
         TestSignal     => DI_dly(14),
         TestSignalName => "DI(14)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(14),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(14),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(14),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(14),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI15_WRCLK_posedge,
         TimingData     => Tmkr_DI15_WRCLK_posedge,
         TestSignal     => DI_dly(15),
         TestSignalName => "DI(15)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLK_posedge_posedge(15),
         SetupLow       => tsetup_DI_WRCLK_negedge_posedge(15),
         HoldLow        => thold_DI_WRCLK_posedge_posedge(15),
         HoldHigh       => thold_DI_WRCLK_negedge_posedge(15),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP0_WRCLK_posedge,
         TimingData     => Tmkr_DIP0_WRCLK_posedge,
         TestSignal     => DIP_dly(0),
         TestSignalName => "DIP(0)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLK_posedge_posedge(0),
         SetupLow       => tsetup_DIP_WRCLK_negedge_posedge(0),
         HoldLow        => thold_DIP_WRCLK_posedge_posedge(0),
         HoldHigh       => thold_DIP_WRCLK_negedge_posedge(0),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP1_WRCLK_posedge,
         TimingData     => Tmkr_DIP1_WRCLK_posedge,
         TestSignal     => DIP_dly(1),
         TestSignalName => "DIP(1)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLK_posedge_posedge(1),
         SetupLow       => tsetup_DIP_WRCLK_negedge_posedge(1),
         HoldLow        => thold_DIP_WRCLK_posedge_posedge(1),
         HoldHigh       => thold_DIP_WRCLK_negedge_posedge(1),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RDEN_RDCLK_posedge,
         TimingData     => Tmkr_RDEN_RDCLK_posedge,
         TestSignal     => RDEN_dly,
         TestSignalName => "RDEN",
         TestDelay      => 0 ns,
         RefSignal      => RDCLK_dly,
         RefSignalName  => "RDCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RDEN_RDCLK_posedge_posedge,
         SetupLow       => tsetup_RDEN_RDCLK_negedge_posedge,
         HoldLow        => thold_RDEN_RDCLK_posedge_posedge,
         HoldHigh       => thold_RDEN_RDCLK_negedge_posedge,
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_WREN_WRCLK_posedge,
         TimingData     => Tmkr_WREN_WRCLK_posedge,
         TestSignal     => WREN_dly,
         TestSignalName => "WREN",
         TestDelay      => 0 ns,
         RefSignal      => WRCLK_dly,
         RefSignalName  => "WRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_WREN_WRCLK_posedge_posedge,
         SetupLow       => tsetup_WREN_WRCLK_negedge_posedge,
         HoldLow        => thold_WREN_WRCLK_posedge_posedge,
         HoldHigh       => thold_WREN_WRCLK_negedge_posedge,
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO18",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalRecoveryRemovalCheck (
        Violation            => Tviol_RST_WRCLK_negedge,
        TimingData           => Tmkr_RST_WRCLK_negedge,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => tisd_RST_WRCLK,
        RefSignal            => WRCLK_dly,
        RefSignalName        => "WRCLK",
        RefDelay             => ticd_WRCLK,
        Recovery             => trecovery_RST_WRCLK_negedge_posedge,
        Removal              => tremoval_RST_WRCLK_negedge_posedge,
        ActiveLow            => false,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        RefTransition        => 'R',
        HeaderMsg            => "/X_FIFO18",
        Xon                  => Xon,
        MsgOn                => true,
        MsgSeverity          => warning);
      VitalRecoveryRemovalCheck (
        Violation            => Tviol_RST_RDCLK_negedge,
        TimingData           => Tmkr_RST_RDCLK_negedge,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => tisd_RST_RDCLK,
        RefSignal            => RDCLK_dly,
        RefSignalName        => "RDCLK",
        RefDelay             => ticd_RDCLK,
        Recovery             => trecovery_RST_RDCLK_negedge_posedge,
        Removal              => tremoval_RST_RDCLK_negedge_posedge,
        ActiveLow            => false,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        RefTransition        => 'R',
        HeaderMsg            => "/X_FIFO18",
        Xon                  => Xon,
        MsgOn                => true,
        MsgSeverity          => warning);
     VitalPeriodPulseCheck (
        Violation            => Pviol_RDCLK,
        PeriodData           => PInfo_RDCLK,
        TestSignal           => RDCLK_dly,
        TestSignalName       => "RDCLK",
        TestDelay            => 0 ps,
        Period               => tperiod_RDCLK_posedge,
        PulseWidthHigh       => tpw_RDCLK_posedge,
        PulseWidthLow        => tpw_RDCLK_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO18",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );
      VitalPeriodPulseCheck (
        Violation            => Pviol_WRCLK,
        PeriodData           => PInfo_WRCLK,
        TestSignal           => WRCLK_dly,
        TestSignalName       => "WRCLK",
        TestDelay            => 0 ps,
        Period               => tperiod_WRCLK_posedge,
        PulseWidthHigh       => tpw_WRCLK_posedge,
        PulseWidthLow        => tpw_WRCLK_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO18",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );
      VitalPeriodPulseCheck (
        Violation            => Pviol_RST,
        PeriodData           => PInfo_RST,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => 0 ps,
        Period               => 0 ps,
        PulseWidthHigh       => tpw_RST_posedge,
        PulseWidthLow        => tpw_RST_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO18",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );

     end if;

     Violation         <=
       Pviol_RDCLK or
       Pviol_RST or Pviol_WRCLK;

     Violation_rdclk <= Tviol_RST_RDCLK_negedge;

     Violation_wrclk <= Tviol_RST_WRCLK_negedge;
     
     --  Wait signal (input/output pins)
   wait on
     DI_dly,
     DIP_dly,
     RDCLK_dly,
     RDEN_dly,
     RST_dly,
     WRCLK_dly,
     WREN_dly;
     
-- End of (TimingChecksOn)

end process prcs_tmngchk;
     
-------------------------------------------------------------------------------
-- Path delay
-------------------------------------------------------------------------------
   prcs_output:process (DO_zd, DOP_zd, EMPTY_zd, FULL_zd, ALMOSTEMPTY_zd, ALMOSTFULL_zd, RDCOUNT_zd, WRCOUNT_zd, RDERR_zd, WRERR_zd)
--  Output Pin glitch declaration
     variable  ALMOSTEMPTY_GlitchData : VitalGlitchDataType;
     variable  ALMOSTFULL_GlitchData : VitalGlitchDataType;
     variable  DO0_GlitchData : VitalGlitchDataType;
     variable  DO1_GlitchData : VitalGlitchDataType;
     variable  DO2_GlitchData : VitalGlitchDataType;
     variable  DO3_GlitchData : VitalGlitchDataType;
     variable  DO4_GlitchData : VitalGlitchDataType;
     variable  DO5_GlitchData : VitalGlitchDataType;
     variable  DO6_GlitchData : VitalGlitchDataType;
     variable  DO7_GlitchData : VitalGlitchDataType;
     variable  DO8_GlitchData : VitalGlitchDataType;
     variable  DO9_GlitchData : VitalGlitchDataType;
     variable  DO10_GlitchData : VitalGlitchDataType;
     variable  DO11_GlitchData : VitalGlitchDataType;
     variable  DO12_GlitchData : VitalGlitchDataType;
     variable  DO13_GlitchData : VitalGlitchDataType;
     variable  DO14_GlitchData : VitalGlitchDataType;
     variable  DO15_GlitchData : VitalGlitchDataType;
     variable  DO16_GlitchData : VitalGlitchDataType;
     variable  DO17_GlitchData : VitalGlitchDataType;
     variable  DO18_GlitchData : VitalGlitchDataType;
     variable  DO19_GlitchData : VitalGlitchDataType;
     variable  DO20_GlitchData : VitalGlitchDataType;
     variable  DO21_GlitchData : VitalGlitchDataType;
     variable  DO22_GlitchData : VitalGlitchDataType;
     variable  DO23_GlitchData : VitalGlitchDataType;
     variable  DO24_GlitchData : VitalGlitchDataType;
     variable  DO25_GlitchData : VitalGlitchDataType;
     variable  DO26_GlitchData : VitalGlitchDataType;
     variable  DO27_GlitchData : VitalGlitchDataType;
     variable  DO28_GlitchData : VitalGlitchDataType;
     variable  DO29_GlitchData : VitalGlitchDataType;
     variable  DO30_GlitchData : VitalGlitchDataType;
     variable  DO31_GlitchData : VitalGlitchDataType;
     variable  DOP0_GlitchData : VitalGlitchDataType;
     variable  DOP1_GlitchData : VitalGlitchDataType;
     variable  DOP2_GlitchData : VitalGlitchDataType;
     variable  DOP3_GlitchData : VitalGlitchDataType;
     variable  EMPTY_GlitchData : VitalGlitchDataType;
     variable  FULL_GlitchData : VitalGlitchDataType;
     variable  RDERR_GlitchData : VitalGlitchDataType;
     variable  WRERR_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT0_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT1_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT2_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT3_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT4_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT5_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT6_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT7_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT8_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT9_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT10_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT11_GlitchData : VitalGlitchDataType;
     variable  RDCOUNT12_GlitchData : VitalGlitchDataType;     
     variable  WRCOUNT0_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT1_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT2_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT3_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT4_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT5_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT6_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT7_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT8_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT9_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT10_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT11_GlitchData : VitalGlitchDataType;
     variable  WRCOUNT12_GlitchData : VitalGlitchDataType;     
     variable  DO_viol     : std_logic_vector(MSB_MAX_DI downto 0);
     variable  DOP_viol    : std_logic_vector(MSB_MAX_DIP downto 0);
     variable  EMPTY_viol  : std_ulogic;
     variable  ALMOSTEMPTY_viol  : std_ulogic;
     variable  FULL_viol  : std_ulogic;
     variable  ALMOSTFULL_viol  : std_ulogic;
     variable  RDERR_viol  : std_ulogic;
     variable  WRERR_viol  : std_ulogic;
     variable  RDCOUNT_viol    : std_logic_vector(MSB_MAX_RDCOUNT downto 0);
     variable  WRCOUNT_viol    : std_logic_vector(MSB_MAX_WRCOUNT downto 0);
     
     begin
       
    DO_viol(0)  := Violation xor DO_zd(0);
    DO_viol(1)  := Violation xor DO_zd(1);
    DO_viol(2)  := Violation xor DO_zd(2);
    DO_viol(3)  := Violation xor DO_zd(3);
    DO_viol(4)  := Violation xor DO_zd(4);
    DO_viol(5)  := Violation xor DO_zd(5);
    DO_viol(6)  := Violation xor DO_zd(6);
    DO_viol(7)  := Violation xor DO_zd(7);
    DO_viol(8)  := Violation xor DO_zd(8);
    DO_viol(9)  := Violation xor DO_zd(9);
    DO_viol(10) := Violation xor DO_zd(10);
    DO_viol(11) := Violation xor DO_zd(11);
    DO_viol(12) := Violation xor DO_zd(12);
    DO_viol(13) := Violation xor DO_zd(13);
    DO_viol(14) := Violation xor DO_zd(14);
    DO_viol(15) := Violation xor DO_zd(15);
    
    DOP_viol(0) := Violation xor DOP_zd(0);
    DOP_viol(1) := Violation xor DOP_zd(1);

    EMPTY_viol := Violation_rdclk xor EMPTY_zd;
    ALMOSTEMPTY_viol := Violation_rdclk xor ALMOSTEMPTY_zd;
    RDERR_viol := Violation_rdclk xor RDERR_zd;
    RDCOUNT_viol(0)  := Violation_rdclk xor RDCOUNT_zd(0);
    RDCOUNT_viol(1)  := Violation_rdclk xor RDCOUNT_zd(1);
    RDCOUNT_viol(2)  := Violation_rdclk xor RDCOUNT_zd(2);
    RDCOUNT_viol(3)  := Violation_rdclk xor RDCOUNT_zd(3);
    RDCOUNT_viol(4)  := Violation_rdclk xor RDCOUNT_zd(4);
    RDCOUNT_viol(5)  := Violation_rdclk xor RDCOUNT_zd(5);
    RDCOUNT_viol(6)  := Violation_rdclk xor RDCOUNT_zd(6);
    RDCOUNT_viol(7)  := Violation_rdclk xor RDCOUNT_zd(7);
    RDCOUNT_viol(8)  := Violation_rdclk xor RDCOUNT_zd(8);
    RDCOUNT_viol(9)  := Violation_rdclk xor RDCOUNT_zd(9);
    RDCOUNT_viol(10) := Violation_rdclk xor RDCOUNT_zd(10);
    RDCOUNT_viol(11) := Violation_rdclk xor RDCOUNT_zd(11);
    
    FULL_viol := Violation_wrclk xor FULL_zd;
    ALMOSTFULL_viol := Violation_wrclk xor ALMOSTFULL_zd;
    WRERR_viol := Violation_wrclk xor WRERR_zd;
    WRCOUNT_viol(0)  := Violation_wrclk xor WRCOUNT_zd(0);
    WRCOUNT_viol(1)  := Violation_wrclk xor WRCOUNT_zd(1);
    WRCOUNT_viol(2)  := Violation_wrclk xor WRCOUNT_zd(2);
    WRCOUNT_viol(3)  := Violation_wrclk xor WRCOUNT_zd(3);
    WRCOUNT_viol(4)  := Violation_wrclk xor WRCOUNT_zd(4);
    WRCOUNT_viol(5)  := Violation_wrclk xor WRCOUNT_zd(5);
    WRCOUNT_viol(6)  := Violation_wrclk xor WRCOUNT_zd(6);
    WRCOUNT_viol(7)  := Violation_wrclk xor WRCOUNT_zd(7);
    WRCOUNT_viol(8)  := Violation_wrclk xor WRCOUNT_zd(8);
    WRCOUNT_viol(9)  := Violation_wrclk xor WRCOUNT_zd(9);
    WRCOUNT_viol(10) := Violation_wrclk xor WRCOUNT_zd(10);
    WRCOUNT_viol(11) := Violation_wrclk xor WRCOUNT_zd(11);

    
--  Output-to-Clock path delay
     VitalPathDelay01
       (
         OutSignal     => ALMOSTEMPTY,
         GlitchData    => ALMOSTEMPTY_GlitchData,
         OutSignalName => "ALMOSTEMPTY",
         OutTemp       => ALMOSTEMPTY_viol,
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_ALMOSTEMPTY,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_ALMOSTEMPTY,TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ALMOSTFULL,
         GlitchData    => ALMOSTFULL_GlitchData,
         OutSignalName => "ALMOSTFULL",
         OutTemp       => ALMOSTFULL_viol,
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_ALMOSTFULL,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_ALMOSTFULL,TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(0),
         GlitchData    => DO0_GlitchData,
         OutSignalName => "DO(0)",
         OutTemp       => DO_viol(0),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(1),
         GlitchData    => DO1_GlitchData,
         OutSignalName => "DO(1)",
         OutTemp       => DO_viol(1),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(1),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(2),
         GlitchData    => DO2_GlitchData,
         OutSignalName => "DO(2)",
         OutTemp       => DO_viol(2),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(2),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(3),
         GlitchData    => DO3_GlitchData,
         OutSignalName => "DO(3)",
         OutTemp       => DO_viol(3),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(3),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(4),
         GlitchData    => DO4_GlitchData,
         OutSignalName => "DO(4)",
         OutTemp       => DO_viol(4),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(4),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(5),
         GlitchData    => DO5_GlitchData,
         OutSignalName => "DO(5)",
         OutTemp       => DO_viol(5),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(5),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(6),
         GlitchData    => DO6_GlitchData,
         OutSignalName => "DO(6)",
         OutTemp       => DO_viol(6),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(6),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(7),
         GlitchData    => DO7_GlitchData,
         OutSignalName => "DO(7)",
         OutTemp       => DO_viol(7),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(7),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(8),
         GlitchData    => DO8_GlitchData,
         OutSignalName => "DO(8)",
         OutTemp       => DO_viol(8),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(8),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(9),
         GlitchData    => DO9_GlitchData,
         OutSignalName => "DO(9)",
         OutTemp       => DO_viol(9),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(9),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(10),
         GlitchData    => DO10_GlitchData,
         OutSignalName => "DO(10)",
         OutTemp       => DO_viol(10),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(10),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(11),
         GlitchData    => DO11_GlitchData,
         OutSignalName => "DO(11)",
         OutTemp       => DO_viol(11),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(11),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(12),
         GlitchData    => DO12_GlitchData,
         OutSignalName => "DO(12)",
         OutTemp       => DO_viol(12),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(12),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(13),
         GlitchData    => DO13_GlitchData,
         OutSignalName => "DO(13)",
         OutTemp       => DO_viol(13),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(13),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(14),
         GlitchData    => DO14_GlitchData,
         OutSignalName => "DO(14)",
         OutTemp       => DO_viol(14),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(14),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(15),
         GlitchData    => DO15_GlitchData,
         OutSignalName => "DO(15)",
         OutTemp       => DO_viol(15),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DO(15),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DOP(0),
         GlitchData    => DOP0_GlitchData,
         OutSignalName => "DOP(0)",
         OutTemp       => DOP_viol(0),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DOP(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DOP(1),
         GlitchData    => DOP1_GlitchData,
         OutSignalName => "DOP(1)",
         OutTemp       => DOP_viol(1),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_DOP(1),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMPTY,
         GlitchData    => EMPTY_GlitchData,
         OutSignalName => "EMPTY",
         OutTemp       => EMPTY_viol,
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_EMPTY,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_EMPTY,TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
         );
     VitalPathDelay01
       (
         OutSignal     => FULL,
         GlitchData    => FULL_GlitchData,
         OutSignalName => "FULL",
         OutTemp       => FULL_viol,
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_FULL,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_FULL,TRUE)),         
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDERR,
         GlitchData    => RDERR_GlitchData,
         OutSignalName => "RDERR",
         OutTemp       => RDERR_viol,
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDERR,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDERR,TRUE)),         
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRERR,
         GlitchData    => WRERR_GlitchData,
         OutSignalName => "WRERR",
         OutTemp       => WRERR_viol,
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRERR,TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRERR,TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(0),
         GlitchData    => RDCOUNT0_GlitchData,
         OutSignalName => "RDCOUNT(0)",
         OutTemp       => RDCOUNT_viol(0),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(0),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(1),
         GlitchData    => RDCOUNT1_GlitchData,
         OutSignalName => "RDCOUNT(1)",
         OutTemp       => RDCOUNT_viol(1),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(1),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(1),TRUE)),         
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(2),
         GlitchData    => RDCOUNT2_GlitchData,
         OutSignalName => "RDCOUNT(2)",
         OutTemp       => RDCOUNT_viol(2),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(2),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(2),TRUE)),         
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(3),
         GlitchData    => RDCOUNT3_GlitchData,
         OutSignalName => "RDCOUNT(3)",
         OutTemp       => RDCOUNT_viol(3),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(3),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(3),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(4),
         GlitchData    => RDCOUNT4_GlitchData,
         OutSignalName => "RDCOUNT(4)",
         OutTemp       => RDCOUNT_viol(4),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(4),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(4),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(5),
         GlitchData    => RDCOUNT5_GlitchData,
         OutSignalName => "RDCOUNT(5)",
         OutTemp       => RDCOUNT_viol(5),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(5),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(5),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(6),
         GlitchData    => RDCOUNT6_GlitchData,
         OutSignalName => "RDCOUNT(6)",
         OutTemp       => RDCOUNT_viol(6),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(6),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(6),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(7),
         GlitchData    => RDCOUNT7_GlitchData,
         OutSignalName => "RDCOUNT(7)",
         OutTemp       => RDCOUNT_viol(7),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(7),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(7),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(8),
         GlitchData    => RDCOUNT8_GlitchData,
         OutSignalName => "RDCOUNT(8)",
         OutTemp       => RDCOUNT_viol(8),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(8),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(8),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(9),
         GlitchData    => RDCOUNT9_GlitchData,
         OutSignalName => "RDCOUNT(9)",
         OutTemp       => RDCOUNT_viol(9),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(9),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(9),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(10),
         GlitchData    => RDCOUNT10_GlitchData,
         OutSignalName => "RDCOUNT(10)",
         OutTemp       => RDCOUNT_viol(10),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(10),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(10),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(11),
         GlitchData    => RDCOUNT11_GlitchData,
         OutSignalName => "RDCOUNT(11)",
         OutTemp       => RDCOUNT_viol(11),
         Paths         => (0 => (RDCLK_dly'last_event, tpd_RDCLK_RDCOUNT(11),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_RDCOUNT(11),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(0),
         GlitchData    => WRCOUNT0_GlitchData,
         OutSignalName => "WRCOUNT(0)",
         OutTemp       => WRCOUNT_viol(0),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(0),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(1),
         GlitchData    => WRCOUNT1_GlitchData,
         OutSignalName => "WRCOUNT(1)",
         OutTemp       => WRCOUNT_viol(1),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(1),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(1),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(2),
         GlitchData    => WRCOUNT2_GlitchData,
         OutSignalName => "WRCOUNT(2)",
         OutTemp       => WRCOUNT_viol(2),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(2),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(2),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(3),
         GlitchData    => WRCOUNT3_GlitchData,
         OutSignalName => "WRCOUNT(3)",
         OutTemp       => WRCOUNT_viol(3),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(3),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(3),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(4),
         GlitchData    => WRCOUNT4_GlitchData,
         OutSignalName => "WRCOUNT(4)",
         OutTemp       => WRCOUNT_viol(4),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(4),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(4),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(5),
         GlitchData    => WRCOUNT5_GlitchData,
         OutSignalName => "WRCOUNT(5)",
         OutTemp       => WRCOUNT_viol(5),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(5),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(5),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(6),
         GlitchData    => WRCOUNT6_GlitchData,
         OutSignalName => "WRCOUNT(6)",
         OutTemp       => WRCOUNT_viol(6),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(6),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(6),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(7),
         GlitchData    => WRCOUNT7_GlitchData,
         OutSignalName => "WRCOUNT(7)",
         OutTemp       => WRCOUNT_viol(7),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(7),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(7),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(8),
         GlitchData    => WRCOUNT8_GlitchData,
         OutSignalName => "WRCOUNT(8)",
         OutTemp       => WRCOUNT_viol(8),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(8),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(8),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(9),
         GlitchData    => WRCOUNT9_GlitchData,
         OutSignalName => "WRCOUNT(9)",
         OutTemp       => WRCOUNT_viol(9),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(9),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(9),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(10),
         GlitchData    => WRCOUNT10_GlitchData,
         OutSignalName => "WRCOUNT(10)",
         OutTemp       => WRCOUNT_viol(10),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(10),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(10),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(11),
         GlitchData    => WRCOUNT11_GlitchData,
         OutSignalName => "WRCOUNT(11)",
         OutTemp       => WRCOUNT_viol(11),
         Paths         => (0 => (WRCLK_dly'last_event, tpd_WRCLK_WRCOUNT(11),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(11),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     
  end process prcs_output;


end X_FIFO18_V;
