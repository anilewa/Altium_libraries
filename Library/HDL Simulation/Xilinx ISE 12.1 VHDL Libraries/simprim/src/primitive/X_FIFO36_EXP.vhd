-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/rainier/VITAL/X_FIFO36_EXP.vhd,v 1.5 2010/01/14 19:38:17 fphillip Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2005 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  36K-Bit FIFO
-- /___/   /\     Filename : X_FIFO36_EXP.vhd
-- \   \  /  \    Timestamp : Tues October 18 16:43:59 PST 2005
--  \___\/\___\
--
-- Revision:
--    10/18/05 - Initial version.
--    08/17/06 - Fixed vital delay for vcs_mx (CR 419867).
--    27/05/08 - CR 472154 Removed Vital GSR constructs
--    04/30/09 - Fixed timing violation for asynchronous reset (CR 519016).
-- End Revision

----- CELL X_FIFO36_EXP -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.Vcomponents.all;
use simprim.VPACKAGE.all;

entity X_FIFO36_EXP is
generic (

    TimingChecksOn : boolean := true;
    InstancePath   : string  := "*";
    Xon            : boolean := true;
    MsgOn          : boolean := true;

----- VITAL input wire delays
    tipd_DI    : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
    tipd_DIP   : VitalDelayArrayType01(3 downto 0)  := (others => (0 ps, 0 ps));
    tipd_RDCLKL : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_RDRCLKL : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_RDEN  : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_RST   : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_WRCLKL : VitalDelayType01                   := ( 0 ps, 0 ps);
    tipd_WREN  : VitalDelayType01                   := ( 0 ps, 0 ps);

----- VITAL pin-to-pin propagation delays

    tpd_RDCLKL_DO          : VitalDelayArrayType01 (31 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDCLKL_DOP         : VitalDelayArrayType01 (3 downto 0)  := (others => (100 ps, 100 ps));
    tpd_RDCLKL_EMPTY       : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDCLKL_ALMOSTEMPTY : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDCLKL_RDCOUNT     : VitalDelayArrayType01 (12 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDCLKL_RDERR       : VitalDelayType01                    := ( 100 ps, 100 ps);

    tpd_RDRCLKL_DO          : VitalDelayArrayType01 (31 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDRCLKL_DOP         : VitalDelayArrayType01 (3 downto 0)  := (others => (100 ps, 100 ps));
    tpd_RDRCLKL_EMPTY       : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDRCLKL_ALMOSTEMPTY : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_RDRCLKL_RDCOUNT     : VitalDelayArrayType01 (12 downto 0) := (others => (100 ps, 100 ps));
    tpd_RDRCLKL_RDERR       : VitalDelayType01                    := ( 100 ps, 100 ps);
    
    tpd_WRCLKL_FULL        : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_WRCLKL_ALMOSTFULL  : VitalDelayType01                    := ( 100 ps, 100 ps);
    tpd_WRCLKL_WRCOUNT     : VitalDelayArrayType01 (12 downto 0) := (others => (100 ps, 100 ps));
    tpd_WRCLKL_WRERR       : VitalDelayType01                    := ( 100 ps, 100 ps);


    tpd_RST_EMPTY              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_EMPTY_RDCLKL       : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_ALMOSTEMPTY        : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_ALMOSTEMPTY_RDCLKL : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_FULL               : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_FULL_WRCLKL        : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_ALMOSTFULL         : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_ALMOSTFULL_WRCLKL  : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_RDCOUNT            : VitalDelayArrayType01 (12 downto 0) := (others => (0 ps, 0 ps));
    tbpd_RST_RDCOUNT_RDCLKL     : VitalDelayArrayType01 (12 downto 0) := (others => (0 ps, 0 ps));    
    tpd_RST_RDERR              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_RDERR_RDCLKL       : VitalDelayType01                    := ( 0 ps, 0 ps);
    tpd_RST_WRCOUNT            : VitalDelayArrayType01 (12 downto 0) := (others => (0 ps, 0 ps));
    tbpd_RST_WRCOUNT_WRCLKL     : VitalDelayArrayType01 (12 downto 0) := (others => (0 ps, 0 ps));
    tpd_RST_WRERR              : VitalDelayType01                    := ( 0 ps, 0 ps);
    tbpd_RST_WRERR_WRCLKL       : VitalDelayType01                    := ( 0 ps, 0 ps);
    
----- VITAL recovery time


    trecovery_RST_WRCLKL_negedge_posedge : VitalDelayType := 0 ps;
    trecovery_RST_RDCLKL_negedge_posedge : VitalDelayType := 0 ps;
    trecovery_RST_RDRCLKL_negedge_posedge : VitalDelayType := 0 ps;    

----- VITAL removal time


    tremoval_RST_WRCLKL_negedge_posedge : VitalDelayType  := 0 ps;
    tremoval_RST_RDCLKL_negedge_posedge : VitalDelayType  := 0 ps;
    tremoval_RST_RDRCLKL_negedge_posedge : VitalDelayType  := 0 ps;    

----- VITAL setup time

    tsetup_DI_WRCLKL_posedge_posedge   : VitalDelayArrayType (31 downto 0) := (others => 0 ps);
    tsetup_DI_WRCLKL_negedge_posedge   : VitalDelayArrayType (31 downto 0) := (others => 0 ps);
    tsetup_DIP_WRCLKL_posedge_posedge  : VitalDelayArrayType (3 downto 0)  := (others => 0 ps);
    tsetup_DIP_WRCLKL_negedge_posedge  : VitalDelayArrayType (3 downto 0)  := (others => 0 ps);
    tsetup_RDEN_RDCLKL_posedge_posedge : VitalDelayType := 0 ps;
    tsetup_RDEN_RDCLKL_negedge_posedge : VitalDelayType := 0 ps;
    tsetup_RDEN_RDRCLKL_posedge_posedge : VitalDelayType := 0 ps;
    tsetup_RDEN_RDRCLKL_negedge_posedge : VitalDelayType := 0 ps;    
    tsetup_WREN_WRCLKL_posedge_posedge : VitalDelayType := 0 ps;
    tsetup_WREN_WRCLKL_negedge_posedge : VitalDelayType := 0 ps;

----- VITAL hold time

    thold_DI_WRCLKL_posedge_posedge    : VitalDelayArrayType (31 downto 0) := (others => 0 ps);
    thold_DI_WRCLKL_negedge_posedge    : VitalDelayArrayType (31 downto 0) := (others => 0 ps);
    thold_DIP_WRCLKL_posedge_posedge   : VitalDelayArrayType (3 downto 0)  := (others => 0 ps);
    thold_DIP_WRCLKL_negedge_posedge   : VitalDelayArrayType (3 downto 0)  := (others => 0 ps);
    thold_RDEN_RDCLKL_posedge_posedge  : VitalDelayType := 0 ps;
    thold_RDEN_RDCLKL_negedge_posedge  : VitalDelayType := 0 ps;
    thold_RDEN_RDRCLKL_posedge_posedge  : VitalDelayType := 0 ps;
    thold_RDEN_RDRCLKL_negedge_posedge  : VitalDelayType := 0 ps;    
    thold_WREN_WRCLKL_posedge_posedge  : VitalDelayType := 0 ps;
    thold_WREN_WRCLKL_negedge_posedge  : VitalDelayType := 0 ps;

----- VITAL 
 
    tisd_DI_WRCLKL    : VitalDelayArrayType(31 downto 0) := (others => 0 ps); 
    tisd_DIP_WRCLKL   : VitalDelayArrayType(3 downto 0)  := (others => 0 ps);
    tisd_RST_WRCLKL   : VitalDelayType                   := 0 ps;

    tisd_RST_RDCLKL   : VitalDelayType                   := 0 ps;
    tisd_RST_RDRCLKL   : VitalDelayType                   := 0 ps;    
    tisd_RDEN_RDCLKL  : VitalDelayType                   := 0 ps;
    ticd_RDCLKL       : VitalDelayType                   := 0 ps;
    tisd_RDEN_RDRCLKL  : VitalDelayType                   := 0 ps;
    ticd_RDRCLKL       : VitalDelayType                   := 0 ps;
    
    tisd_WREN_WRCLKL  : VitalDelayType                   := 0 ps;
    ticd_WRCLKL       : VitalDelayType                   := 0 ps;

----- VITAL pulse width 
    tpw_RDCLKL_negedge : VitalDelayType := 0 ps;
    tpw_RDCLKL_posedge : VitalDelayType := 0 ps;
    tpw_RDRCLKL_negedge : VitalDelayType := 0 ps;
    tpw_RDRCLKL_posedge : VitalDelayType := 0 ps;
    
    tpw_RST_negedge : VitalDelayType := 0 ps;
    tpw_RST_posedge : VitalDelayType := 0 ps;

    tpw_WRCLKL_negedge : VitalDelayType := 0 ps;
    tpw_WRCLKL_posedge : VitalDelayType := 0 ps;

----- VITAL period
    tperiod_RDCLKL_posedge : VitalDelayType := 0 ps;
    tperiod_RDRCLKL_posedge : VitalDelayType := 0 ps;    

    tperiod_WRCLKL_posedge : VitalDelayType := 0 ps;

    
    ALMOST_EMPTY_OFFSET     : bit_vector := X"0080"; 
    ALMOST_FULL_OFFSET      : bit_vector := X"0080";
    DATA_WIDTH              : integer    := 4;
    DO_REG                  : integer    := 1;
    EN_SYN                  : boolean    := FALSE;
    FIRST_WORD_FALL_THROUGH : boolean    := FALSE;
    LOC                     : string     := "UNPLACED"
    
  );

port (

    ALMOSTEMPTY : out std_ulogic;
    ALMOSTFULL  : out std_ulogic;
    DO          : out std_logic_vector (31 downto 0);
    DOP         : out std_logic_vector (3 downto 0);
    EMPTY       : out std_ulogic;
    FULL        : out std_ulogic;
    RDCOUNT     : out std_logic_vector (12 downto 0);
    RDERR       : out std_ulogic;
    WRCOUNT     : out std_logic_vector (12 downto 0);
    WRERR       : out std_ulogic;

    DI          : in  std_logic_vector (31 downto 0);
    DIP         : in  std_logic_vector (3 downto 0);
    RDCLKL      : in  std_ulogic;
    RDCLKU      : in  std_ulogic;
    RDEN        : in  std_ulogic;
    RDRCLKL     : in  std_ulogic;
    RDRCLKU     : in  std_ulogic;
    RST         : in  std_ulogic;
    WRCLKL      : in  std_ulogic;
    WRCLKU      : in  std_ulogic;
    WREN        : in  std_ulogic    
  );

  attribute VITAL_LEVEL0 of
     X_FIFO36_EXP : entity is true;

end X_FIFO36_EXP;
                                                                        
architecture X_FIFO36_EXP_V of X_FIFO36_EXP is

  attribute VITAL_LEVEL0 of
    X_FIFO36_EXP_V : architecture is true;
  
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

    
  signal GND_4 : std_logic_vector(3 downto 0) := (others => '0');
  signal GND_32 : std_logic_vector(31 downto 0) := (others => '0');
  signal OPEN_4 : std_logic_vector(3 downto 0);
  signal OPEN_32 : std_logic_vector(31 downto 0);
  signal OPEN_8 : std_logic_vector(7 downto 0);
  signal do_dly : std_logic_vector(31 downto 0) :=  (others => '0');
  signal dop_dly : std_logic_vector(3 downto 0) :=  (others => '0');
  signal almostfull_dly : std_ulogic := '0';
  signal almostempty_dly : std_ulogic := '0';
  signal empty_dly : std_ulogic := '0';
  signal full_dly : std_ulogic := '0';
  signal rderr_dly : std_ulogic := '0';
  signal wrerr_dly : std_ulogic := '0';
  signal rdcount_dly : std_logic_vector(12 downto 0) :=  (others => '0');
  signal wrcount_dly : std_logic_vector(12 downto 0) :=  (others => '0');

    constant MSB_MAX_DO  : integer    := 31;
    constant MSB_MAX_DOP : integer    := 3;
    constant MSB_MAX_RDCOUNT : integer    := 12;
    constant MSB_MAX_WRCOUNT : integer    := 12;

    constant MSB_MAX_DI  : integer    := 31;
    constant MSB_MAX_DIP : integer    := 3;

    signal DI_ipd    : std_logic_vector(MSB_MAX_DI downto 0)    := (others => 'X');
    signal DIP_ipd   : std_logic_vector(MSB_MAX_DIP downto 0)   := (others => 'X');
    signal GSR_ipd   : std_ulogic     :=    'X';
    signal RDCLKL_ipd : std_ulogic     :=    'X';
    signal RDRCLKL_ipd : std_ulogic     :=    'X';
    signal RDEN_ipd  : std_ulogic     :=    'X';
    signal RST_ipd   : std_ulogic     :=    'X';
    signal WRCLKL_ipd : std_ulogic     :=    'X';
    signal WREN_ipd  : std_ulogic     :=    'X';

    signal DI_dly    : std_logic_vector(MSB_MAX_DI downto 0)    := (others => 'X');
    signal DIP_dly   : std_logic_vector(MSB_MAX_DIP downto 0)   := (others => 'X');
    signal GSR_dly   : std_ulogic     :=    '0';
    signal RDCLKL_dly : std_ulogic     :=    'X';
    signal RDRCLKL_dly : std_ulogic     :=    'X';  
    signal RDEN_dly  : std_ulogic     :=    'X';
    signal RST_dly   : std_ulogic     :=    'X';
    signal WRCLKL_dly : std_ulogic     :=    'X';
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
    VitalWireDelay (RDCLKL_ipd,      RDCLKL,      tipd_RDCLKL);
    VitalWireDelay (RDRCLKL_ipd,      RDRCLKL,      tipd_RDRCLKL);
    VitalWireDelay (RST_ipd,        RST,        tipd_RST);
    VitalWireDelay (WREN_ipd,       WREN,       tipd_WREN);
    VitalWireDelay (WRCLKL_ipd,      WRCLKL,      tipd_WRCLKL);

  end block;


  SignalDelay : block
  begin

    DI_Delay : for i in MSB_MAX_DI downto 0 generate
        VitalSignalDelay (DI_dly(i),     DI_ipd(i),    tisd_DI_WRCLKL(i));  -- FP ??
    end generate DI_Delay;    

    DIP_Delay : for i in MSB_MAX_DIP downto 0 generate
        VitalSignalDelay (DIP_dly(i),     DIP_ipd(i),    tisd_DIP_WRCLKL(i));  -- FP ??
    end generate DIP_Delay;    

    VitalSignalDelay (RDEN_dly,     RDEN_ipd,   tisd_RDEN_RDCLKL);          -- FP ??
    VitalSignalDelay (RDCLKL_dly,    RDCLKL_ipd,  ticd_RDCLKL);
    VitalSignalDelay (RDRCLKL_dly,    RDRCLKL_ipd,  ticd_RDRCLKL);    
    VitalSignalDelay (RST_dly,      RST_ipd,    tisd_RST_WRCLKL);           -- FP ??
    VitalSignalDelay (WREN_dly,     WREN_ipd,   tisd_WREN_WRCLKL);          -- FP ??
    VitalSignalDelay (WRCLKL_dly,    WRCLKL_ipd,  ticd_WRCLKL);


  end block;

  
X_FIFO36_EXP_inst : X_AFIFO36_INTERNAL
  generic map (
    ALMOST_FULL_OFFSET => ALMOST_FULL_OFFSET,
    ALMOST_EMPTY_OFFSET => ALMOST_EMPTY_OFFSET, 
    DATA_WIDTH => DATA_WIDTH,
    DO_REG => DO_REG,
    EN_SYN => EN_SYN,
    FIRST_WORD_FALL_THROUGH => FIRST_WORD_FALL_THROUGH
    )

  port map (
    DO(31 downto 0) => do_zd,
    DO(63 downto 32) => OPEN_32,
    DOP(3 downto 0) => dop_zd,
    DOP(7 downto 4) => OPEN_4,
    ALMOSTEMPTY => almostempty_zd,
    ALMOSTFULL => almostfull_zd,
    ECCPARITY => OPEN_8,
    EMPTY => empty_zd,
    FULL => full_zd,
    RDCOUNT => rdcount_zd,
    WRCOUNT => wrcount_zd,
    RDERR => rderr_zd,
    SBITERR => OPEN,
    DBITERR => OPEN,
    WRERR => wrerr_zd,
    DI(31 downto 0) => DI_dly,
    DI(63 downto 32) => GND_32,
    DIP(3 downto 0) => DIP_dly,
    DIP(7 downto 4) => GND_4,
    WREN => WREN_dly,
    RDEN => RDEN_dly,
    RDCLK => RDCLKL_dly,
    RDRCLK => RDRCLKL_dly,
    WRCLK => WRCLKL_dly,
    RST => RST_dly
    );



--####################################################################
--#####                   TIMING CHECKS                          #####
--####################################################################

  prcs_tmngchk:process

--  Pin Timing Violations (all input pins)
     variable Tviol_DI0_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI0_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI1_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI1_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI2_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI2_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI3_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI3_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI4_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI4_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI5_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI5_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI6_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI6_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI7_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI7_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI8_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI8_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI9_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI9_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI10_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI10_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI11_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI11_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI12_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI12_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI13_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI13_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI14_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI14_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI15_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI15_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI16_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI16_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI17_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI17_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI18_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI18_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI19_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI19_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI20_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI20_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI21_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI21_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI22_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI22_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI23_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI23_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI24_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI24_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI25_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI25_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI26_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI26_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI27_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI27_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI28_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI28_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI29_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI29_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI30_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI30_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI31_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI31_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP0_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP0_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP1_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP1_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP2_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP2_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DIP3_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DIP3_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RDEN_RDCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RDEN_RDCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RDEN_RDRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RDEN_RDRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;     
     variable Tviol_WREN_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_WREN_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_WRCLKL_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_WRCLKL_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_WRCLKL_negedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_WRCLKL_negedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_RDCLKL_negedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_RDCLKL_negedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RST_RDRCLKL_negedge : STD_ULOGIC := '0';
     variable  Tmkr_RST_RDRCLKL_negedge : VitalTimingDataType := VitalTimingDataInit;
     
    variable PInfo_RDCLKL : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RDCLKL : std_ulogic := '0';
    variable PInfo_RDRCLKL : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RDRCLKL : std_ulogic := '0';
     
    variable PInfo_WRCLKL : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_WRCLKL : std_ulogic := '0';

    variable PInfo_RST : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RST : std_ulogic := '0';

begin

--  Setup/Hold Check Violations (all input pins)

     if (TimingChecksOn) then
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI0_WRCLKL_posedge,
         TimingData     => Tmkr_DI0_WRCLKL_posedge,
         TestSignal     => DI_dly(0),
         TestSignalName => "DI(0)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(0),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(0),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(0),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(0),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI1_WRCLKL_posedge,
         TimingData     => Tmkr_DI1_WRCLKL_posedge,
         TestSignal     => DI_dly(1),
         TestSignalName => "DI(1)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(1),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(1),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(1),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(1),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI2_WRCLKL_posedge,
         TimingData     => Tmkr_DI2_WRCLKL_posedge,
         TestSignal     => DI_dly(2),
         TestSignalName => "DI(2)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(2),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(2),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(2),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(2),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI3_WRCLKL_posedge,
         TimingData     => Tmkr_DI3_WRCLKL_posedge,
         TestSignal     => DI_dly(3),
         TestSignalName => "DI(3)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(3),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(3),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(3),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(3),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI4_WRCLKL_posedge,
         TimingData     => Tmkr_DI4_WRCLKL_posedge,
         TestSignal     => DI_dly(4),
         TestSignalName => "DI(4)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(4),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(4),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(4),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(4),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI5_WRCLKL_posedge,
         TimingData     => Tmkr_DI5_WRCLKL_posedge,
         TestSignal     => DI_dly(5),
         TestSignalName => "DI(5)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(5),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(5),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(5),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(5),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI6_WRCLKL_posedge,
         TimingData     => Tmkr_DI6_WRCLKL_posedge,
         TestSignal     => DI_dly(6),
         TestSignalName => "DI(6)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(6),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(6),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(6),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(6),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI7_WRCLKL_posedge,
         TimingData     => Tmkr_DI7_WRCLKL_posedge,
         TestSignal     => DI_dly(7),
         TestSignalName => "DI(7)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(7),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(7),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(7),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(7),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI8_WRCLKL_posedge,
         TimingData     => Tmkr_DI8_WRCLKL_posedge,
         TestSignal     => DI_dly(8),
         TestSignalName => "DI(8)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(8),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(8),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(8),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(8),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI9_WRCLKL_posedge,
         TimingData     => Tmkr_DI9_WRCLKL_posedge,
         TestSignal     => DI_dly(9),
         TestSignalName => "DI(9)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(9),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(9),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(9),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(9),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI10_WRCLKL_posedge,
         TimingData     => Tmkr_DI10_WRCLKL_posedge,
         TestSignal     => DI_dly(10),
         TestSignalName => "DI(10)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(10),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(10),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(10),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(10),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI11_WRCLKL_posedge,
         TimingData     => Tmkr_DI11_WRCLKL_posedge,
         TestSignal     => DI_dly(11),
         TestSignalName => "DI(11)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(11),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(11),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(11),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(11),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI12_WRCLKL_posedge,
         TimingData     => Tmkr_DI12_WRCLKL_posedge,
         TestSignal     => DI_dly(12),
         TestSignalName => "DI(12)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(12),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(12),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(12),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(12),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI13_WRCLKL_posedge,
         TimingData     => Tmkr_DI13_WRCLKL_posedge,
         TestSignal     => DI_dly(13),
         TestSignalName => "DI(13)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(13),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(13),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(13),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(13),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI14_WRCLKL_posedge,
         TimingData     => Tmkr_DI14_WRCLKL_posedge,
         TestSignal     => DI_dly(14),
         TestSignalName => "DI(14)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(14),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(14),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(14),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(14),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI15_WRCLKL_posedge,
         TimingData     => Tmkr_DI15_WRCLKL_posedge,
         TestSignal     => DI_dly(15),
         TestSignalName => "DI(15)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(15),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(15),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(15),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(15),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI16_WRCLKL_posedge,
         TimingData     => Tmkr_DI16_WRCLKL_posedge,
         TestSignal     => DI_dly(16),
         TestSignalName => "DI(16)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(16),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(16),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(16),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(16),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI17_WRCLKL_posedge,
         TimingData     => Tmkr_DI17_WRCLKL_posedge,
         TestSignal     => DI_dly(17),
         TestSignalName => "DI(17)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(17),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(17),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(17),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(17),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI18_WRCLKL_posedge,
         TimingData     => Tmkr_DI18_WRCLKL_posedge,
         TestSignal     => DI_dly(18),
         TestSignalName => "DI(18)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(18),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(18),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(18),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(18),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI19_WRCLKL_posedge,
         TimingData     => Tmkr_DI19_WRCLKL_posedge,
         TestSignal     => DI_dly(19),
         TestSignalName => "DI(19)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(19),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(19),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(19),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(19),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI20_WRCLKL_posedge,
         TimingData     => Tmkr_DI20_WRCLKL_posedge,
         TestSignal     => DI_dly(20),
         TestSignalName => "DI(20)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(20),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(20),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(20),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(20),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI21_WRCLKL_posedge,
         TimingData     => Tmkr_DI21_WRCLKL_posedge,
         TestSignal     => DI_dly(21),
         TestSignalName => "DI(21)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(21),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(21),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(21),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(21),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI22_WRCLKL_posedge,
         TimingData     => Tmkr_DI22_WRCLKL_posedge,
         TestSignal     => DI_dly(22),
         TestSignalName => "DI(22)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(22),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(22),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(22),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(22),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI23_WRCLKL_posedge,
         TimingData     => Tmkr_DI23_WRCLKL_posedge,
         TestSignal     => DI_dly(23),
         TestSignalName => "DI(23)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(23),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(23),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(23),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(23),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI24_WRCLKL_posedge,
         TimingData     => Tmkr_DI24_WRCLKL_posedge,
         TestSignal     => DI_dly(24),
         TestSignalName => "DI(24)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(24),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(24),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(24),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(24),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI25_WRCLKL_posedge,
         TimingData     => Tmkr_DI25_WRCLKL_posedge,
         TestSignal     => DI_dly(25),
         TestSignalName => "DI(25)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(25),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(25),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(25),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(25),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI26_WRCLKL_posedge,
         TimingData     => Tmkr_DI26_WRCLKL_posedge,
         TestSignal     => DI_dly(26),
         TestSignalName => "DI(26)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(26),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(26),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(26),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(26),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI27_WRCLKL_posedge,
         TimingData     => Tmkr_DI27_WRCLKL_posedge,
         TestSignal     => DI_dly(27),
         TestSignalName => "DI(27)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(27),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(27),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(27),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(27),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI28_WRCLKL_posedge,
         TimingData     => Tmkr_DI28_WRCLKL_posedge,
         TestSignal     => DI_dly(28),
         TestSignalName => "DI(28)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(28),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(28),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(28),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(28),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI29_WRCLKL_posedge,
         TimingData     => Tmkr_DI29_WRCLKL_posedge,
         TestSignal     => DI_dly(29),
         TestSignalName => "DI(29)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(29),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(29),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(29),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(29),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI30_WRCLKL_posedge,
         TimingData     => Tmkr_DI30_WRCLKL_posedge,
         TestSignal     => DI_dly(30),
         TestSignalName => "DI(30)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(30),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(30),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(30),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(30),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI31_WRCLKL_posedge,
         TimingData     => Tmkr_DI31_WRCLKL_posedge,
         TestSignal     => DI_dly(31),
         TestSignalName => "DI(31)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DI_WRCLKL_posedge_posedge(31),
         SetupLow       => tsetup_DI_WRCLKL_negedge_posedge(31),
         HoldLow        => thold_DI_WRCLKL_posedge_posedge(31),
         HoldHigh       => thold_DI_WRCLKL_negedge_posedge(31),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP0_WRCLKL_posedge,
         TimingData     => Tmkr_DIP0_WRCLKL_posedge,
         TestSignal     => DIP_dly(0),
         TestSignalName => "DIP(0)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLKL_posedge_posedge(0),
         SetupLow       => tsetup_DIP_WRCLKL_negedge_posedge(0),
         HoldLow        => thold_DIP_WRCLKL_posedge_posedge(0),
         HoldHigh       => thold_DIP_WRCLKL_negedge_posedge(0),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP1_WRCLKL_posedge,
         TimingData     => Tmkr_DIP1_WRCLKL_posedge,
         TestSignal     => DIP_dly(1),
         TestSignalName => "DIP(1)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLKL_posedge_posedge(1),
         SetupLow       => tsetup_DIP_WRCLKL_negedge_posedge(1),
         HoldLow        => thold_DIP_WRCLKL_posedge_posedge(1),
         HoldHigh       => thold_DIP_WRCLKL_negedge_posedge(1),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP2_WRCLKL_posedge,
         TimingData     => Tmkr_DIP2_WRCLKL_posedge,
         TestSignal     => DIP_dly(2),
         TestSignalName => "DIP(2)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLKL_posedge_posedge(2),
         SetupLow       => tsetup_DIP_WRCLKL_negedge_posedge(2),
         HoldLow        => thold_DIP_WRCLKL_posedge_posedge(2),
         HoldHigh       => thold_DIP_WRCLKL_negedge_posedge(2),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DIP3_WRCLKL_posedge,
         TimingData     => Tmkr_DIP3_WRCLKL_posedge,
         TestSignal     => DIP_dly(3),
         TestSignalName => "DIP(3)",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DIP_WRCLKL_posedge_posedge(3),
         SetupLow       => tsetup_DIP_WRCLKL_negedge_posedge(3),
         HoldLow        => thold_DIP_WRCLKL_posedge_posedge(3),
         HoldHigh       => thold_DIP_WRCLKL_negedge_posedge(3),
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RDEN_RDCLKL_posedge,
         TimingData     => Tmkr_RDEN_RDCLKL_posedge,
         TestSignal     => RDEN_dly,
         TestSignalName => "RDEN",
         TestDelay      => 0 ns,
         RefSignal      => RDCLKL_dly,
         RefSignalName  => "RDCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RDEN_RDCLKL_posedge_posedge,
         SetupLow       => tsetup_RDEN_RDCLKL_negedge_posedge,
         HoldLow        => thold_RDEN_RDCLKL_posedge_posedge,
         HoldHigh       => thold_RDEN_RDCLKL_negedge_posedge,
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RDEN_RDRCLKL_posedge,
         TimingData     => Tmkr_RDEN_RDRCLKL_posedge,
         TestSignal     => RDEN_dly,
         TestSignalName => "RDEN",
         TestDelay      => 0 ns,
         RefSignal      => RDRCLKL_dly,
         RefSignalName  => "RDRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RDEN_RDRCLKL_posedge_posedge,
         SetupLow       => tsetup_RDEN_RDRCLKL_negedge_posedge,
         HoldLow        => thold_RDEN_RDRCLKL_posedge_posedge,
         HoldHigh       => thold_RDEN_RDRCLKL_negedge_posedge,
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );     
     VitalSetupHoldCheck
       (
         Violation      => Tviol_WREN_WRCLKL_posedge,
         TimingData     => Tmkr_WREN_WRCLKL_posedge,
         TestSignal     => WREN_dly,
         TestSignalName => "WREN",
         TestDelay      => 0 ns,
         RefSignal      => WRCLKL_dly,
         RefSignalName  => "WRCLKL",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_WREN_WRCLKL_posedge_posedge,
         SetupLow       => tsetup_WREN_WRCLKL_negedge_posedge,
         HoldLow        => thold_WREN_WRCLKL_posedge_posedge,
         HoldHigh       => thold_WREN_WRCLKL_negedge_posedge,
         CheckEnabled   => (TO_X01(GSR_dly) = '0'),
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_FIFO36_EXP",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => Warning
       );
     VitalRecoveryRemovalCheck (
        Violation            => Tviol_RST_WRCLKL_negedge,
        TimingData           => Tmkr_RST_WRCLKL_negedge,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => tisd_RST_WRCLKL,
        RefSignal            => WRCLKL_dly,
        RefSignalName        => "WRCLKL",
        RefDelay             => ticd_WRCLKL,
        Recovery             => trecovery_RST_WRCLKL_negedge_posedge,
        Removal              => tremoval_RST_WRCLKL_negedge_posedge,
        ActiveLow            => false,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        RefTransition        => 'R',
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => true,
        MsgSeverity          => warning);
      VitalRecoveryRemovalCheck (
        Violation            => Tviol_RST_RDCLKL_negedge,
        TimingData           => Tmkr_RST_RDCLKL_negedge,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => tisd_RST_RDCLKL,
        RefSignal            => RDCLKL_dly,
        RefSignalName        => "RDCLKL",
        RefDelay             => ticd_RDCLKL,
        Recovery             => trecovery_RST_RDCLKL_negedge_posedge,
        Removal              => tremoval_RST_RDCLKL_negedge_posedge,
        ActiveLow            => false,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        RefTransition        => 'R',
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => true,
        MsgSeverity          => warning);
      VitalRecoveryRemovalCheck (
        Violation            => Tviol_RST_RDRCLKL_negedge,
        TimingData           => Tmkr_RST_RDRCLKL_negedge,
        TestSignal           => RST_dly,
        TestSignalName       => "RST",
        TestDelay            => tisd_RST_RDRCLKL,
        RefSignal            => RDRCLKL_dly,
        RefSignalName        => "RDRCLKL",
        RefDelay             => ticd_RDRCLKL,
        Recovery             => trecovery_RST_RDRCLKL_negedge_posedge,
        Removal              => tremoval_RST_RDRCLKL_negedge_posedge,
        ActiveLow            => false,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        RefTransition        => 'R',
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => true,
        MsgSeverity          => warning);
     VitalPeriodPulseCheck (
        Violation            => Pviol_RDCLKL,
        PeriodData           => PInfo_RDCLKL,
        TestSignal           => RDCLKL_dly,
        TestSignalName       => "RDCLKL",
        TestDelay            => 0 ps,
        Period               => tperiod_RDCLKL_posedge,
        PulseWidthHigh       => tpw_RDCLKL_posedge,
        PulseWidthLow        => tpw_RDCLKL_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );
     VitalPeriodPulseCheck (
        Violation            => Pviol_RDRCLKL,
        PeriodData           => PInfo_RDRCLKL,
        TestSignal           => RDRCLKL_dly,
        TestSignalName       => "RDRCLKL",
        TestDelay            => 0 ps,
        Period               => tperiod_RDRCLKL_posedge,
        PulseWidthHigh       => tpw_RDRCLKL_posedge,
        PulseWidthLow        => tpw_RDRCLKL_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );     
      VitalPeriodPulseCheck (
        Violation            => Pviol_WRCLKL,
        PeriodData           => PInfo_WRCLKL,
        TestSignal           => WRCLKL_dly,
        TestSignalName       => "WRCLKL",
        TestDelay            => 0 ps,
        Period               => tperiod_WRCLKL_posedge,
        PulseWidthHigh       => tpw_WRCLKL_posedge,
        PulseWidthLow        => tpw_WRCLKL_negedge,
        CheckEnabled         => (TO_X01(GSR_dly) = '0'),
        HeaderMsg            => "/X_FIFO36_EXP",
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
        HeaderMsg            => "/X_FIFO36_EXP",
        Xon                  => Xon,
        MsgOn                => MsgOn,
        MsgSeverity          => Warning
      );

     end if;

     Violation         <=
       Pviol_RDCLKL or Pviol_RDRCLKL or
       Pviol_RST or Pviol_WRCLKL;

     Violation_rdclk <= Tviol_RST_RDCLKL_negedge or
                        Tviol_RST_RDRCLKL_negedge;

     Violation_wrclk <= Tviol_RST_WRCLKL_negedge;
     
     --  Wait signal (input/output pins)
   wait on
     DI_dly,
     DIP_dly,
     RDCLKL_dly,
     RDRCLKL_dly,
     RDEN_dly,
     RST_dly,
     WRCLKL_dly,
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
    DO_viol(16) := Violation xor DO_zd(16);
    DO_viol(17) := Violation xor DO_zd(17);
    DO_viol(18) := Violation xor DO_zd(18);
    DO_viol(19) := Violation xor DO_zd(19);
    DO_viol(20) := Violation xor DO_zd(20);
    DO_viol(21) := Violation xor DO_zd(21);
    DO_viol(22) := Violation xor DO_zd(22);
    DO_viol(23) := Violation xor DO_zd(23);
    DO_viol(24) := Violation xor DO_zd(24);
    DO_viol(25) := Violation xor DO_zd(25);
    DO_viol(26) := Violation xor DO_zd(26);
    DO_viol(27) := Violation xor DO_zd(27);
    DO_viol(28) := Violation xor DO_zd(28);
    DO_viol(29) := Violation xor DO_zd(29);
    DO_viol(30) := Violation xor DO_zd(30);
    DO_viol(31) := Violation xor DO_zd(31);
    
    DOP_viol(0) := Violation xor DOP_zd(0);
    DOP_viol(1) := Violation xor DOP_zd(1);
    DOP_viol(2) := Violation xor DOP_zd(2);
    DOP_viol(3) := Violation xor DOP_zd(3);

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
    RDCOUNT_viol(12) := Violation_rdclk xor RDCOUNT_zd(12);
    
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
    WRCOUNT_viol(12) := Violation_wrclk xor WRCOUNT_zd(12);
    

--  Output-to-Clock path delay
     VitalPathDelay01
       (
         OutSignal     => ALMOSTEMPTY,
         GlitchData    => ALMOSTEMPTY_GlitchData,
         OutSignalName => "ALMOSTEMPTY",
         OutTemp       => ALMOSTEMPTY_viol,
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_ALMOSTEMPTY,TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_ALMOSTEMPTY,TRUE),
                           2 => (RST_dly'last_event, tpd_RST_ALMOSTEMPTY,TRUE)),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_ALMOSTFULL,TRUE),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(0),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(0),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(1),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(1),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(2),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(2),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(3),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(3),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(4),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(4),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(5),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(5),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(6),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(6),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(7),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(7),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(8),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(8),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(9),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(9),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(10),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(10),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(11),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(11),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(12),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(12),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(13),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(13),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(14),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(14),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(15),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(15),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(16),
         GlitchData    => DO16_GlitchData,
         OutSignalName => "DO(16)",
         OutTemp       => DO_viol(16),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(16),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(16),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(17),
         GlitchData    => DO17_GlitchData,
         OutSignalName => "DO(17)",
         OutTemp       => DO_viol(17),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(17),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(17),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(18),
         GlitchData    => DO18_GlitchData,
         OutSignalName => "DO(18)",
         OutTemp       => DO_viol(18),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(18),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(18),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(19),
         GlitchData    => DO19_GlitchData,
         OutSignalName => "DO(19)",
         OutTemp       => DO_viol(19),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(19),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(19),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(20),
         GlitchData    => DO20_GlitchData,
         OutSignalName => "DO(20)",
         OutTemp       => DO_viol(20),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(20),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(20),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(21),
         GlitchData    => DO21_GlitchData,
         OutSignalName => "DO(21)",
         OutTemp       => DO_viol(21),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(21),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(21),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(22),
         GlitchData    => DO22_GlitchData,
         OutSignalName => "DO(22)",
         OutTemp       => DO_viol(22),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(22),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(22),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(23),
         GlitchData    => DO23_GlitchData,
         OutSignalName => "DO(23)",
         OutTemp       => DO_viol(23),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(23),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(23),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(24),
         GlitchData    => DO24_GlitchData,
         OutSignalName => "DO(24)",
         OutTemp       => DO_viol(24),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(24),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(24),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(25),
         GlitchData    => DO25_GlitchData,
         OutSignalName => "DO(25)",
         OutTemp       => DO_viol(25),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(25),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(25),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(26),
         GlitchData    => DO26_GlitchData,
         OutSignalName => "DO(26)",
         OutTemp       => DO_viol(26),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(26),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(26),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(27),
         GlitchData    => DO27_GlitchData,
         OutSignalName => "DO(27)",
         OutTemp       => DO_viol(27),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(27),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(27),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(28),
         GlitchData    => DO28_GlitchData,
         OutSignalName => "DO(28)",
         OutTemp       => DO_viol(28),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(28),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(28),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(29),
         GlitchData    => DO29_GlitchData,
         OutSignalName => "DO(29)",
         OutTemp       => DO_viol(29),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(29),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(29),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(30),
         GlitchData    => DO30_GlitchData,
         OutSignalName => "DO(30)",
         OutTemp       => DO_viol(30),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(30),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(30),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DO(31),
         GlitchData    => DO31_GlitchData,
         OutSignalName => "DO(31)",
         OutTemp       => DO_viol(31),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DO(31),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DO(31),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DOP(0),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DOP(0),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DOP(1),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DOP(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DOP(2),
         GlitchData    => DOP2_GlitchData,
         OutSignalName => "DOP(2)",
         OutTemp       => DOP_viol(2),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DOP(2),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DOP(0),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DOP(3),
         GlitchData    => DOP3_GlitchData,
         OutSignalName => "DOP(3)",
         OutTemp       => DOP_viol(3),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_DOP(3),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_DOP(0),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_EMPTY,TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_EMPTY,TRUE),
                           2 => (RST_dly'last_event, tpd_RST_EMPTY,TRUE)),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_FULL,TRUE),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDERR,TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDERR,TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDERR,TRUE)),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRERR,TRUE),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(0),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(0),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(0),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(1),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(1),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(1),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(2),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(2),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(2),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(3),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(3),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(3),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(4),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(4),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(4),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(5),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(5),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(5),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(6),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(6),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(6),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(7),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(7),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(7),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(8),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(8),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(8),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(9),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(9),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(9),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(10),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(10),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(10),TRUE)),
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
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(11),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(11),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(11),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RDCOUNT(12),
         GlitchData    => RDCOUNT12_GlitchData,
         OutSignalName => "RDCOUNT(12)",
         OutTemp       => RDCOUNT_viol(12),
         Paths         => (0 => (RDCLKL_dly'last_event, tpd_RDCLKL_RDCOUNT(12),TRUE),
                           1 => (RDRCLKL_dly'last_event, tpd_RDRCLKL_RDCOUNT(12),TRUE),
                           2 => (RST_dly'last_event, tpd_RST_RDCOUNT(12),TRUE)),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(0),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(1),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(2),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(3),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(4),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(5),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(6),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(7),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(8),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(9),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(10),TRUE),
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
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(11),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(11),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => WRCOUNT(12),
         GlitchData    => WRCOUNT12_GlitchData,
         OutSignalName => "WRCOUNT(12)",
         OutTemp       => WRCOUNT_viol(12),
         Paths         => (0 => (WRCLKL_dly'last_event, tpd_WRCLKL_WRCOUNT(12),TRUE),
                           1 => (RST_dly'last_event, tpd_RST_WRCOUNT(12),TRUE)),
         Mode          => OnEvent,
         Xon           => Xon,
         MsgOn         => MsgOn,
         MsgSeverity   => WARNING
       );
     
  end process prcs_output;

  
end X_FIFO36_EXP_V;
