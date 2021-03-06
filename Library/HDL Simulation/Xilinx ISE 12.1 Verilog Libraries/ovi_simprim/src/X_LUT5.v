// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_LUT5.v,v 1.11 2007/06/05 00:00:54 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, ADRnc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1i (K.17)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  5-input Look-Up-Table with General Output
// /___/   /\     Filename : X_LUT5.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:56 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - ADRnitial version.
//    02/04/05 - Replace premitive with function; Remove buf.
//    01/07/06 - Add LOC Parameter (CR 222733)
//    06/04/07 - Add wire declaration to internal signal.
// End Revision

`timescale 1 ps/1 ps

module X_LUT5 (O, ADR0, ADR1, ADR2, ADR3, ADR4);

  parameter INIT = 32'h00000000;
  parameter LOC = "UNPLACED";

  output O;
  input ADR0, ADR1, ADR2, ADR3, ADR4;

  wire a0, a1, a2, a3, a4;
  wire o_out_tmp;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);
  buf b2 (a2, ADR2);
  buf b3 (a3, ADR3);
  buf b4 (a4, ADR4);
  buf b5 (O, o_out_tmp);

  reg o_out;
  reg tmp;

  assign o_out_tmp= o_out;

  always @( a4 or a3 or  a2 or  a1 or  a0 )  begin

    tmp =  a0 ^ a1  ^ a2 ^ a3 ^ a4;

    if ( tmp == 0 || tmp == 1)

        o_out = INIT[{a4, a3, a2, a1, a0}];

    else

      o_out =  lut4_mux4 (
                        { lut6_mux8 ( INIT[31:24], {a2, a1, a0}),
                          lut6_mux8 ( INIT[23:16], {a2, a1, a0}),
                          lut6_mux8 ( INIT[15:8], {a2, a1, a0}),
                          lut6_mux8 ( INIT[7:0], {a2, a1, a0}) }, { a4, a3});
  end


  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	(ADR4 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify


  function lut6_mux8;
  input [7:0] d;
  input [2:0] s;
   
  begin

       if ((s[2]^s[1]^s[0] ==1) || (s[2]^s[1]^s[0] ==0))
           
           lut6_mux8 = d[s];

         else
           if ( ~(|d))
                 lut6_mux8 = 1'b0;
           else if ((&d))
                 lut6_mux8 = 1'b1;
           else if (((s[1]^s[0] ==1'b1) || (s[1]^s[0] ==1'b0)) && (d[{1'b0,s[1:0]}]==d[{1'b1,s[1:0]}]))
                 lut6_mux8 = d[{1'b0,s[1:0]}];
           else if (((s[2]^s[0] ==1) || (s[2]^s[0] ==0)) && (d[{s[2],1'b0,s[0]}]==d[{s[2],1'b1,s[0]}]))
                 lut6_mux8 = d[{s[2],1'b0,s[0]}];
           else if (((s[2]^s[1] ==1) || (s[2]^s[1] ==0)) && (d[{s[2],s[1],1'b0}]==d[{s[2],s[1],1'b1}]))
                 lut6_mux8 = d[{s[2],s[1],1'b0}];
           else if (((s[0] ==1) || (s[0] ==0)) && (d[{1'b0,1'b0,s[0]}]==d[{1'b0,1'b1,s[0]}]) &&
              (d[{1'b0,1'b0,s[0]}]==d[{1'b1,1'b0,s[0]}]) && (d[{1'b0,1'b0,s[0]}]==d[{1'b1,1'b1,s[0]}]))
                 lut6_mux8 = d[{1'b0,1'b0,s[0]}];
           else if (((s[1] ==1) || (s[1] ==0)) && (d[{1'b0,s[1],1'b0}]==d[{1'b0,s[1],1'b1}]) &&
              (d[{1'b0,s[1],1'b0}]==d[{1'b1,s[1],1'b0}]) && (d[{1'b0,s[1],1'b0}]==d[{1'b1,s[1],1'b1}]))
                 lut6_mux8 = d[{1'b0,s[1],1'b0}];
           else if (((s[2] ==1) || (s[2] ==0)) && (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b0,1'b1}]) &&
              (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b1,1'b0}]) && (d[{s[2],1'b0,1'b0}]==d[{s[2],1'b1,1'b1}]))
                 lut6_mux8 = d[{s[2],1'b0,1'b0}];
           else
                 lut6_mux8 = 1'bx;
   end
  endfunction


  function lut4_mux4;
  input [3:0] d;
  input [1:0] s;
   
  begin

       if ((s[1]^s[0] ==1) || (s[1]^s[0] ==0))

           lut4_mux4 = d[s];

         else if ((d[0] ^ d[1]) == 0 && (d[2] ^ d[3]) == 0 && (d[0] ^ d[2]) == 0)
           lut4_mux4 = d[0];
         else if ((s[1] == 0) && (d[0] == d[1]))
           lut4_mux4 = d[0];
         else if ((s[1] == 1) && (d[2] == d[3]))
           lut4_mux4 = d[2];
         else if ((s[0] == 0) && (d[0] == d[2]))
           lut4_mux4 = d[0];
         else if ((s[0] == 1) && (d[1] == d[3]))
           lut4_mux4 = d[1];
         else
           lut4_mux4 = 1'bx;

   end
  endfunction

endmodule
