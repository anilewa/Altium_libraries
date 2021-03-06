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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FD1P3BX.v,v 1.8 2005/05/19 18:29:42 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FD1P3BX (D, SP, CK, PD, Q, QN);
  parameter DISABLED_GSR = 0;
  defparam g.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, CK ,PD;
  output Q, QN;
  reg SRN;

  reg notifier; 

 `ifdef GSR_SIGNAL
  wire GSR = `GSR_SIGNAL;
 `else
  pullup (weak1) (GSR);
 `endif

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

  FD1P3BX_GSR  g (.D(D), .SP(SP), .CK(CK), .PD(PD), .GSR(GSR), .PUR(PUR), .Q(Q)); 

  not(QN,Q);

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR1, SRN);
  or INST1 (SR, PD, SR1);


endmodule

`endcelldefine
