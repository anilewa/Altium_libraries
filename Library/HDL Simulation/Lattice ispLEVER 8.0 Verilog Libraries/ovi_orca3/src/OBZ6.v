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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OBZ6.v,v 1.5 2005/05/19 18:30:38 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module OBZ6 (I, T, O);
  input  I, T;
  output O;

 `ifdef TSALL_SIGNAL
  wire TSALL = `TSALL_SIGNAL;
 `else
  pullup (weak1) (TSALL);
 `endif

  not INST1 (TO, T);
  and INST2 (T_AND, TO, TSALL);
  bufif1 INST5 (O, I, T_AND);


endmodule 

`endcelldefine
