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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1P3IZ.v,v 1.4 2005/05/19 18:05:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:46:54 1994 */
/* module compiled from "lsl2db 3.6.4" run */


`celldefine
module FD1P3IZ (D, SP, CK, CD, Q, QN);
input  D, SP, CK, CD;
output Q, QN;
reg notifier; 

`ifdef GSR_SIGNAL
wire GSR = `GSR_SIGNAL;
`else
pullup (weak1) (GSR);
`endif

FD1P3IZ_GSR  g (.D(D), .SP(SP), .CK(CK), .CD(CD), .GSR(GSR), .Q(Q), .QN()); 

not(QN,Q);


endmodule
`endcelldefine
