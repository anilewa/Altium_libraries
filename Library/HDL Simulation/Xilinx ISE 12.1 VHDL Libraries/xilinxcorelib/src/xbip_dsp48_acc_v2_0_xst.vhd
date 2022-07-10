-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/xbip_dsp48_acc_v2_0/simulation/xbip_dsp48_acc_v2_0_xst.vhd,v 1.3 2009/09/08 16:46:31 akennedy Exp $
--
--  (c) Copyright 2008 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.xbip_dsp48_acc_v2_0_comp.all;

--core_if on entity bip_dsp48_acc_v2_0_xst
  entity bip_dsp48_acc_v2_0_xst is
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
      C_USE_PCIN        : integer := 0;
      C_USE_CARRYCASCIN : integer := 0
      );
    PORT (
      CLK          : in  std_logic                                     := '1';
      CE           : in  std_logic                                     := '1';
      SCLR         : in  std_logic                                     := '0';
      CARRYIN      : in  std_logic                                     := '0';
      CARRYCASCIN  : in  std_logic                                     := '0';
      ACC_NLOAD    : in  std_logic                                     := '0';
      SUBTRACT     : in  std_logic                                     := '0';
      C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
      PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
      CARRYOUT     : out std_logic                                     := '0';
      CARRYCASCOUT : out std_logic                                     := '0';
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
      P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0')
      );
--core_if off
  end entity bip_dsp48_acc_v2_0_xst;


architecture behavioral of bip_dsp48_acc_v2_0_xst is
begin

  i_behv : xbip_dsp48_acc_v2_0
    generic map(
      C_VERBOSITY     => C_VERBOSITY,
      C_MODEL_TYPE    => C_MODEL_TYPE,
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_LATENCY       => C_LATENCY,
      C_HAS_SUBTRACT  => C_HAS_SUBTRACT,
      C_USE_PCIN      => C_USE_PCIN,
      C_USE_CARRYCASCIN => C_USE_CARRYCASCIN
      )
    port map(
      CLK          => CLK,
      CE           => CE,
      SCLR         => SCLR,
      CARRYIN      => CARRYIN,
      CARRYCASCIN  => CARRYCASCIN,
      ACC_NLOAD    => ACC_NLOAD,
      SUBTRACT     => SUBTRACT,
      C            => C,
      PCIN         => PCIN,
      CARRYOUT     => CARRYOUT,
      CARRYCASCOUT => CARRYCASCOUT,
      PCOUT        => PCOUT,
      P            => P
      );

end behavioral;
