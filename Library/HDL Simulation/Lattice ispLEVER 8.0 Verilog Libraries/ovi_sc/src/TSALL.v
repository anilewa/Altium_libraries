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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/TSALL.v,v 1.4 2005/05/31 21:16:13 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module TSALL (TSALLN);
  input TSALLN;

wire TSALLNET;

assign TSALLNET = TSALLN;

endmodule

`endcelldefine
