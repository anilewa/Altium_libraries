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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FADD8O.v,v 1.6 2005/05/19 18:29:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FADD8O (A0, A1, A2, A3, A4, A5, A6, A7, B0, 
       B1, B2, B3, B4, B5, B6, B7, CI, OFL, S0, 
       S1, S2, S3, S4, S5, S6, S7);
input  A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, CI;
output OFL, S0, S1, S2, S3, S4, S5, S6, S7;
FAD4INT INST1 (.A0(A0), .A1(A1), .A2(A2), .A3(A3), .B0(B0),
      .B1(B1), .B2(B2), .B3(B3), .CI(CI), .CO(CO_INT),
      .S0(S0), .S1(S1), .S2(S2), .S3(S3));
FAD4OINT INST2 (.A0(A4), .A1(A5), .A2(A6), .A3(A7), .B0(B4),
      .B1(B5), .B2(B6), .B3(B7), .CI(CO_INT), .OFL(OFL),
      .S0(S4), .S1(S5), .S2(S6), .S3(S7));


endmodule

`endcelldefine
