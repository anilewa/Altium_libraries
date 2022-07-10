// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/NAND3B3.v,v 1.4 2007/05/23 20:05:04 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  3-input NAND Gate
// /___/   /\     Filename : NAND3B3.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:03 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Added wire declaration for internal signals.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module NAND3B3 (O, I0, I1, I2);


    output O;

    input  I0, I1, I2;

    wire i0_inv;
    wire i1_inv;
    wire i2_inv;

    not N2 (i2_inv, I2);
    not N1 (i1_inv, I1);
    not N0 (i0_inv, I0);
    nand A1 (O, i0_inv, i1_inv, i2_inv);

    specify
	(I0 *> O) = (0, 0);
	(I1 *> O) = (0, 0);
	(I2 *> O) = (0, 0);
    endspecify

endmodule

`endcelldefine
