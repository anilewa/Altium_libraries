-------------------------------------------------------------------------------
-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
-------------------------------------------------------------------------------
-- This text contains proprietary, confidential
-- information of Xilinx, Inc. , is distributed by
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
-------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/J/addr_gen_3gpp_v4_1/simulation/addr_gen_3gpp_v4_1_xst_comp.vhd,v 1.7 2008/09/09 19:55:31 akennedy Exp $
--
-- Description: Component statement for Turbo Convolutional Decoder
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY XilinxCorelib;
USE XilinxCoreLib.addr_gen_3gpp_top_level_pkg_v4_1.ALL;

PACKAGE addr_gen_3gpp_v4_1_xst_comp IS

COMPONENT addr_gen_3gpp_v4_1_xst
  generic (
    C_ELABORATION_DIR     : string  := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_elaboration_dir_default;
    C_FAMILY              : string  := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_family_default;
    C_COMPONENT_NAME      : string  := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_component_name_default;
    --C_MEM_INIT_PREFIX     : string  := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_mem_init_prefix_default;
    C_HAS_CE              : integer := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_ce_default;
    C_HAS_SCLR            : integer := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_sclr_default;
    C_HAS_ACLR            : integer := ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_aclr_default
  );
  port (
    BLOCK_SIZE            : in  std_logic_vector(12 downto 0);
    IADDR_LOAD_INIT       : in  std_logic;
    IADDR_INIT            : in  std_logic;
    IADDR_READY           : out std_logic;
    IADDR_EN              : in  std_logic;
    IADDR_DATA            : out std_logic_vector(12 downto 0);
    CLK                   : in  std_logic;
    CE                    : in  std_logic;
    ACLR                  : in  std_logic;
    SCLR                  : in  std_logic
);
END COMPONENT;

END addr_gen_3gpp_v4_1_xst_comp;


PACKAGE BODY addr_gen_3gpp_v4_1_xst_comp IS


END addr_gen_3gpp_v4_1_xst_comp;
