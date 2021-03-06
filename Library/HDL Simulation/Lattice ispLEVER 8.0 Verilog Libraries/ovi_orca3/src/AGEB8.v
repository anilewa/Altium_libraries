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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/AGEB8.v,v 1.6 2005/05/19 18:29:08 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module AGEB8 (A0, A1, A2, A3, A4, A5, A6, A7, B0, 
       B1, B2, B3, B4, B5, B6, B7, CI, GE);
input  A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, CI;
output GE;
AG4INT INST1 (.A0(A0), .A1(A1), .A2(A2), .A3(A3), .B0(B0),
      .B1(B1), .B2(B2), .B3(B3), .CI(CI), .GE(GE_INT));
AG4INT INST2 (.A0(A4), .A1(A5), .A2(A6), .A3(A7), .B0(B4),
      .B1(B5), .B2(B6), .B3(B7), .CI(GE_INT), .GE(GE));


endmodule

`endcelldefine

