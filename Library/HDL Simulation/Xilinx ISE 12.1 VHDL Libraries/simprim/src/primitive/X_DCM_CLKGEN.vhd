-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/stan/VITAL/X_DCM_CLKGEN.vhd,v 1.17 2010/01/15 20:44:17 yanx Exp $
------------------------------------------------------------------------------/
-- Copyright (c) 1995/2007 Xilinx, Inc.
-- All Right Reserved.
------------------------------------------------------------------------------/
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  Digital Clock Manager
-- /___/   /\     Filename : x_dcm_clkgen.vhd
-- \   \  /  \    Timestamp : 
--  \___\/\___\
--
-- Revision:
--    01/08/06 - Initial version.
--    07/25/08 - Add attributes SPREAD_SPECTRUM, CLKIN_PERIOD. Remove CLK_SOURCE.
--    09/02/08 - Add STATUS[2:1] pin.
--    09/23/08 - Change CLKFX_MULTIPLY range to 2 to 256 (CR490109).
--    11/20/08 - Add timing check.
--    02/19/09 - Change STARTUP_WAIT type to boolean (CR509029)
--    04/10/09 - Progdata pin loads M-1 and D-1. (CR518158)
--    05/15/09 - Remove DFS_BANDWIDTH & PROG_MD_BANDWIDTH attributes (CR521993)
--    06/18/09 - Change SPREAD_SPECTRUM values (CR525436)
--    11/17/09 - Add spread sprectrum function.
--    11/20/09 - Add STATUS[7:0] pin to simprim_model. (CR538362)
-- End Revision


----- CELL X_DCM_CLKGEN -----

library STD;
use STD.TEXTIO.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
library IEEE;
use IEEE.VITAL_Timing.all;
library simprim;
use simprim.VPACKAGE.all;
use simprim.VCOMPONENTS.all;

  entity X_DCM_CLKGEN is
    generic (
    TimingChecksOn : boolean := true;
    InstancePath : string := "*";
    Xon : boolean := true;
    MsgOn : boolean := false;
    LOC   : string  := "UNPLACED";
      tipd_FREEZEDCM : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PROGCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PROGDATA : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PROGEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RST : VitalDelayType01 :=  (0 ps, 0 ps);
      tpd_CLKIN_LOCKED : VitalDelayType01 := (100 ps, 100 ps);
      tpd_CLKIN_STATUS : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_PROGCLK_PROGDONE : VitalDelayType01 := (100 ps, 100 ps);
      thold_FREEZEDCM_CLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_FREEZEDCM_CLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_PROGDATA_PROGCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PROGDATA_PROGCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PROGEN_PROGCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PROGEN_PROGCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_FREEZEDCM_CLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_FREEZEDCM_CLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PROGDATA_PROGCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PROGDATA_PROGCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PROGEN_PROGCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PROGEN_PROGCLK_posedge_posedge : VitalDelayType := 0 ps;
      tisd_FREEZEDCM_CLKIN : VitalDelayType := 0 ps;
      tisd_PROGDATA_PROGCLK : VitalDelayType := 0 ps;
      tisd_PROGEN_PROGCLK : VitalDelayType := 0 ps;
      ticd_CLKIN : VitalDelayType := 0 ps;
      ticd_PROGCLK : VitalDelayType := 0 ps;
      tperiod_CLKIN_POSEDGE : VitalDelayType := 0.000 ns;
      tperiod_PROGCLK_POSEDGE : VitalDelayType := 0.000 ns;
      tpw_CLKIN_negedge : VitalDelayType := 0.000 ns;
      tpw_CLKIN_posedge : VitalDelayType := 0.000 ns;
      tpw_PROGCLK_negedge : VitalDelayType := 0.000 ns;
      tpw_PROGCLK_posedge : VitalDelayType := 0.000 ns;
      tpw_RST_posedge : VitalDelayType := 0.000 ns;

      CLKFXDV_DIVIDE : integer := 2;
      CLKFX_DIVIDE : integer := 1;
      CLKFX_MULTIPLY : integer := 4;
      CLKFX_MD_MAX : real := 0.0;
      CLKIN_PERIOD : real :=  10.0;
      SPREAD_SPECTRUM : string := "NONE";
      STARTUP_WAIT : boolean := FALSE
    );
    port (
      CLKFX                : out std_ulogic := '0';
      CLKFX180             : out std_ulogic := '0';
      CLKFXDV              : out std_ulogic := '0';
      LOCKED               : out std_ulogic := '0';
      PROGDONE             : out std_ulogic := '0';
      STATUS               : out std_logic_vector(7 downto 0) := "00000000";
      CLKIN                : in std_ulogic := 'L';
      FREEZEDCM            : in std_ulogic := 'L';
      PROGCLK              : in std_ulogic := 'L';
      PROGDATA             : in std_ulogic := 'L';
      PROGEN               : in std_ulogic := 'L';
      RST                  : in std_ulogic := 'L'
    );
  end X_DCM_CLKGEN;

  architecture X_DCM_CLKGEN_V of X_DCM_CLKGEN is

  signal CLKIN_ipd, FREEZEDCM_ipd : std_ulogic;
  signal PROGCLK_ipd, PROGEN_ipd, PROGDATA_ipd, RST_ipd : std_ulogic;
  signal PROGCLK_dly ,PROGEN_dly, PROGDATA_dly : std_ulogic := '0';
  signal CLKIN_dly, FREEZEDCM_dly : std_ulogic := '0';

  constant OSC_P2 : time := 250 ps;
  signal clk_osc : std_ulogic := '0';
  signal clkfx_out  : std_ulogic :=  '0';
  signal clkfx180_out  : std_ulogic :=  '0';
  signal clkfxdv_out  : std_ulogic :=  '0';
  signal clkfx_out1  : std_ulogic :=  '0';
  signal clkfx180_out1  : std_ulogic :=  '0';
  signal clkfxdv_out1  : std_ulogic :=  '0';
  signal rst_reg : std_logic_vector (2 downto 0) :=  "000"; 
  signal rst_prog  : std_ulogic :=  '0';
  signal locked_out  : std_ulogic :=  '0';
  signal locked_out_u  : std_ulogic :=  '0';
  signal progdone_out  : std_ulogic :=  '0';
  signal progdone_out_u  : std_ulogic :=  '0';
  signal clkin_ls_out : std_ulogic :=  '0';
  signal clkfx_ls_out : std_ulogic :=  '0';
  signal clkin_p : std_ulogic :=  '0';
  signal clkfx_p : std_ulogic :=  '0';
  signal clkin_ls_val : integer :=  0;
  signal clkfx_ls_val : integer :=  0;
  signal clkin_ls_cnt : integer :=  0;
  signal clkfx_ls_cnt : integer :=  0;
  signal period_sample : integer :=  0;
  signal lk_pd  : std_ulogic :=  '0';
  signal lk_pd1  : std_ulogic :=  '0';
  signal lk_pd0  : std_ulogic :=  '0';
  signal clkfx_clk  : std_ulogic :=  '0';
  signal pg_sf_reg  : std_logic_vector (9 downto 0) := "0000000000"; 
  signal pg_m_reg  : std_logic_vector (7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED((CLKFX_MULTIPLY-1), 8)); 
  signal pg_d_reg  : std_logic_vector (7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED((CLKFX_DIVIDE-1), 8));
  signal lk_cnt  : integer :=  0;
  signal go_cmd  : std_ulogic :=  '0';
  signal dcm_en_prog  : std_ulogic :=  '0';
  signal pg_cnt  : integer :=  0;
  signal period_sample_done  : integer :=  0;
  signal bit0_flag  : integer :=  0;
  signal attr_err_flag  : integer :=  0;
  signal locked_out_ms1 : std_ulogic :=  '0';
  signal locked_out_ms2 : std_ulogic :=  '0';
  signal first_time : integer := 1;
  signal clkin_pd_init : time;

  signal clkdv_cnt  : integer :=  0;
  signal fx_m  : integer :=  CLKFX_MULTIPLY;
  signal fx_d  : integer :=  CLKFX_DIVIDE;
  signal fx_mt  : integer :=  CLKFX_MULTIPLY;
  signal fx_dt  : integer :=  CLKFX_DIVIDE;
  signal fx_n : real;
  signal fx_o : real;

  signal clkin_pd :time := 0 ps;
  signal clkin_pd1 :time := 0 ps;
  signal lk_delay :time := 0 ps;
  signal spa : integer;
  signal fx_sn_r : real := 1024.0;
  signal fx_sn : integer := 1024;
  signal fx_sn1 : integer := 512;
  signal fx_sn2 : integer := 512;
  signal fx_sn11 : integer    := 256;
  signal fx_sn12 : integer  := 256;
  signal fx_sn21 : integer := 256;
  signal fx_sn22 : integer := 256;
  signal spju : integer := 0;
  signal spd : integer := 0;
  signal sps : real := 0.0;
  signal spst : real := 0.0;
  signal spse : std_ulogic := '0';
  signal spse0 : std_ulogic := '0';
  signal spse1 : std_ulogic := '0';
  signal pd_fx : time    := 0 ps;
  signal pd_fx_i : time    := 0 ps;
  signal pdhf_fx : time    := 0 ps;
  signal pdhf_fx1 : time    := 0 ps;
  signal pdh_fx : time    := 0 ps;
  signal pdh_fx_r : real := 0.0;
  signal pdhfh_fx : time    := 0 ps;
  signal pdhfh_fx1 : time    := 0 ps;
  signal rm_fx : time    := 0 ps;
  signal rmh_fx : time    := 0 ps;
 
  signal clkin_edge  : time :=  0 ps;
  signal clkin_period_s  : time :=  0 ps;
  signal lock_delay  : time :=  0 ps;
  signal period_fx  : time :=  0 ps;
  signal period_half_fx  : time :=  0 ps ;
  signal period_half_fx1  : time :=  0 ps ;
  signal remain_fx  : time :=  0 ps;
  signal fxdv_div1 : integer;
  signal fxdv_div_half : integer;
  signal rst_flag  : integer :=  0;
  signal rst_pulse_wid  : time :=  0 ps;
  signal rst_pos_edge  : time :=  0 ps;
  
  signal clkin_in : std_ulogic;
  signal freezedcm_in : std_ulogic;
  signal progclk_in : std_ulogic;
  signal progen_in : std_ulogic;
  signal progdata_in : std_ulogic;
  signal rst_in : std_ulogic;
  signal locked_out_out : std_ulogic;
  signal rst_ms : std_ulogic;
  signal locked_out_ms : std_ulogic;
  signal clkfx_ms_clk : std_ulogic;
  signal clkfx_md_max_val : real;

begin
  
  INIPROC : process
     variable clkfx_md_max_val_tmp : real;
     variable clkfx_md_ratio : real;
     variable Message : line;
     variable tmp_val1_rl : real;
     variable tmp_val2_rl : real;
     variable tmp_val1 : time;
     variable tmp_val2 : time;
    begin

    if ( CLKFXDV_DIVIDE /= 2 and CLKFXDV_DIVIDE /= 4 and CLKFXDV_DIVIDE /= 8 and
           CLKFXDV_DIVIDE /= 16 and CLKFXDV_DIVIDE /= 32) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute CLKFXDV_DIVIDE on X_DCM_CLKGEN is set to "));
      Write ( Message, CLKFXDV_DIVIDE );
      Write ( Message, string'(".  Legal values for this attribute are 2, 4, 8, 16, or 32") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;

    if (((CLKFX_DIVIDE < 1)  or  (CLKFX_DIVIDE > 256)) 
        and (SPREAD_SPECTRUM = "NONE")) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute CLKFX_DIVIDE on X_DCM_CLKGEN is set to "));
      Write ( Message, CLKFX_DIVIDE );
      Write ( Message, string'(".  Legal values for this attribute are 1 to 256") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    elsif (((CLKFX_DIVIDE < 1)  or  (CLKFX_DIVIDE > 4)) 
        and (SPREAD_SPECTRUM /= "NONE")) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute CLKFX_DIVIDE on X_DCM_CLKGEN is set to "));
      Write ( Message, CLKFX_DIVIDE );
      Write ( Message, string'(".  Legal values for this attribute are 1 to 4 in spread spectrum mode") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;

    tmp_val1 := CLKFX_MULTIPLY * 1 ps;
    tmp_val2 := CLKFX_DIVIDE * 1 ps;
    tmp_val1_rl := (tmp_val1 / 1 ps ) * 1.0;
    tmp_val2_rl := (tmp_val2 / 1 ps) * 1.0;
    clkfx_md_ratio := tmp_val1_rl / tmp_val2_rl;
    if (CLKFX_MD_MAX = 0.0) then
       clkfx_md_max_val_tmp := clkfx_md_ratio;
    else
       clkfx_md_max_val_tmp := CLKFX_MD_MAX;
    end if;
    clkfx_md_max_val <= clkfx_md_max_val_tmp;
    if (clkfx_md_ratio > clkfx_md_max_val_tmp and CLKFX_MD_MAX > 0.0) then
      Write ( Message, string'("Attribute Syntax Error : The ratio of  CLKFX_MULTIPLY / CLKFX_DIVIDE is "));
      Write ( Message, clkfx_md_ratio);
      Write ( Message, string'(".  It is over the value ") );
      Write ( Message, CLKFX_MD_MAX);
      Write ( Message, string'(" set by attribute CLKFX_MD_MAX") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;

    if (((CLKFX_MULTIPLY < 2)  or  (CLKFX_MULTIPLY > 256)) 
         and (SPREAD_SPECTRUM = "NONE")) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute CLKFX_MULTIPLY on X_DCM_CLKGEN is set to "));
      Write ( Message, CLKFX_MULTIPLY);
      Write ( Message, string'(".  Legal values for this attribute are 2 to 256") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    elsif (((CLKFX_MULTIPLY < 2)  or  (CLKFX_MULTIPLY > 32))
         and (SPREAD_SPECTRUM /= "NONE")) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute CLKFX_MULTIPLY on X_DCM_CLKGEN is set to "));
      Write ( Message, CLKFX_MULTIPLY);
      Write ( Message, string'(".  Legal values for this attribute are 2 to 32 in spread spectrum mode") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;
    
    if ( SPREAD_SPECTRUM = "NONE") then
      spa <= 0 ;
    elsif ( SPREAD_SPECTRUM = "CENTER_HIGH_SPREAD") then
      spa <= 1 ;
    elsif ( SPREAD_SPECTRUM = "CENTER_LOW_SPREAD") then
      spa <= 2;
    elsif ( SPREAD_SPECTRUM = "VIDEO_LINK_M0") then
      spa <= 3;
    elsif ( SPREAD_SPECTRUM = "VIDEO_LINK_M1") then
      spa <= 4;
    elsif ( SPREAD_SPECTRUM = "VIDEO_LINK_M2") then
      spa <= 5;
    else
      Write ( Message, string'("Attribute Syntax Error : The Attribute SPREAD_SPECTRUM on X_DCM_CLKGEN is set to "));
      Write ( Message, SPREAD_SPECTRUM);
      Write ( Message, string'(".  Legal values for this attribute are NONE, VIDEO_LINK_M0, VIDEO_LINK_M1, VIDEO_LINK_M2, CENTER_LOW_SPREAD and CENTER_HIGH_SPREAD"));
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;

    if ( STARTUP_WAIT /= FALSE and STARTUP_WAIT /= TRUE) then
      Write ( Message, string'("Attribute Syntax Error : The Attribute STARTUP_WAIT on X_DCM_CLKGEN is set to "));
      Write ( Message, STARTUP_WAIT);
      Write ( Message, string'(".  Legal values for this attribute are FALSE or TRUE"));
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;

   wait;
  end process;

  WireDelay : block
  begin
    VitalWireDelay (CLKIN_ipd, CLKIN, tipd_CLKIN);
    VitalWireDelay (FREEZEDCM_ipd, FREEZEDCM, tipd_FREEZEDCM);
    VitalWireDelay (PROGCLK_ipd, PROGCLK, tipd_PROGCLK);
    VitalWireDelay (PROGEN_ipd, PROGEN, tipd_PROGEN);
    VitalWireDelay (PROGDATA_ipd, PROGDATA, tipd_PROGDATA);
    VitalWireDelay (RST_ipd, RST, tipd_RST);
  end block;

  SignalDelay : block
  begin
    VitalSignalDelay (CLKIN_dly, CLKIN_ipd, ticd_CLKIN);
    VitalSignalDelay (PROGCLK_dly, PROGCLK_ipd, ticd_PROGCLK);
    VitalSignalDelay (PROGEN_dly, PROGEN_ipd, tisd_PROGEN_PROGCLK);
    VitalSignalDelay (PROGDATA_dly, PROGDATA_ipd, tisd_PROGDATA_PROGCLK);
    VitalSignalDelay (FREEZEDCM_dly, FREEZEDCM_ipd, tisd_FREEZEDCM_CLKIN);
  end block;


   STATUS(1) <= clkin_ls_out;
   STATUS(2) <= clkfx_ls_out;
   STATUS(5) <= clkfx_out;
   STATUS(7) <= CLKIN_ipd;
   clkin_in <= CLKIN_ipd;
   freezedcm_in <= FREEZEDCM_ipd;
   progclk_in <= PROGCLK_dly;
   progen_in <= PROGEN_dly;
   progdata_in <= PROGDATA_dly;
   rst_in <= RST_ipd;


  init_p :process  
  begin
    fxdv_div1 <= CLKFXDV_DIVIDE - 1;
    fxdv_div_half <= CLKFXDV_DIVIDE/2;
    wait;
  end process;


--
-- generate master reset signal
--


--    rst_ms <=  (rst_in or rst_prog);
    rst_ms <=  rst_in;

  process (clkin_in) begin
   if(rising_edge(clkin_in)) then
     rst_reg(0) <= rst_in;
     rst_reg(1) <= rst_reg(0)  and  rst_in;
     rst_reg(2) <= rst_reg(1)  and  rst_reg(0)  and  rst_in;
   end if;
  end process;

  rst_check_p : process (rst_in)
     variable rst_pulse_wid : time;
  begin
   if (rst_in  =  '1') then
       rst_flag <= 0 after 1 ps;
   end if;
   if (falling_edge(rst_in)) then
          if ((rst_reg(2)  and  rst_reg(1)  and  rst_reg(0))  =  '0') then
             rst_flag <= 1;
	     assert false report "Input Error : RST on X_DCM_CLKGEN must be asserted for 3 CLKIN clock cycles." severity error;
          end if;
   end if;
  end process;


-- RST less than 3 cycles, lock <= x

   locked_out_out <= 'X' when (rst_flag  =  1) else locked_out_ms1;


--
-- CLKIN period calculation
--
  process
  begin
    clkin_pd_init <= 1000.0 * CLKIN_PERIOD * 1 ps;
  wait;
  end process; 

  clkin_period_cal_p : process (clkin_in, rst_in) begin
  if (rst_in  =  '1') then
    clkin_pd <= clkin_pd_init;
    clkin_pd1 <= clkin_pd_init;
    clkin_edge <= 0 ps;
    period_sample <= 0;
  elsif (rising_edge(clkin_in)) then
    if (freezedcm_in = '0') then
       clkin_edge <= NOW;
       if (clkin_edge  >  0 ps) then
	      clkin_pd1 <= clkin_pd;
	      clkin_pd <= NOW - clkin_edge;
         period_sample <= 1;
       end if;
    end if;
  end if;
  end process;

  lk_pd_p : process (clkin_in, rst_in)
  begin
  if (rst_in  =  '1') then
      lk_cnt <= 0;
      lk_pd0 <= '0';
  elsif (falling_edge(clkin_in))  then
     if (lk_pd0  =  '0') then
        if (freezedcm_in = '0') then   
             lk_cnt <= lk_cnt + 1;
             if (lk_cnt  >=  14) then
                lk_pd0 <= '1';
             end if;
         else
            if (clkin_pd = clkin_pd1 and period_sample = 1) then
                lk_pd0 <= '1';
             end if;
         end if;
      end if;
   end if;
   end process;


--
-- generate lock signal
--

  process (lk_pd0, dcm_en_prog, rst_ms) begin
   if (rst_ms  =  '1') then
       locked_out <= '0';
       lk_pd1 <= '0';
       lk_pd <= '0';
   elsif (rising_edge(lk_pd0) or rising_edge(dcm_en_prog)) then
       locked_out <=  lk_pd0 after lk_delay;
       lk_pd1 <= lk_pd0 after  1 ps;
       lk_pd <= lk_pd0 after 2 ps;
   end if;
  end process;
 
  locked_out_ms <= locked_out;
  locked_out_ms1 <=  locked_out when ((spa = 0) or ((spa >= 3) and (spa <= 5) and
                        (spse = '0'))) else '0';

--
-- generate fx clk from CLKIN period
--

  process (lk_pd0, clkin_pd, fx_d, fx_m)
     variable pd_fx_tmp : integer;
     variable pdhf_fx_tmp : integer;
     variable fx_sn1_t : integer;
     variable fx_sn2_t : integer;
     variable fx_sn_t1 : time;   
     variable fx_sn_t : real;   
     variable fx_sn_i : integer;
     variable fx_sn11_t : integer;
     variable fx_sn12_t : integer;
     variable fx_sn21_t : integer;
     variable fx_sn22_t : integer;
     variable fx_m_rt : time;
     variable fx_m_r : real;
     variable fx_d_rt : time;
     variable fx_d_r : real;
  begin
    lk_delay <= (((clkin_pd / 2) / 1 ps) - 1) * 1 ps;
    fx_m_rt :=  fx_m * 1 ps;
    fx_m_r := (fx_m_rt / 1 ps) * 1.0;
    fx_d_rt :=  fx_d * 1 ps;
    fx_d_r := (fx_d_rt / 1 ps) * 1.0;
    if (lk_pd0  =  '1'  ) then
	    pd_fx_tmp := ((clkin_pd * fx_d) / fx_m ) / 1 ps;
	    pd_fx <= pd_fx_tmp * 1 ps;
       if (spse0 = '0') then
          pd_fx_i <= pd_fx_tmp * 1 ps;
       end if;
	    pdhf_fx_tmp := pd_fx_tmp / 2;
	    pdhf_fx <= pdhf_fx_tmp * 1 ps;
	    pdhf_fx1 <= pdhf_fx_tmp * 1 ps  - 1 ps;
	    rm_fx <= (pd_fx_tmp - pdhf_fx_tmp ) *  1 ps;
       clkin_ls_val <= (clkin_pd * 2) / 500 ps;
       clkfx_ls_val <= (pd_fx_tmp * 2) / 500;
       fx_sn_t := (fx_m_r * 1024.0) / fx_d_r;
       fx_sn_i := (fx_m * 1024) / fx_d;
       fx_sn_r <= fx_sn_t;
       fx_sn <= fx_sn_i;
       fx_sn1_t := (fx_sn_i / 2 );
       fx_sn2_t := fx_sn_i - fx_sn1_t;
       fx_sn1 <= fx_sn1_t;
       fx_sn2 <= fx_sn2_t;
       fx_sn11_t := fx_sn1_t / 2;
       fx_sn11 <= fx_sn11_t;
       fx_sn12_t := fx_sn1_t - fx_sn11_t;
       fx_sn12 <= fx_sn12_t;
       fx_sn21_t := fx_sn2_t / 2;
       fx_sn21 <= fx_sn21_t;
       fx_sn22_t :=  fx_sn1_t + fx_sn21_t;
       fx_sn22 <= fx_sn22_t;
      if (spa = 1) then
         if (fx_d = 1) then
             sps <= 200.0 / fx_sn_t;
         elsif (fx_d = 2) then
             sps <= 125.0 / fx_sn_t;
         elsif (fx_d = 3) then
             sps <= 100.0 / fx_sn_t;
         elsif (fx_d = 4) then
             sps <= 75.0 / fx_sn_t;
         end if;
      elsif (spa = 2) then 
         if (fx_d = 1) then
             sps <= 125.0 / fx_sn_t;
         elsif (fx_d = 2) then
             sps <= 75.0 / fx_sn_t;
         elsif (fx_d = 3 ) then
             sps <= 65.0 / fx_sn_t;
         elsif (fx_d = 4) then
             sps <= 60.0 / fx_sn_t;
         end if;
      elsif (spa = 3) then
         sps <= 5.4 / fx_m_r;
      elsif (spa = 4) then
         sps <= 1.1 / fx_m_r;
      elsif (spa = 5) then
         sps <= 0.3 / fx_m_r;
      end if;
    end if;
  end process;

  sp_pd_cal_p : process (clkfx_clk, rst_ms, lk_pd1, lk_pd, spse1)
    variable pdh_fx_t : time;
    variable pdhfh_fx_t : time;
    variable  spst_tmp1 : time := 0 ps;
    variable  spst_tmpr : real := 0.0;
    variable  spst_tmpt : time := 0 ps;
    variable  spst_tmpi : integer := 0;
    variable  spst_tmp : real := 0.0;
  begin
    if (rst_ms = '1' or lk_pd1 = '0') then
      spju <= 0;
      spst <= 0.0;
      pdh_fx <= pd_fx;
      pdh_fx_t := pd_fx;
      pdh_fx_r <= (pd_fx / 1 ps) * 1.0;
      pdhfh_fx <= pd_fx / 2;
      pdhfh_fx_t := pd_fx / 2;
      pdhfh_fx1 <= pdhfh_fx_t - 1 ps;
      rmh_fx <= pd_fx - pdhfh_fx_t;
    elsif (spse1 = '1') then
      pdh_fx <= pd_fx_i;
      pdh_fx_t := pd_fx_i;
      pdh_fx_r <= (pd_fx_i / 1 ps) * 1.0;
      pdhfh_fx <= pd_fx_i / 2;
      pdhfh_fx_t := pd_fx_i / 2;
      pdhfh_fx1 <= pdhfh_fx_t - 1 ps;
      rmh_fx <= pd_fx_i - pdhfh_fx_t;
      spst <= 0.0;
      spst_tmp := 0.0;
      spst_tmp1 := 0 ps;
    elsif (falling_edge(clkfx_clk) or rising_edge(lk_pd1)) then 
      if (lk_pd1 = '1') then
       if (spa = 1 or spa = 2) then 
         if (spju >= fx_sn) then
           spju <= 0;
         else
           spju <= spju + 1;
         end if;

         if (spju = 0 or spju = fx_sn1) then
            spst <= 0.0;
           pdh_fx_t := pd_fx;
         elsif ((spju > 0 and spju <= fx_sn11) or 
               (spju > fx_sn22 and spju <= fx_sn)) then 
           spst <= spst + sps;
           pdh_fx_t := pd_fx + (spst * 1 ps);
         elsif (spju > fx_sn11  and  spju <= fx_sn22) then   
           spst <= spst - sps;
           pdh_fx_t := pd_fx + (spst * 1 ps);
         end if;
       elsif (spa >= 3 and  spa <= 5 and  spse = '1') then 
        spst_tmp :=  spst + sps;
        if (spst_tmp >= 1.0 ) then
            spst_tmpt := spst_tmp * 1 ps;
            spst_tmpi :=  spst_tmpt / 1 ps;
            spst_tmpr := (spst_tmpt / 1 ps ) * 1.0;
            spst <=  spst_tmp - spst_tmpr;
            spst_tmp1 := spst_tmpt;
        else 
            spst_tmp1 := 0 ps;
            spst <= spst_tmp;
        end if;

        if (spd = 1) then 
           pdh_fx_t := pdh_fx - spst_tmp1;
        else 
           pdh_fx_t := pdh_fx + spst_tmp1;
        end if;
      end if;

      if (spa /= 0) then
          pdhfh_fx_t := pdh_fx_t / 2;
          pdh_fx <= pdh_fx_t;
          pdhfh_fx <= pdhfh_fx_t;
          pdhfh_fx1 <= pdhfh_fx_t - 1 ps;
          rmh_fx <= pdh_fx_t - pdhfh_fx_t;
      end if;
     end if;
    end if;
  end process;

  clkfx_clk_gen_p : process (clkfx_clk, locked_out_ms, rst_ms)
      variable first_time : integer := 1;
  begin
    if (rst_ms  =  '1')  then
       clkfx_clk <= '0';
       first_time := 1;
    elsif ( clkfx_clk'event or rising_edge(locked_out_ms)) then 
       if (locked_out_ms = '1') then
          if (first_time = 1) then 
             clkfx_clk <= '1';
             first_time := 0;
           elsif (clkfx_clk  =  '1') then
             if (spa = 0 or (spse = '0' and  spa >= 3 and spa <= 5)) then
               clkfx_clk <= '0' after pdhf_fx;
             else 
               clkfx_clk <= '0' after pdhfh_fx;
             end if;
           elsif (clkfx_clk  =  '0' )  then
             if (spa = 0 or (spse = '0' and  spa >= 3 and spa <= 5)) then
                clkfx_clk <= '1' after rm_fx;
             else
                clkfx_clk <= '1' after rmh_fx;
             end if;
           end if;
      end if;
    end if;
  end process;
       
  clkfx_ms_clk <=   clkfx_clk;

  clk_osc_p : process(clk_osc,  rst_ms)
  begin
    if (rst_ms = '1') then
      clk_osc <= '0';
    else
      clk_osc <=  not clk_osc after OSC_P2;
    end if;
  end process;

  clkin_p_p : process(clkin_in)
  begin
    if (rising_edge(clkin_in) or falling_edge(clkin_in)) then
      clkin_p <= '1';
      clkin_p <= '0' after 100 ps;
    end if;
  end process;

  clkfx_p_p : process(clkfx_out)
  begin
    if (rising_edge(clkfx_out) or falling_edge(clkfx_out)) then
      clkfx_p <= '1';
      clkfx_p <= '0' after 100 ps;
    end if;
  end process;

  clkin_lost_p : process(clk_osc, rst_ms, clkin_p)
  begin
    if (rst_ms = '1' or clkin_p = '1') then
       clkin_ls_out <= '0';
       clkin_ls_cnt <= 0;
    elsif (rising_edge(clk_osc)) then
       if (locked_out = '1' and freezedcm_in = '0') then
         if (clkin_ls_cnt < clkin_ls_val) then
           clkin_ls_cnt <= clkin_ls_cnt + 1;
           clkin_ls_out <= '0';
         else
           clkin_ls_out <= '1';
         end if;
       end if;
    end if;
  end process;

  clkfx_lost_p : process(clk_osc, rst_ms, clkfx_p)
  begin
    if (rst_ms = '1' or clkfx_p = '1') then
       clkfx_ls_out <= '0';
       clkfx_ls_cnt <= 0;
    elsif (rising_edge(clk_osc)) then
       if (locked_out = '1' and spa = 0) then
         if (clkfx_ls_cnt < clkfx_ls_val) then
           clkfx_ls_cnt <= clkfx_ls_cnt + 1;
           clkfx_ls_out <= '0';
         else
           clkfx_ls_out <= '1';
         end if;
       end if;
    end if;
  end process;

--
-- generate all output signal
--

  locked_out_ms_p1: process (locked_out_ms)
  begin
    locked_out_ms2 <=  locked_out_ms after 1 ps;
  end process;

  clkfx_out1 <= clkfx_out when (locked_out_ms2 = '1')   else '0';
  clkfx180_out1 <= clkfx180_out when (locked_out_ms2 = '1') else '0';
  clkfxdv_out1 <= clkfxdv_out when (locked_out_ms2 = '1')   else '0';

  clkfx_out_gen_p : process (clkfx_ms_clk,   rst_ms) begin
    if (rst_ms  =  '1') then
       clkfx_out <= '0';
       clkfx180_out <= '0';
    elsif (clkfx_ms_clk'event) then  
      if (locked_out_ms  =  '1') then
         clkfx_out <= clkfx_ms_clk;
         clkfx180_out <=  not clkfx_ms_clk;
      end if;
    end if;
  end process;

  process (clkfx_ms_clk,  rst_ms) begin
  if (rst_ms  =  '1') then
       clkfxdv_out <= '0';
       clkdv_cnt <= 0;
  elsif (rising_edge(clkfx_ms_clk)) then
      if (clkdv_cnt >= fxdv_div1) then
           clkdv_cnt <= 0;
      else
           clkdv_cnt <= clkdv_cnt + 1;
      end if;

      if (clkdv_cnt < fxdv_div_half) then
          clkfxdv_out <= '1';
      else
          clkfxdv_out <= '0';
      end if;
  end if;
  end process;


     CLKFX <= clkfx_out1;
     CLKFX180 <= clkfx180_out1;
     CLKFXDV <= clkfxdv_out1;

--
--SPI for M/D dynamic change
--

  process (progclk_in, rst_in) begin
  if (rst_in  =  '1') then
     progdone_out <= '1';
     bit0_flag <= 0;
     pg_cnt <= 0;
  elsif (rising_edge(progclk_in)) then
    if (progen_in  =  '1') then
       if (bit0_flag  =  0) then
          if (progdata_in  =  '0') then
             go_cmd <= '1';
          else 
            progdone_out <= '0';
            bit0_flag <= 1;
            pg_cnt <= 1;
            pg_sf_reg(9) <= progdata_in;
            pg_sf_reg(8 downto 0) <= "000000000";
          end if;
       else 
          progdone_out <= '0';
          if (pg_cnt >= 10) then
             assert false report "Warning : PROGDATA over 10 bit limit on X_DCMCLK_GEN." severity warning;
          end if;
          pg_sf_reg(8 downto 0) <= pg_sf_reg(9 downto 1);
          pg_sf_reg(9) <= progdata_in;
          pg_cnt <=  pg_cnt + 1;
       end if;
    else 
       bit0_flag <= 0;
       pg_cnt <= 0;
    end if;

    if (dcm_en_prog  =  '1') then
        progdone_out <= '1';
    end if;
 
    if (go_cmd = '1') then
        go_cmd <= '0';
    end if;
  end if;
  end process;


  process (progen_in) begin
    if (falling_edge(progen_in)) then
      if ( pg_sf_reg(1 downto 0)  =  "11") then
        pg_m_reg <= pg_sf_reg(9 downto 2);
      elsif ( pg_sf_reg(1 downto 0)  =  "01") then
        pg_d_reg <= pg_sf_reg(9 downto 2);
      end if;
    end if;
  end process;

  spse_p : process
  begin
  if (rising_edge(spse0)) then
    wait until rising_edge(clkin_in);
    if (spa >= 3 and  spa <= 5) then
          wait for 1 ps;
          spse1 <= '1';
          wait for  1 ps;
          spse1 <= '0';
          spse <= '1';
    else
            spse <= '0';
    end if;
  end if;
  wait on spse0;
  end process;

  process 
      variable clkfx_md_ratio : real;
      variable tmp_v1 : time;
      variable tmp_v2 : time;
      variable tmp_v1_rl : real;
      variable tmp_v2_rl : real;
      variable Message : line;
      variable fx_mt : integer;
      variable fx_dt : integer;
      variable fx_mt_r1 : time;   
      variable fx_dt_r1 : time;   
      variable fx_mt_r : real;   
      variable fx_dt_r : real;   
      variable fx_m_r1 : time;   
      variable fx_d_r1 : time;   
      variable fx_m_r : real;   
      variable fx_d_r : real;   
      variable fx_n : real;   
      variable fx_o : real;   
  begin
  if (rising_edge(go_cmd)) then
    wait until falling_edge(clkfx_out);
--    rst_prog <= '1' after pdhf_fx1;
    wait until rising_edge(clkin_in);
    wait until rising_edge(clkin_in);
    wait until rising_edge(clkin_in);
    wait until rising_edge(clkin_in);
    if (spa >= 3 and spa <= 5 and spse0 = '0') then
       spse0 <= '1';
    end if;
    wait until rising_edge(clkin_in);
    fx_mt := SLV_TO_INT(pg_m_reg) + 1;
    fx_dt := SLV_TO_INT(pg_d_reg) + 1;
    fx_m_r1 := fx_m * 1 ps;
    fx_m_r := (fx_m_r1 / 1 ps ) * 1.0;
    fx_d_r1 := fx_d * 1 ps;
    fx_d_r := (fx_d_r1 / 1 ps ) * 1.0;
    fx_mt_r1 := fx_mt * 1 ps;
    fx_mt_r := (fx_mt_r1 / 1 ps ) * 1.0;
    fx_dt_r1 := fx_dt * 1 ps;
    fx_dt_r := (fx_dt_r1 / 1 ps ) * 1.0;
    fx_n := fx_mt_r  / fx_dt_r;
    fx_o := fx_m_r / fx_d_r;
    if (fx_n > fx_o) then
       spd <= 1;
    elsif (fx_n < fx_o) then
       spd <= 0;
    end if;
    fx_m <= fx_mt;
    fx_d <= fx_dt;
--    if (spa >= 3 and  spa <= 5) then
--      if (spse = '0') then
--          wait for 1 ps;
--          spse1 <= '1';
--          wait for  2 ps;
--          spse1 <= '0';
--          spse <= '1';
--      end if;
--    else
--            spse <= '0';
--    end if;
    wait until rising_edge(clkin_in);
    tmp_v1 := fx_m * 1 ps;
    tmp_v2 := fx_d * 1 ps;
    tmp_v1_rl := (tmp_v1 / 1 ps ) * 1.0;
    tmp_v2_rl := (tmp_v2 / 1 ps ) * 1.0;
    clkfx_md_ratio := tmp_v1_rl / tmp_v2_rl;
    if (clkfx_md_ratio > clkfx_md_max_val and CLKFX_MD_MAX > 0.0) then
      Write ( Message, string'(" Error : The CLKFX MULTIPLIER and DIVIDER are programed to ") );
      Write ( Message, fx_m);
      Write ( Message, string'(" and ") );
      Write ( Message, fx_d);
      Write ( Message, string'(" on X_DCM_CLKGEN. The ratio of  CLKFX MULTIPLIER / CLKFX DIVIDER is ") );
     
      Write ( Message, clkfx_md_ratio);
      Write ( Message, string'(". It is over the value ") );
      Write ( Message, clkfx_md_max_val);
      Write ( Message, string'(" set by attribute CLKFX_MD_MAX") );
      Write ( Message, '.' & LF );
      assert false report Message.all severity error;
      DEALLOCATE (Message);
    end if;
     wait until rising_edge(clkin_in);
     wait until rising_edge(clkin_in);
     rst_prog <= '0';
     wait until rising_edge(clkin_in);
     wait until rising_edge(clkin_in);
     wait until rising_edge(clkin_in);
     wait until rising_edge(clkin_in);
     wait until rising_edge(clkin_in);
     wait until rising_edge(progclk_in);
     wait until rising_edge(progclk_in);
     dcm_en_prog <= '1';
     wait until rising_edge(progclk_in);
     dcm_en_prog <=  '0';
  end  if;
  wait on go_cmd;
  end process;

  schedule_outputs : process
    variable PROGDONE_GlitchData : VitalGlitchDataType;
    variable LOCKED_GlitchData : VitalGlitchDataType;
  begin
    VitalPathDelay01 (
      OutSignal  => PROGDONE,
      GlitchData => PROGDONE_GlitchData,
      OutSignalName => "PROGDONE",
      OutTemp => progdone_out,
      Paths => (0 => (progdone_out'last_event, tpd_PROGCLK_PROGDONE, true)),
      Mode => OnEvent,
      Xon => Xon,
      MsgOn => MsgOn,
      MsgSeverity => warning
      );
    VitalPathDelay01 (
      OutSignal  => LOCKED,
      GlitchData => LOCKED_GlitchData,
      OutSignalName => "LOCKED",
      OutTemp => locked_out_out,
      Paths => (0 => (locked_out_out'last_event, tpd_CLKIN_LOCKED, true)),
      Mode => OnEvent,
      Xon => Xon,
      MsgOn => MsgOn,
      MsgSeverity => warning
      );
    wait on  locked_out_out, progdone_out;
  end process schedule_outputs;

  VitalTimingCheck : process
    variable Tviol_FREEZEDCM_CLKIN_posedge : std_ulogic := '0';
    variable Tmkr_FREEZEDCM_CLKIN_posedge  : VitalTimingDataType := VitalTimingDataInit;
    variable Tviol_PROGDATA_PROGCLK_posedge : std_ulogic := '0';
    variable Tmkr_PROGDATA_PROGCLK_posedge  : VitalTimingDataType := VitalTimingDataInit;
    variable Tviol_PROGEN_PROGCLK_posedge        : std_ulogic := '0';
    variable Tmkr_PROGEN_PROGCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Pviol_CLKIN   : std_ulogic := '0';
    variable PInfo_CLKIN   : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_PROGCLK   : std_ulogic := '0';
    variable PInfo_PROGCLK   : VitalPeriodDataType := VitalPeriodDataInit;
    variable Pviol_RST   : std_ulogic := '0';
    variable PInfo_RST   : VitalPeriodDataType := VitalPeriodDataInit;
  begin
    if (TimingChecksOn) then
      VitalSetupHoldCheck (
        Violation               => Tviol_FREEZEDCM_CLKIN_posedge,
        TimingData              => Tmkr_FREEZEDCM_CLKIN_posedge,
        TestSignal              => FREEZEDCM_dly,
        TestSignalName          => "FREEZEDCM",
        TestDelay               => tisd_FREEZEDCM_CLKIN,
        RefSignal               => CLKIN_dly,
        RefSignalName          => "CLKIN",
        RefDelay                => ticd_CLKIN,
        SetupHigh               => tsetup_FREEZEDCM_CLKIN_posedge_posedge,
        SetupLow                => tsetup_FREEZEDCM_CLKIN_negedge_posedge,
        HoldLow                => thold_FREEZEDCM_CLKIN_posedge_posedge,
        HoldHigh                 => thold_FREEZEDCM_CLKIN_negedge_posedge,
        CheckEnabled            => (TO_X01(((NOT RST_ipd)) AND (FREEZEDCM_dly)) /= '0'),
        RefTransition           => 'R',
        HeaderMsg               => InstancePath & "/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);
      VitalSetupHoldCheck (
        Violation               => Tviol_PROGDATA_PROGCLK_posedge,
        TimingData              => Tmkr_PROGDATA_PROGCLK_posedge,
        TestSignal              => PROGDATA_dly,
        TestSignalName          => "PROGDATA",
        TestDelay               => tisd_PROGDATA_PROGCLK,
        RefSignal               => PROGCLK_dly,
        RefSignalName          => "PROGCLK",
        RefDelay                => ticd_PROGCLK,
        SetupHigh               => tsetup_PROGDATA_PROGCLK_posedge_posedge,
        SetupLow                => tsetup_PROGDATA_PROGCLK_negedge_posedge,
        HoldLow                => thold_PROGDATA_PROGCLK_posedge_posedge,
        HoldHigh                 => thold_PROGDATA_PROGCLK_negedge_posedge,
        CheckEnabled            => (TO_X01(((NOT RST_ipd)) AND (PROGEN_dly)) /= '0'),
        RefTransition           => 'R',
        HeaderMsg               => InstancePath & "/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);
      VitalSetupHoldCheck (
        Violation               => Tviol_PROGEN_PROGCLK_posedge,
        TimingData              => Tmkr_PROGEN_PROGCLK_posedge,
        TestSignal              => PROGEN_dly,
        TestSignalName          => "PROGEN",
        TestDelay               => tisd_PROGEN_PROGCLK,
        RefSignal               => PROGCLK_dly,
        RefSignalName          => "PROGCLK",
        RefDelay                => ticd_PROGCLK,
        SetupHigh               => tsetup_PROGEN_PROGCLK_posedge_posedge,
        SetupLow                => tsetup_PROGEN_PROGCLK_negedge_posedge,
        HoldLow                => thold_PROGEN_PROGCLK_posedge_posedge,
        HoldHigh                 => thold_PROGEN_PROGCLK_negedge_posedge,
        CheckEnabled            => TO_X01(NOT RST_ipd)  /= '0',
        RefTransition           => 'R',
        HeaderMsg               => InstancePath & "/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);

      VitalPeriodPulseCheck (
        Violation               => Pviol_PROGCLK,
        PeriodData              => PInfo_PROGCLK,
        TestSignal              => PROGCLK_dly,
        TestSignalName          => "PROGCLK",
        TestDelay               => 0 ns,
        Period                  => tperiod_PROGCLK_POSEDGE,
        PulseWidthHigh          => tpw_PROGCLK_posedge,
        PulseWidthLow           => tpw_PROGCLK_negedge,
        CheckEnabled            => true,
        HeaderMsg               => InstancePath &"/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);


      VitalPeriodPulseCheck (
        Violation               => Pviol_CLKIN,
        PeriodData              => PInfo_CLKIN,
        TestSignal              => CLKIN_ipd,
        TestSignalName          => "CLKIN",
        TestDelay               => 0 ns,
        Period                  => tperiod_CLKIN_POSEDGE,
        PulseWidthHigh          => tpw_CLKIN_posedge,
        PulseWidthLow           => tpw_CLKIN_negedge,
        CheckEnabled            => TO_X01(NOT RST_ipd)  /= '0',
        HeaderMsg               => InstancePath &"/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);

      VitalPeriodPulseCheck (
        Violation               => Pviol_RST,
        PeriodData              => PInfo_RST,
        TestSignal              => RST_ipd,
        TestSignalName          => "RST",
        TestDelay               => 0 ns,
        Period                  => 0 ns,
        PulseWidthHigh          => tpw_RST_posedge,
        PulseWidthLow           => 0 ns,
        CheckEnabled            => true,
        HeaderMsg               => InstancePath &"/X_DCM_CLKGEN",
        Xon                     => Xon,
        MsgOn                   => MsgOn,
        MsgSeverity             => warning);
    end if;
    wait on CLKIN_ipd, PROGCLK_dly, PROGEN_dly, PROGDATA_dly, RST_ipd, FREEZEDCM_dly;
  end process VITALTimingCheck;

end X_DCM_CLKGEN_V;
