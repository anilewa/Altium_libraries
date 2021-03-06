-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/vhdl/BRAM_SDP_MACRO.vhd,v 1.17 2010/02/23 18:30:46 vandanad Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2007 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  Macro for Simple Dual Port Block RAM
-- /___/   /\     Filename : BRAM_SDP_MACRO.vhd
-- \   \  /  \    Timestamp : Wed April 18 10:43:59 PST 2008
--  \___\/\___\
--
-- Revision:
--    04/11/06 - Initial version.
-- End Revision

----- CELL BRAM_SDP_MACRO -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library unisim;
use unisim.VCOMPONENTS.all;
library STD;
use STD.TEXTIO.ALL;


entity BRAM_SDP_MACRO is
generic (
    BRAM_SIZE : string := "18Kb";
    DEVICE : string := "VIRTEX5";
    DO_REG : integer := 0;
    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_40 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_41 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_42 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_43 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_44 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_45 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_46 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_47 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_48 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_49 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_4F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_50 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_51 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_52 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_53 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_54 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_55 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_56 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_57 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_58 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_59 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_5F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_60 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_61 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_62 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_63 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_64 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_65 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_66 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_67 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_68 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_69 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_6F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_70 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_71 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_72 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_73 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_74 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_75 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_76 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_77 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_78 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_79 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_7F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT : bit_vector := X"000000000000000000";
    INIT_FILE : string := "NONE";
    READ_WIDTH : integer := 0;
    WRITE_WIDTH : integer := 0;
    SIM_COLLISION_CHECK : string := "ALL";
    SIM_MODE : string := "SAFE"; -- This parameter is valid only for Virtex5
    SRVAL : bit_vector := X"000000000000000000"
 
    
  );
-- ports are unconstrained arrays
port (
  
    DO : out std_logic_vector;

    DI : in std_logic_vector;
    RDADDR : in std_logic_vector;
    RDCLK : in std_ulogic;
    RDEN : in std_ulogic;
    REGCE : in std_ulogic;
    RST : in std_ulogic;
    WE : in std_logic_vector;
    WRADDR : in std_logic_vector;
    WRCLK : in std_ulogic;
    WREN : in std_ulogic

  );
end BRAM_SDP_MACRO;
                                                                        
architecture bram_V of BRAM_SDP_MACRO is

  function GetWEWidth (
    bram_size : in string;
    device : in string;
    wr_width : in integer
    ) return integer is
    variable func_width : integer;
  begin
    if(DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
      if bram_size= "18Kb" then
        if wr_width <= 9 then
          func_width := 1;
        elsif wr_width > 9 and wr_width <= 18 then
          func_width := 2;
        elsif wr_width > 18 and wr_width <= 36 then
          func_width := 4;
        end if;
      elsif bram_size = "36Kb" then
        if wr_width <= 9 then
          func_width := 1;
        elsif wr_width > 9 and wr_width <= 18 then
          func_width := 2;
        elsif wr_width > 18 and wr_width <= 36 then
          func_width := 4;
        elsif wr_width > 36 and wr_width <= 72 then
          func_width := 8;
        end if;
      else
        func_width := 8;
      end if;
   -- begin s1
    elsif(DEVICE = "SPARTAN6") then
      if bram_size = "9Kb" then
        if wr_width <= 9 then
          func_width := 1;
        elsif wr_width > 9 and wr_width <= 18 then
          func_width := 2;
        elsif wr_width > 18 and wr_width <= 36 then
          func_width := 4;
        else
          func_width := 4;
        end if;
      elsif bram_size = "18Kb" then
        if wr_width <= 9 then
          func_width := 1;
        elsif wr_width > 9 and wr_width <= 18 then
          func_width := 2;
        elsif wr_width > 18 and wr_width <= 36 then
          func_width := 4;
        else
          func_width := 4;
        end if;
     end if; -- end s1
    else 
      func_width := 8;
    end if;
    return func_width;
  end;
  function GetDataWidth (
    rd_width :  in integer;
    wr_width :  in integer;
    bram_size : in string;
    device : in string
    ) return integer is
    variable func_width : integer;
    variable Message : LINE;
  begin
    if (DEVICE = "VIRTEX5") then
      if rd_width = wr_width then
        func_width := rd_width;
      else
        write( Message, STRING'("Illegal values of Attributes  READ_WIDTH, WRITE_WIDTH : ") );
        write ( Message, READ_WIDTH);
        write ( Message, STRING'(" and "));
        write ( Message, WRITE_WIDTH);
        write( Message, STRING'(". To use BRAM_SDP_MACRO, READ_WIDTH and WRITE_WIDTH must be equal ") );
        ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
        DEALLOCATE (Message);
      end if;
    end if;
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      if rd_width = 0 then
                         write( Message, STRING'("Illegal value of Attribute READ_WIDTH : ") );
                         write ( Message, READ_WIDTH);
                         write( Message, STRING'(". This attribute must atleast be equal to 1 . ") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
     -- begin s2
      elsif (DEVICE = "SPARTAN6" and bram_size = "9Kb" and rd_width > 36 and DEVICE = "SPARTAN6") then
                         write( Message, STRING'("Illegal value of Attribute READ_WIDTH : ") );
                         write ( Message, READ_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute for BRAM_SIZE 9Kb are ") );
                         write( Message, STRING'(" 1 to 36 .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message); -- end s2
     elsif bram_size = "18Kb" and rd_width > 36 then
                         write( Message, STRING'("Illegal value of Attribute READ_WIDTH : ") );
                         write ( Message, READ_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute for BRAM_SIZE 18Kb are ") );
                         write( Message, STRING'(" 1 to 36 .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
      elsif bram_size = "36Kb" and rd_width > 72 then
                         write( Message, STRING'("Illegal value of Attribute READ_WIDTH : ") );
                         write ( Message, READ_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute are ") );
                         write( Message, STRING'(" 1 to 36 for BRAM_SIZE of 9Kb, 18Kb and ") );
                         write( Message, STRING'(" 1 to 72 for BRAM_SIZE of 36Kb .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
     end if;
     if wr_width = 0 then
                         write( Message, STRING'("Illegal value of Attribute WRITE_WIDTH : ") );
                         write ( Message, WRITE_WIDTH);
                         write( Message, STRING'(". This attribute must atleast be equal to 1 . ") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
    -- begin s3
     elsif (DEVICE = "SPARTAN6" and bram_size = "9Kb" and wr_width > 36) then
                         write( Message, STRING'("Illegal value of Attribute WRITE_WIDTH : ") );
                         write ( Message, WRITE_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute for BRAM_SIZE 9Kb are ") );
                         write( Message, STRING'(" 1 to 36 .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message); -- end s3
     elsif bram_size = "18Kb" and wr_width > 36 then
                         write( Message, STRING'("Illegal value of Attribute WRITE_WIDTH : ") );
                         write ( Message, WRITE_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute for BRAM_SIZE 18Kb are ") );
                         write( Message, STRING'(" 1 to 36 .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
     elsif bram_size = "36Kb" and wr_width > 72 then
                         write( Message, STRING'("Illegal value of Attribute WRITE_WIDTH : ") );
                         write ( Message, WRITE_WIDTH);
                         write( Message, STRING'(". Legal values of this attribute are ") );
                         write( Message, STRING'(" 1 to 36 for BRAM_SIZE of 9Kb, 18Kb and") );
                         write( Message, STRING'(" 1 to 72 for BRAM_SIZE of 36Kb .") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message);
     end if;
     if (DEVICE = "SPARTAN6" and bram_size = "9Kb" and (wr_width > 18 or rd_width > 18) and ( write_width /= read_width) ) then
                         write( Message, STRING'("Illegal value of Attribute READ_WIDTH : ") );
                         write ( Message, READ_WIDTH);
                         write( Message, STRING'(" . Illegal value of Attribute WRITE_WIDTH : ") );
                         write ( Message, WRITE_WIDTH);
                         write( Message, STRING'(". For BRAM_SIZE 9Kb and read or write widths greater than 18 ") );
                         write( Message, STRING'(" same port width must be used for read and write.") );
                         ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
                         DEALLOCATE (Message); -- end sx
     end if;

   end if;
  return func_width;
  end;
 
  function GetWriteBusSize (
    w_width :  in integer;
    dip_width :  in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
    variable Message : LINE;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
       case w_width is
        when 0 => func_width := 1;
        when 1 => func_width := 1;
        when 2 => func_width := 2;
        when 3|4 => func_width := 4;
        when 5|6|7|8|9 => func_width := 8;
        when 10 to 18 => func_width := 16;
        when 19 to 36 => if(bram_size = "36Kb") then
                         func_width := 32;
                         else
                         func_width := w_width - dip_width; 
                         end if;
        when 37 to 72 => func_width := w_width - dip_width;
        when others => func_width := 64;
       end case;
    else
      func_width := 64;
    end if;
    return func_width;
  end;
  
  function GetReadBusSize (
    r_width :  in integer;
    dop_width :  in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
    variable Message : LINE;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
       case r_width is
        when 0 => func_width := 1;
        when 1 => func_width := 1;
        when 2 => func_width := 2;
        when 3|4 => func_width := 4;
        when 5|6|7|8|9 => func_width := 8;
        when 10 to 18 => func_width := 16;
        when 19 to 36 => if(bram_size = "36Kb") then
                         func_width := 32;
                         else
                         func_width := r_width - dop_width; 
                         end if;
        when 37 to 72 => func_width := r_width - dop_width;
        when others => func_width := 64;
       end case;
    else
      func_width := 64;
    end if;
    return func_width;
  end;

  function GetDataPSize (
    d_width : in integer;
    func_bram_size : in string;
    device : in string 
    ) return integer is
    variable func_width : integer;
  begin
      if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      case d_width is
        when 9 => func_width := 1;
        when 17 => func_width := 1;
        when 18 => func_width := 2;
        when 33 => func_width := 1;
        when 34 => func_width := 2;
        when 35 => func_width := 3;
        when 36 => func_width := 4;
        when 65 => func_width := 1;
        when 66 => func_width := 2;
        when 67 => func_width := 3;
        when 68 => func_width := 4;
        when 69 => func_width := 5;
        when 70 => func_width := 6;
        when 71 => func_width := 7;
        when 72 => func_width := 8;
        when others => func_width := 0;
    end case;
    else
      func_width := 0;
    end if;
  return func_width;
  end;

  function GetMaxADDRSize (
    d_width : in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
  begin
    if (DEVICE = "VIRTEX5") then
      if bram_size = "18Kb" and d_width <= 18 then
        func_width := 14;
      elsif bram_size = "18Kb" and d_width > 18 and d_width <= 36 then
        func_width := 9;
      elsif bram_size = "36Kb" and d_width <= 36 then
        func_width := 16;
      elsif bram_size = "36Kb" and d_width > 36 and d_width <= 72 then
        func_width := 9;
      else
        func_width := 16;
      end if;
    -- begin b1
    elsif ( DEVICE = "VIRTEX6") then
      if bram_size = "18Kb" then
        func_width := 14;
      elsif bram_size = "36Kb" then
        func_width := 16;
      else
        func_width := 16;
      end if; -- end b1
    -- begin s4
    elsif ( DEVICE = "SPARTAN6") then
      if bram_size = "9Kb" then
        func_width := 13;
      elsif bram_size = "18Kb" then
        func_width := 14;
      else
        func_width := 14;
      end if; -- end s4
    else
      func_width := 16;
    end if;
    return func_width;
  end;
 
  function GetMaxDataSize (
    d_width : in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
      if bram_size = "18Kb" and d_width <= 18 then
        func_width := 16;
      elsif bram_size = "18Kb" and d_width > 18 and d_width <= 36 then
        func_width := 32;
      elsif bram_size = "36Kb" and d_width <= 36 then
        func_width := 32;
      elsif bram_size = "36Kb" and d_width > 36 and d_width <= 72 then
        func_width := 64;
      else
        func_width := 64;
      end if;
    -- begin s5 
    elsif (DEVICE = "SPARTAN6") then
      if bram_size = "9Kb" and d_width <= 18 then
        func_width := 16;
      elsif bram_size = "9Kb" and d_width > 18 and d_width <= 36 then
        func_width := 32;
      elsif bram_size = "18Kb" and d_width <= 36 then
        func_width := 32;
      else
        func_width := 32;
      end if; -- end s5
    else
      func_width := 64;
    end if;
    return func_width;
  end;
  
  function GetMaxDataPSize (
    d_width : in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
      if bram_size = "18Kb" and d_width <= 18 then
        func_width := 2;
      elsif bram_size = "18Kb" and d_width > 18 and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "36Kb" and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "36Kb" and d_width > 36 and d_width <= 72 then
        func_width := 8;
      else
        func_width := 8;
      end if;
    -- begin s6
    elsif (DEVICE = "SPARTAN6") then
      if bram_size = "9Kb" and d_width <= 18 then
        func_width := 2;
      elsif bram_size = "9Kb" and d_width > 18 and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "18Kb" and d_width <= 36 then
        func_width := 4;
      else
        func_width := 4;
      end if; -- end s6
    else
      func_width := 8;
    end if;
    return func_width;
  end;
  function GetMaxWESize (
    d_width : in integer;
    bram_size : in string; 
    device : in string 
    ) return integer is
    variable func_width : integer;
  begin
    if (DEVICE = "VIRTEX5") then
      if bram_size = "18Kb" and d_width <= 18 then
        func_width := 2;
      elsif bram_size = "18Kb" and d_width > 18 and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "36Kb" and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "36Kb" and d_width > 36 and d_width <= 72 then
        func_width := 8;
      else
        func_width := 8;
      end if;
    -- begin b4
    elsif (DEVICE = "VIRTEX6") then
      if bram_size = "18Kb" and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "36Kb" and d_width <= 72 then
        func_width := 8;
      else
        func_width := 4;
      end if; -- end b4
    -- begin s7
    elsif (DEVICE = "SPARTAN6") then
      if bram_size = "9Kb" and d_width <= 18 then
        func_width := 2;
      elsif bram_size = "9Kb" and d_width > 18 and d_width <= 36 then
        func_width := 4;
      elsif bram_size = "18Kb" and d_width <= 36 then
        func_width := 4;
      else
        func_width := 4;
      end if; -- end s7
    else
      func_width := 8;
    end if;
    return func_width;
  end;
  function GetADDRWidth (
    d_width : in integer;
    func_bram_size : in string;
    device : in string
    ) return integer is
    variable func_width : integer;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      case d_width is
        when 1 => if (func_bram_size = "9Kb") then
                    func_width := 13;
                  elsif (func_bram_size = "18Kb") then
                    func_width := 14;
                  else
                    func_width := 15;
                  end if;
        when 2 => if (func_bram_size = "9Kb") then
                    func_width := 12;
                  elsif (func_bram_size = "18Kb") then
                    func_width := 13;
                  else
                    func_width := 14;
                  end if;
        when 3|4 => if (func_bram_size = "9Kb") then
                    func_width := 11;
                  elsif (func_bram_size = "18Kb") then
                    func_width := 12;
                  else
                    func_width := 13;
                  end if;
        when 5|6|7|8|9 => if (func_bram_size = "9Kb") then
                    func_width := 10;
                   elsif (func_bram_size = "18Kb") then
                    func_width := 11;
                  else
                    func_width := 12;
                  end if;
        when 10 to 18 => if (func_bram_size = "9Kb") then
                    func_width := 9;
                   elsif (func_bram_size = "18Kb") then
                     func_width := 10;
                   else
                     func_width := 11;
                   end if;
        when 19 to 36 => if (func_bram_size = "9Kb") then
                    func_width := 8;
                   elsif (func_bram_size = "18Kb") then
                     func_width := 9;
                   elsif (func_bram_size = "36Kb") then
                     func_width := 10;
                   else
                     func_width := 14;
                   end if;
        when 37 to 72 => if (func_bram_size = "36Kb") then
                     func_width := 9;
                    end if;
        when others => func_width := 15;
      end case;
  else
    func_width := 15;
  end if;
    return func_width;
  end;

  function GetWidthDP (
    d_width : in integer;
    device : in string
    ) return integer is
    variable func_width : integer;
    variable Message : LINE;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      case d_width is
        when 0 => func_width := 0;
        when 1 => func_width := 1;
        when 2 => func_width := 2;
        when 3|4 => func_width := 4;
        when 5|6|7|8|9 => func_width := 9;
        when 10 to 18 => func_width := 18;
        when 19 to 36 => func_width := 36;
        when 37 to 72 => func_width := 72;
        when others => func_width := 1;
      end case;
    else
      func_width := 1;
    end if;
    return func_width;
  end;

  function GetFinalWidth (
    d_width : in integer
    ) return integer is
    variable func_least_width : integer;
  begin
    if (d_width = 0) then
      func_least_width := 1;
    else
      func_least_width := d_width;
    end if;
    return func_least_width;
  end;

  function GetBRAMSize (
    bram_size : in string; 
    device : in string
    ) return boolean is
    variable bram_val : boolean;
    variable Message : LINE;
  begin
    if(DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
        bram_val := TRUE;
    else 
        bram_val := FALSE;
        write( Message, STRING'("Illegal value of Attribute DEVICE : ") );
        write ( Message, DEVICE);
        write( Message, STRING'(". Legal values of this attribute are ") );
        write( Message, STRING'(" VIRTEX5, VIRTEX6, SPARTAN6 ") );
        ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
        DEALLOCATE (Message);
    end if;

    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then 
       if (bram_size = "18Kb" or bram_size = "36Kb") then
        bram_val := TRUE;
       else
        bram_val := FALSE;
        write( Message, STRING'("Illegal value of Attribute BRAM_SIZE : ") );
        write ( Message, BRAM_SIZE);
        write( Message, STRING'(". Legal values of this attribute are ") );
        write( Message, STRING'(" 18Kb, 36Kb ") );
        ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
        DEALLOCATE (Message);
      end if;
   end if;
   -- begin s8
      if (DEVICE = "SPARTAN6") then
       if(bram_size = "9Kb" or bram_size = "18Kb") then
        bram_val := TRUE;
       else
        bram_val := FALSE;
        write( Message, STRING'("Illegal value of Attribute BRAM_SIZE : ") );
        write ( Message, BRAM_SIZE);
        write( Message, STRING'(". Legal values of this attribute are ") );
        write( Message, STRING'(" 9Kb, 18Kb ") );
        ASSERT FALSE REPORT Message.ALL SEVERITY Failure;
        DEALLOCATE (Message); 
      end if; 
    end if; -- end s8

    return bram_val;
  end;
  function GetD_P (
    dw : in integer;
    device : in string 
    ) return boolean is
    variable wp : boolean;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      if dw = 9 or dw = 17 or dw = 18 or dw = 33 or dw = 34 or dw = 35 or dw = 36 or dw = 65 or dw = 66 or dw = 67 or dw = 68 or dw = 69 or dw = 70 or dw = 71 or dw = 72 then
        wp := TRUE;
      else
        wp := FALSE;
      end if;
    else
      wp := FALSE;
    end if;
    return wp;
  end;
  function CheckParity (
  wp, rp : in boolean;
    device : in string
  ) return boolean is
  variable Message : LINE;
  variable check : boolean;
  begin
    if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") then
      if ( (wp = FALSE and rp = FALSE ) or  (wp = TRUE and rp = TRUE) ) then 
        check := FALSE;
        elsif(wp = TRUE and rp = FALSE) then
          write( Message, STRING'("Port Width Mismatch : ") );
          write( Message, STRING'("The attribute ") );
          write( Message, STRING'("WRITE_WIDTH on BRAM_SDP_MACRO is set to ") );
          write( Message, WRITE_WIDTH);
          write( Message, STRING'(". The parity bit(s) cannot be read") );
          ASSERT FALSE REPORT Message.ALL SEVERITY Warning;
          DEALLOCATE (Message);
        elsif(wp = FALSE and rp = TRUE) then
          write( Message, STRING'("Port Width Mismatch : ") );
          write( Message, STRING'("The attribute ") );
          write( Message, STRING'("READ_WIDTH on BRAM_SDP_MACRO is set to ") );
          write( Message, READ_WIDTH);
          write( Message, STRING'(". The parity bit(s) have not been written and hence cannot be read") );
          ASSERT FALSE REPORT Message.ALL SEVERITY Warning;
          DEALLOCATE (Message);
      end if;
    end if;
  return check;
  end;
  function GetINITSRVALWidth (
  bram_size : in string;
  device : in string
  ) return integer is
    variable init_srval : integer;
  begin
    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
      if(bram_size = "18Kb") then
       init_srval := 20; 
     elsif (bram_size = "36Kb") then
       init_srval := 36; 
     end if;
    end if;
    -- begin s12
    if ( DEVICE = "SPARTAN6") then
      if(bram_size = "9Kb") then
       init_srval := 20; 
      elsif(bram_size = "18Kb") then
       init_srval := 20; 
     end if;
    end if; -- end s12
  return init_srval;
  end; 
  function init_b_size (
  inputvec : in bit_vector;
  init_width : in integer;
  rd_width : in integer;
  wr_width : in integer;
  device : in string
  ) return bit_vector is
    variable init_b_resize : bit_vector(0 to (init_width-1));
  begin
    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
     if((bram_size = "18Kb") and ((rd_width > 18) and (wr_width > 18))) then
       init_b_resize := "00" & inputvec(0 to 1) & inputvec(4 to 19); 
     elsif ((bram_size = "36Kb") and ((rd_width > 36) and (wr_width > 36))) then
       init_b_resize := inputvec(0 to 3) & inputvec(8 to 39); 
     end if;
    end if;
   -- begin s13
   if ( DEVICE = "SPARTAN6") then
     if((bram_size = "9Kb") and ((rd_width > 18) and (wr_width > 18))) then
       init_b_resize := "00" & inputvec(0 to 1) & inputvec(4 to 19); 
     end if;
   end if; -- end s13
  return init_b_resize;
  end;
  function init_a_size (
  inputvec : in bit_vector;
  init_width : in integer;
  rd_width : in integer;
  wr_width : in integer;
  device : in string
  ) return bit_vector is
    variable init_a_resize : bit_vector(0 to (init_width-1));
  begin
    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
     if((bram_size = "18Kb") and ((rd_width > 18) and (wr_width > 18))) then
       init_a_resize := "00" & inputvec(2 to 3) & inputvec(20 to 35); 
     elsif ((bram_size = "36Kb") and ((rd_width > 36) and (wr_width > 36))) then
       init_a_resize := inputvec(4 to 7) & inputvec(40 to 71); 
     end if;
    end if;
   -- begin s14
   if ( DEVICE = "SPARTAN6") then
     if((bram_size = "9Kb") and ((rd_width > 18) and (wr_width > 18))) then
       init_a_resize := "00" & inputvec(2 to 3) & inputvec(20 to 35); 
     end if;
   end if; -- end s14
  return init_a_resize;
  end;
  function srval_b_size (
  inputvec : in bit_vector;
  srval_width : in integer;
  rd_width : in integer;
  wr_width : in integer;
  device : in string
  ) return bit_vector is
    variable srval_b_resize : bit_vector(0 to (srval_width-1));
  begin
    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
     if((bram_size = "18Kb") and ((rd_width > 18) and (wr_width > 18))) then
       srval_b_resize := "00" & inputvec(0 to 1) & inputvec(4 to 19); 
     elsif ((bram_size = "36Kb") and ((rd_width > 36) and (wr_width > 36))) then
       srval_b_resize := inputvec(0 to 3) & inputvec(8 to 39); 
     end if;
    end if;
   -- begin s15
   if ( DEVICE = "SPARTAN6") then
     if((bram_size = "9Kb") and ((rd_width > 18) and (wr_width > 18))) then
       srval_b_resize := "00" & inputvec(0 to 1) & inputvec(4 to 19); 
     end if;
   end if; -- end s15
   return srval_b_resize;
  end;
  function srval_a_size (
  inputvec : in bit_vector;
  srval_width : in integer;
  rd_width : in integer;
  wr_width : in integer;
  device : in string
  ) return bit_vector is
    variable srval_a_resize : bit_vector(0 to (srval_width-1));
  begin
    if ( DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6") then
     if((bram_size = "18Kb") and ((rd_width > 18) and (wr_width > 18))) then
       srval_a_resize := "00" & inputvec(2 to 3) & inputvec(20 to 35); 
     elsif ((bram_size = "36Kb") and ((rd_width > 36) and (wr_width > 36))) then
       srval_a_resize := inputvec(4 to 7) & inputvec(40 to 71); 
     end if;
    end if;
   -- begin s16
   if ( DEVICE = "SPARTAN6") then
     if((bram_size = "9Kb") and ((rd_width > 18) and (wr_width > 18))) then
       srval_a_resize := "00" & inputvec(2 to 3) & inputvec(20 to 35); 
     end if;
   end if; -- end s16
   return srval_a_resize;
  end;


  constant data_width : integer := GetDataWidth(READ_WIDTH, WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant wrwidth : integer := GetWidthDP(WRITE_WIDTH, DEVICE);
  constant rdwidth : integer := GetWidthDP(READ_WIDTH, DEVICE);
  constant bram_size_val : boolean := GetBRAMSize(BRAM_SIZE, DEVICE);
  constant write_p : boolean := GetD_P(WRITE_WIDTH, DEVICE);
  constant read_p : boolean := GetD_P(READ_WIDTH, DEVICE);
  constant check_p : boolean := CheckParity(write_p, read_p, DEVICE);
  constant dip_width : integer := GetDataPSize(WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant dop_width : integer := GetDataPSize(READ_WIDTH, BRAM_SIZE, DEVICE);
  constant wraddr_width : integer := GetADDRWidth(WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant rdaddr_width : integer := GetADDRWidth(READ_WIDTH, BRAM_SIZE, DEVICE);
  constant write_size : integer := GetWriteBusSize(WRITE_WIDTH, dip_width, BRAM_SIZE, DEVICE);
  constant read_size : integer := GetReadBusSize(READ_WIDTH, dop_width, BRAM_SIZE, DEVICE);
  constant we_width : integer := GetWEWidth(BRAM_SIZE, DEVICE, WRITE_WIDTH);
  constant fin_wr_width : integer := GetFinalWidth(WRITE_WIDTH);
  constant fin_rd_width : integer := GetFinalWidth(READ_WIDTH);
  constant max_rdaddr_width : integer := GetMaxADDRSize(READ_WIDTH, BRAM_SIZE, DEVICE);
  constant max_wraddr_width : integer := GetMaxADDRSize(WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant max_write_width : integer := GetMaxDataSize(WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant max_read_width : integer := GetMaxDataSize(READ_WIDTH, BRAM_SIZE, DEVICE);
  constant max_writep_width : integer := GetMaxDataPSize(WRITE_WIDTH, BRAM_SIZE, DEVICE);
  constant max_readp_width : integer := GetMaxDataPSize(READ_WIDTH, BRAM_SIZE, DEVICE);
  constant max_we_width : integer := GetMaxWESize(WRITE_WIDTH, BRAM_SIZE, DEVICE);
 
  signal rdaddr_pattern : std_logic_vector(max_rdaddr_width-1 downto 0) := (others=>'0');  
  signal wraddr_pattern : std_logic_vector(max_wraddr_width-1 downto 0) := (others=>'0');  
  signal di_pattern : std_logic_vector(max_write_width-1 downto 0) := (others=>'0');  
  signal dip_pattern : std_logic_vector(max_writep_width-1 downto 0) := (others=>'0');  
  signal do_pattern : std_logic_vector(max_read_width-1 downto 0);  
  signal dop_pattern : std_logic_vector(max_readp_width-1 downto 0) := (others=>'0');  
  signal we_pattern : std_logic_vector(max_we_width-1 downto 0) := (others=>'0');  
 
  signal rstram_pattern : std_logic := '0';  
  signal rstreg_pattern : std_logic := '0';  
  constant init_srval_width : integer := GetINITSRVALWidth(BRAM_SIZE, DEVICE);
  constant init_a_pattern : bit_vector := init_a_size(INIT, init_srval_width, READ_WIDTH, WRITE_WIDTH, DEVICE);
  constant init_b_pattern : bit_vector := init_b_size(INIT, init_srval_width, READ_WIDTH, WRITE_WIDTH, DEVICE);
  constant srval_a_pattern : bit_vector := srval_a_size(SRVAL, init_srval_width, READ_WIDTH, WRITE_WIDTH, DEVICE);
  constant srval_b_pattern : bit_vector := srval_b_size(SRVAL, init_srval_width, READ_WIDTH, WRITE_WIDTH, DEVICE);

begin

  a1 : rdaddr_pattern <= 
                   -- begin s9
                   RDADDR when (BRAM_SIZE = "9Kb" and rdaddr_width = 13 ) else
                   (RDADDR & '1') when (BRAM_SIZE = "9Kb" and rdaddr_width = 12 ) else
                   (RDADDR & "11") when (BRAM_SIZE = "9Kb" and rdaddr_width = 11 ) else
                   (RDADDR & "111") when (BRAM_SIZE = "9Kb" and rdaddr_width = 10) else
                   (RDADDR & "1111") when (BRAM_SIZE = "9Kb" and rdaddr_width = 9 ) else -- end s9
                   RDADDR when (BRAM_SIZE = "18Kb" and rdaddr_width = 14 ) else
                   (RDADDR & '1') when (BRAM_SIZE = "18Kb" and rdaddr_width = 13 ) else
                   (RDADDR & "11") when (BRAM_SIZE = "18Kb" and rdaddr_width = 12) else
                   (RDADDR & "111") when (BRAM_SIZE = "18Kb" and rdaddr_width = 11 ) else
                   (RDADDR & "1111") when (BRAM_SIZE = "18Kb" and rdaddr_width = 10) else
                   RDADDR when (DEVICE = "VIRTEX5" and BRAM_SIZE = "18Kb" and rdaddr_width = 9) else
                   (RDADDR & "11111") when ( BRAM_SIZE = "18Kb" and rdaddr_width = 9) else
                   RDADDR when (BRAM_SIZE = "36Kb" and rdaddr_width = 16 ) else
                   ('1' & RDADDR) when (BRAM_SIZE = "36Kb" and rdaddr_width = 15 ) else
                   ('1' & RDADDR & '1') when (BRAM_SIZE = "36Kb" and rdaddr_width = 14 ) else
                   ('1' & RDADDR & "11") when (BRAM_SIZE = "36Kb" and rdaddr_width = 13 ) else
                   ('1' & RDADDR & "111") when (BRAM_SIZE = "36Kb" and rdaddr_width = 12 ) else
                   ('1' & RDADDR & "1111") when (BRAM_SIZE = "36Kb" and rdaddr_width = 11 ) else
                   ('1' & RDADDR & "11111") when (BRAM_SIZE = "36Kb" and rdaddr_width = 10) else
                   RDADDR when (DEVICE = "VIRTEX5" and BRAM_SIZE = "36Kb" and rdaddr_width = 9) else 
                   ('1' & RDADDR & "111111") when (BRAM_SIZE = "36Kb" and rdaddr_width = 9) else 
                   (others => '1') ;
   a2 : wraddr_pattern <= 
                   -- begin s10
                   WRADDR when (BRAM_SIZE = "9Kb" and wraddr_width = 13 ) else
                   (WRADDR & '1') when (BRAM_SIZE = "9Kb" and wraddr_width = 12 ) else
                   (WRADDR & "11") when (BRAM_SIZE = "9Kb" and wraddr_width = 11) else
                   (WRADDR & "111") when (BRAM_SIZE = "9Kb" and wraddr_width = 10) else
                   (WRADDR & "1111") when (BRAM_SIZE = "9Kb" and wraddr_width = 9) else -- end s10
                   WRADDR when (BRAM_SIZE = "18Kb" and wraddr_width = 14 ) else
                   (WRADDR & '1') when (BRAM_SIZE = "18Kb" and wraddr_width = 13 ) else
                   (WRADDR & "11") when (BRAM_SIZE = "18Kb" and wraddr_width = 12 ) else
                   (WRADDR & "111") when (BRAM_SIZE = "18Kb" and wraddr_width = 11 ) else
                   (WRADDR & "1111") when (BRAM_SIZE = "18Kb" and wraddr_width = 10) else
                   (WRADDR) when (DEVICE = "VIRTEX5" and BRAM_SIZE = "18Kb" and wraddr_width = 9) else
                   (WRADDR & "11111") when ( BRAM_SIZE = "18Kb" and wraddr_width = 9) else
                   WRADDR when (BRAM_SIZE = "36Kb" and wraddr_width = 16 ) else
                   ('1' & WRADDR) when (BRAM_SIZE = "36Kb" and wraddr_width = 15) else
                   ('1' & WRADDR & '1') when (BRAM_SIZE = "36Kb" and wraddr_width = 14) else
                   ('1' & WRADDR & "11") when (BRAM_SIZE = "36Kb" and wraddr_width = 13) else
                   ('1' & WRADDR & "111") when (BRAM_SIZE = "36Kb" and wraddr_width = 12) else
                   ('1' & WRADDR & "1111") when (BRAM_SIZE = "36Kb" and wraddr_width = 11 ) else
                   ('1' & WRADDR & "11111") when (BRAM_SIZE = "36Kb" and wraddr_width = 10) else
                   WRADDR when (DEVICE = "VIRTEX5" and BRAM_SIZE = "36Kb" and wraddr_width = 9) else
                   ('1' & WRADDR & "111111") when (BRAM_SIZE = "36Kb" and wraddr_width = 9) else
                   (others => '1') ;

  di1_v5 : if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") generate
    digen1 : if (write_p = TRUE  and ((BRAM_SIZE = "9Kb" and WRITE_WIDTH <= 36) or (BRAM_SIZE = "18Kb" and WRITE_WIDTH <= 36) or (BRAM_SIZE = "36Kb" and WRITE_WIDTH <= 72) ) ) generate
    begin 
       dip_pattern(dip_width-1 downto 0) <= DI(fin_wr_width-1 downto write_size) ;
       di_pattern (write_size-1 downto 0) <= DI(write_size-1 downto 0);
    end generate digen1;
  end generate di1_v5;

  di2_v5 : if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") generate
    digen2 : if (write_p = FALSE and ((BRAM_SIZE = "9Kb" and WRITE_WIDTH <= 36) or (BRAM_SIZE = "18Kb" and WRITE_WIDTH <= 36) or (BRAM_SIZE = "36Kb" and WRITE_WIDTH <= 72) ) ) generate
    begin 
       di_pattern(fin_wr_width-1 downto 0) <= DI(fin_wr_width-1 downto 0);
    end generate digen2;
  end generate di2_v5;

  do1_v5 : if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") generate
   dogen1 : if (read_p= TRUE and ((BRAM_SIZE = "9Kb" and READ_WIDTH <= 36) or (BRAM_SIZE = "18Kb" and READ_WIDTH <= 36) or (BRAM_SIZE = "36Kb" and READ_WIDTH <= 72) ) ) generate
     begin
       DO <= (dop_pattern(dop_width-1 downto 0) & do_pattern(read_size-1 downto 0));
    end generate dogen1;
  end generate do1_v5;

  do2_v5 : if (DEVICE = "VIRTEX5" or DEVICE = "VIRTEX6" or DEVICE = "SPARTAN6") generate
    dogen2 : if (read_p= FALSE and ((BRAM_SIZE = "9Kb" and READ_WIDTH <= 36) or (BRAM_SIZE = "18Kb" and READ_WIDTH <= 36) or (BRAM_SIZE = "36Kb" and READ_WIDTH <= 72) ) ) generate
      begin
        DO <= do_pattern(fin_rd_width-1 downto 0);
      end generate dogen2;
    end generate do2_v5;

 we1 : if (DEVICE = "VIRTEX5") generate
  w1 : we_pattern <= 
                   (WE & WE) when (BRAM_SIZE = "18Kb" and we_width = 1 ) else
                   WE when (BRAM_SIZE = "18Kb" and we_width = 2 ) else
                   (WE & WE & WE & WE) when (BRAM_SIZE = "36Kb" and we_width = 1 ) else
                   (WE & WE) when (BRAM_SIZE = "36Kb" and we_width = 2 ) else
                   WE when (BRAM_SIZE = "36Kb" and we_width = 4 ) else
                   WE;
  end generate we1;
 web_bl : if (DEVICE = "VIRTEX6") generate
  w1 : we_pattern <= 
                   (WE & WE & WE & WE) when (BRAM_SIZE = "18Kb" and we_width = 1 ) else
                   (WE & WE) when (BRAM_SIZE = "18Kb" and we_width = 2 ) else
                   WE when (BRAM_SIZE = "18Kb" and we_width = 2 ) else
                   (WE & WE & WE & WE & WE & WE & WE & WE) when (BRAM_SIZE = "36Kb" and we_width = 1 ) else
                   (WE & WE & WE & WE) when (BRAM_SIZE = "36Kb" and we_width = 2 ) else
                   (WE & WE) when (BRAM_SIZE = "36Kb" and we_width = 4 ) else
                   WE when (BRAM_SIZE = "36Kb" and we_width = 8 ) else
                   WE;
  end generate web_bl;
  -- begin s11
 we2 : if (DEVICE = "SPARTAN6") generate
  w2 : we_pattern <= 
                   (WE & WE) when (BRAM_SIZE = "9Kb" and we_width = 1 ) else
                   WE when (BRAM_SIZE = "9Kb" and we_width = 2 ) else
                   (WE & WE & WE & WE) when (BRAM_SIZE = "18Kb" and we_width = 1 ) else
                   (WE & WE) when (BRAM_SIZE = "18Kb" and we_width = 2 ) else
                   WE when (BRAM_SIZE = "18Kb" and we_width = 4 ) else
                   WE;
  end generate we2;
  -- end s11

  rstram_pattern <= RST when (DO_REG = 0) else '0';
  rstreg_pattern <= RST when (DO_REG = 1) else '0';

  -- begin generate virtex5
  sdp_v5 : if DEVICE = "VIRTEX5" generate

      ramb18_dp : if (BRAM_SIZE = "18Kb" and DATA_WIDTH <= 18) generate 
      begin
        ram18 : RAMB18 
          generic map(
                DOA_REG => DO_REG,
                INIT_A => INIT,
                INIT_FILE => INIT_FILE,
                INIT_00 => INIT_00,
                INIT_01 => INIT_01,
                INIT_02 => INIT_02,
                INIT_03 => INIT_03,
                INIT_04 => INIT_04,
                INIT_05 => INIT_05,
                INIT_06 => INIT_06,
                INIT_07 => INIT_07,
                INIT_08 => INIT_08,
                INIT_09 => INIT_09,
                INIT_0A => INIT_0A,
                INIT_0B => INIT_0B,
                INIT_0C => INIT_0C,
                INIT_0D => INIT_0D,
                INIT_0E => INIT_0E,
                INIT_0F => INIT_0F,
                INIT_10 => INIT_10,
                INIT_11 => INIT_11,
                INIT_12 => INIT_12,
                INIT_13 => INIT_13,
                INIT_14 => INIT_14,
                INIT_15 => INIT_15,
                INIT_16 => INIT_16,
                INIT_17 => INIT_17,
                INIT_18 => INIT_18,
                INIT_19 => INIT_19,
                INIT_1A => INIT_1A,
                INIT_1B => INIT_1B,
                INIT_1C => INIT_1C,
                INIT_1D => INIT_1D,
                INIT_1E => INIT_1E,
                INIT_1F => INIT_1F,
                INIT_20 => INIT_20,
                INIT_21 => INIT_21,
                INIT_22 => INIT_22,
                INIT_23 => INIT_23,
                INIT_24 => INIT_24,
                INIT_25 => INIT_25,
                INIT_26 => INIT_26,
                INIT_27 => INIT_27,
                INIT_28 => INIT_28,
                INIT_29 => INIT_29,
                INIT_2A => INIT_2A,
                INIT_2B => INIT_2B,
                INIT_2C => INIT_2C,
                INIT_2D => INIT_2D,
                INIT_2E => INIT_2E,
                INIT_2F => INIT_2F,
                INIT_30 => INIT_30,
                INIT_31 => INIT_31,
                INIT_32 => INIT_32,
                INIT_33 => INIT_33,
                INIT_34 => INIT_34,
                INIT_35 => INIT_35,
                INIT_36 => INIT_36,
                INIT_37 => INIT_37,
                INIT_38 => INIT_38,
                INIT_39 => INIT_39,
                INIT_3A => INIT_3A,
                INIT_3B => INIT_3B,
                INIT_3C => INIT_3C,
                INIT_3D => INIT_3D,
                INIT_3E => INIT_3E,
                INIT_3F => INIT_3F,
                INITP_00 => INITP_00,
                INITP_01 => INITP_01,
                INITP_02 => INITP_02,
                INITP_03 => INITP_03,
                INITP_04 => INITP_04,
                INITP_05 => INITP_05,
                INITP_06 => INITP_06,
                INITP_07 => INITP_07,
                READ_WIDTH_A => rdwidth,
                SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SIM_MODE => SIM_MODE,
                SRVAL_A => SRVAL ,
                WRITE_MODE_B => "READ_FIRST",
                WRITE_WIDTH_B => wrwidth
              )
          port map (
                ADDRA => rdaddr_pattern,
                ADDRB => wraddr_pattern,
                CLKA => RDCLK,
                CLKB => WRCLK,
                DIA  => X"0000",
                DIB => di_pattern,
                DIPA => "00",
                DIPB => dip_pattern,
                ENA => RDEN,
                ENB => WREN,
                SSRA => RST,
                SSRB => '0',
                WEA => "00",
                WEB => we_pattern,
                DOA => do_pattern,
                DOB => OPEN,
                DOPA => dop_pattern,
                DOPB => OPEN,
                REGCEA => REGCE,
                REGCEB => '0'
        );

    end generate ramb18_dp;

    ramb18_sdp : if (BRAM_SIZE = "18Kb" and DATA_WIDTH > 18 and DATA_WIDTH <= 36) generate 
    begin
      ram18sd : RAMB18SDP
        generic map (

                DO_REG => DO_REG,
                INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INIT  => INIT,
                INIT_FILE => INIT_FILE,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SIM_MODE => SIM_MODE,
		SRVAL => SRVAL
                )
  
        port map (
                DI => di_pattern,
                DIP => dip_pattern,
                RDADDR => RDADDR,
                RDCLK => RDCLK,
                RDEN => RDEN,
                SSR => RST,
                WRADDR => WRADDR,
                WRCLK => WRCLK,
                WREN => WREN,
                WE => we_pattern,
                DO => do_pattern,
                DOP => dop_pattern,
                REGCE => REGCE
        );

    end generate ramb18_sdp;
    ramb36_dp : if (BRAM_SIZE = "36Kb" and DATA_WIDTH <= 36) generate 
      begin
        ram36 : RAMB36
          generic map (

                DOA_REG => DO_REG,
		INIT_A  => INIT,
                INIT_FILE => INIT_FILE,
		INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INIT_40 => INIT_40,
		INIT_41 => INIT_41,
		INIT_42 => INIT_42,
		INIT_43 => INIT_43,
		INIT_44 => INIT_44,
		INIT_45 => INIT_45,
		INIT_46 => INIT_46,
		INIT_47 => INIT_47,
		INIT_48 => INIT_48,
		INIT_49 => INIT_49,
		INIT_4A => INIT_4A,
		INIT_4B => INIT_4B,
		INIT_4C => INIT_4C,
		INIT_4D => INIT_4D,
		INIT_4E => INIT_4E,
		INIT_4F => INIT_4F,
		INIT_50 => INIT_50,
		INIT_51 => INIT_51,
		INIT_52 => INIT_52,
		INIT_53 => INIT_53,
		INIT_54 => INIT_54,
		INIT_55 => INIT_55,
		INIT_56 => INIT_56,
		INIT_57 => INIT_57,
		INIT_58 => INIT_58,
		INIT_59 => INIT_59,
		INIT_5A => INIT_5A,
		INIT_5B => INIT_5B,
		INIT_5C => INIT_5C,
		INIT_5D => INIT_5D,
		INIT_5E => INIT_5E,
		INIT_5F => INIT_5F,
		INIT_60 => INIT_60,
		INIT_61 => INIT_61,
		INIT_62 => INIT_62,
		INIT_63 => INIT_63,
		INIT_64 => INIT_64,
		INIT_65 => INIT_65,
		INIT_66 => INIT_66,
		INIT_67 => INIT_67,
		INIT_68 => INIT_68,
		INIT_69 => INIT_69,
		INIT_6A => INIT_6A,
		INIT_6B => INIT_6B,
		INIT_6C => INIT_6C,
		INIT_6D => INIT_6D,
		INIT_6E => INIT_6E,
		INIT_6F => INIT_6F,
		INIT_70 => INIT_70,
		INIT_71 => INIT_71,
		INIT_72 => INIT_72,
		INIT_73 => INIT_73,
		INIT_74 => INIT_74,
		INIT_75 => INIT_75,
		INIT_76 => INIT_76,
		INIT_77 => INIT_77,
		INIT_78 => INIT_78,
		INIT_79 => INIT_79,
		INIT_7A => INIT_7A,
		INIT_7B => INIT_7B,
		INIT_7C => INIT_7C,
		INIT_7D => INIT_7D,
		INIT_7E => INIT_7E,
		INIT_7F => INIT_7F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INITP_08 => INITP_08,
		INITP_09 => INITP_09,
		INITP_0A => INITP_0A,
		INITP_0B => INITP_0B,
		INITP_0C => INITP_0C,
		INITP_0D => INITP_0D,
		INITP_0E => INITP_0E,
		INITP_0F => INITP_0F,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SIM_MODE => SIM_MODE,
		SRVAL_A => SRVAL,
                READ_WIDTH_A => rdwidth,
		WRITE_MODE_B => "READ_FIRST",                
                WRITE_WIDTH_B => wrwidth         

                )
           port map (
                ADDRA => rdaddr_pattern,
                ADDRB => wraddr_pattern,
                CLKA => RDCLK,
                CLKB => WRCLK,
                DIA  => X"00000000",
                DIB  => di_pattern,
                DIPA => "0000",
                DIPB => dip_pattern,
                ENA => RDEN,
                ENB => WREN,
                SSRA => RST,
                SSRB => '0',
                WEA => "0000",
                WEB => we_pattern,
                DOA => do_pattern,
                DOB => OPEN,
                DOPA => dop_pattern,
                DOPB => OPEN,
                CASCADEOUTLATA => OPEN,
                CASCADEOUTLATB => OPEN,
                CASCADEOUTREGA => OPEN,
                CASCADEOUTREGB => OPEN,
                CASCADEINLATA => '0',
                CASCADEINLATB => '0',
                CASCADEINREGA => '0',
                CASCADEINREGB => '0',
                REGCEA => REGCE,
                REGCEB => '0'
          );
    end generate ramb36_dp;

    ramb36_sdp : if (BRAM_SIZE = "36Kb" and DATA_WIDTH > 36 and DATA_WIDTH <= 72) generate 
    begin
      ram36sd : RAMB36SDP
        generic map (

                DO_REG => DO_REG,
                INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INIT_40 => INIT_40,
		INIT_41 => INIT_41,
		INIT_42 => INIT_42,
		INIT_43 => INIT_43,
		INIT_44 => INIT_44,
		INIT_45 => INIT_45,
		INIT_46 => INIT_46,
		INIT_47 => INIT_47,
		INIT_48 => INIT_48,
		INIT_49 => INIT_49,
		INIT_4A => INIT_4A,
		INIT_4B => INIT_4B,
		INIT_4C => INIT_4C,
		INIT_4D => INIT_4D,
		INIT_4E => INIT_4E,
		INIT_4F => INIT_4F,
		INIT_50 => INIT_50,
		INIT_51 => INIT_51,
		INIT_52 => INIT_52,
		INIT_53 => INIT_53,
		INIT_54 => INIT_54,
		INIT_55 => INIT_55,
		INIT_56 => INIT_56,
		INIT_57 => INIT_57,
		INIT_58 => INIT_58,
		INIT_59 => INIT_59,
		INIT_5A => INIT_5A,
		INIT_5B => INIT_5B,
		INIT_5C => INIT_5C,
		INIT_5D => INIT_5D,
		INIT_5E => INIT_5E,
		INIT_5F => INIT_5F,
		INIT_60 => INIT_60,
		INIT_61 => INIT_61,
		INIT_62 => INIT_62,
		INIT_63 => INIT_63,
		INIT_64 => INIT_64,
		INIT_65 => INIT_65,
		INIT_66 => INIT_66,
		INIT_67 => INIT_67,
		INIT_68 => INIT_68,
		INIT_69 => INIT_69,
		INIT_6A => INIT_6A,
		INIT_6B => INIT_6B,
		INIT_6C => INIT_6C,
		INIT_6D => INIT_6D,
		INIT_6E => INIT_6E,
		INIT_6F => INIT_6F,
		INIT_70 => INIT_70,
		INIT_71 => INIT_71,
		INIT_72 => INIT_72,
		INIT_73 => INIT_73,
		INIT_74 => INIT_74,
		INIT_75 => INIT_75,
		INIT_76 => INIT_76,
		INIT_77 => INIT_77,
		INIT_78 => INIT_78,
		INIT_79 => INIT_79,
		INIT_7A => INIT_7A,
		INIT_7B => INIT_7B,
		INIT_7C => INIT_7C,
		INIT_7D => INIT_7D,
		INIT_7E => INIT_7E,
		INIT_7F => INIT_7F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INITP_08 => INITP_08,
		INITP_09 => INITP_09,
		INITP_0A => INITP_0A,
		INITP_0B => INITP_0B,
		INITP_0C => INITP_0C,
		INITP_0D => INITP_0D,
		INITP_0E => INITP_0E,
		INITP_0F => INITP_0F,
		INIT  => INIT,
                INIT_FILE => INIT_FILE,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SIM_MODE => SIM_MODE,
		SRVAL => SRVAL
                )
  
        port map (
                DI => di_pattern,
                DIP => dip_pattern,
                RDADDR => RDADDR,
                RDCLK => RDCLK,
                RDEN => RDEN,
                SSR => RST,
                WRADDR => WRADDR,
                WRCLK => WRCLK,
                WREN => WREN,
                WE => we_pattern,
                DO => do_pattern,
                DOP => dop_pattern,
                DBITERR => OPEN,
                ECCPARITY => OPEN,
                REGCE => REGCE,
                SBITERR => OPEN
        );

     end generate ramb36_sdp;
   end generate sdp_v5;
  -- end generate virtex5
  -- begin generate virtex6
   sdp_bl : if DEVICE = "VIRTEX6" generate

      ramb18_dp_bl : if (BRAM_SIZE = "18Kb" and READ_WIDTH <= 18 and WRITE_WIDTH <= 18) generate 
      begin
        ram18_bl : RAMB18E1 
          generic map(
                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_A => INIT(0 to 19),
                INIT_B => INIT(0 to 19),
                INIT_FILE => INIT_FILE,
                INIT_00 => INIT_00,
                INIT_01 => INIT_01,
                INIT_02 => INIT_02,
                INIT_03 => INIT_03,
                INIT_04 => INIT_04,
                INIT_05 => INIT_05,
                INIT_06 => INIT_06,
                INIT_07 => INIT_07,
                INIT_08 => INIT_08,
                INIT_09 => INIT_09,
                INIT_0A => INIT_0A,
                INIT_0B => INIT_0B,
                INIT_0C => INIT_0C,
                INIT_0D => INIT_0D,
                INIT_0E => INIT_0E,
                INIT_0F => INIT_0F,
                INIT_10 => INIT_10,
                INIT_11 => INIT_11,
                INIT_12 => INIT_12,
                INIT_13 => INIT_13,
                INIT_14 => INIT_14,
                INIT_15 => INIT_15,
                INIT_16 => INIT_16,
                INIT_17 => INIT_17,
                INIT_18 => INIT_18,
                INIT_19 => INIT_19,
                INIT_1A => INIT_1A,
                INIT_1B => INIT_1B,
                INIT_1C => INIT_1C,
                INIT_1D => INIT_1D,
                INIT_1E => INIT_1E,
                INIT_1F => INIT_1F,
                INIT_20 => INIT_20,
                INIT_21 => INIT_21,
                INIT_22 => INIT_22,
                INIT_23 => INIT_23,
                INIT_24 => INIT_24,
                INIT_25 => INIT_25,
                INIT_26 => INIT_26,
                INIT_27 => INIT_27,
                INIT_28 => INIT_28,
                INIT_29 => INIT_29,
                INIT_2A => INIT_2A,
                INIT_2B => INIT_2B,
                INIT_2C => INIT_2C,
                INIT_2D => INIT_2D,
                INIT_2E => INIT_2E,
                INIT_2F => INIT_2F,
                INIT_30 => INIT_30,
                INIT_31 => INIT_31,
                INIT_32 => INIT_32,
                INIT_33 => INIT_33,
                INIT_34 => INIT_34,
                INIT_35 => INIT_35,
                INIT_36 => INIT_36,
                INIT_37 => INIT_37,
                INIT_38 => INIT_38,
                INIT_39 => INIT_39,
                INIT_3A => INIT_3A,
                INIT_3B => INIT_3B,
                INIT_3C => INIT_3C,
                INIT_3D => INIT_3D,
                INIT_3E => INIT_3E,
                INIT_3F => INIT_3F,
                INITP_00 => INITP_00,
                INITP_01 => INITP_01,
                INITP_02 => INITP_02,
                INITP_03 => INITP_03,
                INITP_04 => INITP_04,
                INITP_05 => INITP_05,
                INITP_06 => INITP_06,
                INITP_07 => INITP_07,
                RAM_MODE => "TDP",
                READ_WIDTH_A => rdwidth,
                SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SRVAL_A => SRVAL(0 to 19),
                SRVAL_B => SRVAL(0 to 19),
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST",
                WRITE_WIDTH_B => wrwidth
              )
          port map (
                ADDRARDADDR => rdaddr_pattern,
                ADDRBWRADDR => wraddr_pattern,
                CLKARDCLK => RDCLK,
                CLKBWRCLK => WRCLK,
                DIADI  => X"0000",
                DIBDI => di_pattern,
                DIPADIP => "00",
                DIPBDIP => dip_pattern,
                ENARDEN => RDEN,
                ENBWREN => WREN,
                REGCEAREGCE => REGCE,
                REGCEB => '0',
                RSTREGARSTREG => rstreg_pattern,
                RSTREGB => '0',
                RSTRAMARSTRAM => rstram_pattern,
                RSTRAMB => '0',
                WEA => "00",
                WEBWE => we_pattern,
                DOADO => do_pattern,
                DOBDO => OPEN,
                DOPADOP => dop_pattern,
                DOPBDOP => OPEN
        );

    end generate ramb18_dp_bl;

    ramb18_sdp_bl : if (BRAM_SIZE = "18Kb" and ( (READ_WIDTH > 18 and READ_WIDTH <= 36) or (WRITE_WIDTH > 18 and WRITE_WIDTH <= 36) )) generate 
    begin
      ram18sd_bl : RAMB18E1
        generic map (

                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_A => init_a_pattern,
                INIT_B => init_b_pattern,
                INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
                INIT_FILE => INIT_FILE,
                RAM_MODE => "SDP",
                READ_WIDTH_A => rdwidth,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
		SRVAL_A => srval_a_pattern,
		SRVAL_B => srval_b_pattern,
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST",
                WRITE_WIDTH_B => wrwidth
                )
  
        port map (
                ADDRARDADDR => rdaddr_pattern,
                ADDRBWRADDR => wraddr_pattern,
                CLKARDCLK => RDCLK,
                CLKBWRCLK => WRCLK,
                DIADI  => di_pattern(15 downto 0),
                DIBDI => di_pattern(31 downto 16),
                DIPADIP => dip_pattern(1 downto 0),
                DIPBDIP => dip_pattern(3 downto 2),
                ENARDEN => RDEN,
                ENBWREN => WREN,
                REGCEAREGCE => REGCE,
                REGCEB => '0',
                RSTREGARSTREG => rstreg_pattern,
                RSTREGB => '0',
                RSTRAMARSTRAM => rstram_pattern,
                RSTRAMB => '0',
                WEA => "00",
                WEBWE => we_pattern,
                DOADO => do_pattern(15 downto 0),
                DOBDO => do_pattern(31 downto 16),
                DOPADOP => dop_pattern(1 downto 0),
                DOPBDOP => dop_pattern(3 downto 2)
        );

    end generate ramb18_sdp_bl;
    ramb36_dp_bl : if (BRAM_SIZE = "36Kb" and READ_WIDTH <= 36 and WRITE_WIDTH <= 36) generate 
      begin
        ram36_bl : RAMB36E1
          generic map (

                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
		INIT_A  => INIT(0 to 35),
		INIT_B  => INIT(0 to 35),
                INIT_FILE => INIT_FILE,
		INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INIT_40 => INIT_40,
		INIT_41 => INIT_41,
		INIT_42 => INIT_42,
		INIT_43 => INIT_43,
		INIT_44 => INIT_44,
		INIT_45 => INIT_45,
		INIT_46 => INIT_46,
		INIT_47 => INIT_47,
		INIT_48 => INIT_48,
		INIT_49 => INIT_49,
		INIT_4A => INIT_4A,
		INIT_4B => INIT_4B,
		INIT_4C => INIT_4C,
		INIT_4D => INIT_4D,
		INIT_4E => INIT_4E,
		INIT_4F => INIT_4F,
		INIT_50 => INIT_50,
		INIT_51 => INIT_51,
		INIT_52 => INIT_52,
		INIT_53 => INIT_53,
		INIT_54 => INIT_54,
		INIT_55 => INIT_55,
		INIT_56 => INIT_56,
		INIT_57 => INIT_57,
		INIT_58 => INIT_58,
		INIT_59 => INIT_59,
		INIT_5A => INIT_5A,
		INIT_5B => INIT_5B,
		INIT_5C => INIT_5C,
		INIT_5D => INIT_5D,
		INIT_5E => INIT_5E,
		INIT_5F => INIT_5F,
		INIT_60 => INIT_60,
		INIT_61 => INIT_61,
		INIT_62 => INIT_62,
		INIT_63 => INIT_63,
		INIT_64 => INIT_64,
		INIT_65 => INIT_65,
		INIT_66 => INIT_66,
		INIT_67 => INIT_67,
		INIT_68 => INIT_68,
		INIT_69 => INIT_69,
		INIT_6A => INIT_6A,
		INIT_6B => INIT_6B,
		INIT_6C => INIT_6C,
		INIT_6D => INIT_6D,
		INIT_6E => INIT_6E,
		INIT_6F => INIT_6F,
		INIT_70 => INIT_70,
		INIT_71 => INIT_71,
		INIT_72 => INIT_72,
		INIT_73 => INIT_73,
		INIT_74 => INIT_74,
		INIT_75 => INIT_75,
		INIT_76 => INIT_76,
		INIT_77 => INIT_77,
		INIT_78 => INIT_78,
		INIT_79 => INIT_79,
		INIT_7A => INIT_7A,
		INIT_7B => INIT_7B,
		INIT_7C => INIT_7C,
		INIT_7D => INIT_7D,
		INIT_7E => INIT_7E,
		INIT_7F => INIT_7F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INITP_08 => INITP_08,
		INITP_09 => INITP_09,
		INITP_0A => INITP_0A,
		INITP_0B => INITP_0B,
		INITP_0C => INITP_0C,
		INITP_0D => INITP_0D,
		INITP_0E => INITP_0E,
		INITP_0F => INITP_0F,
                RAM_MODE => "TDP",
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
		SRVAL_A => SRVAL(0 to 35),
		SRVAL_B => SRVAL(0 to 35),
                READ_WIDTH_A => rdwidth,
		WRITE_MODE_B => "READ_FIRST",                
                WRITE_WIDTH_B => wrwidth         

                )
           port map (
                ADDRARDADDR => rdaddr_pattern,
                ADDRBWRADDR => wraddr_pattern,
                CASCADEINA => '0',
                CASCADEINB => '0',
                CLKARDCLK => RDCLK,
                CLKBWRCLK => WRCLK,
                DIADI  => X"00000000",
                DIBDI => di_pattern,
                DIPADIP => "0000",
                DIPBDIP => dip_pattern,
                ENARDEN => RDEN,
                ENBWREN => WREN,
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                REGCEAREGCE => REGCE,
                REGCEB => '0',
                RSTREGARSTREG => rstreg_pattern,
                RSTREGB => '0',
                RSTRAMARSTRAM => rstram_pattern,
                RSTRAMB => '0',
                WEA => "0000",
                WEBWE => we_pattern,
                CASCADEOUTA => OPEN,
                CASCADEOUTB => OPEN,
                DOADO => do_pattern,
                DOBDO => OPEN,
                DOPADOP => dop_pattern,
                DOPBDOP => OPEN,
                DBITERR => OPEN,
                ECCPARITY => OPEN,
                RDADDRECC => OPEN
        );

    end generate ramb36_dp_bl;
    ramb36_sdp_bl : if (BRAM_SIZE = "36Kb" and ( (WRITE_WIDTH > 36 and WRITE_WIDTH <= 72) and (READ_WIDTH <= 72) )) generate 
    begin
      ram36sd_bl : RAMB36E1
        generic map (

                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INIT_40 => INIT_40,
		INIT_41 => INIT_41,
		INIT_42 => INIT_42,
		INIT_43 => INIT_43,
		INIT_44 => INIT_44,
		INIT_45 => INIT_45,
		INIT_46 => INIT_46,
		INIT_47 => INIT_47,
		INIT_48 => INIT_48,
		INIT_49 => INIT_49,
		INIT_4A => INIT_4A,
		INIT_4B => INIT_4B,
		INIT_4C => INIT_4C,
		INIT_4D => INIT_4D,
		INIT_4E => INIT_4E,
		INIT_4F => INIT_4F,
		INIT_50 => INIT_50,
		INIT_51 => INIT_51,
		INIT_52 => INIT_52,
		INIT_53 => INIT_53,
		INIT_54 => INIT_54,
		INIT_55 => INIT_55,
		INIT_56 => INIT_56,
		INIT_57 => INIT_57,
		INIT_58 => INIT_58,
		INIT_59 => INIT_59,
		INIT_5A => INIT_5A,
		INIT_5B => INIT_5B,
		INIT_5C => INIT_5C,
		INIT_5D => INIT_5D,
		INIT_5E => INIT_5E,
		INIT_5F => INIT_5F,
		INIT_60 => INIT_60,
		INIT_61 => INIT_61,
		INIT_62 => INIT_62,
		INIT_63 => INIT_63,
		INIT_64 => INIT_64,
		INIT_65 => INIT_65,
		INIT_66 => INIT_66,
		INIT_67 => INIT_67,
		INIT_68 => INIT_68,
		INIT_69 => INIT_69,
		INIT_6A => INIT_6A,
		INIT_6B => INIT_6B,
		INIT_6C => INIT_6C,
		INIT_6D => INIT_6D,
		INIT_6E => INIT_6E,
		INIT_6F => INIT_6F,
		INIT_70 => INIT_70,
		INIT_71 => INIT_71,
		INIT_72 => INIT_72,
		INIT_73 => INIT_73,
		INIT_74 => INIT_74,
		INIT_75 => INIT_75,
		INIT_76 => INIT_76,
		INIT_77 => INIT_77,
		INIT_78 => INIT_78,
		INIT_79 => INIT_79,
		INIT_7A => INIT_7A,
		INIT_7B => INIT_7B,
		INIT_7C => INIT_7C,
		INIT_7D => INIT_7D,
		INIT_7E => INIT_7E,
		INIT_7F => INIT_7F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INITP_08 => INITP_08,
		INITP_09 => INITP_09,
		INITP_0A => INITP_0A,
		INITP_0B => INITP_0B,
		INITP_0C => INITP_0C,
		INITP_0D => INITP_0D,
		INITP_0E => INITP_0E,
		INITP_0F => INITP_0F,
		INIT_A  => init_a_pattern,
		INIT_B  => init_b_pattern,
                INIT_FILE => INIT_FILE,
                RAM_MODE => "SDP",
                READ_WIDTH_A => rdwidth,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
		SRVAL_A => srval_a_pattern,
		SRVAL_B => srval_b_pattern,
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST",
                WRITE_WIDTH_B => wrwidth
                )
        
        port map (
                ADDRARDADDR => rdaddr_pattern,
                ADDRBWRADDR => wraddr_pattern,
                CASCADEINA => '0',
                CASCADEINB => '0',
                CLKARDCLK => RDCLK,
                CLKBWRCLK => WRCLK,
                DIADI => di_pattern(31 downto 0),
                DIBDI  => di_pattern(63 downto 32),
                DIPADIP => dip_pattern(3 downto 0),
                DIPBDIP => dip_pattern(7 downto 4),
                ENARDEN => RDEN,
                ENBWREN => WREN,
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                REGCEAREGCE => REGCE,
                REGCEB => '0',
                RSTREGARSTREG => rstreg_pattern,
                RSTREGB => '0',
                RSTRAMARSTRAM => rstram_pattern,
                RSTRAMB => '0',
                WEA => "0000",
                WEBWE => we_pattern,
                CASCADEOUTA => OPEN,
                CASCADEOUTB => OPEN,
                DOADO => do_pattern(31 downto 0),
                DOBDO => do_pattern(63 downto 32),
                DOPADOP => dop_pattern(3 downto 0),
                DOPBDOP => dop_pattern(7 downto 4),
                DBITERR => OPEN,
                ECCPARITY => OPEN,
                RDADDRECC => OPEN
        ); 

     end generate ramb36_sdp_bl;
     ramb36_sdp_bl_1 : if (BRAM_SIZE = "36Kb" and ( (WRITE_WIDTH <= 36) and (READ_WIDTH > 36 and READ_WIDTH <= 72) )) generate 
    begin
      ram36sd_bl_1 : RAMB36E1
        generic map (

                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INIT_40 => INIT_40,
		INIT_41 => INIT_41,
		INIT_42 => INIT_42,
		INIT_43 => INIT_43,
		INIT_44 => INIT_44,
		INIT_45 => INIT_45,
		INIT_46 => INIT_46,
		INIT_47 => INIT_47,
		INIT_48 => INIT_48,
		INIT_49 => INIT_49,
		INIT_4A => INIT_4A,
		INIT_4B => INIT_4B,
		INIT_4C => INIT_4C,
		INIT_4D => INIT_4D,
		INIT_4E => INIT_4E,
		INIT_4F => INIT_4F,
		INIT_50 => INIT_50,
		INIT_51 => INIT_51,
		INIT_52 => INIT_52,
		INIT_53 => INIT_53,
		INIT_54 => INIT_54,
		INIT_55 => INIT_55,
		INIT_56 => INIT_56,
		INIT_57 => INIT_57,
		INIT_58 => INIT_58,
		INIT_59 => INIT_59,
		INIT_5A => INIT_5A,
		INIT_5B => INIT_5B,
		INIT_5C => INIT_5C,
		INIT_5D => INIT_5D,
		INIT_5E => INIT_5E,
		INIT_5F => INIT_5F,
		INIT_60 => INIT_60,
		INIT_61 => INIT_61,
		INIT_62 => INIT_62,
		INIT_63 => INIT_63,
		INIT_64 => INIT_64,
		INIT_65 => INIT_65,
		INIT_66 => INIT_66,
		INIT_67 => INIT_67,
		INIT_68 => INIT_68,
		INIT_69 => INIT_69,
		INIT_6A => INIT_6A,
		INIT_6B => INIT_6B,
		INIT_6C => INIT_6C,
		INIT_6D => INIT_6D,
		INIT_6E => INIT_6E,
		INIT_6F => INIT_6F,
		INIT_70 => INIT_70,
		INIT_71 => INIT_71,
		INIT_72 => INIT_72,
		INIT_73 => INIT_73,
		INIT_74 => INIT_74,
		INIT_75 => INIT_75,
		INIT_76 => INIT_76,
		INIT_77 => INIT_77,
		INIT_78 => INIT_78,
		INIT_79 => INIT_79,
		INIT_7A => INIT_7A,
		INIT_7B => INIT_7B,
		INIT_7C => INIT_7C,
		INIT_7D => INIT_7D,
		INIT_7E => INIT_7E,
		INIT_7F => INIT_7F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
		INITP_08 => INITP_08,
		INITP_09 => INITP_09,
		INITP_0A => INITP_0A,
		INITP_0B => INITP_0B,
		INITP_0C => INITP_0C,
		INITP_0D => INITP_0D,
		INITP_0E => INITP_0E,
		INITP_0F => INITP_0F,
		INIT_A  => init_a_pattern,
		INIT_B  => init_b_pattern,
                INIT_FILE => INIT_FILE,
                RAM_MODE => "SDP",
                READ_WIDTH_A => rdwidth,
		SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
		SRVAL_A => srval_a_pattern,
		SRVAL_B => srval_b_pattern,
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST",
                WRITE_WIDTH_B => wrwidth
                )
        
        port map (
                ADDRARDADDR => rdaddr_pattern,
                ADDRBWRADDR => wraddr_pattern,
                CASCADEINA => '0',
                CASCADEINB => '0',
                CLKARDCLK => RDCLK,
                CLKBWRCLK => WRCLK,
                DIADI => di_pattern(63 downto 32),
                DIBDI  => di_pattern(31 downto 0),
                DIPADIP => dip_pattern(7 downto 4),
                DIPBDIP => dip_pattern(3 downto 0),
                ENARDEN => RDEN,
                ENBWREN => WREN,
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                REGCEAREGCE => REGCE,
                REGCEB => '0',
                RSTREGARSTREG => rstreg_pattern,
                RSTREGB => '0',
                RSTRAMARSTRAM => rstram_pattern,
                RSTRAMB => '0',
                WEA => "0000",
                WEBWE => we_pattern,
                CASCADEOUTA => OPEN,
                CASCADEOUTB => OPEN,
                DOADO => do_pattern(31 downto 0),
                DOBDO => do_pattern(63 downto 32),
                DOPADOP => dop_pattern(3 downto 0),
                DOPBDOP => dop_pattern(7 downto 4),
                DBITERR => OPEN,
                ECCPARITY => OPEN,
                RDADDRECC => OPEN
        ); 

     end generate ramb36_sdp_bl_1;
   end generate sdp_bl;
  -- end generate virtex6
  -- begin generate spartan6
     ramb_st : if DEVICE = "SPARTAN6" generate 
       ramb9_dp_st : if (BRAM_SIZE = "9Kb" and WRITE_WIDTH <= 18)  generate 
      begin
        ram9_st : RAMB8BWER 
          generic map(
                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_A => INIT(0 to 19),
                INIT_B => INIT(0 to 19),
                INIT_00 => INIT_00,
                INIT_01 => INIT_01,
                INIT_02 => INIT_02,
                INIT_03 => INIT_03,
                INIT_04 => INIT_04,
                INIT_05 => INIT_05,
                INIT_06 => INIT_06,
                INIT_07 => INIT_07,
                INIT_08 => INIT_08,
                INIT_09 => INIT_09,
                INIT_0A => INIT_0A,
                INIT_0B => INIT_0B,
                INIT_0C => INIT_0C,
                INIT_0D => INIT_0D,
                INIT_0E => INIT_0E,
                INIT_0F => INIT_0F,
                INIT_10 => INIT_10,
                INIT_11 => INIT_11,
                INIT_12 => INIT_12,
                INIT_13 => INIT_13,
                INIT_14 => INIT_14,
                INIT_15 => INIT_15,
                INIT_16 => INIT_16,
                INIT_17 => INIT_17,
                INIT_18 => INIT_18,
                INIT_19 => INIT_19,
                INIT_1A => INIT_1A,
                INIT_1B => INIT_1B,
                INIT_1C => INIT_1C,
                INIT_1D => INIT_1D,
                INIT_1E => INIT_1E,
                INIT_1F => INIT_1F,
                INITP_00 => INITP_00,
                INITP_01 => INITP_01,
                INITP_02 => INITP_02,
                INITP_03 => INITP_03,
                DATA_WIDTH_A => rdwidth,
                DATA_WIDTH_B => wrwidth,
                RAM_MODE => "TDP",
                SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SRVAL_A => SRVAL(0 to 19),
                SRVAL_B => SRVAL(0 to 19),
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST"
              )
          port map (
                ADDRAWRADDR => wraddr_pattern,
                ADDRBRDADDR => rdaddr_pattern,
                CLKAWRCLK => WRCLK,
                CLKBRDCLK => RDCLK,
                DIADI  => di_pattern,
                DIBDI => X"0000",
                DIPADIP => dip_pattern,
                DIPBDIP => "00",
                ENAWREN => WREN,
                ENBRDEN => RDEN,
                REGCEA => '0',
                REGCEBREGCE => REGCE,
                RSTA => '0',
                RSTBRST => RST,
                WEAWEL => we_pattern,
                WEBWEU => "00",
                DOADO => OPEN,
                DOBDO => do_pattern,
                DOPADOP => OPEN,
                DOPBDOP => dop_pattern
        );

    end generate ramb9_dp_st; 
     ramb9_sdp_st : if (BRAM_SIZE = "9Kb" and WRITE_WIDTH > 18 and WRITE_WIDTH <= 36)  generate 
      begin
        ram9_st : RAMB8BWER 
          generic map(
                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
                INIT_A => init_a_pattern,
                INIT_B => init_b_pattern,
                INIT_00 => INIT_00,
                INIT_01 => INIT_01,
                INIT_02 => INIT_02,
                INIT_03 => INIT_03,
                INIT_04 => INIT_04,
                INIT_05 => INIT_05,
                INIT_06 => INIT_06,
                INIT_07 => INIT_07,
                INIT_08 => INIT_08,
                INIT_09 => INIT_09,
                INIT_0A => INIT_0A,
                INIT_0B => INIT_0B,
                INIT_0C => INIT_0C,
                INIT_0D => INIT_0D,
                INIT_0E => INIT_0E,
                INIT_0F => INIT_0F,
                INIT_10 => INIT_10,
                INIT_11 => INIT_11,
                INIT_12 => INIT_12,
                INIT_13 => INIT_13,
                INIT_14 => INIT_14,
                INIT_15 => INIT_15,
                INIT_16 => INIT_16,
                INIT_17 => INIT_17,
                INIT_18 => INIT_18,
                INIT_19 => INIT_19,
                INIT_1A => INIT_1A,
                INIT_1B => INIT_1B,
                INIT_1C => INIT_1C,
                INIT_1D => INIT_1D,
                INIT_1E => INIT_1E,
                INIT_1F => INIT_1F,
                INITP_00 => INITP_00,
                INITP_01 => INITP_01,
                INITP_02 => INITP_02,
                INITP_03 => INITP_03,
                DATA_WIDTH_A => rdwidth,
                DATA_WIDTH_B => wrwidth,
                RAM_MODE => "SDP",
                SIM_COLLISION_CHECK => SIM_COLLISION_CHECK,
                SRVAL_A => srval_a_pattern,
                SRVAL_B => srval_b_pattern,
                WRITE_MODE_A => "READ_FIRST",
                WRITE_MODE_B => "READ_FIRST"
              )
          port map (
                ADDRAWRADDR => wraddr_pattern,
                ADDRBRDADDR => rdaddr_pattern,
                CLKAWRCLK => WRCLK,
                CLKBRDCLK => RDCLK,
                DIADI  => di_pattern(15 downto 0),
                DIBDI => di_pattern(31 downto 16),
                DIPADIP => dip_pattern(1 downto 0),
                DIPBDIP => dip_pattern(3 downto 2),
                ENAWREN => WREN,
                ENBRDEN => RDEN,
                REGCEA => REGCE,
                REGCEBREGCE => REGCE,
                RSTA => '0',
                RSTBRST => RST,
                WEAWEL => we_pattern(1 downto 0),
                WEBWEU => we_pattern(3 downto 2),
                DOADO => do_pattern(15 downto 0),
                DOBDO => do_pattern(31 downto 16),
                DOPADOP => dop_pattern(1 downto 0),
                DOPBDOP => dop_pattern(3 downto 2)
        );

    end generate ramb9_sdp_st;
    ramb18_sdp_st : if BRAM_SIZE = "18Kb" generate 
      begin
        ram18_st : RAMB16BWER
          generic map (

                DOA_REG => DO_REG,
                DOB_REG => DO_REG,
		INIT_A  => INIT(0 to 35),
		INIT_B  => INIT(0 to 35),
		INIT_00 => INIT_00,
		INIT_01 => INIT_01,
		INIT_02 => INIT_02,
		INIT_03 => INIT_03,
		INIT_04 => INIT_04,
		INIT_05 => INIT_05,
		INIT_06 => INIT_06,
		INIT_07 => INIT_07,
		INIT_08 => INIT_08,
		INIT_09 => INIT_09,
		INIT_0A => INIT_0A,
		INIT_0B => INIT_0B,
		INIT_0C => INIT_0C,
		INIT_0D => INIT_0D,
		INIT_0E => INIT_0E,
		INIT_0F => INIT_0F,
		INIT_10 => INIT_10,
		INIT_11 => INIT_11,
		INIT_12 => INIT_12,
		INIT_13 => INIT_13,
		INIT_14 => INIT_14,
		INIT_15 => INIT_15,
		INIT_16 => INIT_16,
		INIT_17 => INIT_17,
		INIT_18 => INIT_18,
		INIT_19 => INIT_19,
		INIT_1A => INIT_1A,
		INIT_1B => INIT_1B,
		INIT_1C => INIT_1C,
		INIT_1D => INIT_1D,
		INIT_1E => INIT_1E,
		INIT_1F => INIT_1F,
		INIT_20 => INIT_20,
		INIT_21 => INIT_21,
		INIT_22 => INIT_22,
		INIT_23 => INIT_23,
		INIT_24 => INIT_24,
		INIT_25 => INIT_25,
		INIT_26 => INIT_26,
		INIT_27 => INIT_27,
		INIT_28 => INIT_28,
		INIT_29 => INIT_29,
		INIT_2A => INIT_2A,
		INIT_2B => INIT_2B,
		INIT_2C => INIT_2C,
		INIT_2D => INIT_2D,
		INIT_2E => INIT_2E,
		INIT_2F => INIT_2F,
		INIT_30 => INIT_30,
		INIT_31 => INIT_31,
		INIT_32 => INIT_32,
		INIT_33 => INIT_33,
		INIT_34 => INIT_34,
		INIT_35 => INIT_35,
		INIT_36 => INIT_36,
		INIT_37 => INIT_37,
		INIT_38 => INIT_38,
		INIT_39 => INIT_39,
		INIT_3A => INIT_3A,
		INIT_3B => INIT_3B,
		INIT_3C => INIT_3C,
		INIT_3D => INIT_3D,
		INIT_3E => INIT_3E,
		INIT_3F => INIT_3F,
		INITP_00 => INITP_00,
		INITP_01 => INITP_01,
		INITP_02 => INITP_02,
		INITP_03 => INITP_03,
		INITP_04 => INITP_04,
		INITP_05 => INITP_05,
		INITP_06 => INITP_06,
		INITP_07 => INITP_07,
                SIM_DEVICE => "SPARTAN6",
		SRVAL_A => SRVAL(0 to 35),
		SRVAL_B => SRVAL(0 to 35),
                DATA_WIDTH_A => rdwidth,
                DATA_WIDTH_B => wrwidth,
		WRITE_MODE_A => "READ_FIRST",
		WRITE_MODE_B => "READ_FIRST"

                )
           port map (
                ADDRA => wraddr_pattern,
                ADDRB => rdaddr_pattern,
                CLKA => WRCLK,
                CLKB => RDCLK,
                DIA  => di_pattern,
                DIB  => X"00000000",
                DIPA => dip_pattern,
                DIPB => "0000",
                ENA => WREN,
                ENB => RDEN,
                REGCEA => '0',
                REGCEB => REGCE,
                RSTA => '0',
                RSTB => RST,
                WEA => we_pattern,
                WEB => "0000",
                DOA => OPEN,
                DOB => do_pattern,
                DOPA => OPEN,
                DOPB => dop_pattern
          );
    end generate ramb18_sdp_st;
   
  end generate ramb_st;
  -- end generate spartan6

 end bram_V;
