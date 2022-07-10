// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/AOI42.v,v 1.2 2005/05/19 18:05:18 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.2 on Fri Aug  5 11:14:16 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module AOI42 (A1, A2, A3, A4, B1, B2, Z);
input  A1, A2, A3, A4, B1, B2;
output Z;
NR2 INST12 (.A(I2), .B(I3), .Z(Z));
AND2 INST5 (.A(B1), .B(B2), .Z(I3));
AND4 INST6 (.A(A1), .B(A2), .C(A3), .D(A4), .Z(I2));

endmodule

