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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1S1B_GSR.v,v 1.8 2005/05/19 18:30:03 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1S1B_GSR (D0, D1, CK, SD, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D0, D1, CK, SD, PD, GSR, PUR;
  output Q;
  reg SR;
  reg notifier; 

  or INST47 (I29, PDI, SR);
  or INST34 (I31, I38, I40);
  and INST35 (I38, D0I, I43);
  buf INST981 (D0I, D0);
  and INST36 (I40, SDI, D1I);
  buf INST980 (SDI, SD);
  buf INST982 (D1I, D1);
  not INST37 (I43, SDI);
//  not INST50 (I45, GSR);
//---- Programmable GSR ----
  and (GP, GSR, PUR);
  not INST58 (I27, GP);
  not INST59 (I28, PUR);

  always @ (GSR or PUR  or I27 or I28) begin
    if (DISABLED_GSR == 0) begin
      SR = I27;
    end
    else if (DISABLED_GSR == 1)
      SR = I28;
  end
//--------------------------

  UDFDL3_UDP_X INST6 (Q, I29, I31, CK, notifier);
  buf INST997 (PDI, PD); 

endmodule

`endcelldefine
