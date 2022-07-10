/********************************************************************
        Actel IGLOOPLUS Verilog Library
        NAME: iglooplus.v
        DATE: September 4, 2007
*********************************************************************/

`timescale 1 ns / 100 ps

//----------------------------------------------------------------------
//---             VERILOG LIBRRAY PRIMITIVE SECTION                     
//----------------------------------------------------------------------

 //---------------------------------------------------------------------
 // primitibe module (Dffpr) state table definition
 // FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
 //            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
 //            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).
 //            Enable active low.

 //----------------------------------------------------------------------
primitive Dffpr (Q, D, CLK, CLR, PRE, E, NOTIFIER_REG);
  output Q;
  input  NOTIFIER_REG;
  input  D, CLK, E, CLR, PRE;
  reg Q;

	table

	//  D   CLK   CLR  PRE   E  NOTIFIER_REG  :   Qt  :  Qt+1

	    1   (01)    1   1    0      ?         :   ?   :   1;  // clocked data
	    0   (01)    1   1    0      ?         :   ?   :   0;  // clocked data
	    1   (01)    1   1    x      ?         :   1   :   1;  // clocked data
	    0   (01)    1   1    x      ?         :   0   :   0; 
	    0   (01)    1   1    x      ?         :   1   :   x;
	    1   (01)    1   1    x      ?         :   0   :   x;
	    0   (01)    x   1    0      ?         :   ?   :   0;  // pessimism
	    1   (01)    1   x    0      ?         :   ?   :   1;  // pessimism
	    ?    ?      1   x    ?      ?         :   1   :   1;  // pessimism
	    0    ?      1   x    ?      ?         :   x   :   x;  // pessimism
	    ?    ?      1   x    ?      ?         :   0   :   x;
	    ?    ?      x   x    ?      ?         :   ?   :   x;
	    ?    ?      x   0    ?      ?         :   ?   :   x;
	    ?    ?      x   1    ?      ?         :   0   :   0;
	    ?    ?      x   1    ?      ?         :   1   :   x;
	    ?    ?      0   ?    ?      ?         :   ?   :   0;
	    ?    ?      1   0    ?      ?         :   ?   :   1;
	    1   (x1)    1   1    0      ?         :   1   :   1;  // reducing pessimism
	    0   (x1)    1   1    0      ?         :   0   :   0;
	    1   (0x)    1   1    0      ?         :   1   :   1;
     0   (0x)    1   1    0      ?         :   0   :   0;
	    1   (x1)    1   1    x      ?         :   1   :   1;  // reducing pessimism
	    0   (x1)    1   1    x      ?         :   0   :   0;
	    1   (0x)    1   1    x      ?         :   1   :   1;
	    0   (0x)    1   1    x      ?         :   0   :   0;
	    ?  (?1)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	    ?  (0x)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	    ?   ?       ?   ?    *      ?         :   ?   :   -;
	    ?   (?0)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	    ?   (1x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	    *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges
	    ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on
	    ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear
	    ?   ?       ?   ?    ?      *         :   ?   :   x;

	endtable
 endprimitive


 //---------------------------------------------------------------------
 // primitibe module (Dffpf) logic table definition
 // FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
 //            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
 //            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).
 //            Enable active low.

 //----------------------------------------------------------------------
primitive Dffpf (Q, D, CLK, CLR, PRE, E, NOTIFIER_REG);
  output Q;
  input  NOTIFIER_REG;
  input  D, CLK, E, CLR, PRE;
  reg Q;

 table

//    D   CLK     CLR PRE  E  NOTIFIER_REG  :   Qt  :  Qt+1	
	     1   (10)    1   1    0      ?         :   ?   :   1;  // clocked data
	     0   (10)    1   1    0      ?         :   ?   :   0;  // clocked data
	     1   (10)    1   1    x      ?         :   1   :   1;  // clocked data
	     0   (10)    1   1    x      ?         :   0   :   0;
	     0   (10)    1   x    x      ?         :   1   :   1;
	     0   (10)    1   1    x      ?         :   1   :   x;
	     1   (10)    1   1    x      ?         :   0   :   x;
	     0   (10)    1   x    0      ?         :   1   :   1;
	     0   (10)    x   1    0      ?         :   ?   :   0;
	     1   (10)    1   ?    0      ?         :   ?   :   1;  // pessimism
	     1    ?      1   x    0      ?         :   1   :   1;  // pessimism
	     ?    ?      1   x    ?      ?         :   0   :   x;
	     0    1      1   x    0      ?         :   1   :   1;  // pessimism
	     0    x      1 (?x)   0      ?         :   1   :   1;  // pessimism
	     0    ?      1 (?x)   0      ?         :   1   :   1;  // baoxian
	     0    ?      x   1    ?      ?         :   0   :   0;
	     0    ?      x   0    ?      ?         :   ?   :   x;
	     0    ?      x   1    ?      ?         :   1   :   x;
	     x    1      1   x    0      ?         :   1   :   1;  // pessimism
	     x    x      1 (?x)   0      ?         :   1   :   1;  // pessimism
	     x    0      1   x    0      ?         :   1   :   1;  // pessimism
	     1    ?      1   x    x      ?         :   1   :   1;  // pessimism
	     0    1      1   x    x      ?         :   1   :   1;  // pessimism
	     0    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
	     0    0      1 (?x)   x      ?         :   1   :   1;  // pessimism
	     x    1      1   x    x      ?         :   1   :   1;  // pessimism
	     x    ?      1   x    x      ?         :   1   :   1;  // pessimism
	     1    0      x   1    0      ?         :   0   :   0;  // pessimism
	     1    x    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     1    1    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     x    0      x   1    0      ?         :   0   :   0;  // pessimism
	     x    x    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     x    1    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     1    0      x   1    x      ?         :   0   :   0;  // pessimism
	     1    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     1    1    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     x    0      x   1    x      ?         :   0   :   0;  // pessimism
	     x    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     x    1    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     1   (1x)    1   1    0      ?         :   1   :   1;  // reducing pessimism
	     0   (1x)    1   1    0      ?         :   0   :   0;
	     1   (x0)    1   1    0      ?         :   1   :   1;
	     0   (x0)    1   1    0      ?         :   0   :   0;
	     1   (1x)    1   1    x      ?         :   1   :   1;  // reducing pessimism
	     0   (1x)    1   1    x      ?         :   0   :   0;
	     1   (x0)    1   1    x      ?         :   1   :   1;
	     0   (x0)    1   1    x      ?         :   0   :   0;
	     ?   ?       0   1    ?      ?         :   ?   :   0;  // asynchronous clear
	     ?   ?       1   0    ?      ?         :   ?   :   1;  // asynchronous set
	     ?  (?0)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	     ?  (1x)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	     ?   (?0)    x   1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?   (1x)    x   1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?    ?    (?x)  1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?   (?0)    1   x    1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?   (1x)    1   x    1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?    ?      1  (?x)  1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?   ?       ?   ?    *      ?         :   ?   :   -;
	     ?   (?1)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	     ?   (0x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	     *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges
	     ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on
	     ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear
	     ?   ?       0   0    ?      ?         :   ?   :   0; // CLR Priority (added 0n 11/12/97)
	     ?   ?       0   x    ?      ?         :   ?   :   0; // CLR Priority (added 0n 11/12/97)
	     ?   ?       ?   ?    ?      *         :   ?   :   x;
	endtable
 endprimitive

//--------------------------------------------------------------------
//-                    cell  UFPRB.v                                  -
//--------------------------------------------------------------------

primitive UFPRB (Q, D, CP, RB, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q;

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).

    table
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;

        0   (01)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    0      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    1    (?x)        ?          :   0   :   0;  // pessimism
        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism
        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;
        1   (0x)    1         ?          :   1   :   1;
        0   (0x)    1         ?          :   0   :   0;
        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear
        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear
        ?    ?      ?         *          :   ?   :   x;
    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFNRB.v                                  -
//--------------------------------------------------------------------
primitive UFNRB (Q, D, CP, RB, NOTIFIER_REG);
    output Q;
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q;
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).
    table
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1
        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;
        0   (10)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism
        1    1      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    0    (?x)        ?          :   0   :   0;  // pessimism
        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism
        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;
        1   (x0)    1         ?          :   1   :   1;
        0   (x0)    1         ?          :   0   :   0;
        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear
        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear
        ?    ?      ?         *          :   ?   :   x;
    endtable
endprimitive

//------------------------------------------------------------------------
// primitive DL2C_UDP functional description
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.
//-------------------------------------------------------------------------

primitive DL2C_UDP (q, d, g, c, p, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        g,              // CLOCK
        c,              // CLEAR ACTIVE HIGH
        p,              // SET ACTIVE HIGH
        NOTIFIER_REG;

 reg q;

    table
    //  D     G     C     P  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     1     ?     ?          :   ?   :   0;  // active low clear
        ?     ?     0     1     ?          :   ?   :   1;  // active high preset

        ?     1     0     0     ?          :   ?   :   -;  // latch
        0     0     0     0     ?          :   ?   :   0;  // transparent

        0     0     x     0     ?          :   ?   :   0;  // CLR==x
        ?     1     x     0     ?          :   0   :   0;  // CLR==x
        0     x     ?     0     ?          :   0   :   0;  // CLR,G==x

        1     x     0     ?     ?          :   1   :   1;  // PRE==x/?,G==x
        1     0     0     ?     ?          :   ?   :   1;  // PRE==x/?
        ?     1     0     x     ?          :   1   :   1;  // PRE==x
    endtable


endprimitive


//--------------------------------------------------------------------------
// primitive DLE3B_UDP
// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ACTIVE HIGH ASYNCHRONOUS PRESET.
//            TWO CLOCKS: E G
//-------------------------------------------------------------------------

primitive DLE3B_UDP (q, d, g, e, p, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        g,              // CLOCK
        e,              // CLEAR ACTIVE HIGH
        p,              // SET ACTIVE HIGH
        NOTIFIER_REG;

 reg    q;

    table
    //  D     G     E     P  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     ?     1     ?          :   ?   :   1;  // active high preset

        ?     1     ?     0     ?          :   ?   :   -;  // latch
        ?     ?     1     0     ?          :   ?   :   -;  // latch

        1     0     0     0     ?          :   ?   :   1;  // transparent
        0     0     0     0     ?          :   ?   :   0;  // transparent

        1     x     ?     0     ?          :   1   :   1;  // o/p mux pessimism
        1     ?     x     0     ?          :   1   :   1;  // o/p mux pessimism
        0     x     ?     0     ?          :   0   :   0;  // o/p mux pessimism
        0     ?     x     0     ?          :   0   :   0;  // o/p mux pessimism

        1     0     0     x     ?          :   ?   :   1;  // PRE==x
        ?     1     ?     x     ?          :   1   :   1;  // PRE==x
        ?     ?     1     x     ?          :   1   :   1;  // PRE==x
        1     0     x     x     ?          :   1   :   1;  // PRE==x
        1     x     0     x     ?          :   1   :   1;  // PRE==x
        1     x     x     x     ?          :   1   :   1;  // PRE==x
    endtable

endprimitive


//--------------------------------------------------------------------------
// primitive DLE2B_UDP
// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ACTIVE HIGH ASYNCHRONOUS CLEAR.
//            TWO CLOCKS: E G
//-------------------------------------------------------------------------

primitive DLE2B_UDP (q, d, e, g, c, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        e,              // CLOCK
        g,              // CLOCK
        c,              // CLEAR ACTIVE HIGH
        NOTIFIER_REG;

 reg    q;

    table
    //  D     E     G     C  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     ?     0     ?          :   ?   :   0;  // active low clear

        ?     ?     1     1     ?          :   ?   :   -;  // latch
        ?     1     ?     1     ?          :   ?   :   -;  // latch

        1     0     0     1     ?          :   ?   :   1;  // transparent
        0     0     0     1     ?          :   ?   :   0;  // transparent

        0     ?     ?     1     ?          :   0   :   0;  // o/p mux pessimism
        1     ?     ?     1     ?          :   1   :   1;  // o/p mux pessimism

        0     ?     ?     x     ?          :   0   :   0;  // CLR==x, o/p mux pessimism
        ?     ?     1     x     ?          :   0   :   0;  // PRE==x, o/p mux pessimism, latch
        ?     1     ?     x     ?          :   0   :   0;  // PRE==x, o/p mux pessimism, latch
        0     0     0     x     ?          :   ?   :   0;  // PRE==x, o/p mux pessimism
    endtable

endprimitive


//--------------------------------------------------------------------
//-                 primitive  JKFFF  -- falling edge                -
//--------------------------------------------------------------------

primitive JKFFF (Q, J, K, CP, RB, SB, NOTIFIER_REG);
    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
            CP,                                  // Clock.
            RB,                                  // Clear input
            SB;                                  // Set input
// FUNCTION :NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO X WHEN BOTH CLEAR AND SET ARE ACTIVE
    table
      // J   K   CP  RB   SB       NOTIFIER_REG  : Qtn : Qtn+1
         0   1  (10) 1    1           ?          :  ?  :   - ;    // Output retains the
         0   0  (10) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (10) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism
         1   1  (10) 1    1           ?          :  ?  :   1 ;
         1   1  (10) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimis
         1   0  (10) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (10) 1    1           ?          :  1  :   0 ;
         ?   0  (10) x    1           ?          :  1  :   0 ;    //pessimism
         1   ?  (10) 1    x           ?          :  0  :   1 ;
         0   1  (1x) 1    1           ?          :  ?  :   - ;    //possible clocked JK
         0   0  (1x) 1    1           ?          :  0  :   0 ;
         1   1  (1x) 1    1           ?          :  1  :   1 ;
         0   1  (x0) 1    1           ?          :  ?  :   - ;
         0   0  (x0) 1    1           ?          :  0  :   0 ;
         1   1  (x0) 1    1           ?          :  1  :   1 ;
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL
         x   1   f   1    1           ?          :  1  :   1 ;
         x   0   f   1    1           ?          :  1  :   0 ;
         0   x   f   1    1           ?          :  0  :   0 ;
         1   x   f   1    1           ?          :  0  :   1 ;
         x   1 (1x)  1    1           ?          :  1  :   1 ;    //possible clocked with
         0   x (1x)  1    1           ?          :  0  :   0 ;    //possible J & K
         x   1 (x0)  1    1           ?          :  1  :   1 ;
         0   x (x0)  1    1           ?          :  0  :   0 ;
         ?   ? (?1)  ?    ?           ?          :  ?  :   - ;
         ?   ? (0x)  ?    ?           ?          :  ?  :   - ;
         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;
    endtable
endprimitive

//--------------------------------------------------------------------
//-                   primitive  JKFFR                                -
//--------------------------------------------------------------------
primitive JKFFR (Q, J, K, CP, RB, SB, NOTIFIER_REG);
    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // Clock.
           RB,                                  // Clear input
           SB;                                  // Set input
// FUNCTION :POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO x WHEN BOTH CLEAR AND SET ARE ACTIVE
    table
      // J   K  CP  RB   SB        NOTIFIER_REG  : Qtn : Qtn+1
         0   1  (01) 1    1           ?          :  ?  :   - ;    // Output retains the
         0   0  (01) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (01) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism
         1   1  (01) 1    1           ?          :  ?  :   1 ;
         1   1  (01) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimism
         1   0  (01) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (01) 1    1           ?          :  1  :   0 ;
         ?   0  (01) x    1           ?          :  1  :   0 ;     //pessimism
         1   ?  (01) 1    x           ?          :  0  :   1 ;
         0   1  (x1) 1    1           ?          :  ?  :   - ;   //possible clocked JK
         0   0  (x1) 1    1           ?          :  0  :   0 ;
         1   1  (x1) 1    1           ?          :  1  :   1 ;
         0   1  (0x) 1    1           ?          :  ?  :   - ;
         0   0  (0x) 1    1           ?          :  0  :   0 ;
         1   1  (0x) 1    1           ?          :  1  :   1 ;
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL
         x   1   r   1    1           ?          :  1  :   1 ;
         x   0   r   1    1           ?          :  1  :   0 ;
         0   x   r   1    1           ?          :  0  :   0 ;
         1   x   r   1    1           ?          :  0  :   1 ;
         x   1 (x1)  1    1           ?          :  1  :   1 ;        //possible clocked with
         0   x (x1)  1    1           ?          :  0  :   0 ;        //possible J & K
         x   1 (0x)  1    1           ?          :  1  :   1 ;
         0   x (0x)  1    1           ?          :  0  :   0 ;
         ?   ? (?0)  1    1           ?          :  ?  :   - ;    //ignore falling clock.
         ?   ? (1x)  1    1           ?          :  ?  :   - ;
         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;
    endtable
endprimitive
 // --------------------------------------------------------------------
 // 2-1 MUX  primitive   
 // FUNCTION : when select signal S= 1, A will be selected, S= 0, B will 
 //            be selected; when S=X, if A=B, A will be selected, if A!=B,
 //            X will be the output!
 // --------------------------------------------------------------------
primitive UDP_MUX2 (Q, A, B, SL);
output Q;
input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   0 ;
        1   1   ?   :   1 ;

        0   ?   1   :   0 ;
        1   ?   1   :   1 ;

        ?   0   0   :   0 ;
        ?   1   0   :   1 ;

    endtable
endprimitive

primitive UDPN_MUX2 (Q, A, B, SL);
output Q;
input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   1 ;
        1   1   ?   :   0 ;

        0   ?   1   :   1 ;
        1   ?   1   :   0 ;

        ?   0   0   :   1 ;
        ?   1   0   :   0 ;

    endtable
endprimitive


//---------------  END OF VERILOG PRIMITIVE SECTION --------------------

primitive CMA9_primitive (Y, D0,DB, D3,S01,S11);
output Y;
input D0,DB, D3,S01,S11;


	table
	// D0   DB   D3   S01  S11 :       Y
	   ?    0    ?    0    ?  :       1;
	   ?    1    ?    ?    1  :       0;
	   ?    0    0    1    ?  :       0;
	   1    1    ?    ?    0  :       1;
	   1    ?    1    ?    0  :       1;
	   ?    0    1    ?    ?  :       1;
	   0    1    ?    ?    ?  :       0;
	   0    ?    0    1    ?  :       0;
	   1    ?    ?    0    0  :       1;
	   ?    ?    0    1    1  :       0;

	endtable
endprimitive

primitive CMAF_primitive (Y, D0, D2,  D3, DB, S01, S11);
output Y;
input D0, D2,  D3, DB, S01, S11;


	table
	// D0   D2   D3   DB   S01  S11       Y
	   0    0    0     ?    ?    ? :    0;
	   1    1    1     ?    ?    ? :    1;
	   0    0    ?     ?    0    0 :    0;
	   1    1    ?     ?    0    0 :    1;
	   0    0    ?     1    ?    ? :    0;
	   1    1    ?     1    ?    ? :    1;
	   0    0    ?     ?    0    ? :    0;
	   1    1    ?     ?    0    ? :    1;
	   ?    0    0     ?    1    1 :    0;
	   ?    1    1     ?    1    1 :    1;
	   ?    0    0     0    ?    ? :    0;
	   ?    1    1     0    ?    ? :    1;
	   ?    0    0     ?    ?    1 :    0;
	   ?    1    1     ?    ?    1 :    1;
	   0    ?    0     ?    1    0 :    0;
	   1    ?    1     ?    1    0 :    1;
	   ?    0    ?     0    0    ? :    0;
	   ?    1    ?     0    0    ? :    1;
	   ?    0    ?     1    ?    1 :    0;
	   ?    1    ?     1    ?    1 :    1;
	   ?    0    ?     ?    0    1 :    0;
	   ?    1    ?     ?    0    1 :    1;
	   ?    ?    0     0    1    ? :    0;
	   ?    ?    1     0    1    ? :    1;
	   0    ?    ?     1    ?    0 :    0;
	   1    ?    ?     1    ?    0 :     1;

	endtable
endprimitive

primitive CMB7_primitive (Y, D0, D1, D2, DB, S00, S01, S11);
output Y;
input D0, D1, D2, DB, S00, S01, S11;


   table
	//D0   D1   D2   DB   S00  S01  S11          Y
	  0    0    0    1    ?    ?    ?  :       0;
	  ?    ?    1    0    ?    ?    ?  :      1;
	  ?    0    ?    1    1    1    0  :      0;
	  ?    1    ?    ?    1    1    0  :      1;
	  0    ?    ?    1    0    ?    0  :      0;
	  0    ?    ?    1    ?    0    0  :      0;
	  1    ?    ?    1    0    ?    0  :      1;
	  1    ?    ?    1    ?    0    0  :      1;
	  ?    ?    ?    1    1    1    1  :      0;
	  ?    ?    ?    0    1    1    ?  :      1;
	  ?    ?    0    0    0    ?    ?  :      0;
	  ?    ?    0    0    ?    0    ?  :      0;
	  ?    ?    0    ?    0    ?    1  :      0;
	  ?    ?    0    ?    ?    0    1  :      0;
	  0    ?    0    ?    0    ?    ?  :      0;
	  0    ?    0    ?    ?    0    ?  :      0;
	  1    ?    1    ?    0    ?    ?  :      1;
	  1    ?    1    ?    ?    0    ?  :      1;
	  ?    ?    1    ?    0    ?    1  :      1;
	  ?    ?    1    ?    ?    0    1  :      1;
	  ?    0    ?    1    1    1    ?  :      0;
	  0    0    ?    1    ?    ?    0  :      0;
	  1    1    ?    1    ?    ?    0  :      1;
	  ?    ?    0    1    ?    ?    1  :      0;
	  1    1    1    ?    ?    ?    0  :      1;

	endtable
endprimitive

primitive CMBB_primitive (Y, D0,D1,DB,D3,S00,S01,S11);
output Y;
input D0,D1,DB,D3,S00,S01,S11;


	table
// D0   D1   DB   D3   S00  S01  S11          Y
	0    0    1    0    ?    ?    ? :        0;
	?    ?    0    1    ?    ?    ? :       1;
	?    ?    0    ?    ?    0    ? :       1;
	?    ?    1    ?    ?    0    1 :       0;
	?    ?    0    ?    0    ?    ? :       1;
	?    ?    1    ?    0    ?    1 :       0;
	0    ?    1    ?    ?    0    0 :       0;
	1    ?    ?    ?    ?    0    0 :       1;
	0    ?    1    ?    0    ?    0 :       0;
	1    ?    ?    ?    0    ?    0 :       1;
	?    0    1    ?    1    1    0 :       0;
	?    1    1    ?    1    1    0 :       1;
	?    ?    ?    0    1    1    1 :       0;
	?    ?    ?    1    1    1    1 :       1;
	?    ?    0    0    1    1    ? :       0;
	?    ?    1    0    ?    ?    1 :       0;
	?    0    ?    0    1    1    ? :       0;
	?    1    ?    1    1    1    ? :       1;
	0    ?    1    ?    0    ?    ? :       0;
	0    0    1    ?    ?    ?    0 :       0;
	1    1    1    ?    ?    ?    0 :       1;
	0    ?    1    ?    ?    0    ? :       0;
	1    1    ?    1    ?    ?    0 :       1;

	endtable
endprimitive

primitive CMEA_primitive (Y, DB,D1,D3,S01,S10,S11);
output Y;
input DB,D1,D3,S01,S10,S11;


	table
// DB   D1   D3   S01  S10  S11          Y
	1     ?    ?    ?   ?    ? :       0;
	0     1    1    ?   ?    ? :       1;
	0     0    ?    1   0    0 :       0;
	0     1    ?    ?   0    0 :       1;
	0     ?    0    1   1    ? :       0;
	0     ?    0    1   ?    1 :       0;
	0     ?    ?    0   ?    ? :       1;
	?     0    0    1   ?    ? :       0;
	0     ?    1    ?   1    ? :       1;
	0     ?    1    ?   ?    1 :       1;

   endtable
endprimitive

primitive CMEB_primitive (Y,D0,D1,DB,D3,S01,S10,S11);
output Y;
input D0,D1,DB,D3,S01,S10,S11;


   table
	// D0   D1   DB   D3   S01  S10  S11          Y
	0   0   1   0   ?   ?   ? :        0;
	1   1   0   1   ?   ?   ? :       1;
	0   ?   ?   ?   0   0   0 :       0;
	1   ?   ?   ?   0   0   0 :       1;
	0   ?   1   ?   ?   0   0 :       0;
	1   ?   1   ?   ?   0   0 :       1;
	?   ?   0   1   1   1   ? :       1;
	?   ?   0   1   1   ?   1 :       1;
	?   0   0   ?   1   0   0 :       0;
	?   1   0   ?   1   0   0 :       1;
	?   ?   ?   0   1   1   ? :       0;
	?   ?   ?   0   1   ?   1 :       0;
	?   ?   1   ?   ?   1   ? :       0;
	?   ?   1   ?   ?   ?   1 :       0;
	?   ?   0   ?   0   1   ? :       1;
	?   0   0   0   1   ?   ? :       0;
	?   1   0   1   1   ?   ? :       1;
	0   0   ?   ?   ?   0   0 :       0;
	1   1   ?   ?   ?   0   0 :       1;
	0   ?   1   ?   ?   ?   ? :       0;
	1   ?   0   ?   0   ?   ? :       1;
	?   ?   0   1   ?   1   ? :       1;
	?   ?   0   1   ?   ?   1 :       1;
	?   ?   0   ?   0   ?   1 :       1;
	0   0   ?   0   1   ?   ? :       0;

	endtable
endprimitive

primitive CMEE_primitive (Y,DB, D1, D2, D3, S01,S10, S11);
output Y;
input DB, D1, D2, D3, S01,S10, S11;


   table
	//DB   D1   D2   D3   S01  S10  S11          Y
	1 0 0 0 ? ? ? :       0;
	0 1 1 1 ? ? ? :       1;
	? 0 ? ? 1 0 0 :       0;
	0 1 ? ? 1 0 0 :       1;
	0 ? ? 0 1 1 ? :       0;
	0 ? ? 1 1 1 ? :       1;
	0 ? ? 0 1 ? 1 :       0;
	0 ? ? 1 1 ? 1 :       1;
	1 ? ? ? ? 0 0 :       0;
	0 ? ? ? 0 0 0 :       1;
	? ? 0 ? 0 ? 1 :       0;
	? ? 1 ? 0 ? 1 :       1;
	? ? 0 ? 0 1 ? :       0;
	? ? 1 ? 0 1 ? :       1;
	1 ? 0 ? ? ? 1 :       0;
	1 ? 1 ? ? ? 1 :       1;
	1 ? 0 ? ? 1 ? :       0;
	1 ? 1 ? ? 1 ? :       1;
	1 ? 0 ? ? ? ? :       0;
	0 ? 1 ? 0 ? ? :       1;
	? ? 0 0 ? 1 ? :       0;
	? ? 1 1 ? 1 ? :       1;
	? ? 0 0 ? ? 1 :       0;
	0 0 ? 0 1 ? ? :       0;
	0 1 ? 1 1 ? ? :       1;
	? ? 1 1 ? ? 1 :       1;
	0 1 ? ? ? 0 0 :       1;
	? 0 0 0 1 ? ? :       0;

   endtable
endprimitive




/*--------------------------------------------------------------------
 CELL NAME : AND2
 CELL TYPE : comb
 CELL LOGIC : Y = A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2(Y,A,B);
 input A,B;
 output Y;

 and      U2(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND2A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_0(A_, A);
 and      U5(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND2B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_1(A_, A);
 not	INV_2(B_, B);
 and      U8(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U15(NET_0_0, A, B);
 and      U16(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_4(A_, A);
 and      U20(NET_0_0, A_, B);
 and      U21(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_5(A_, A);
 not	INV_6(B_, B);
 and      U25(NET_0_0, A_, B_);
 and      U26(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3C
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_7(A_, A);
 not	INV_8(B_, B);
 not	INV_9(C_, C);
 and      U30(NET_0_0, A_, B_);
 and      U31(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO12
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + !A & !C + A & !B & C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO12(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_13(A_, A);
 not	INV_14(B_, B);
 not	INV_15(C_, C);
 UDP_MUX2   U56(NET_0_5, B, NET_0_3, C_);
 and      U59(NET_0_3, A, B_);
 or       U60(Y, NET_0_5, NET_0_2);
 and      U63(NET_0_0, A_, B);
 or       U64(NET_0_2, NET_0_0, NET_0_1);
 and      U66(NET_0_1, A_, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO13
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + A & !C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO13(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_16(C_, C);
 and      U71(NET_0_0, A, B);
 or       U72(NET_0_2, NET_0_0, NET_0_1);
 and      U74(NET_0_1, A, C_);
 or       U75(Y, NET_0_2, NET_0_3);
 and      U77(NET_0_3, B, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO14
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + A & !C + B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO14(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_17(A_, A);
 not	INV_18(B_, B);
 not	INV_19(C_, C);
 and      U82(NET_0_5, A_, B_);
 UDP_MUX2   U83(NET_0_4, NET_0_5, B, C);
 or       U85(Y, NET_0_4, NET_0_2);
 and      U88(NET_0_0, A, B);
 or       U89(NET_0_2, NET_0_0, NET_0_1);
 and      U91(NET_0_1, A, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO15
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B & C + !A & B & C + !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO15(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_20(A_, A);
 not	INV_21(B_, B);
 not	INV_22(C_, C);
 and      U96(NET_0_0, A, B_);
 UDP_MUX2   U97(NET_0_4, NET_0_0, NET_0_5, C);
 and      U100(NET_0_5, A_, B_);
 or       U101(Y, NET_0_4, NET_0_3);
 and      U104(NET_0_2, A_, B);
 and      U105(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO16
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO16(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_23(A_, A);
 not	INV_24(B_, B);
 not	INV_25(C_, C);
 and      U109(NET_0_0, A, B);
 UDP_MUX2   U110(Y, NET_0_0, NET_0_2, C_);
 and      U113(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO17
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C + !A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO17(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_26(A_, A);
 not	INV_27(B_, B);
 not	INV_28(C_, C);
 and      U118(NET_0_5, A_, B_);
 UDP_MUX2   U119(NET_0_4, NET_0_5, NET_0_2, C);
 and      U122(NET_0_2, A_, B);
 or       U123(Y, NET_0_4, NET_0_1);
 and      U126(NET_0_0, A, B);
 and      U127(NET_0_1, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO18
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + !A & !C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO18(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_29(A_, A);
 not	INV_30(C_, C);
 and      U132(NET_0_0, A_, B);
 or       U133(NET_0_2, NET_0_0, NET_0_1);
 and      U135(NET_0_1, A_, C_);
 or       U136(Y, NET_0_2, NET_0_3);
 and      U138(NET_0_3, B, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U142(NET_0_0, A, B);
 or       U143(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_31(A_, A);
 and      U147(NET_0_0, A_, B);
 or       U148(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1B
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_32(C_, C);
 and      U152(NET_0_0, A, B);
 or       U153(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_33(A_, A);
 not	INV_34(C_, C);
 and      U157(NET_0_0, A_, B);
 or       U158(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1D
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_35(A_, A);
 not	INV_36(B_, B);
 and      U162(NET_0_0, A_, B_);
 or       U163(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1E
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1E(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_37(A_, A);
 not	INV_38(B_, B);
 not	INV_39(C_, C);
 and      U167(NET_0_0, A_, B_);
 or       U168(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U192(NET_0_0, A, B);
 nor      U193(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_44(A_, A);
 and      U197(NET_0_0, A_, B);
 nor      U198(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1B
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_45(C_, C);
 and      U202(NET_0_0, A, B);
 nor      U203(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_46(A_, A);
 not	INV_47(B_, B);
 and      U207(NET_0_0, A_, B_);
 nor      U208(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1D
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_48(A_, A);
 not	INV_49(B_, B);
 not	INV_50(C_, C);
 and      U212(NET_0_0, A_, B_);
 nor      U213(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI5
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B & C + A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_54(A_, A);
 not	INV_55(B_, B);
 not	INV_56(C_, C);
 and      U237(NET_0_0, A_, B);
 UDPN_MUX2  U238(Y, NET_0_0, NET_0_2, C);
 and      U241(NET_0_2, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_57(A_, A);
 and      U245(NET_0_0, A_, B);
 xor      U246(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_58(A_, A);
 and      U250(NET_0_0, A_, B);
 xnor     U251(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1B
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_59(A_, A);
 not	INV_60(B_, B);
 and      U255(NET_0_0, A_, B_);
 xor      U256(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1C
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U260(NET_0_0, A, B);
 xor      U261(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1D
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & !B) ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_61(A_, A);
 not	INV_62(B_, B);
 and      U265(NET_0_0, A_, B_);
 xnor     U266(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1E
 CELL TYPE : comb
 CELL LOGIC : Y = !((A & B) ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1E(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U270(NET_0_0, A, B);
 xnor     U271(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO1
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_63(B_, B);
 not	INV_64(C_, C);
 and      U275(NET_0_1_XOR_REXT, B, C_);
 or       U276(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U278(NET_0_1, C, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO2
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO2(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_65(A_, A);
 not	INV_66(B_, B);
 not	INV_67(C_, C);
 and      U283(NET_0_1_XOR_REXT, B, C_);
 or       U284(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U286(NET_0_1, C, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO3
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_68(B_, B);
 not	INV_69(C_, C);
 and      U291(NET_0_1_XOR_LEXT, B_, C);
 or       U292(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U294(NET_0_1, A, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO5
 CELL TYPE : comb
 CELL LOGIC : Y =  !A & B + (!B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_70(A_, A);
 not	INV_71(B_, B);
 not	INV_72(C_, C);
 and      U299(NET_0_1_XOR_LEXT, B, C);
 or       U300(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U302(NET_0_1, A_, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO6
 CELL TYPE : comb
 CELL LOGIC : Y =  A & !B + (!B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO6(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_73(B_, B);
 not	INV_74(C_, C);
 and      U307(NET_0_1_XOR_REXT, B_, C_);
 or       U308(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U310(NET_0_1, C, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO7
 CELL TYPE : comb
 CELL LOGIC : Y =  !A & !B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO7(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_75(A_, A);
 not	INV_76(B_, B);
 not	INV_77(C_, C);
 and      U315(NET_0_1_XOR_LEXT, B_, C);
 or       U316(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U318(NET_0_1, A_, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI1
 CELL TYPE : comb
 CELL LOGIC : Y =  !(A & B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_78(B_, B);
 not	INV_79(C_, C);
 and      U323(NET_0_1_XOR_REXT, B, C_);
 nor      U324(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U326(NET_0_1, C, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI2
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI2(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_80(A_, A);
 not	INV_81(B_, B);
 not	INV_82(C_, C);
 and      U331(NET_0_1_XOR_REXT, B, C_);
 nor      U332(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U334(NET_0_1, C, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & !B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_83(B_, B);
 not	INV_84(C_, C);
 and      U339(NET_0_1_XOR_LEXT, B_, C);
 nor      U340(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U342(NET_0_1, A, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI4
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + (!B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI4(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_85(B_, B);
 not	INV_86(C_, C);
 and      U347(NET_0_1_XOR_LEXT, B, C);
 nor      U348(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U350(NET_0_1, A, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI5
 CELL TYPE : comb
 CELL LOGIC : Y =  !(!A & B + (!B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_87(A_, A);
 not	INV_88(B_, B);
 not	INV_89(C_, C);
 and      U355(NET_0_1_XOR_LEXT, B, C);
 nor      U356(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U358(NET_0_1, A_, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI7
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI7(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_90(A_, A);
 not	INV_91(B_, B);
 not	INV_92(C_, C);
 and      U363(NET_0_1_XOR_LEXT, B_, C);
 nor      U364(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U366(NET_0_1, A_, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : PLLINT 
 CELL TYPE : comb
 CELL LOGIC : Y=A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module PLLINT(Y,A);
 input A;
 output Y;

 buf    BUF_U_00(Y,A);

       specify

                specparam tpdLH_A_to_Y = (0.0:0.0:0.0);
                specparam tpdHL_A_to_Y = (0.0:0.0:0.0);
                specparam MacroType = "comb";

                //pin to pin path delay

                (A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U370(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
                (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_12(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U373(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_12D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U376(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_12U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U379(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_16(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U382(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_16D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_16D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U385(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_16U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_16U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U388(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_8(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U400(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_8D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_8D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U403(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_8U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_8U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U406(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS15
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS15(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U418(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS15D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS15D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U421(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS15U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS15U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U424(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS12(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U427(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS12D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U430(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS12U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U433(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS18
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS18(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U427(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS18D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS18D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U430(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS18U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS18U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U433(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS25
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS25(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U436(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS25D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS25D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U439(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS25U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS25U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U442(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS33
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS33(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U2(PAD, D, E);
 buf    BUF_U_01(Y,PAD);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
        (D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS33D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS33D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U5(PAD, D, E);
 buf    BUF_U_01(Y,PAD);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
        (D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_LVCMOS33U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_LVCMOS33U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U8(PAD, D, E);
 buf    BUF_U_01(Y,PAD);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
        (D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_12(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U472(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_12D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U475(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_12U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U478(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_16(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U481(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_16D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_16D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U484(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_16U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_16U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U487(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_8(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U499(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_8D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_8D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U502(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_8U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_8U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U505(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUF
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf    BUF_U_00(Y,PAD);

       specify

                specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

                (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : CLKBUF_LVCMOS15
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF_LVCMOS15(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : CLKBUF_LVCMOS12
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF_LVCMOS12(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUF_LVCMOS18
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF_LVCMOS18(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUF_LVCMOS25
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF_LVCMOS25(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUF_LVCMOS33
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF_LVCMOS33(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf    BUF_U_00(Y,PAD);

      specify

        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults





/*--------------------------------------------------------------
 CELL NAME : DFI0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0(CLK, QN,D);
 input D,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0C0(CLR, CLK, QN,D);
 input D,CLR,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,CLR);
       buf U_c2 (Enable02, CLR);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0C1(CLR, CLK, QN,D);
 input D,CLR,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(q_tmp, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E0(E, CLK, QN,D);
 input D,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I3 (_E0, E);
      buf U_c0 (Enable01,_E0);
      buf U_c2 (Enable02, _E0);
      buf U_c4 (Enable04, _E0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK,  0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E0C0(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,CLR, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, CLR);
      and U_c2 (Enable02, _E0, CLR);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E0C1(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(q_tmp, D,CLK,CLR_0, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _CLR0);
      and U_c2 (Enable02, _E0, _CLR0);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E0P0(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, PRE);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E0P1(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _PRE0);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E1(E, CLK, QN,D);
 input D,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(q_tmp, D,CLK,VCC_0, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      buf U_c0 (Enable01,E);
      buf U_c2 (Enable02, E);
      buf U_c4 (Enable04, E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK,  0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E1C0(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(q_tmp, D,CLK,CLR, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, CLR);
      and U_c2 (Enable02, E, CLR);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E1C1(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);
 not INV_EN_0(E_0, E);

 Dffpf DF_0(q_tmp, D,CLK,CLR_0, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, _CLR0);
      and U_c2 (Enable02, E, _CLR0);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E1P0(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, PRE);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0E1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0E1P1(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_EN_0(E_0, E);

 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, _PRE0);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0P0(PRE, CLK, QN,D);
 input D,PRE,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, PRE);       buf U_c4 (Enable04, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0P1(PRE, CLK, QN,D);
 input D,PRE,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpf DF_0(q_tmp, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI0P1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, _CLK=CLK, CLR=CLR, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI0P1C1(PRE, CLR, CLK, QN,D);
 input D,PRE,CLR,CLK;
 output QN;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(q_tmp, D,CLK,CLR_0, PRE_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, _CLR0, _PRE0);
       buf U_c2 (Enable02, _CLR0);
       buf U_c4 (Enable04, _PRE0);
      and U_c6 (Enable05, _CLR0, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& ~CLR,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);
	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1(CLK, QN,D);
 input D,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1C0(CLR, CLK, QN,D);
 input D,CLR,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,CLR);
       buf U_c2 (Enable02, CLR);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1C1(CLR, CLK, QN,D);
 input D,CLR,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(q_tmp, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E0(E, CLK, QN,D);
 input D,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I3 (_E0, E);
      buf U_c0 (Enable01,_E0);
      buf U_c2 (Enable02, _E0);
      buf U_c4 (Enable04, _E0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK,  0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E0C0(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,CLR, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, CLR);
      and U_c2 (Enable02, _E0, CLR);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E0C1(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(q_tmp, D,CLK,CLR_0, VCC_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _CLR0);
      and U_c2 (Enable02, _E0, _CLR0);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E0P0(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, PRE);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E0P1(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE_0, E, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _PRE0);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E1(E, CLK, QN,D);
 input D,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(q_tmp, D,CLK,VCC_0, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      buf U_c0 (Enable01,E);
      buf U_c2 (Enable02, E);
      buf U_c4 (Enable04, E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK,  0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E1C0(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(q_tmp, D,CLK,CLR, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, CLR);
      and U_c2 (Enable02, E, CLR);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E1C1(CLR, E, CLK, QN,D);
 input D,CLR,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);
 not INV_EN_0(E_0, E);

 Dffpr DF_0(q_tmp, D,CLK,CLR_0, VCC_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, _CLR0);
      and U_c2 (Enable02, E, _CLR0);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E1P0(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, PRE);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1E1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1E1P1(PRE, E, CLK, QN,D);
 input D,PRE,E,CLK;
 output QN;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_EN_0(E_0, E);

 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE_0, E_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, _PRE0);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1P0(PRE, CLK, QN,D);
 input D,PRE,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, PRE);       buf U_c4 (Enable04, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1P1(PRE, CLK, QN,D);
 input D,PRE,CLK;
 output QN;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(q_tmp, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFI1P1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[QN=QN, CLK =CLK, CLR=CLR, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFI1P1C1(PRE, CLR, CLK, QN,D);
 input D,PRE,CLR,CLK;
 output QN;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(q_tmp, D,CLK,CLR_0, PRE_0, GND_0, NOTIFY_REG);
  not INV_Q_0(QN,q_tmp);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, _CLR0, _PRE0);
       buf U_c2 (Enable02, _CLR0);
       buf U_c4 (Enable04, _PRE0);
      and U_c6 (Enable05, _CLR0, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_QN = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_QN = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (QN +: D))=(tpdLH_CLK_to_QN, tpdHL_CLK_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& ~CLR,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);
	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0(CLK, Q,D);
 input D,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0C0(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,CLR);
       buf U_c2 (Enable02, CLR);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0C1(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(Q, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E0(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I3 (_E0, E);
      buf U_c0 (Enable01,_E0);
      buf U_c2 (Enable02, _E0);
      buf U_c4 (Enable04, _E0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK,  0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E0C0(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, CLR);
      and U_c2 (Enable02, _E0, CLR);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E0C1(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(Q, D,CLK,CLR_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _CLR0);
      and U_c2 (Enable02, _E0, _CLR0);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E0P0(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, PRE);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E0P1(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpf DF_0(Q, D,CLK,VCC_0, PRE_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _PRE0);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E1(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(Q, D,CLK,VCC_0, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      buf U_c0 (Enable01,E);
      buf U_c2 (Enable02, E);
      buf U_c4 (Enable04, E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK,  0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E1C0(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(Q, D,CLK,CLR, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, CLR);
      and U_c2 (Enable02, E, CLR);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E1C1(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);
 not INV_EN_0(E_0, E);

 Dffpf DF_0(Q, D,CLK,CLR_0, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, _CLR0);
      and U_c2 (Enable02, E, _CLR0);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E1P0(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpf DF_0(Q, D,CLK,VCC_0, PRE, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, PRE);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0E1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0E1P1(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_EN_0(E_0, E);

 Dffpf DF_0(Q, D,CLK,VCC_0, PRE_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, _PRE0);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0P0(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, PRE);       buf U_c4 (Enable04, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0P1(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpf DF_0(Q, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN0P1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, CLR=CLR, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN0P1C1(PRE, CLR, CLK, Q,D);
 input D,PRE,CLR,CLK;
 output Q;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_CLR_0(CLR_0, CLR);

 Dffpf DF_0(Q, D,CLK,CLR_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I0 (_CLK0, CLK);
      not U0_I1 (_PRE0, PRE);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, _CLR0, _PRE0);
       buf U_c2 (Enable02, _CLR0);
       buf U_c4 (Enable04, _PRE0);
      and U_c6 (Enable05, _CLR0, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& ~CLR,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK &&& Enable02, 0.0, NOTIFY_REG);
	$recovery(negedge CLR, negedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1(CLK, Q,D);
 input D,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1C0(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,CLR);
       buf U_c2 (Enable02, CLR);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1C1(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 UFPRB DF_0( Q, D, CLK, CLR_0, NOTIFY_REG );

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E0(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I3 (_E0, E);
      buf U_c0 (Enable01,_E0);
      buf U_c2 (Enable02, _E0);
      buf U_c4 (Enable04, _E0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK,  0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E0C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E0C0(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, CLR);
      and U_c2 (Enable02, _E0, CLR);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E0C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E0C1(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(Q, D,CLK,CLR_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _CLR0);
      and U_c2 (Enable02, _E0, _CLR0);
      buf U_c4 (Enable04, _E0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E0P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E0P0(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, PRE);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E0P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E0P1(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(Q, D,CLK,VCC_0, PRE_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I3 (_E0, E);
      and U_c0 (Enable01, _E0, _PRE0);
      buf U_c2 (Enable02, _E0);
      and U_c4 (Enable04, _E0, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E1(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      buf U_c0 (Enable01,E);
      buf U_c2 (Enable02, E);
      buf U_c4 (Enable04, E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK,  0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E1C0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E1C0(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, CLR);
      and U_c2 (Enable02, E, CLR);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, E=E, CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E1C1(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);
 not INV_EN_0(E_0, E);

 Dffpr DF_0(Q, D,CLK,CLR_0, VCC_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, E, _CLR0);
      and U_c2 (Enable02, E, _CLR0);
      buf U_c4 (Enable04, E);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E1P0(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_EN_0(E_0, E);

 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, PRE);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1E1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, E=E, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1E1P1(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_EN_0(E_0, E);

 Dffpr DF_0(Q, D,CLK,VCC_0, PRE_0, E_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      and U_c0 (Enable01, E, _PRE0);
      buf U_c2 (Enable02, E);
      and U_c4 (Enable04, E, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable05,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable05, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable05, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1P0
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1P0(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, PRE);       buf U_c4 (Enable04, PRE);
       buf U_c6 (Enable05, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1P1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1P1(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(Q, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFN1P1C1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, CLR=CLR, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFN1P1C1(PRE, CLR, CLK, Q,D);
 input D,PRE,CLR,CLK;
 output Q;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);
 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(Q, D,CLK,CLR_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      not U0_I2 (_CLR0, CLR);
      and U_c0 (Enable01, _CLR0, _PRE0);
       buf U_c2 (Enable02, _CLR0);
       buf U_c4 (Enable04, _PRE0);
      and U_c6 (Enable05, _CLR0, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK &&& Enable02, negedge PRE,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable04, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& ~CLR,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable02, 0.0, NOTIFY_REG);
	$recovery(negedge CLR, posedge CLK &&& Enable04, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, D=D ];
-----------------------------------------------------------------*/

module DLI0(G, QN,D);
 input D,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 DL2C_UDP DL_U0(QN_, D, G, GND, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	buf U_c1 (Enable2, _G);
	buf U_c3 (Enable4, _G);
	buf U_c5 (Enable6, _G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0C0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLI0C0(CLR, G, QN,D);
 input D,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(QN_, D, G, CLR_, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, _G, CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, _G, CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && CLR )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(posedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLI0C1(CLR, G, QN,D);
 input D,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(QN_, D, G, CLR, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, _G, _CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && !CLR )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(negedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0P0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI0P0(PRE, G, QN,D);
 input D,PRE,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(QN_, D, G, GND, PRE_, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, _G, PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, _G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
       if (!G )
       (posedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge PRE, 0.0, NOTIFY_REG);
	$hold(posedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0P1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI0P1(PRE, G, QN,D);
 input D,PRE,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(QN_, D, G, GND, PRE, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, _G, _PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && !PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
       if (!G )
	(negedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge PRE, 0.0, NOTIFY_REG);
	$hold(posedge G,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI0P1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, _CLK=G, CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI0P1C1(PRE, CLR, G, QN,D);
 input D,PRE,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(QN_, D, G, CLR, PRE, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, _CLR, _PRE);
	and U_c1 (Enable2, _G, _CLR, _PRE);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	and U_c6 (Enable7, _CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && !CLR && !PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(negedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(negedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	if (!CLR)
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
       if (!G && !CLR )
	(negedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& Enable3, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (negedge CLR, posedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable5, negedge CLR, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable3,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, D=D ];
-----------------------------------------------------------------*/

module DLI1(G, QN,D);
 input D,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, GND, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	buf U_c1 (Enable2, G);
	buf U_c3 (Enable4, G);
	buf U_c5 (Enable6, G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1C0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLI1C0(CLR, G, QN,D);
 input D,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, CLR_, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, G,CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, G, CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && CLR )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(negedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(posedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLI1C1(CLR, G, QN,D);
 input D,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, CLR, GND, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, G,_CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, G, _CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && !CLR )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(negedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1P0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI1P0(PRE, G, QN,D);
 input D,PRE,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, GND, PRE_, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, G, PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(negedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
       if (G )
       (posedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge PRE, 0.0, NOTIFY_REG);
	$hold(negedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1P1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI1P1(PRE, G, QN,D);
 input D,PRE,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, GND, PRE, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, G, _PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && !PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
       if (G )
	(negedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge PRE, 0.0, NOTIFY_REG);
	$hold(negedge G,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLI1P1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[QN=QN, CLK =G, CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLI1P1C1(PRE, CLR, G, QN,D);
 input D,PRE,CLR,G;
 output QN;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(QN_, D, G_, CLR, PRE, NOTIFY_REG);
  not INV_Q(QN, QN_);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, _CLR, _PRE);
	and U_c1 (Enable2, G, _CLR, _PRE);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, G, _CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	and U_c6 (Enable7, _CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_QN = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_QN = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_QN = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_QN = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && !CLR && !PRE )
        (D => QN) = (tpdLH_D_to_QN, tpdHL_D_to_QN);

	if (Enable1)
	(posedge G => (QN+:D))=(tpdLH_G_to_QN, tpdHL_G_to_QN);
	(posedge CLR => (QN +: 1'b0)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	(negedge CLR => (QN+:D)) = (tpdLH_CLR_to_QN, tpdHL_CLR_to_QN);
	if (!CLR)
	(posedge PRE => (QN +: 1'b1)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);
        if (G && !CLR )
	(negedge PRE => (QN+:D)) = (tpdLH_PRE_to_QN, tpdHL_PRE_to_QN);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& Enable3, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (negedge CLR, negedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable5, negedge CLR, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable3,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, D=D ];
-----------------------------------------------------------------*/

module DLN0(G, Q,D);
 input D,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 DL2C_UDP DL_U0(Q, D, G, GND, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	buf U_c1 (Enable2, _G);
	buf U_c3 (Enable4, _G);
	buf U_c5 (Enable6, _G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0C0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLN0C0(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR_, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, _G, CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, _G, CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLN0C1(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, _G, _CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && !CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0P0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN0P0(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(Q, D, G, GND, PRE_, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, _G, PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, _G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if (!G )
       (posedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge PRE, 0.0, NOTIFY_REG);
	$hold(posedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0P1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN0P1(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(Q, D, G, GND, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, _G, _PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (!G && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if (!G )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge PRE, 0.0, NOTIFY_REG);
	$hold(posedge G,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN0P1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN0P1C1(PRE, CLR, G, Q,D);
 input D,PRE,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, _CLR, _PRE);
	and U_c1 (Enable2, _G, _CLR, _PRE);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	and U_c6 (Enable7, _CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output

	if (!G && !CLR && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	if (!CLR)
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
        if (!G && !CLR )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& Enable3, 0.0, 0, NOTIFY_REG);
	
        $width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (negedge CLR, posedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable5, negedge CLR, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable3,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, D=D ];
-----------------------------------------------------------------*/

module DLN1(G, Q,D);
 input D,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	buf U_c1 (Enable2, G);
	buf U_c3 (Enable4, G);
	buf U_c5 (Enable6, G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (G )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1C0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLN1C0(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR_, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, G,CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, G, CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLN1C1(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, G,_CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, G, _CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output

	if (G && !CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1P0
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN1P0(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, PRE_, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, G, PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if (G )
       (posedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge PRE, 0.0, NOTIFY_REG);
	$hold(negedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1P1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN1P1(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, G, _PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if (G )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge PRE, 0.0, NOTIFY_REG);
	$hold(negedge G,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLN1P1C1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLN1P1C1(PRE, CLR, G, Q,D);
 input D,PRE,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, _CLR, _PRE);
	and U_c1 (Enable2, G, _CLR, _PRE);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, G, _CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	and U_c6 (Enable7, _CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    LibName	="iglooplus";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if (G && !CLR && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if (Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	if (!CLR)
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
        if (G && !CLR )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& Enable3, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (negedge CLR, negedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable5, negedge CLR, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable3,  negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : GND
 CELL TYPE : comb
 CELL LOGIC : Y=0
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GND(Y);
 output Y;

 supply0	Y;

       specify

		specparam MacroType = "comb";

		//pin to pin path delay 

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : INBUF_FF
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_FF(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS15
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS15(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS15D
 CELL TYPE : comb
 CELL LOGIC : Y#Down=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS15D(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pulldown	DN(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS15U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS15U(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pullup	UP(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS12
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS12(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS12D
 CELL TYPE : comb
 CELL LOGIC : Y#Down=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS12D(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pulldown	DN(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS12U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS12U(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pullup	UP(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS18
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS18(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS18D
 CELL TYPE : comb
 CELL LOGIC : Y#Down=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS18D(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pulldown	DN(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS18U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS18U(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pullup	UP(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS25
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS25(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS25D
 CELL TYPE : comb
 CELL LOGIC : Y#Down=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS25D(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pulldown	DN(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS25U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS25U(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pullup	UP(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS33
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS33(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 buf    BUF_U_00(Y,PAD);

      specify

        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS33D
 CELL TYPE : comb
 CELL LOGIC : Y#Down=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS33D(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pulldown       DN(PAD);
 buf    BUF_U_00(Y,PAD);

      specify

        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF_LVCMOS33U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF_LVCMOS33U(Y,PAD);
 input PAD;
 output Y;
 reg NOTIFY_REG;

 pullup UP(PAD);
 buf    BUF_U_00(Y,PAD);

      specify

        specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
        specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

        (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : INV
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INV(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + (B & C) + (A & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 and      U510(NET_0_0, A, B);
 or       U511(NET_0_2, NET_0_0, NET_0_1);
 and      U513(NET_0_1, B, C);
 or       U514(Y, NET_0_2, NET_0_3);
 and      U516(NET_0_3, A, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3X
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & !C + A & !B & C + !A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3X(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_93(A_, A);
 not	INV_94(B_, B);
 not	INV_95(C_, C);
 and      U521(NET_0_0, A, B);
 UDP_MUX2   U522(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U525(NET_0_5, A_, B);
 or       U526(Y, NET_0_4, NET_0_3);
 and      U529(NET_0_2, A, B_);
 and      U530(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3XI
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & !C + A & !B & C + !A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3XI(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_96(A_, A);
 not	INV_97(B_, B);
 not	INV_98(C_, C);
 and      U535(NET_0_0, A, B);
 UDP_MUX2   U536(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U539(NET_0_5, A_, B);
 nor      U540(Y, NET_0_4, NET_0_3);
 and      U543(NET_0_2, A, B_);
 and      U544(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !A & !C + !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_99(A_, A);
 not	INV_100(B_, B);
 not	INV_101(C_, C);
 and      U549(NET_0_0, A_, B_);
 or       U550(NET_0_2, NET_0_0, NET_0_1);
 and      U552(NET_0_1, A_, C_);
 or       U553(Y, NET_0_2, NET_0_3);
 and      U555(NET_0_3, B_, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3X
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B & !C + !A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3X(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_102(A_, A);
 not	INV_103(B_, B);
 not	INV_104(C_, C);
 and      U560(NET_0_0, A, B_);
 UDP_MUX2   U561(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U564(NET_0_5, A_, B_);
 or       U565(Y, NET_0_4, NET_0_3);
 and      U568(NET_0_2, A_, B);
 and      U569(NET_0_3, NET_0_2, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3XI
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & !B & !C + !A & B & !C + !A & !B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3XI(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_105(A_, A);
 not	INV_106(B_, B);
 not	INV_107(C_, C);
 and      U574(NET_0_0, A, B_);
 UDP_MUX2   U575(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U578(NET_0_5, A_, B_);
 nor      U579(Y, NET_0_4, NET_0_3);
 and      U582(NET_0_2, A_, B);
 and      U583(NET_0_3, NET_0_2, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2
 CELL TYPE : comb
 CELL LOGIC : Y = (A & !S) + (B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_110(S_, S);
 UDP_MUX2   U594(Y, A, B, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !S) + (B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2A(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_111(A_, A);
 not	INV_112(S_, S);
 UDP_MUX2   U598(Y, A_, B, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2B
 CELL TYPE : comb
 CELL LOGIC : Y = (A & !S) + (!B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2B(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_113(S_, S);
 not	INV_114(B_, B);
 UDP_MUX2   U602(Y, A, B_, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !S) + (!B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2C(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_115(A_, A);
 not	INV_116(S_, S);
 not	INV_117(B_, B);
 UDP_MUX2   U606(Y, A_, B_, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2(Y,A,B);
 input A,B;
 output Y;

 nand     U610(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_118(A_, A);
 nand     U613(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_119(A_, A);
 not	INV_120(B_, B);
 nand     U616(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U620(NET_0_0, A, B);
 nand     U621(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_121(A_, A);
 and      U625(NET_0_0, A_, B);
 nand     U626(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_122(A_, A);
 not	INV_123(B_, B);
 and      U630(NET_0_0, A_, B_);
 nand     U631(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_124(A_, A);
 not	INV_125(B_, B);
 not	INV_126(C_, C);
 and      U635(NET_0_0, A_, B_);
 nand     U636(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2(Y,A,B);
 input A,B;
 output Y;

 nor      U649(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_130(A_, A);
 nor      U652(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_131(A_, A);
 not	INV_132(B_, B);
 nor      U655(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U662(NET_0_0, A, B);
 nor      U663(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_134(A_, A);
 or       U667(NET_0_0, A_, B);
 nor      U668(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_135(A_, A);
 not	INV_136(B_, B);
 or       U672(NET_0_0, A_, B_);
 nor      U673(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_137(A_, A);
 not	INV_138(B_, B);
 not	INV_139(C_, C);
 or       U677(NET_0_0, A_, B_);
 nor      U678(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U692(NET_0_0, A, B);
 and      U693(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A + B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_143(A_, A);
 or       U697(NET_0_0, A_, B);
 and      U698(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1B
 CELL TYPE : comb
 CELL LOGIC : Y = !C & (A + B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1B(Y,C,A,B);
 input C,A,B;
 output Y;
 wire NET_0_0;

 not	INV_144(C_, C);
 and      U701(Y, C_, NET_0_0);
 or       U703(NET_0_0, A, B);

       specify

		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A + B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_145(A_, A);
 not	INV_146(C_, C);
 or       U707(NET_0_0, A_, B);
 and      U708(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OAI1
 CELL TYPE : comb
 CELL LOGIC : Y = !((A + B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OAI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U732(NET_0_0, A, B);
 nand     U733(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2
 CELL TYPE : comb
 CELL LOGIC : Y = A + B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2(Y,A,B);
 input A,B;
 output Y;

 or       U756(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2A
 CELL TYPE : comb
 CELL LOGIC : Y = !A + B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_156(A_, A);
 or       U759(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_157(A_, A);
 not	INV_158(B_, B);
 or       U762(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3
 CELL TYPE : comb
 CELL LOGIC : Y = A + B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U769(NET_0_0, A, B);
 or       U770(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3A
 CELL TYPE : comb
 CELL LOGIC : Y = !A + B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_160(A_, A);
 or       U774(NET_0_0, A_, B);
 or       U775(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_161(A_, A);
 not	INV_162(B_, B);
 or       U779(NET_0_0, A_, B_);
 or       U780(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3C
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_163(A_, A);
 not	INV_164(B_, B);
 not	INV_165(C_, C);
 or       U784(NET_0_0, A_, B_);
 or       U785(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_12(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_12(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_16(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_8(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_LVCMOS15
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_LVCMOS15(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_LVCMOS12
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_LVCMOS12(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_LVCMOS18
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_LVCMOS18(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_LVCMOS25
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_LVCMOS25(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_LVCMOS33
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_LVCMOS33(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf    BUF_U_00(PAD,D);

      specify

        specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

        (D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_16(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_8(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U798(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_12(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U801(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_12D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U804(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_12U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U807(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_16(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U810(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_16D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_16D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U813(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_16U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_16U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U816(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_8(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U828(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_8D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_8D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U831(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_8U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_8U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U834(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS15
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS15(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U846(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS15D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS15D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U849(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS15U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS15U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U852(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS12(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U855(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS12D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U858(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS12U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U861(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS18
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS18(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U855(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS18D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS18D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U858(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS18U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS18U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U861(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS25
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS25(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U864(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS25D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS25D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U867(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS25U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS25U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U870(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS33
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS33(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U11(PAD, D, E);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS33D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS33D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U14(PAD, D, E);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_LVCMOS33U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_LVCMOS33U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U17(PAD, D, E);

      specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
        specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
        specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
        specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
        specparam MacroType = "comb";

        //pin to pin path delay

      //if(~D)
        (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);


      endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults





/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_12
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_12(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U900(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_12D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_12D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U903(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_12U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_12U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U906(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_16
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_16(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U909(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_16D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_16D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U912(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_16U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_16U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U915(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_8
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_8(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U927(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_8D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_8D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U930(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_8U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_8U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U933(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : VCC
 CELL TYPE : comb
 CELL LOGIC : Y=1
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module VCC(Y);
 output Y;

 supply1    Y;

       specify

		specparam MacroType = "comb";

		//pin to pin path delay 

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_169(A_, A);
 not	INV_170(B_, B);
 UDP_MUX2   U937(NET_0_0, B, B_, A_);
 and      U939(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_171(A_, A);
 not	INV_172(B_, B);
 UDPN_MUX2  U943(NET_0_0, B, B_, A_);
 and      U945(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1B
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_173(A_, A);
 not	INV_174(B_, B);
 not	INV_175(C_, C);
 UDP_MUX2   U949(NET_0_0, B, B_, A_);
 and      U951(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1C
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_176(A_, A);
 not	INV_177(B_, B);
 not	INV_178(C_, C);
 UDPN_MUX2  U955(NET_0_0, B, B_, A_);
 and      U957(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XAI1
 CELL TYPE : comb
 CELL LOGIC : Y = !((A ^ B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XAI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_179(A_, A);
 not	INV_180(B_, B);
 UDP_MUX2   U961(NET_0_0, B, B_, A_);
 nand     U963(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XAI1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!(A ^ B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XAI1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_181(A_, A);
 not	INV_182(B_, B);
 UDPN_MUX2  U967(NET_0_0, B, B_, A_);
 nand     U969(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XNOR2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XNOR2(Y,A,B);
 input A,B;
 output Y;

 not	INV_183(A_, A);
 not	INV_184(B_, B);
 UDPN_MUX2  U972(Y, B, B_, A_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XNOR3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XNOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_187(A_, A);
 not	INV_188(B_, B);
 UDP_MUX2   U981(NET_0_0, B, B_, A_);
 xnor     U983(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XO1
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_189(A_, A);
 not	INV_190(B_, B);
 UDP_MUX2   U987(NET_0_0, B, B_, A_);
 or       U989(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XO1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XO1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_191(A_, A);
 not	INV_192(B_, B);
 UDPN_MUX2  U993(NET_0_0, B, B_, A_);
 or       U995(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XOR2
 CELL TYPE : comb
 CELL LOGIC : Y = A ^ B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XOR2(Y,A,B);
 input A,B;
 output Y;

 not	INV_193(A_, A);
 not	INV_194(B_, B);
 UDP_MUX2   U998(Y, B, B_, A_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XOR3
 CELL TYPE : comb
 CELL LOGIC : Y = A ^ B ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_197(A_, A);
 not	INV_198(B_, B);
 UDP_MUX2   U1007(NET_0_0, B, B_, A_);
 xor      U1009(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : ZOR3
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C + !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ZOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_199(A_, A);
 not	INV_200(B_, B);
 not	INV_201(C_, C);
 and      U1013(NET_0_0, A, B);
 UDP_MUX2   U1014(Y, NET_0_0, NET_0_2, C);
 and      U1017(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : ZOR3I
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & C + !A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ZOR3I(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_202(A_, A);
 not	INV_203(B_, B);
 not	INV_204(C_, C);
 and      U1021(NET_0_0, A, B);
 UDPN_MUX2  U1022(Y, NET_0_0, NET_0_2, C);
 and      U1025(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BUFF
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BUFF(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKINT
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKINT(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOIN_IB
 CELL TYPE : comb
 CELL LOGIC : Y = YIN
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOIN_IB(Y,YIN);
 input YIN;
 output Y;

 buf	BUF_U_00(Y,YIN);

       specify

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOIN_IRC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Y,CLK =CLK, CLR=CLR, D=YIN ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOIN_IRC(CLR, CLK, Y,YIN);
 input YIN,CLR,CLK;
 output Y;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(Y, YIN,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Y = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge CLR => (Y +: 1'b0)) = (tpdLH_CLR_to_Y, tpdHL_CLR_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOIN_IRP
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Y,CLK =CLK, PRE=PRE, D=YIN ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOIN_IRP(PRE, CLK, Y,YIN);
 input YIN,PRE,CLK;
 output Y;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(Y, YIN,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Y = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge PRE => (Y +: 1'b1)) = (tpdLH_PRE_to_Y, tpdHL_PRE_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOTRI_OB_EB
 CELL TYPE : comb
 CELL LOGIC : DOUT=D;EOUT=E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OB_EB(DOUT,EOUT,D,E);
 input D,E;
 output DOUT,EOUT;

 buf	BUF_U_00(DOUT,D);
 buf	BUF_U_01(EOUT,E);

       specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );
		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOTRI_OB_ERC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=EOUT,CLK =CLK, CLR=CLR, D=E ];
 CELL COMB EQN : "DOUT = D"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OB_ERC(CLR, CLK, EOUT,DOUT,E,D);
 input E,D,CLR,CLK;
 output EOUT,DOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_DOUT_0(DOUT,D);

	// create the sequential logic -- DFF flip-flop plus comb input logic
 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(EOUT, E,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(D => DOUT) = (tpdLH_D_to_DOUT, tpdHL_D_to_DOUT);

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOTRI_OB_ERP
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=EOUT,CLK =CLK, PRE=PRE, D=E ];
 CELL COMB EQN : "DOUT = D"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OB_ERP(PRE, CLK, EOUT,DOUT,E,D);
 input E,D,PRE,CLK;
 output EOUT,DOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_DOUT_0(DOUT,D);

	// create the sequential logic -- DFF flip-flop plus comb input logic
 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(EOUT, E,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(D => DOUT) = (tpdLH_D_to_DOUT, tpdHL_D_to_DOUT);

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------
 CELL NAME : IOTRI_ORC_EB
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=DOUT,CLK =CLK, CLR=CLR, D=D ];
 CELL COMB EQN : "EOUT = E"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_ORC_EB(CLR, CLK, DOUT,EOUT,D,E);
 input D,E,CLR,CLK;
 output DOUT,EOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_EOUT_0(EOUT,E);

	// create the sequential logic -- DFF flip-flop plus comb input logic
 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(DOUT, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
       buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(E => EOUT) = (tpdLH_E_to_EOUT, tpdHL_E_to_EOUT);

	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOTRI_ORP_EB
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=DOUT,CLK =CLK, PRE=PRE, D=D ];
 CELL COMB EQN : "EOUT = E"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_ORP_EB(PRE, CLK, DOUT,EOUT,D,E);
 input D,E,PRE,CLK;
 output DOUT,EOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_EOUT_0(EOUT,E);

	// create the sequential logic -- DFF flip-flop plus comb input logic
 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(DOUT, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
       buf U_c4 (Enable04, _PRE0);
       buf U_c6 (Enable05, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(E => EOUT) = (tpdLH_E_to_EOUT, tpdHL_E_to_EOUT);

	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOTRI_ORC_ERC
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_ORC_ERC(DOUT,EOUT,D,CLK,CLR,E);
 input D,CLK,CLR,E;
 output DOUT,EOUT;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;


 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(DOUT, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(EOUT, E,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);



//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

		specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& ~CLR, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& ~CLR, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& ~CLR, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& ~CLR, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& ~CLR ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& ~CLR, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& ~CLR, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& ~CLR, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& ~CLR, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& ~CLR, negedge E,0.0, NOTIFY_REG);



 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults





/*--------------------------------------------------------------------
 CELL NAME : IOTRI_ORP_ERP
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_ORP_ERP(DOUT,EOUT,D,CLK,PRE,E);
 input D,CLK,PRE,E;
 output DOUT,EOUT;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;


 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(DOUT, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(EOUT, E,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);


// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
      buf U_c4 (Enable04, _PRE0);
      buf U_c6 (Enable05, _PRE0);





//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

		specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge E,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_OB_EB
 CELL TYPE : comb
 CELL LOGIC : DOUT=D;EOUT=E;Y=YIN
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OB_EB(DOUT,EOUT,Y,D,E,YIN);
 input D,E,YIN;
 output DOUT,EOUT,Y;

 buf	BUF_U_00(DOUT,D);
 buf	BUF_U_01(EOUT,E);
 buf	BUF_U_02(Y,YIN);

       specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );
		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );
		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_OB_ERC
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OB_ERC(DOUT,EOUT,Y,D,E,CLK,CLR,YIN);
 input D,E,CLK,CLR,YIN;
 output DOUT,EOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(EOUT, E,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);



// some temp signals created for timing checking sections

      not U1_I2 (_CLR1, CLR);
      buf U_c0 (Enable11,_CLR1);
       buf U_c2 (Enable12, _CLR1);
      buf U_c6 (Enable15, _CLR1);




//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_OB_ERP
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OB_ERP(DOUT,EOUT,Y,D,E,CLK,PRE,YIN);
 input D,E,CLK,PRE,YIN;
 output DOUT,EOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(EOUT, E,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);



// some temp signals created for timing checking sections

      not U1_I1 (_PRE1, PRE);
      buf U_c0 (Enable11, _PRE1);
      buf U_c4 (Enable14, _PRE1);
      buf U_c6 (Enable15, _PRE1);




//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
		specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
		specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);


		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_ORC_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_ORC_EB(EOUT,DOUT,Y,E,D,CLK,CLR,YIN);
 input E,D,CLK,CLR,YIN;
 output EOUT,DOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 buf	BUF_U_00(EOUT,E);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(DOUT, D,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);



// some temp signals created for timing checking sections

      not U1_I2 (_CLR1, CLR);
      buf U_c0 (Enable11,_CLR1);
       buf U_c2 (Enable12, _CLR1);
      buf U_c6 (Enable15, _CLR1);




//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );




	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_ORP_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_ORP_EB(EOUT,DOUT,Y,E,D,CLK,PRE,YIN);
 input E,D,CLK,PRE,YIN;
 output EOUT,DOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 buf	BUF_U_00(EOUT,E);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(DOUT, D,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);



// some temp signals created for timing checking sections

      not U1_I1 (_PRE1, PRE);
      buf U_c0 (Enable11, _PRE1);
       buf U_c4 (Enable14, _PRE1);
       buf U_c6 (Enable15, _PRE1);




//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );




	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);


		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_ORC_ERC
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_ORC_ERC(DOUT,EOUT,Y,D,CLK,CLR,E,YIN);
 input D,CLK,CLR,E,YIN;
 output DOUT,EOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(DOUT, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(EOUT, E,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);


// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
      buf U_c2 (Enable02, _CLR0);
      buf U_c6 (Enable05, _CLR0);



//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

	specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
	specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge E,0.0, NOTIFY_REG);


		//pin to pin path delay 

	(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_ORP_ERP
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_ORP_ERP(DOUT,EOUT,Y,D,CLK,PRE,E,YIN);
 input D,CLK,PRE,E,YIN;
 output DOUT,EOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;



 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(DOUT, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(EOUT, E,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 buf	BUF_U_20(Y,YIN);


// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
      buf U_c4 (Enable04, _PRE0);
      buf U_c6 (Enable05, _PRE0);


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

	specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
	specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	//pin to pin path delay 

	(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults





/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRC_OB_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRC_OB_EB(DOUT,EOUT,Y,D,E,YIN,CLK,CLR);
 input D,E,YIN,CLK,CLR;
 output DOUT,EOUT,Y;


 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 buf	BUF_U_10(EOUT,E);

 not INV_CLR_2(CLR_2, CLR);

 Dffpr DF_2(Y, YIN,CLK,CLR_2, VCC_2, GND_2, NOTIFY_REG);




// some temp signals created for timing checking sections

      not U2_I2 (_CLR2, CLR);
      buf U_c0 (Enable21,_CLR2);
      buf U_c2 (Enable22, _CLR2);
      buf U_c6 (Enable25, _CLR2);



//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
		specparam   tpdLH_CLR_to_Y = (0.1:0.1:0.1);
		specparam   tpdHL_CLR_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );


		//pin to pin path delay 

		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );




	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge CLR => (Y +: 1'b0)) = (tpdLH_CLR_to_Y, tpdHL_CLR_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable25 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable25, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRP_OB_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRP_OB_EB(DOUT,EOUT,Y,D,E,YIN,CLK,PRE);
 input D,E,YIN,CLK,PRE;
 output DOUT,EOUT,Y;


 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 buf	BUF_U_10(EOUT,E);

 not INV_PRE_2(PRE_2, PRE);

 Dffpr DF_2(Y, YIN,CLK,VCC_2, PRE_2, GND_2, NOTIFY_REG);




// some temp signals created for timing checking sections

      not U2_I1 (_PRE2, PRE);
      buf U_c0 (Enable21, _PRE2);
       buf U_c4 (Enable24, _PRE2);
       buf U_c6 (Enable25, _PRE2);



//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

		specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
		specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
		specparam   tpdLH_PRE_to_Y = (0.1:0.1:0.1);
		specparam   tpdHL_PRE_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );


		//pin to pin path delay 

		(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );




	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge PRE => (Y +: 1'b1)) = (tpdLH_PRE_to_Y, tpdHL_PRE_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable25 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable25, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRC_OB_ERC
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRC_OB_ERC(DOUT,EOUT,Y,D,E,CLK,CLR,YIN);
 input D,E,CLK,CLR,YIN;
 output DOUT,EOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(EOUT, E,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 not INV_CLR_2(CLR_2, CLR);

 Dffpr DF_2(Y, YIN,CLK,CLR_2, VCC_2, GND_2, NOTIFY_REG);



// some temp signals created for timing checking sections

      not U1_I2 (_CLR1, CLR);
      buf U_c0 (Enable11,_CLR1);
      buf U_c6 (Enable15, _CLR1);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";

		//pin to pin path delay 

	(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge CLR => (Y +: 1'b0)) = (tpdLH_CLR_to_Y, tpdHL_CLR_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRP_OB_ERP
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRP_OB_ERP(DOUT,EOUT,Y,D,E,CLK,PRE,YIN);
 input D,E,CLK,PRE,YIN;
 output DOUT,EOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(EOUT, E,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 not INV_PRE_2(PRE_2, PRE);

 Dffpr DF_2(Y, YIN,CLK,VCC_2, PRE_2, GND_2, NOTIFY_REG);



// some temp signals created for timing checking sections

      not U1_I1 (_PRE1, PRE);
      buf U_c0 (Enable11, _PRE1);
      buf U_c4 (Enable14, _PRE1);
      buf U_c6 (Enable15, _PRE1);


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

	(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge PRE => (Y +: 1'b1)) = (tpdLH_PRE_to_Y, tpdHL_PRE_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRC_ORC_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRC_ORC_EB(EOUT,DOUT,Y,E,D,CLK,CLR,YIN);
 input E,D,CLK,CLR,YIN;
 output EOUT,DOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(EOUT,E);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(DOUT, D,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 not INV_CLR_2(CLR_2, CLR);

 Dffpr DF_2(Y, YIN,CLK,CLR_2, VCC_2, GND_2, NOTIFY_REG);



// some temp signals created for timing checking sections

      not U1_I2 (_CLR1, CLR);
      buf U_c0 (Enable11,_CLR1);
      buf U_c2 (Enable12, _CLR1);
      buf U_c6 (Enable15, _CLR1);

      buf U_c3 (Enable21,_CLR1);
      buf U_c4 (Enable22, _CLR1);
 


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";

		//pin to pin path delay 

	(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );


	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge CLR => (Y +: 1'b0)) = (tpdLH_CLR_to_Y, tpdHL_CLR_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRP_ORP_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRP_ORP_EB(EOUT,DOUT,Y,E,D,CLK,PRE,YIN);
 input E,D,CLK,PRE,YIN;
 output EOUT,DOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(EOUT,E);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(DOUT, D,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 not INV_PRE_2(PRE_2, PRE);

 Dffpr DF_2(Y, YIN,CLK,VCC_2, PRE_2, GND_2, NOTIFY_REG);



// some temp signals created for timing checking sections

      not U1_I1 (_PRE1, PRE);
      buf U_c0 (Enable11, _PRE1);
      buf U_c1 (Enable14, _PRE1);
      buf U_c2 (Enable15, _PRE1);

      buf U_c3 (Enable21, _PRE1);
      buf U_c4 (Enable24, _PRE1);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

	(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );


	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable15 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable15, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge PRE => (Y +: 1'b1)) = (tpdLH_PRE_to_Y, tpdHL_PRE_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRC_ORC_ERC
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRC_ORC_ERC(DOUT,EOUT,Y,D,CLK,CLR,E,YIN);
 input D,CLK,CLR,E,YIN;
 output DOUT,EOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 not INV_CLR_0(CLR_0, CLR);

 Dffpr DF_0(DOUT, D,CLK,CLR_0, VCC_0, GND_0, NOTIFY_REG);

 not INV_CLR_1(CLR_1, CLR);

 Dffpr DF_1(EOUT, E,CLK,CLR_1, VCC_1, GND_1, NOTIFY_REG);

 not INV_CLR_2(CLR_2, CLR);

 Dffpr DF_2(Y, YIN,CLK,CLR_2, VCC_2, GND_2, NOTIFY_REG);


// some temp signals created for timing checking sections

      not U0_I2 (_CLR0, CLR);
      buf U_c0 (Enable01,_CLR0);
      buf U_c1 (Enable02, _CLR0);
      buf U_c2 (Enable05, _CLR0);

      buf U_c3 (Enable11,_CLR0);
      buf U_c4 (Enable12, _CLR0);
      buf U_c5 (Enable15, _CLR0);

      buf U_c6 (Enable21,_CLR0);
      buf U_c7 (Enable22, _CLR0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge CLR => (DOUT +: 1'b0)) = (tpdLH_CLR_to_DOUT, tpdHL_CLR_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, negedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge CLR => (EOUT +: 1'b0)) = (tpdLH_CLR_to_EOUT, tpdHL_CLR_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge CLR => (Y +: 1'b0)) = (tpdLH_CLR_to_Y, tpdHL_CLR_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IRP_ORP_ERP
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IRP_ORP_ERP(DOUT,EOUT,Y,D,CLK,PRE,E,YIN);
 input D,CLK,PRE,E,YIN;
 output DOUT,EOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(DOUT, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

 not INV_PRE_1(PRE_1, PRE);

 Dffpr DF_1(EOUT, E,CLK,VCC_1, PRE_1, GND_1, NOTIFY_REG);

 not INV_PRE_2(PRE_2, PRE);

 Dffpr DF_2(Y, YIN,CLK,VCC_2, PRE_2, GND_2, NOTIFY_REG);


// some temp signals created for timing checking sections

      not U0_I1 (_PRE0, PRE);
      buf U_c0 (Enable01, _PRE0);
      buf U_c1 (Enable04, _PRE0);
      buf U_c2 (Enable05, _PRE0);

      buf U_c3 (Enable11, _PRE0);
      buf U_c4 (Enable14, _PRE0);
      buf U_c5 (Enable15, _PRE0);

      buf U_c6 (Enable21, _PRE0);
      buf U_c7 (Enable24, _PRE0);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);
	(posedge PRE => (DOUT +: 1'b1)) = (tpdLH_PRE_to_DOUT, tpdHL_PRE_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable01, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable01, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable05 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable05, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);
	(posedge PRE => (EOUT +: 1'b1)) = (tpdLH_PRE_to_EOUT, tpdHL_PRE_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable11, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable11, negedge E,0.0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);
	(posedge PRE => (Y +: 1'b1)) = (tpdLH_PRE_to_Y, tpdHL_PRE_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK &&& Enable21, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable21, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOPAD_IN
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_IN(Y,PAD);
 input PAD;
 output Y;

 reg NOTIFY_REG;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : IOPAD_TRI
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_TRI(PAD,D,E);
 input D,E;
 output PAD;

 reg NOTIFY_REG;

 bufif1   U1210(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOPAD_BI
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_BI(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;

 reg NOTIFY_REG;

 bufif1   U1213(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                specparam PATHPULSE$D$Y = (0.1, 0.1);
                specparam PATHPULSE$E$Y = (0.1, 0.1);
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : IOPAD_IN_U
 CELL TYPE : comb
 CELL LOGIC : Y#UP=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_IN_U(Y,PAD);
 input PAD;
 output Y;

 reg NOTIFY_REG;

 pullup	UP(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOPAD_IN_D
 CELL TYPE : comb
 CELL LOGIC : Y#DOWN=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_IN_D(Y,PAD);
 input PAD;
 output Y;

 reg NOTIFY_REG;

 pulldown	DN(PAD);
 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOPAD_TRI_U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_TRI_U(PAD,D,E);
 input D,E;
 output PAD;

 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U2089(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOPAD_TRI_D
 CELL TYPE : comb
 CELL LOGIC : PAD#DOWN=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_TRI_D(PAD,D,E);
 input D,E;
 output PAD;

 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U2092(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOPAD_BI_U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_BI_U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;

 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U2095(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                specparam PATHPULSE$D$Y = (0.1, 0.1);
                specparam PATHPULSE$E$Y = (0.1, 0.1);
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOPAD_BI_D
 CELL TYPE : comb
 CELL LOGIC : PAD#DOWN=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOPAD_BI_D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;

 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U2098(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
                specparam PATHPULSE$D$PAD = (0.1, 0.1);
                specparam PATHPULSE$E$PAD = (0.1, 0.1);
                specparam PATHPULSE$D$Y = (0.1, 0.1);
                specparam PATHPULSE$E$Y = (0.1, 0.1);
                specparam PATHPULSE$PAD$Y = (0.1, 0.1);
                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_6(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1079(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_6D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_6D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1082(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_6U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_6U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1085(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_2(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1052(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_2D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_2D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1055(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_2U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_2U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1058(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_4(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1061(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_4D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_4D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1064(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_F_4U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_F_4U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1067(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_2(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1103(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_2D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_2D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1106(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_2U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_2U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1109(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_4(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1112(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_4D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_4D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1115(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_4U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_4U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1118(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_6(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1121(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_6D
 CELL TYPE : comb
 CELL LOGIC : PAD#Down=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_6D(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1124(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF_S_6U
 CELL TYPE : comb
 CELL LOGIC : PAD#UP=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF_S_6U(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1127(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_2(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_4(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_F_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_F_6(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_2(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_4(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : OUTBUF_S_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF_S_6(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_2(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1139(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_2D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_2D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1142(PAD, D, E);
 tri0 PAD;

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_2U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_2U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1145(PAD, D, E);
       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_4(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1148(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_4D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_4D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1151(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_4U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_4U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1154(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_6(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1157(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_6D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_6D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1160(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_F_6U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_F_6U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1163(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_2
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_2(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1190(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_2D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_2D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1193(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_2U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_2U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1196(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_4
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_4(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1199(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_4D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_4D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1202(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_4U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_4U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1205(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_6
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_6(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 bufif1   U1208(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_6D
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_6D(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri0 PAD;
 bufif1   U1211(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF_S_6U
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF_S_6U(PAD,D,E);
 input D,E;
 output PAD;
 reg NOTIFY_REG;

 tri1 PAD;
 bufif1   U1214(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if (~D)
		(E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);

                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : BUFD
 CELL TYPE : comb
 CELL LOGIC : Y=A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BUFD(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INVD
 CELL TYPE : comb
 CELL LOGIC : Y=!A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INVD(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOIN_IR
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Y,CLK =CLK, D=YIN ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOIN_IR(CLK, Y,YIN);
 input YIN,CLK;
 output Y;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Y, YIN,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : IOTRI_OB_ER
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=EOUT,CLK =CLK, D=E ];
 CELL COMB EQN : "DOUT = D"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OB_ER(CLK, EOUT,DOUT,E,D);
 input E,D,CLK;
 output EOUT,DOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_DOUT_0(DOUT,D);

	// create the sequential logic -- DFF flip-flop plus comb input logic

 Dffpr DF_0(EOUT, E,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_D_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(D => DOUT) = (tpdLH_D_to_DOUT, tpdHL_D_to_DOUT);

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------
 CELL NAME : IOTRI_OR_EB
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=DOUT,CLK =CLK, D=D ];
 CELL COMB EQN : "EOUT = E"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OR_EB(CLK, DOUT,EOUT,D,E);
 input D,E,CLK;
 output DOUT,EOUT;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_EOUT_0(EOUT,E);

	// create the sequential logic -- DFF flip-flop plus comb input logic

 Dffpr DF_0(DOUT, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(E => EOUT) = (tpdLH_E_to_EOUT, tpdHL_E_to_EOUT);

	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOTRI_OR_ER
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOTRI_OR_ER(EOUT,DOUT,E,CLK,D);
 input E,CLK,D;
 output EOUT,DOUT;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;


 reg NOTIFY_REG;


 Dffpr DF_0(EOUT, E,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

 Dffpr DF_1(DOUT, D,CLK,VCC_1, VCC_1, GND_1, NOTIFY_REG);



//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

	specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_OB_ER
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OB_ER(DOUT,Y,EOUT,D,YIN,E,CLK);
 input D,YIN,E,CLK;
 output DOUT,Y,EOUT;


 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 buf	BUF_U_10(Y,YIN);


 Dffpr DF_2(EOUT, E,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
		specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );


		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );




	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data



 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------
 CELL NAME : IOBI_IB_OR_EB
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=DOUT,CLK =CLK, D=D ];
 CELL COMB EQN : "EOUT = E, Y = YIN"
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OR_EB(CLK, DOUT,Y, EOUT,D,E, YIN);
 input D,E,CLK,YIN;
 output DOUT,EOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

	// create Logics for combinatorial output Logics! 

 buf BUF_EOUT_0(EOUT,E);
 buf U0 (Y,YIN);

	// create the sequential logic -- DFF flip-flop plus comb input logic

 Dffpr DF_0(DOUT, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_E_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

        // checking timing path for combinatorial output

	(E => EOUT) = (tpdLH_E_to_EOUT, tpdHL_E_to_EOUT);

        (YIN => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOBI_IB_OR_ER
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IB_OR_ER(Y,DOUT,EOUT,YIN,D,CLK,E);
 input YIN,D,CLK,E;
 output Y,DOUT,EOUT;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(Y,YIN);


 Dffpr DF_1(DOUT, D,CLK,VCC_1, VCC_1, GND_1, NOTIFY_REG);
 Dffpr DF_2(EOUT, E,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

		specparam tpdLH_YIN_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_YIN_to_Y = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

		specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
		specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

		specparam MacroType = "multi";

		//pin to pin path delay 

		(YIN => Y ) = ( tpdLH_YIN_to_Y, tpdHL_YIN_to_Y );




	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOBI_IR_OB_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IR_OB_EB(DOUT,EOUT,Y,D,E,YIN,CLK);
 input D,E,YIN,CLK;
 output DOUT,EOUT,Y;


 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);

 buf	BUF_U_10(EOUT,E);


 Dffpr DF_2(Y, YIN,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

	specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";

	//pin to pin path delay 

	(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );


	//pin to pin path delay 

	(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );


	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data



 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IR_OB_ER
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IR_OB_ER(DOUT,EOUT,Y,D,E,CLK,YIN);
 input D,E,CLK,YIN;
 output DOUT,EOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(DOUT,D);


 Dffpr DF_1(EOUT, E,CLK,VCC_1, VCC_1, GND_1, NOTIFY_REG);

 Dffpr DF_2(Y, YIN,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_D_to_DOUT = (0.1:0.1:0.1);
	specparam tpdHL_D_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";

	//pin to pin path delay 

	(D => DOUT ) = ( tpdLH_D_to_DOUT, tpdHL_D_to_DOUT );

	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);


	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge YIN,0.0, NOTIFY_REG);

	//checking timing for control signals



 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : IOBI_IR_OR_EB
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IR_OR_EB(EOUT,DOUT,Y,E,D,CLK,YIN);
 input E,D,CLK,YIN;
 output EOUT,DOUT,Y;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;

 buf	BUF_U_00(EOUT,E);


 Dffpr DF_1(DOUT, D,CLK,VCC_1, VCC_1, GND_1, NOTIFY_REG);
 Dffpr DF_2(Y, YIN,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam tpdLH_E_to_EOUT = (0.1:0.1:0.1);
	specparam tpdHL_E_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);

	specparam MacroType = "multi";

	//pin to pin path delay 

	(E => EOUT ) = ( tpdLH_E_to_EOUT, tpdHL_E_to_EOUT );

	//check timing delay for output

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : IOBI_IR_OR_ER
 CELL TYPE : multi
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module IOBI_IR_OR_ER(EOUT,DOUT,Y,E,CLK,D,YIN);
 input E,CLK,D,YIN;
 output EOUT,DOUT,Y;
 supply1 VCC_0;
 supply0 GND_0;

 supply1 VCC_1;
 supply0 GND_1;

 supply1 VCC_2;
 supply0 GND_2;


 reg NOTIFY_REG;


 Dffpr DF_0(EOUT, E,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);
 Dffpr DF_1(DOUT, D,CLK,VCC_1, VCC_1, GND_1, NOTIFY_REG);
 Dffpr DF_2(Y, YIN,CLK,VCC_2, VCC_2, GND_2, NOTIFY_REG);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_EOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_EOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_DOUT = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_DOUT = (0.1:0.1:0.1);

	specparam   tpdLH_CLK_to_Y = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Y = (0.1:0.1:0.1);

		specparam MacroType = "multi";



	//check timing delay for output

	(posedge CLK => (EOUT +: E))=(tpdLH_CLK_to_EOUT, tpdHL_CLK_to_EOUT);

	//checking setup and hold timing for inputs

	$setup(posedge E,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	(posedge CLK => (DOUT +: D))=(tpdLH_CLK_to_DOUT, tpdHL_CLK_to_DOUT);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//check timing delay for output

	(posedge CLK => (Y +: YIN))=(tpdLH_CLK_to_Y, tpdHL_CLK_to_Y);

	//checking setup and hold timing for inputs

	$setup(posedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge YIN,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge YIN,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge YIN,0.0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------------
 CELL NAME : CLKIO
 CELL TYPE : comb
 CELL LOGIC : Y=A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKIO(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults

/*--------------------------------------------------------------------
 CELL NAME : CLKBIBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E % Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBIBUF(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;
 reg NOTIFY_REG;

 bufif1   U1583(PAD, D, E);
 buf    BUF_U1(Y,PAD);

        specify
		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
                specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
                specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
                specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
                specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
                specparam tpdLH_D_to_PAD= (0.1:0.1:0.1);
                specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
                specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

            //if (~D)
                (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

                (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
                (D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
                (E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
                (PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );

                $width(negedge PAD, 0.0, 0, NOTIFY_REG);
                $width(posedge PAD, 0.0, 0, NOTIFY_REG);
                $width(negedge D, 0.0, 0, NOTIFY_REG);
                $width(posedge D, 0.0, 0, NOTIFY_REG);
                $width(negedge E, 0.0, 0, NOTIFY_REG);
                $width(posedge E, 0.0, 0, NOTIFY_REG);

        endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*-----------------------------------------------------------------
 CELL NAME : RAM4K9
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ps/1 ps

module RAM4K9 (ADDRA11, ADDRA10, ADDRA9, ADDRA8, ADDRA7, ADDRA6, ADDRA5,
               ADDRA4, ADDRA3, ADDRA2, ADDRA1, ADDRA0, DINA8, DINA7, DINA6,
               DINA5, DINA4, DINA3, DINA2, DINA1, DINA0, DOUTA8, DOUTA7,
               DOUTA6, DOUTA5, DOUTA4, DOUTA3, DOUTA2, DOUTA1, DOUTA0,
               WIDTHA1, WIDTHA0, PIPEA, WMODEA, BLKA, WENA, CLKA,
               ADDRB11, ADDRB10, ADDRB9, ADDRB8, ADDRB7, ADDRB6, ADDRB5,
               ADDRB4, ADDRB3, ADDRB2, ADDRB1, ADDRB0, DINB8, DINB7, DINB6,
               DINB5, DINB4, DINB3, DINB2, DINB1, DINB0, DOUTB8, DOUTB7,
               DOUTB6, DOUTB5, DOUTB4, DOUTB3, DOUTB2, DOUTB1, DOUTB0,
               WIDTHB1, WIDTHB0, PIPEB, WMODEB, BLKB, WENB, CLKB, RESET
              );

parameter DELAY_TWO = 2;
parameter TC2CWRH = 1013;
parameter TC2CRWH = 888;
parameter TC2CWWL = 300;

input ADDRA11, ADDRA10, ADDRA9, ADDRA8, ADDRA7, ADDRA6, ADDRA5, ADDRA4, ADDRA3, ADDRA2, ADDRA1, ADDRA0;
input DINA8, DINA7, DINA6, DINA5, DINA4, DINA3, DINA2, DINA1, DINA0;
input WIDTHA1, WIDTHA0, PIPEA, WMODEA, BLKA, WENA, CLKA;
input ADDRB11, ADDRB10, ADDRB9, ADDRB8, ADDRB7, ADDRB6, ADDRB5, ADDRB4, ADDRB3, ADDRB2, ADDRB1, ADDRB0;
input DINB8, DINB7, DINB6, DINB5, DINB4, DINB3, DINB2, DINB1, DINB0;
input WIDTHB1, WIDTHB0, PIPEB, WMODEB, BLKB, WENB, CLKB, RESET;

output DOUTA8, DOUTA7, DOUTA6, DOUTA5, DOUTA4, DOUTA3, DOUTA2, DOUTA1, DOUTA0;
output DOUTB8, DOUTB7, DOUTB6, DOUTB5, DOUTB4, DOUTB3, DOUTB2, DOUTB1, DOUTB0; 


reg DOUTAP8, DOUTAP7, DOUTAP6, DOUTAP5, DOUTAP4, DOUTAP3, DOUTAP2, DOUTAP1, DOUTAP0;
reg DOUTBP8, DOUTBP7, DOUTBP6, DOUTBP5, DOUTBP4, DOUTBP3, DOUTBP2, DOUTBP1, DOUTBP0;

reg DOUTAP8_stg1, DOUTAP7_stg1, DOUTAP6_stg1, DOUTAP5_stg1, DOUTAP4_stg1, DOUTAP3_stg1, DOUTAP2_stg1, DOUTAP1_stg1, DOUTAP0_stg1;
reg DOUTBP8_stg1, DOUTBP7_stg1, DOUTBP6_stg1, DOUTBP5_stg1, DOUTBP4_stg1, DOUTBP3_stg1, DOUTBP2_stg1, DOUTBP1_stg1, DOUTBP0_stg1;

wire CLKA_int, CLKB_int;
wire WENA_int, WENB_int, WMODEA_int, WMODEB_int;
wire BLKA_int, BLKB_int, RESET_int,  PIPEA_int, PIPEB_int;

wire ADDRA11_int, ADDRA10_int, ADDRA9_int, ADDRA8_int, ADDRA7_int, ADDRA6_int, ADDRA5_int, ADDRA4_int;
wire ADDRA3_int, ADDRA2_int, ADDRA1_int, ADDRA0_int;

wire ADDRB11_int, ADDRB10_int, ADDRB9_int, ADDRB8_int, ADDRB7_int, ADDRB6_int, ADDRB5_int, ADDRB4_int;
wire ADDRB3_int, ADDRB2_int, ADDRB1_int, ADDRB0_int;

wire DINA8_int, DINA7_int, DINA6_int, DINA5_int, DINA4_int, DINA3_int, DINA2_int, DINA1_int, DINA0_int;
wire DINB8_int, DINB7_int, DINB6_int, DINB5_int, DINB4_int, DINB3_int, DINB2_int, DINB1_int, DINB0_int;

reg [8:0] MEM_512_9 [0:511];

reg NOTIFY_REG;

integer ADDRA;            // Address of PORT A
integer ADDRB;            // Address of PORT B
integer DEPTH;
integer MAXADD;

reg  ADDRA_VALID;
reg  ADDRB_VALID;

wire BLKA_EN;
wire BLKB_EN;

wire BLKA_WEN;
wire BLKB_WEN;

time CLKA_wr_re, CLKA_rd_re;
time CLKA_wr_fe;
time CLKB_wr_re, CLKB_rd_re;
time CLKB_wr_fe;

reg  WENA_lat, WENB_lat;

reg  DINA8_reg, DINA7_reg, DINA6_reg, DINA5_reg, DINA4_reg, DINA3_reg, DINA2_reg, DINA1_reg, DINA0_reg;
reg  DINB8_reg, DINB7_reg, DINB6_reg, DINB5_reg, DINB4_reg, DINB3_reg, DINB2_reg, DINB1_reg, DINB0_reg;

reg  DINA8_bypass, DINA7_bypass, DINA6_bypass, DINA5_bypass, DINA4_bypass;
reg  DINA3_bypass, DINA2_bypass, DINA1_bypass, DINA0_bypass;

reg  DINB8_bypass, DINB7_bypass, DINB6_bypass, DINB5_bypass, DINB4_bypass;
reg  DINB3_bypass, DINB2_bypass, DINB1_bypass, DINB0_bypass;


/********************* TEXT MACRO DEFINITIONS ******************/

`define BLKA_WIDTH_CFG {WIDTHA1,WIDTHA0}
`define BLKB_WIDTH_CFG {WIDTHB1,WIDTHB0}

`define BLKA_ADDR      {ADDRA11_int,ADDRA10_int,ADDRA9_int,ADDRA8_int,ADDRA7_int,ADDRA6_int,ADDRA5_int,ADDRA4_int,ADDRA3_int,ADDRA2_int,ADDRA1_int,ADDRA0_int}
`define BLKB_ADDR      {ADDRB11_int,ADDRB10_int,ADDRB9_int,ADDRB8_int,ADDRB7_int,ADDRB6_int,ADDRB5_int,ADDRB4_int,ADDRB3_int,ADDRB2_int,ADDRB1_int,ADDRB0_int}

`define DATA_A_OUT     {DOUTAP8,DOUTAP7,DOUTAP6,DOUTAP5,DOUTAP4,DOUTAP3,DOUTAP2,DOUTAP1,DOUTAP0}
`define DATA_B_OUT     {DOUTBP8,DOUTBP7,DOUTBP6,DOUTBP5,DOUTBP4,DOUTBP3,DOUTBP2,DOUTBP1,DOUTBP0}

`define DATAP_A_OUT    {DOUTAP8_stg1,DOUTAP7_stg1,DOUTAP6_stg1,DOUTAP5_stg1,DOUTAP4_stg1,DOUTAP3_stg1,DOUTAP2_stg1,DOUTAP1_stg1,DOUTAP0_stg1}
`define DATAP_B_OUT    {DOUTBP8_stg1,DOUTBP7_stg1,DOUTBP6_stg1,DOUTBP5_stg1,DOUTBP4_stg1,DOUTBP3_stg1,DOUTBP2_stg1,DOUTBP1_stg1,DOUTBP0_stg1}

`define DATA_A_IN      {DINA8_int,DINA7_int,DINA6_int,DINA5_int,DINA4_int,DINA3_int,DINA2_int,DINA1_int,DINA0_int}
`define DATA_B_IN      {DINB8_int,DINB7_int,DINB6_int,DINB5_int,DINB4_int,DINB3_int,DINB2_int,DINB1_int,DINB0_int}

`define DATA_A_REG     {DINA8_reg,DINA7_reg,DINA6_reg,DINA5_reg,DINA4_reg,DINA3_reg,DINA2_reg,DINA1_reg,DINA0_reg}
`define DATA_B_REG     {DINB8_reg,DINB7_reg,DINB6_reg,DINB5_reg,DINB4_reg,DINB3_reg,DINB2_reg,DINB1_reg,DINB0_reg}

`define DATA_A_BYP     {DINA8_bypass,DINA7_bypass,DINA6_bypass,DINA5_bypass,DINA4_bypass,DINA3_bypass,DINA2_bypass,DINA1_bypass,DINA0_bypass}
`define DATA_B_BYP     {DINB8_bypass,DINB7_bypass,DINB6_bypass,DINB5_bypass,DINB4_bypass,DINB3_bypass,DINB2_bypass,DINB1_bypass,DINB0_bypass}

assign BLKA_EN = ~BLKA_int & RESET_int;
assign BLKB_EN = ~BLKB_int & RESET_int;
assign BLKA_WEN = ~BLKA_int & RESET_int & ~WENA_int;
assign BLKB_WEN = ~BLKB_int & RESET_int & ~WENB_int;

buf b0(CLKA_int, CLKA);
buf b1(CLKB_int, CLKB);
buf b2(WENA_int, WENA);
buf b3(WENB_int, WENB);

buf b4(DINA0_int, DINA0);
buf b5(DINA1_int, DINA1);
buf b6(DINA2_int, DINA2);
buf b7(DINA3_int, DINA3);
buf b8(DINA4_int, DINA4);
buf b9(DINA5_int, DINA5);
buf b10(DINA6_int, DINA6);
buf b11(DINA7_int, DINA7);
buf b12(DINA8_int, DINA8);


buf b13(DINB0_int, DINB0);
buf b14(DINB1_int, DINB1);
buf b15(DINB2_int, DINB2);
buf b16(DINB3_int, DINB3);
buf b17(DINB4_int, DINB4);
buf b18(DINB5_int, DINB5);
buf b19(DINB6_int, DINB6);
buf b20(DINB7_int, DINB7);
buf b21(DINB8_int, DINB8);

buf b22(ADDRA0_int, ADDRA0);
buf b23(ADDRA1_int, ADDRA1);
buf b24(ADDRA2_int, ADDRA2);
buf b25(ADDRA3_int, ADDRA3);
buf b26(ADDRA4_int, ADDRA4);
buf b27(ADDRA5_int, ADDRA5);
buf b28(ADDRA6_int, ADDRA6);
buf b29(ADDRA7_int, ADDRA7);
buf b30(ADDRA8_int, ADDRA8);
buf b31(ADDRA9_int, ADDRA9);
buf b32(ADDRA10_int, ADDRA10);
buf b33(ADDRA11_int, ADDRA11);

buf b34(ADDRB0_int, ADDRB0);
buf b35(ADDRB1_int, ADDRB1);
buf b36(ADDRB2_int, ADDRB2);
buf b37(ADDRB3_int, ADDRB3);
buf b38(ADDRB4_int, ADDRB4);
buf b39(ADDRB5_int, ADDRB5);
buf b40(ADDRB6_int, ADDRB6);
buf b41(ADDRB7_int, ADDRB7);
buf b42(ADDRB8_int, ADDRB8);
buf b43(ADDRB9_int, ADDRB9);
buf b44(ADDRB10_int, ADDRB10);
buf b45(ADDRB11_int, ADDRB11);

buf b46(RESET_int, RESET);
buf b47(BLKA_int, BLKA);
buf b48(BLKB_int, BLKB);
buf b49(PIPEA_int, PIPEA);
buf b50(PIPEB_int, PIPEB);
buf b51(WMODEA_int, WMODEA);
buf b52(WMODEB_int, WMODEB);

pmos inst1(DOUTA0, DOUTAP0, 0);
pmos inst2(DOUTA1, DOUTAP1, 0);
pmos inst3(DOUTA2, DOUTAP2, 0);
pmos inst4(DOUTA3, DOUTAP3, 0);
pmos inst5(DOUTA4, DOUTAP4, 0);
pmos inst6(DOUTA5, DOUTAP5, 0);
pmos inst7(DOUTA6, DOUTAP6, 0);
pmos inst8(DOUTA7, DOUTAP7, 0);
pmos inst9(DOUTA8, DOUTAP8, 0);

pmos inst10(DOUTB0, DOUTBP0, 0);
pmos inst11(DOUTB1, DOUTBP1, 0);
pmos inst12(DOUTB2, DOUTBP2, 0);
pmos inst13(DOUTB3, DOUTBP3, 0);
pmos inst14(DOUTB4, DOUTBP4, 0);
pmos inst15(DOUTB5, DOUTBP5, 0);
pmos inst16(DOUTB6, DOUTBP6, 0);
pmos inst17(DOUTB7, DOUTBP7, 0);
pmos inst18(DOUTB8, DOUTBP8, 0);

parameter MEMORYFILE = "";
parameter WARNING_MSGS_ON = 1; // Used to turn off warnings about read &
                               // write to same address at same time.
                               // Default = on.  Set to 0 to turn them off.

  initial
    begin
    
      if ( WARNING_MSGS_ON == 0 )
        $display("Note: RAM4K9 warnings disabled. Set WARNING_MSGS_ON = 1 to enable.");

      if ( MEMORYFILE != "")
        $readmemb ( MEMORYFILE, MEM_512_9 );
      else
        begin
          //if ( WARNING_MSGS_ON == 1 )
            //$display ( "Note: Module %m, memory initialization file parameter MEMORYFILE not defined" );
        end
    end


always @(CLKA_int === 1'bx )
begin
  if ($time > 0) begin
    if (BLKA_int == 1'b0) begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning : CLKA went unknown at time %0.1f ps. Instance: %m\n",$realtime*100);
    end
  end
end

always @(CLKB_int === 1'bx )
begin
  if ($time > 0) begin
    if (BLKB_int == 1'b0) begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning : CLKB went unknown at time %0.1f ps. Instance: %m\n",$realtime*100);
    end
  end
end

  always @(RESET_int)
      begin
	  if(RESET_int === 1'b0 )
	      begin

		  if (PIPEA_int == 1'b0) begin 
		      case (`BLKA_WIDTH_CFG)
			 2'b00 : DOUTAP0 = 1'b0;
			 2'b01 : begin
			     DOUTAP0 = 1'b0;
			     DOUTAP1 = 1'b0;
			 end
			 2'b10 : begin
			     DOUTAP0 = 1'b0;
			     DOUTAP1 = 1'b0;
			     DOUTAP2 = 1'b0;
			     DOUTAP3 = 1'b0;
			 end
			 2'b11 : begin
			     DOUTAP0 = 1'b0;
			     DOUTAP1 = 1'b0;
			     DOUTAP2 = 1'b0;
			     DOUTAP3 = 1'b0;
			     DOUTAP4 = 1'b0;
			     DOUTAP5 = 1'b0;
			     DOUTAP6 = 1'b0;
			     DOUTAP7 = 1'b0;
			     DOUTAP8 = 1'b0;
			 end
			 default:
			     begin
				// if ( WARNING_MSGS_ON == 1 )
				//     $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9", $time);
			     end
		      endcase
		  end else if (PIPEA_int == 1'b1) begin
		      case (`BLKA_WIDTH_CFG)
			 2'b00 : begin
			     DOUTAP0      = 1'b0;
			     DOUTAP0_stg1 = 1'b0;
			 end
			 2'b01 : begin
			     DOUTAP0 = 1'b0;
			     DOUTAP1 = 1'b0;
			     DOUTAP0_stg1 = 1'b0;
			     DOUTAP1_stg1 = 1'b0;
			 end
			 2'b10 : begin
			     DOUTAP0= 1'b0;
			     DOUTAP1 = 1'b0;
			     DOUTAP2 = 1'b0;
			     DOUTAP3 = 1'b0;
			     DOUTAP0_stg1= 1'b0;
			     DOUTAP1_stg1 = 1'b0;
			     DOUTAP2_stg1 = 1'b0;
			     DOUTAP3_stg1 = 1'b0;
			 end
			 2'b11 : begin
			     DOUTAP0 = 1'b0;
			     DOUTAP1 = 1'b0;
			     DOUTAP2 = 1'b0;
			     DOUTAP3 = 1'b0;
			     DOUTAP4 = 1'b0;
			     DOUTAP5 = 1'b0;
			     DOUTAP6 = 1'b0;
			     DOUTAP7 = 1'b0;
			     DOUTAP8 = 1'b0;
			     DOUTAP0_stg1 = 1'b0;
			     DOUTAP1_stg1 = 1'b0;
			     DOUTAP2_stg1 = 1'b0;
			     DOUTAP3_stg1 = 1'b0;
			     DOUTAP4_stg1 = 1'b0;
			     DOUTAP5_stg1 = 1'b0;
			     DOUTAP6_stg1 = 1'b0;
			     DOUTAP7_stg1 = 1'b0;
			     DOUTAP8_stg1 = 1'b0;

			 end
			 default:
			     begin
				 //if ( WARNING_MSGS_ON == 1 )
				 //    $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9", $time);
			     end
		      endcase
		  end

		  if (PIPEB_int == 1'b0) begin  
		      case (`BLKB_WIDTH_CFG)
			 2'b00 : DOUTBP0 = 1'b0;
			 2'b01 : begin
			     DOUTBP0 = 1'b0;
			     DOUTBP1 = 1'b0;
			 end
			 2'b10 : begin
			     DOUTBP0= 1'b0;
			     DOUTBP1 = 1'b0;
			     DOUTBP2 = 1'b0;
			     DOUTBP3 = 1'b0;
			 end
			 2'b11 : begin
			     DOUTBP0 = 1'b0;
			     DOUTBP1 = 1'b0;
			     DOUTBP2 = 1'b0;
			     DOUTBP3 = 1'b0;
			     DOUTBP4 = 1'b0;
			     DOUTBP5 = 1'b0;
			     DOUTBP6 = 1'b0;
			     DOUTBP7 = 1'b0;
			     DOUTBP8 = 1'b0;
			 end
			 default:
			     begin
				// if ( WARNING_MSGS_ON == 1 )
				 //    $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9", $time);
			     end
		      endcase

		  end else if (PIPEB_int == 1'b1) begin
		      case (`BLKB_WIDTH_CFG)
			 2'b00 : begin
			     DOUTBP0 = 1'b0;
			     DOUTBP0_stg1 = 1'b0;
			 end
			 2'b01 : begin
			     DOUTBP0 = 1'b0;
			     DOUTBP1 = 1'b0;
			     DOUTBP0_stg1 = 1'b0;
			     DOUTBP1_stg1 = 1'b0;

			 end
			 2'b10 : begin
			     DOUTBP0= 1'b0;
			     DOUTBP1 = 1'b0;
			     DOUTBP2 = 1'b0;
			     DOUTBP3 = 1'b0;
			     DOUTBP0_stg1= 1'b0;
			     DOUTBP1_stg1 = 1'b0;
			     DOUTBP2_stg1 = 1'b0;
			     DOUTBP3_stg1 = 1'b0;

			 end
			 2'b11 : begin
			     DOUTBP0 = 1'b0;
			     DOUTBP1 = 1'b0;
			     DOUTBP2 = 1'b0;
			     DOUTBP3 = 1'b0;
			     DOUTBP4 = 1'b0;
			     DOUTBP5 = 1'b0;
			     DOUTBP6 = 1'b0;
			     DOUTBP7 = 1'b0;
			     DOUTBP8 = 1'b0;
			     DOUTBP0_stg1 = 1'b0;
			     DOUTBP1_stg1 = 1'b0;
			     DOUTBP2_stg1 = 1'b0;
			     DOUTBP3_stg1 = 1'b0;
			     DOUTBP4_stg1 = 1'b0;
			     DOUTBP5_stg1 = 1'b0;
			     DOUTBP6_stg1 = 1'b0;
			     DOUTBP7_stg1 = 1'b0;
			     DOUTBP8_stg1 = 1'b0;

			 end
			 default:
			     begin
				// if ( WARNING_MSGS_ON == 1 )
				//     $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9", $time);
			     end
		      endcase
		  end
	      end // if (RESET_int === 1'b0 )
	  
      end  // Reset


// start the RAM BLKA negative edge behavior to handle write/write conflicts
// This part is only added to UMC chips since their RAM cells are level triggered
// rather than being edge triggered.
always @(negedge CLKA_int) begin
	if ((BLKA_int == 1'b0) && (RESET_int == 1'b1)) begin
		if ( (WENA_lat == 1'b0) && ADDRA_VALID ) begin  // Write mode
			CLKA_wr_fe = $time;
			
			// Check if Write from Port B and Write from Port A are to the same address, 
			// and CLKA and CLKB fall simultaneously --> write data is non-deterministic
			if ( (WENB_lat == 1'b0) && same_addr(ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0} ) &&
                                                        ((CLKB_wr_fe + TC2CWWL) > CLKA_wr_fe) ) begin
				$display (" ** Warning: Port B Write and Port A Write to same address at same time. Write data conflict. Updating memory contents at conflicting address with X"); 
				$display (" Time: %0.1f ps Instance: %m", $realtime);
				// function call to determine conflicting write data bits based on address and width configuration
				//`DATA_A_REG = `DATA_A_IN;
				`DATA_A_REG = drive_data_x (ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}, `DATA_A_IN);
			end	
			
			case (`BLKA_WIDTH_CFG)
				2'b00 : begin
					MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ] = DINA0_reg;
				end
				2'b01 : begin
					MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ] = DINA0_reg;
					MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ] = DINA1_reg;
				end
				2'b10 : begin
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ] = DINA0_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ] = DINA1_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ] = DINA2_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ] = DINA3_reg;
				end
				2'b11 : begin
					MEM_512_9[ ADDRA ] = {DINA8_reg,DINA7_reg,DINA6_reg,DINA5_reg,DINA4_reg,DINA3_reg,DINA2_reg,DINA1_reg,DINA0_reg};
				end
				default: begin
					if ( WARNING_MSGS_ON == 1 )
						$display ("Warning: Invalid WIDTH configuration at time %d ns. Legal Width: 1, 2, 4, 9. Instance: %m", $time);
				end	
			endcase
			
		end
	end
end

// start the RAM BLKB negative edge behavior to handle write/write conflicts
// This part is only added to UMC chips since their RAM cells are level triggered
// rather than being edge triggered.
always @(negedge CLKB_int) begin
	if ((BLKB_int == 1'b0) && (RESET_int == 1'b1)) begin
		if ( (WENB_lat == 1'b0) && ADDRB_VALID ) begin // Write mode
			CLKB_wr_fe = $time;
      
			// Check if Write from Port B and Write from Port A are to the same address, 
			// and CLKA and CLKB fall simultaneously --> write data is non-deterministic
			if ( (WENA_lat == 1'b0) && same_addr(ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0} ) &&
								  ((CLKA_wr_fe + TC2CWWL) > CLKB_wr_fe) ) begin
				$display (" ** Warning: Port B Write and Port A Write to same address at same time. Write data conflict. Updating memory contents at conflicting address with X"); 
				$display (" Time: %0.1f ps Instance: %m ", $realtime );
				// function call to determine conflicting write data bits based on address and width configuration
				//`DATA_B_REG = `DATA_B_IN;
				`DATA_B_REG = drive_data_x (ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}, `DATA_B_IN);
			end
			
			case (`BLKB_WIDTH_CFG)
				2'b00 : begin
					MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ] = DINB0_reg;
				end
				2'b01 : begin
					MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ] = DINB0_reg;
					MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ] = DINB1_reg;
				end
				2'b10 : begin
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ] = DINB0_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ] = DINB1_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ] = DINB2_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ] = DINB3_reg;
				end
				2'b11 : begin
					MEM_512_9[ ADDRB ]  = {DINB8_reg,DINB7_reg,DINB6_reg,DINB5_reg,DINB4_reg,DINB3_reg,DINB2_reg,DINB1_reg,DINB0_reg};
				end
				default: begin
					if ( WARNING_MSGS_ON == 1 )
						$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
					end
			endcase
				
		end
	end
end
	  
// start the RAM BLKA write/read  behavior section
always @(posedge CLKA_int) begin

  if (PIPEA_int == 1'b1) begin
    case (`BLKA_WIDTH_CFG)
      2'b00 : begin 
               DOUTAP0 = DOUTAP0_stg1;
              end
      2'b01 : begin
               DOUTAP0 = DOUTAP0_stg1;
               DOUTAP1 = DOUTAP1_stg1;
              end
      2'b10 : begin
               DOUTAP0 = DOUTAP0_stg1;
               DOUTAP1 = DOUTAP1_stg1;
               DOUTAP2 = DOUTAP2_stg1;
               DOUTAP3 = DOUTAP3_stg1;
              end
      2'b11 : begin
               DOUTAP0 = DOUTAP0_stg1;
               DOUTAP1 = DOUTAP1_stg1;
               DOUTAP2 = DOUTAP2_stg1;
               DOUTAP3 = DOUTAP3_stg1;
               DOUTAP4 = DOUTAP4_stg1;
               DOUTAP5 = DOUTAP5_stg1;
               DOUTAP6 = DOUTAP6_stg1;
               DOUTAP7 = DOUTAP7_stg1;
               DOUTAP8 = DOUTAP8_stg1;
             end
      default:
              begin
                if ( WARNING_MSGS_ON == 1 )
                  $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
              end
    endcase
  end
  else if (PIPEA_int == 1'bx) begin
    if ( WARNING_MSGS_ON == 1 )
      $display ("Warning: PIPEA unknown at time %d ns, no data was read. Instance: %m", $time);
    DOUTAP0 = 1'bx;
    DOUTAP1 = 1'bx;
    DOUTAP2 = 1'bx;
    DOUTAP3 = 1'bx;
    DOUTAP4 = 1'bx;
    DOUTAP5 = 1'bx;
    DOUTAP6 = 1'bx;
    DOUTAP7 = 1'bx;
    DOUTAP8 = 1'bx;
  end

  if ((BLKA_int == 1'b0) && (RESET_int == 1'b1)) begin

    WENA_lat = WENA_int;

    ADDRA = get_address(`BLKA_ADDR);   // get the address (read or write ) 
    ADDRA_VALID = 1;

    if ((^ADDRA) === 1'bx) begin
      ADDRA_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port A at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKA_WIDTH_CFG == 2'b00) && (ADDRA > 4095)) begin
      ADDRA_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port A at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKA_WIDTH_CFG == 2'b01) && (ADDRA > 2047)) begin
      ADDRA_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port A at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKA_WIDTH_CFG == 2'b10) && (ADDRA > 1023)) begin
      ADDRA_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port A at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKA_WIDTH_CFG == 2'b11) && (ADDRA > 511)) begin
      ADDRA_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port A at time %0.1f ps ! Instance: %m", $realtime);
    end

    if ( (WENA_int == 1'b0) && ADDRA_VALID ) begin  // Write mode
			CLKA_wr_re = $time;
			// assign write data to data registers for writing into the memory array
			`DATA_A_REG = `DATA_A_IN;
      // assign write data to bypass registers for driving onto RD if MODE=1 
      `DATA_A_BYP = `DATA_A_IN;

      // Check for Read from Port B and Write from Port A to the same address, read data on Port B is driven to X
      if ( (WENB_lat == 1'b1) && same_addr(ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}) &&
                                                              ((CLKB_rd_re + TC2CRWH) > CLKA_wr_re) ) begin
        $display (" ** Warning: Port B Read and Port A Write to same address at same time. Port B read data is unpredictable, driving read data to X.");
        $display (" Time: %0.1f ps Instance: %m ", $realtime );
				
        if (PIPEB_int == 1'b1) begin
          case (`BLKB_WIDTH_CFG)
						2'b00 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ];
										end
						2'b01 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ];
										DOUTBP1_stg1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ];
										DOUTBP1_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ];
										DOUTBP2_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ];
										DOUTBP3_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTBP8_stg1, DOUTBP7_stg1, DOUTBP6_stg1, DOUTBP5_stg1, DOUTBP4_stg1,
																	 DOUTBP3_stg1, DOUTBP2_stg1, DOUTBP1_stg1, DOUTBP0_stg1} = MEM_512_9[ ADDRB ];
										end
						default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					`DATAP_B_OUT = drive_data_x (ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}, `DATAP_B_OUT);
				end
        else if (PIPEB_int == 1'b0) begin
          case (`BLKB_WIDTH_CFG)
						2'b00 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ];
										end
						2'b01 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ];
										DOUTBP1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ];
										DOUTBP1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ];
										DOUTBP2 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ];
										DOUTBP3 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTBP8, DOUTBP7, DOUTBP6, DOUTBP5, DOUTBP4,
															DOUTBP3, DOUTBP2, DOUTBP1, DOUTBP0} = MEM_512_9[ ADDRB ];
										end
						default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					`DATA_B_OUT = drive_data_x (ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}, `DATA_B_OUT);
				end
      end
			
			case (`BLKA_WIDTH_CFG)
				2'b00 : begin
					MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ] = DINA0_reg;
					if (WMODEA_int == 1'b1) begin
						if (PIPEA_int == 1'b0) begin 
							DOUTAP0 = DINA0_bypass;
						end else if (PIPEA_int == 1'b1) begin
							DOUTAP0_stg1 = DINA0_bypass;
						end 
					end
				end
				2'b01 : begin
					MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ] = DINA0_reg;
					MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ] = DINA1_reg;
					if (WMODEA_int == 1'b1) begin
						if (PIPEA_int == 1'b0) begin
							DOUTAP0 = DINA0_bypass;
							DOUTAP1 = DINA1_bypass;
						end else if (PIPEA_int == 1'b1) begin
							DOUTAP0_stg1 = DINA0_bypass;
							DOUTAP1_stg1 = DINA1_bypass;
						end
					end
				end
				2'b10 : begin
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ] = DINA0_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ] = DINA1_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ] = DINA2_reg;
					MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ] = DINA3_reg;
					if (WMODEA_int == 1'b1) begin
						if (PIPEA_int == 1'b0) begin
							DOUTAP0 = DINA0_bypass;
							DOUTAP1 = DINA1_bypass;
							DOUTAP2 = DINA2_bypass;
							DOUTAP3 = DINA3_bypass;
						end else if (PIPEA_int == 1'b1) begin
							DOUTAP0_stg1 = DINA0_bypass;
							DOUTAP1_stg1 = DINA1_bypass;
							DOUTAP2_stg1 = DINA2_bypass;
							DOUTAP3_stg1 = DINA3_bypass;
						end
					end
				end
				2'b11 : begin
					MEM_512_9[ ADDRA ] = {DINA8_reg,DINA7_reg,DINA6_reg,DINA5_reg,DINA4_reg,DINA3_reg,DINA2_reg,DINA1_reg,DINA0_reg};
					if (WMODEA_int == 1'b1) begin
						if (PIPEA_int == 1'b0) begin
							DOUTAP0 = DINA0_bypass;
							DOUTAP1 = DINA1_bypass;
							DOUTAP2 = DINA2_bypass;
							DOUTAP3 = DINA3_bypass;
							DOUTAP4 = DINA4_bypass;
							DOUTAP5 = DINA5_bypass;
							DOUTAP6 = DINA6_bypass;
							DOUTAP7 = DINA7_bypass;
							DOUTAP8 = DINA8_bypass;
						end else if (PIPEA_int == 1'b1) begin
							DOUTAP0_stg1 = DINA0_bypass;
							DOUTAP1_stg1 = DINA1_bypass;
							DOUTAP2_stg1 = DINA2_bypass;
							DOUTAP3_stg1 = DINA3_bypass;
							DOUTAP4_stg1 = DINA4_bypass;
							DOUTAP5_stg1 = DINA5_bypass;
							DOUTAP6_stg1 = DINA6_bypass;
							DOUTAP7_stg1 = DINA7_bypass;
							DOUTAP8_stg1 = DINA8_bypass;
						end
					end
				end
				default: begin
					if ( WARNING_MSGS_ON == 1 )
						$display ("Warning: Invalid WIDTH configuration at time %d ns. Legal Width: 1, 2, 4, 9. Instance: %m", $time);
				end
      endcase
			
		end else if ( (WENA_int == 1'b1) && ADDRA_VALID ) begin // Read mode

        CLKA_rd_re = $time;

        if (PIPEA_int == 1'b0) begin
          case (`BLKA_WIDTH_CFG)
						2'b00 : begin 
										DOUTAP0 = MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ];
										end
						2'b01 : begin
										DOUTAP0 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ];
										DOUTAP1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ];
								end
						2'b10 : begin
										DOUTAP0 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ];
										DOUTAP1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ];
										DOUTAP2 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ];
										DOUTAP3 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ];
								end
						2'b11 : begin
										{DOUTAP8, DOUTAP7, DOUTAP6, DOUTAP5, DOUTAP4, 
															DOUTAP3, DOUTAP2, DOUTAP1, DOUTAP0} = MEM_512_9[ ADDRA ];
										end
						 default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					// Check for Write from Port B and Read from Port A to the same address, read data on Port A is driven to X
          if ( (WENB_lat == 1'b0) && same_addr(ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}) &&
                                                                  ((CLKB_wr_re + TC2CWRH) > CLKA_rd_re) ) begin
            $display (" ** Warning: Port B Write and Port A Read to same address at same time. Port A read data is unpredictable, driving read data to X");
            $display (" Time: %0.1f ps Instance: %m ", $realtime );
            `DATA_A_OUT = drive_data_x (ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}, `DATA_A_OUT);
          end

        end else if (PIPEA_int == 1'b1) begin
          case (`BLKA_WIDTH_CFG)
						2'b00 : begin 
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ];
										end
						2'b01 : begin
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ];
										DOUTAP1_stg1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ];
										DOUTAP1_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ];
										DOUTAP2_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ];
										DOUTAP3_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTAP8_stg1, DOUTAP7_stg1, DOUTAP6_stg1, DOUTAP5_stg1, DOUTAP4_stg1,
																	 DOUTAP3_stg1, DOUTAP2_stg1, DOUTAP1_stg1, DOUTAP0_stg1} = MEM_512_9[ ADDRA ];
										end
						 default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					// Check for Write from Port B and Read from Port A to the same address, read data on Port A is driven to X
          if ( (WENB_lat == 1'b0) && same_addr(ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}) &&
                                                                  ((CLKB_wr_re + TC2CWRH) > CLKA_rd_re) ) begin
            $display (" ** Warning: Port B Write and Port A Read to same address at same time. Port A read data is unpredictable, driving read data to X");
            $display (" Time: %0.1f ps Instance: %m ", $realtime );
            `DATAP_A_OUT = drive_data_x (ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}, `DATAP_A_OUT);
          end
        end else begin
                if ( WARNING_MSGS_ON == 1 )
                  $display ("Warning: PIPEA unknown at time %d ns, no data was read. Instance: %m", $time);
                DOUTAP0 = 1'bx;
                DOUTAP1 = 1'bx;
                DOUTAP2 = 1'bx;
                DOUTAP3 = 1'bx;
                DOUTAP4 = 1'bx;
                DOUTAP5 = 1'bx;
                DOUTAP6 = 1'bx;
                DOUTAP7 = 1'bx;
                DOUTAP8 = 1'bx;
              end
      end else if ( (WENA_int == 1'b0) && (ADDRA_VALID == 0) ) begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Illegal Write Address on port A, Write Not Initiated. Instance: %m");
      end else if ( (WENA_int == 1'b1) && (ADDRA_VALID == 0) ) begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Illegal Read Address on port A, Read Not Initiated. Instance: %m");
      end else begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Warning: WENAis unknown at time %d ns. Instance: %m", $time);
      end
    end
 end
   
                          
  
// start the RAM BLKB write/read  behavior section

always @(posedge CLKB_int) begin

  if (PIPEB_int == 1'b1) begin
    case (`BLKB_WIDTH_CFG)
      2'b00 : begin 
               DOUTBP0 = DOUTBP0_stg1;
              end
      2'b01 : begin
               DOUTBP0 = DOUTBP0_stg1;
               DOUTBP1 = DOUTBP1_stg1;
              end
      2'b10 : begin
               DOUTBP0 = DOUTBP0_stg1;
               DOUTBP1 = DOUTBP1_stg1;
               DOUTBP2 = DOUTBP2_stg1;
               DOUTBP3 = DOUTBP3_stg1;
              end
      2'b11 : begin
               DOUTBP0 = DOUTBP0_stg1;
               DOUTBP1 = DOUTBP1_stg1;
               DOUTBP2 = DOUTBP2_stg1;
               DOUTBP3 = DOUTBP3_stg1;
               DOUTBP4 = DOUTBP4_stg1;
               DOUTBP5 = DOUTBP5_stg1;
               DOUTBP6 = DOUTBP6_stg1;
               DOUTBP7 = DOUTBP7_stg1;
               DOUTBP8 = DOUTBP8_stg1;
             end
      default:
              begin
                if ( WARNING_MSGS_ON == 1 )
                  $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
              end
    endcase
  end
  else if (PIPEB_int == 1'bx) begin
    if ( WARNING_MSGS_ON == 1 )
      $display ("Warning: PIPEB unknown at time %d ns, no data was read. Instance: %m", $time); 
    DOUTBP0 = 1'bx;
    DOUTBP1 = 1'bx;
    DOUTBP2 = 1'bx;
    DOUTBP3 = 1'bx;
    DOUTBP4 = 1'bx;
    DOUTBP5 = 1'bx;
    DOUTBP6 = 1'bx;
    DOUTBP7 = 1'bx;
    DOUTBP8 = 1'bx;
  end
 

  if ((BLKB_int == 1'b0) && (RESET_int == 1'b1)) begin

    WENB_lat = WENB_int;

    ADDRB = get_address(`BLKB_ADDR);   // get the address (read or write )
    ADDRB_VALID = 1;

    if ((^ADDRB) === 1'bx) begin
      ADDRB_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port B at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKB_WIDTH_CFG == 2'b00) && (ADDRB > 4095)) begin
      ADDRB_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port B at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKB_WIDTH_CFG == 2'b01) && (ADDRB > 2047)) begin
      ADDRB_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port B at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKB_WIDTH_CFG == 2'b10) && (ADDRB > 1023)) begin
      ADDRB_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port B at time %0.1f ps ! Instance: %m", $realtime);
    end
    else if ((`BLKB_WIDTH_CFG == 2'b11) && (ADDRB > 511)) begin
      ADDRB_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on port B at time %0.1f ps ! Instance: %m", $realtime);
    end

    if ( (WENB_int == 1'b0) && ADDRB_VALID ) begin // Write mode
			CLKB_wr_re = $time;
			// assign write data to data registers for writing into the memory array
			`DATA_B_REG = `DATA_B_IN;
			// assign write data to bypass registers for driving onto RD if MODE=1 
			`DATA_B_BYP = `DATA_B_IN;

      // Check for Read from Port A and Write from Port B to the same address, read data on Port A is driven to X
      if ( (WENA_lat == 1'b1) && same_addr(ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}) &&
                                                              ((CLKA_rd_re + TC2CRWH) > CLKB_wr_re) ) begin
        $display (" ** Warning: Port A Read and Port B Write to same address at same time. Port A read data is unpredictable, driving read data to X.");
        $display (" Time: %0.1f ps Instance: %m ", $realtime );

        if (PIPEA_int == 1'b1) begin
					case (`BLKA_WIDTH_CFG)
						2'b00 : begin 
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ];
										end
						2'b01 : begin
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ];
										DOUTAP1_stg1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTAP0_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ];
										DOUTAP1_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ];
										DOUTAP2_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ];
										DOUTAP3_stg1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTAP8_stg1, DOUTAP7_stg1, DOUTAP6_stg1, DOUTAP5_stg1, DOUTAP4_stg1,
																	 DOUTAP3_stg1, DOUTAP2_stg1, DOUTAP1_stg1, DOUTAP0_stg1} = MEM_512_9[ ADDRA ];
										end
						 default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
          `DATAP_A_OUT = drive_data_x (ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}, `DATAP_A_OUT);
				end
        else if (PIPEA_int == 1'b0) begin
          case (`BLKA_WIDTH_CFG)
						2'b00 : begin 
										DOUTAP0 = MEM_512_9[ ADDRA[11:3] ] [ ADDRA[2:0] ];
										end
						2'b01 : begin
										DOUTAP0 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 ];
										DOUTAP1 = MEM_512_9[ ADDRA[10:2] ] [ ADDRA[1:0] * 2 + 1 ];
								end
						2'b10 : begin
										DOUTAP0 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 ];
										DOUTAP1 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 1 ];
										DOUTAP2 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 2 ];
										DOUTAP3 = MEM_512_9[ ADDRA[9:1] ] [ ADDRA[0] * 4 + 3 ];
								end
						2'b11 : begin
										{DOUTAP8, DOUTAP7, DOUTAP6, DOUTAP5, DOUTAP4, 
															DOUTAP3, DOUTAP2, DOUTAP1, DOUTAP0} = MEM_512_9[ ADDRA ];
										end
						 default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					`DATA_A_OUT = drive_data_x (ADDRB, ADDRA, {WIDTHB1,WIDTHB0}, {WIDTHA1,WIDTHA0}, `DATA_A_OUT);
				end
      end
			
			case (`BLKB_WIDTH_CFG)
				2'b00 : begin
					MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ] = DINB0_reg;
					if (WMODEB_int == 1'b1) begin
						if (PIPEB_int == 1'b0) begin
							DOUTBP0 = DINB0_bypass;
						end else if (PIPEB_int == 1'b1) begin
							DOUTBP0_stg1 = DINB0_bypass;
						end
					end
				end
				2'b01 : begin
					MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ] = DINB0_reg;
					MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ] = DINB1_reg;
					if (WMODEB_int == 1'b1) begin
						if (PIPEB_int == 1'b0) begin
							DOUTBP0 = DINB0_bypass;
							DOUTBP1 = DINB1_bypass;
						end else if (PIPEB_int == 1'b1) begin
							DOUTBP0_stg1 = DINB0_bypass;
							DOUTBP1_stg1 = DINB1_bypass;
						end
					end 
				end
				2'b10 : begin
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ] = DINB0_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ] = DINB1_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ] = DINB2_reg;
					MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ] = DINB3_reg;
					if (WMODEB_int == 1'b1) begin
						if (PIPEB_int == 1'b0) begin
							DOUTBP0 = DINB0_bypass;
							DOUTBP1 = DINB1_bypass;
							DOUTBP2 = DINB2_bypass;
							DOUTBP3 = DINB3_bypass;
						end else if (PIPEB_int == 1'b1) begin
							DOUTBP0_stg1 = DINB0_bypass;
							DOUTBP1_stg1 = DINB1_bypass;
							DOUTBP2_stg1 = DINB2_bypass;
							DOUTBP3_stg1 = DINB3_bypass;
						end
					end
				end
				2'b11 : begin
					MEM_512_9[ ADDRB ]  = {DINB8_reg,DINB7_reg,DINB6_reg,DINB5_reg,DINB4_reg,DINB3_reg,DINB2_reg,DINB1_reg,DINB0_reg};
					if (WMODEB_int == 1'b1) begin
						if (PIPEB_int == 1'b0) begin
							DOUTBP0 = DINB0_bypass;
							DOUTBP1 = DINB1_bypass;
							DOUTBP2 = DINB2_bypass;
							DOUTBP3 = DINB3_bypass;
							DOUTBP4 = DINB4_bypass;
							DOUTBP5 = DINB5_bypass;
							DOUTBP6 = DINB6_bypass;
							DOUTBP7 = DINB7_bypass;
							DOUTBP8 = DINB8_bypass;
						end else if (PIPEB_int == 1'b1) begin
							DOUTBP0_stg1 = DINB0_bypass;
							DOUTBP1_stg1 = DINB1_bypass;
							DOUTBP2_stg1 = DINB2_bypass;
							DOUTBP3_stg1 = DINB3_bypass;
							DOUTBP4_stg1 = DINB4_bypass;
							DOUTBP5_stg1 = DINB5_bypass;
							DOUTBP6_stg1 = DINB6_bypass;
							DOUTBP7_stg1 = DINB7_bypass;
							DOUTBP8_stg1 = DINB8_bypass;
						end
					end
				end
				default: begin
					if ( WARNING_MSGS_ON == 1 )
						$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
					end
      endcase
			
		end else if ( (WENB_int == 1'b1) && ADDRB_VALID ) begin
        CLKB_rd_re = $time;

        if (PIPEB_int == 1'b0) begin 
          case (`BLKB_WIDTH_CFG)
						2'b00 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ];
										end
						2'b01 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ];
										DOUTBP1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTBP0 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ];
										DOUTBP1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ];
										DOUTBP2 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ];
										DOUTBP3 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTBP8, DOUTBP7, DOUTBP6, DOUTBP5, DOUTBP4,
															DOUTBP3, DOUTBP2, DOUTBP1, DOUTBP0} = MEM_512_9[ ADDRB ];
										end
						default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase

					// Check for Write from Port A and Read from Port B to the same address, read data on Port B is driven to X
          if ( (WENA_lat == 1'b0) && same_addr(ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}) &&
                                                                  ((CLKA_wr_re + TC2CWRH) > CLKB_rd_re) ) begin
            $display (" ** Warning: Port A Write and Port B Read to same address at same time. Port B read data is unpredictable, driving read data to X.");
            $display (" Time: %0.1f ps Instance: %m ", $realtime );
            `DATA_B_OUT = drive_data_x (ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}, `DATA_B_OUT);
						
          end // check for Write and Read to the same address

        end else if (PIPEB_int == 1'b1) begin
          case (`BLKB_WIDTH_CFG)
						2'b00 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[11:3] ] [ ADDRB[2:0] ];
										end
						2'b01 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 ];
										DOUTBP1_stg1 = MEM_512_9[ ADDRB[10:2] ] [ ADDRB[1:0] * 2 + 1 ];
										end
						2'b10 : begin
										DOUTBP0_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 ];
										DOUTBP1_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 1 ];
										DOUTBP2_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 2 ];
										DOUTBP3_stg1 = MEM_512_9[ ADDRB[9:1] ] [ ADDRB[0] * 4 + 3 ];
										end
						2'b11 : begin
										{DOUTBP8_stg1, DOUTBP7_stg1, DOUTBP6_stg1, DOUTBP5_stg1, DOUTBP4_stg1,
																	 DOUTBP3_stg1, DOUTBP2_stg1, DOUTBP1_stg1, DOUTBP0_stg1} = MEM_512_9[ ADDRB ];
										end
						default:
							 begin
								if ( WARNING_MSGS_ON == 1 )
									$display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
							 end
					endcase
					// Check for Write from Port A and Read from Port B to the same address, read data on Port B is driven to X
          if ( (WENA_lat == 1'b0) && same_addr(ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}) &&
                                                                  ((CLKA_wr_re + TC2CWRH) > CLKB_rd_re) ) begin
            $display (" ** Warning: Port A Write and Port B Read to same address at same time. Port B read data is unpredictable, driving read data to X");
            $display (" Time: %0.1f ps Instance: %m ", $realtime );
            `DATAP_B_OUT = drive_data_x (ADDRA, ADDRB, {WIDTHA1,WIDTHA0}, {WIDTHB1,WIDTHB0}, `DATAP_B_OUT);

          end
       end else begin
                   if ( WARNING_MSGS_ON == 1 )
                     $display ("Warning: PIPEB unknown at time %d ns, no data was read. Instance: %m", $time); 
                   DOUTBP0 = 1'bx;
                   DOUTBP1 = 1'bx;
                   DOUTBP2 = 1'bx;
                   DOUTBP3 = 1'bx;
                   DOUTBP4 = 1'bx;
                   DOUTBP5 = 1'bx;
                   DOUTBP6 = 1'bx;
                   DOUTBP7 = 1'bx;
                   DOUTBP8 = 1'bx;
                end
      end else if ( (WENB_int == 1'b0) && (ADDRB_VALID == 0) ) begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Illegal Write Address on port B, Write Not Initiated. Instance: %m");
      end else if ( (WENB_int == 1'b1) && (ADDRB_VALID == 0) ) begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Illegal Read Address on port B, Read Not Initiated. Instance: %m");
      end else begin
        if ( WARNING_MSGS_ON == 1 )
          $display("Warning: WENB is unknown at time %d ns. Instance: %m", $time);
      end
    end
 end
 
// function to drive read data bus to "x" depending on width configuration
// function to check if write and read operations are accessing the same memory location
function same_addr;
	input integer waddr, raddr;
	input [1:0]   ww, rw;
	integer       wr_addr, rd_addr;
begin
	same_addr = 1'b0;
    if ( ww > rw ) begin
		rd_addr = raddr >> (  ww - rw );
		wr_addr = waddr;
    end
    else if ( rw > ww )begin
		rd_addr = raddr;
		wr_addr = waddr >> (  rw - ww );
    end
    else begin
		rd_addr = raddr;
		wr_addr = waddr;
    end
    if ( wr_addr == rd_addr ) begin
		same_addr = 1'b1;
    end
end
endfunction


 // function to drive read data bus to "x" depending on width configuration

 function [8:0] drive_data_x;
	input integer waddr, raddr;
	input [1:0]   ww, rw;
	input [8:0]   rd_data;
	integer       index, i;
begin
	drive_data_x = rd_data;
    case(rw)
		2'b00 : begin
			drive_data_x [ 0 ] = 1'bx;
		end
       2'b01 : begin
			if ( ww == 2'b00 )
				drive_data_x [ waddr[0] ] = 1'bx;
			else
				drive_data_x [ 1:0 ] = 2'bx;
		end
       2'b10 : begin
                 if ( ww == 2'b00 )
                   drive_data_x [ waddr[1:0] ] = 1'bx;
                 else if ( ww == 2'b01 ) begin
                   index = waddr[0] * 2;
                   for ( i=index; i<index+2; i=i+1 )
                     drive_data_x [ i ] = 1'bx;
                 end else
                   drive_data_x [ 3:0 ] = 4'bx;
               end
       2'b11 : begin
                 if ( ww == 2'b00 )
                   drive_data_x [ waddr[2:0] ] = 1'bx;
                 else if ( ww == 2'b01 ) begin
                   index = waddr[1:0] * 2;
                   for ( i=index; i<index+2; i=i+1 )
                     drive_data_x [ i ] = 1'bx;
                 end else if ( ww == 2'b10 ) begin
                   index = waddr[0] * 4;
                   for ( i=index; i<index+4; i=i+1 )
                     drive_data_x [ i ] = 1'bx;
                 end else
                   drive_data_x [ 8:0 ] = 9'bx;
               end
       default: begin
                  $display ("Warning: invalid WIDTH configuration at time %d ns, Legal Width: 1,2,4,9. Instance: %m", $time);
                end
      endcase
   end

 endfunction

 // function to convert addr vector to integer 

 function integer get_address;
   input [11:0] addr_signal;
   integer      ADDR;
   begin
     // the address calculation is based on  width,  because we assume that
     // users (or actgen) will connect low unused address pin to GND (1'b0), otherwise it may cause problem !
     ADDR =  addr_signal[11]*2048 + addr_signal[10]*1024 + addr_signal[9]*512 + addr_signal[8]*256 +
             addr_signal[7]*128 + addr_signal[6]*64 + addr_signal[5]*32 + addr_signal[4]*16 +
             addr_signal[3]*8 + addr_signal[2]*4 + addr_signal[1]*2 + addr_signal[0]*1;
     get_address = ADDR;
   end
 endfunction


   specify

      specparam   LibName     = "igloo";
      (posedge CLKA => (DOUTA0+:DOUTA0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA1+:DOUTA1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA2+:DOUTA2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA3+:DOUTA3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA4+:DOUTA4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA5+:DOUTA5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA6+:DOUTA6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA7+:DOUTA7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKA => (DOUTA8+:DOUTA8) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (posedge CLKB => (DOUTB0+:DOUTB0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB1+:DOUTB1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB2+:DOUTB2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB3+:DOUTB3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB4+:DOUTB4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB5+:DOUTB5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB6+:DOUTB6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB7+:DOUTB7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge CLKB => (DOUTB8+:DOUTB8) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      (negedge RESET => (DOUTA0+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA1+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA2+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA3+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA4+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA5+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA6+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA7+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTA8+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (negedge RESET => (DOUTB0+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB1+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB2+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB3+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB4+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB5+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB6+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB7+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (DOUTB8+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge CLKA, 0.0, 0, NOTIFY_REG);
      $width(negedge CLKA, 0.0, 0, NOTIFY_REG);
      $width(posedge CLKB, 0.0, 0, NOTIFY_REG);
      $width(negedge CLKB, 0.0, 0, NOTIFY_REG);

     
      $setup(posedge ADDRA11, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA11, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA11, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA11, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA10, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA10, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA10, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA10, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA9, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA9, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA9, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA9, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA8, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA8, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA8, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA8, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA7, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA7, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA7, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA7, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA6, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA6, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA6, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA6, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA5, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA5, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA5, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA5, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA4, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA4, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA4, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA4, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA3, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA3, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA3, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA3, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA2, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA2, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA2, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA2, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA1, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA1, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA1, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA1, 0.0, NOTIFY_REG);
      $setup(posedge ADDRA0, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRA0, posedge CLKA &&& BLKA_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, posedge ADDRA0, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_EN, negedge ADDRA0, 0.0, NOTIFY_REG);

      $setup(posedge DINA8, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA8, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA8, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA8, 0.0, NOTIFY_REG);
      $setup(posedge DINA7, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA7, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA7, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA7, 0.0, NOTIFY_REG);
      $setup(posedge DINA6, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA6, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA6, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA6, 0.0, NOTIFY_REG);
      $setup(posedge DINA5, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA5, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA5, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA5, 0.0, NOTIFY_REG);
      $setup(posedge DINA4, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA4, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA4, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA4, 0.0, NOTIFY_REG);
      $setup(posedge DINA3, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA3, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA3, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA3, 0.0, NOTIFY_REG);
      $setup(posedge DINA2, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA2, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA2, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA2, 0.0, NOTIFY_REG);
      $setup(posedge DINA1, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA1, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA1, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA1, 0.0, NOTIFY_REG);
      $setup(posedge DINA0, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINA0, posedge CLKA &&& BLKA_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, posedge DINA0, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& BLKA_WEN, negedge DINA0, 0.0, NOTIFY_REG);


      $setup(posedge WENA, posedge CLKA &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge WENA, posedge CLKA &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& RESET, posedge WENA, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&&RESET, negedge WENA, 0.0, NOTIFY_REG);

      $setup(posedge BLKA, posedge CLKA &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge BLKA, posedge CLKA &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& RESET, posedge BLKA, 0.0, NOTIFY_REG);
      $hold(posedge CLKA &&& RESET, negedge BLKA, 0.0, NOTIFY_REG);

      $recovery(posedge RESET, posedge CLKA, 0.0, NOTIFY_REG);
      $hold(posedge CLKA,posedge RESET, 0.0, NOTIFY_REG);
      
      $recovery(posedge RESET, posedge CLKB, 0.0, NOTIFY_REG);
      $hold(posedge CLKB,posedge RESET, 0.0, NOTIFY_REG);

      $width(negedge RESET, 0.0, 0, NOTIFY_REG);


      $setup(posedge ADDRB11, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB11, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB11, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB11, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB10, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB10, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB10, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB10, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB9, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB9, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB9, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB9, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB8, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB8, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB8, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB8, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB7, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB7, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB7, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB7, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB6, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB6, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB6, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB6, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB5, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB5, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB5, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB5, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB4, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB4, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB4, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB4, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB3, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB3, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB3, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB3, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB2, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB2, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB2, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB2, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB1, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB1, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB1, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB1, 0.0, NOTIFY_REG);
      $setup(posedge ADDRB0, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $setup(negedge ADDRB0, posedge CLKB &&& BLKB_EN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, posedge ADDRB0, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_EN, negedge ADDRB0, 0.0, NOTIFY_REG);

      $setup(posedge DINB8, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB8, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB8, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB8, 0.0, NOTIFY_REG);
      $setup(posedge DINB7, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB7, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB7, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB7, 0.0, NOTIFY_REG);
      $setup(posedge DINB6, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB6, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB6, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB6, 0.0, NOTIFY_REG);
      $setup(posedge DINB5, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB5, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB5, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB5, 0.0, NOTIFY_REG);
      $setup(posedge DINB4, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB4, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB4, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB4, 0.0, NOTIFY_REG);
      $setup(posedge DINB3, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB3, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB3, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB3, 0.0, NOTIFY_REG);
      $setup(posedge DINB2, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB2, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB2, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB2, 0.0, NOTIFY_REG);
      $setup(posedge DINB1, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB1, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB1, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB1, 0.0, NOTIFY_REG);
      $setup(posedge DINB0, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $setup(negedge DINB0, posedge CLKB &&& BLKB_WEN, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, posedge DINB0, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& BLKB_WEN, negedge DINB0, 0.0, NOTIFY_REG);


      $setup(posedge WENB, posedge CLKB &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge WENB, posedge CLKB &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& RESET, posedge WENB, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& RESET, negedge WENB, 0.0, NOTIFY_REG);

      $setup(posedge BLKB, posedge CLKB &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge BLKB, posedge CLKB &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& RESET, posedge BLKB, 0.0, NOTIFY_REG);
      $hold(posedge CLKB &&& RESET, negedge BLKB, 0.0, NOTIFY_REG);

   endspecify
 endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*-----------------------------------------------------------------
 CELL NAME : RAM512X18
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ps/1 ps

module RAM512X18(RADDR8,RADDR7,RADDR6,RADDR5,RADDR4,RADDR3,RADDR2,RADDR1,RADDR0,
                 WADDR8,WADDR7,WADDR6,WADDR5,WADDR4,WADDR3,WADDR2,WADDR1,WADDR0,
                 RD17,RD16,RD15,RD14,RD13,RD12,RD11,RD10,RD9,RD8,RD7,RD6,RD5,RD4,
                 RD3,RD2,RD1,RD0,WD17,WD16,WD15,WD14,WD13,WD12,WD11,WD10,WD9,WD8,
                 WD7,WD6,WD5,WD4,WD3,WD2,WD1,WD0,RW1,WW1,RW0,WW0,REN,RCLK,WEN,WCLK,RESET,PIPE); 

parameter DELAY_TWO = 2;
parameter TC2CWRH = 1043;
parameter TC2CRWH = 871;

input RADDR8,RADDR7,RADDR6,RADDR5,RADDR4,RADDR3,RADDR2,RADDR1,RADDR0;
input WADDR8,WADDR7,WADDR6,WADDR5,WADDR4,WADDR3,WADDR2,WADDR1,WADDR0;
input WD17,WD16,WD15,WD14,WD13,WD12,WD11,WD10,WD9,WD8,WD7,WD6,WD5,WD4,WD3,WD2,WD1,WD0;
input RW1,WW1,RW0, WW0,REN,RCLK,WEN,WCLK,RESET,PIPE;

output RD17,RD16,RD15,RD14,RD13,RD12,RD11,RD10,RD9,RD8,RD7,RD6,RD5,RD4,RD3,RD2,RD1,RD0;

reg RDP17,RDP16,RDP15,RDP14,RDP13,RDP12,RDP11,RDP10,RDP9,RDP8,RDP7,RDP6,RDP5,RDP4,RDP3,RDP2,RDP1,RDP0;
reg RDP17_stg,RDP16_stg,RDP15_stg,RDP14_stg,RDP13_stg,RDP12_stg,RDP11_stg,RDP10_stg,RDP9_stg;
reg RDP8_stg,RDP7_stg,RDP6_stg,RDP5_stg,RDP4_stg,RDP3_stg,RDP2_stg,RDP1_stg,RDP0_stg;

wire RADDR8_int,RADDR7_int,RADDR6_int,RADDR5_int,RADDR4_int,RADDR3_int,RADDR2_int,RADDR1_int,RADDR0_int;
wire WADDR8_int,WADDR7_int,WADDR6_int,WADDR5_int,WADDR4_int,WADDR3_int,WADDR2_int,WADDR1_int,WADDR0_int;
wire WD17_int,WD16_int,WD15_int,WD14_int,WD13_int,WD12_int,WD11_int,WD10_int,WD9_int,WD8_int;
wire WD7_int,WD6_int,WD5_int,WD4_int,WD3_int,WD2_int,WD1_int,WD0_int;
wire REN_int,RCLK_int,WEN_int,WCLK_int,RESET_int,PIPE_int;

wire RENABLE;
wire WENABLE;

time WCLK_re;
time RCLK_re;

reg [8:0] MEM_512_9 [0:511];

reg NOTIFY_REG;

integer RADDR;           
integer WADDR;           
integer DEPTH;
integer MAXADD;

reg RADDR_VALID;
reg WADDR_VALID;

reg WEN_lat, REN_lat;

`define WADDR_BUS {WADDR8_int,WADDR7_int,WADDR6_int,WADDR5_int,WADDR4_int,WADDR3_int,WADDR2_int,WADDR1_int,WADDR0_int}
`define RADDR_BUS {RADDR8_int,RADDR7_int,RADDR6_int,RADDR5_int,RADDR4_int,RADDR3_int,RADDR2_int,RADDR1_int,RADDR0_int}
`define DATA_WIDTH_18 {RDP17,RDP16,RDP15,RDP14,RDP13,RDP12,RDP11,RDP10,RDP9,RDP8,RDP7,RDP6,RDP5,RDP4,RDP3,RDP2,RDP1,RDP0}
`define DATAP_WIDTH_18 {RDP17_stg,RDP16_stg,RDP15_stg,RDP14_stg,RDP13_stg,RDP12_stg,RDP11_stg,RDP10_stg,RDP9_stg,RDP8_stg,                                     RDP7_stg,RDP6_stg,RDP5_stg,RDP4_stg,RDP3_stg,RDP2_stg,RDP1_stg,RDP0_stg}
                            

assign RENABLE = ~REN_int & RESET_int;
assign WENABLE = ~WEN_int & RESET_int;

buf b0(WCLK_int, WCLK);
buf b1(RCLK_int, RCLK);
buf b2(WEN_int,WEN);
buf b3(REN_int,REN);
buf b4(RESET_int, RESET);

buf b5(RADDR8_int, RADDR8);
buf b6(RADDR7_int, RADDR7);
buf b7(RADDR6_int, RADDR6);
buf b8(RADDR5_int, RADDR5);
buf b9(RADDR4_int, RADDR4);
buf b10(RADDR3_int, RADDR3);
buf b11(RADDR2_int, RADDR2);
buf b12(RADDR1_int, RADDR1);
buf b13(RADDR0_int, RADDR0);

buf b14(WADDR8_int, WADDR8);
buf b15(WADDR7_int, WADDR7);
buf b16(WADDR6_int, WADDR6);
buf b17(WADDR5_int, WADDR5);
buf b18(WADDR4_int, WADDR4);
buf b19(WADDR3_int, WADDR3);
buf b20(WADDR2_int, WADDR2);
buf b21(WADDR1_int, WADDR1);
buf b22(WADDR0_int, WADDR0);

buf b23(WD17_int, WD17);
buf b24(WD16_int, WD16);
buf b25(WD15_int, WD15);
buf b26(WD14_int, WD14);
buf b27(WD13_int, WD13);
buf b28(WD12_int, WD12);
buf b29(WD11_int, WD11);
buf b30(WD10_int, WD10);
buf b31(WD9_int, WD9);
buf b32(WD8_int, WD8);
buf b33(WD7_int, WD7);
buf b34(WD6_int, WD6);
buf b35(WD5_int, WD5);
buf b36(WD4_int, WD4);
buf b37(WD3_int, WD3);
buf b38(WD2_int, WD2);
buf b39(WD1_int, WD1);
buf b40(WD0_int, WD0);
buf b41(PIPE_int,PIPE);

pmos inst0(RD17, RDP17, 0);
pmos inst1(RD16, RDP16, 0);
pmos inst2(RD15, RDP15, 0);
pmos inst3(RD14, RDP14, 0);
pmos inst4(RD13, RDP13, 0);
pmos inst5(RD12, RDP12, 0);
pmos inst6(RD11, RDP11, 0);
pmos inst7(RD10, RDP10, 0);
pmos inst8(RD9, RDP9, 0);
pmos inst9(RD8, RDP8, 0);
pmos inst10(RD7, RDP7, 0);
pmos inst11(RD6, RDP6, 0);
pmos inst12(RD5, RDP5, 0);
pmos inst13(RD4, RDP4, 0);
pmos inst14(RD3, RDP3, 0);
pmos inst15(RD2, RDP2, 0);
pmos inst16(RD1, RDP1, 0);
pmos inst17(RD0, RDP0, 0);

parameter MEMORYFILE = "";
parameter WARNING_MSGS_ON = 1; // Used to turn off warnings about read &
                               // write to same address at same time.
                               // Default = on.  Set to 0 to turn them off.

  initial
    begin
    
      if ( WARNING_MSGS_ON == 0 )
        $display ( "Note: RAM512X18 warnings disabled. Set WARNING_MSGS_ON = 1 to enable." );

      if ( MEMORYFILE != "")
        $readmemb ( MEMORYFILE, MEM_512_9 );
      else
        begin
          //if ( WARNING_MSGS_ON == 1 )
            //$display ( "Note: Module %m, memory initialization file parameter MEMORYFILE not defined" );
        end
    end

always @(WCLK_int === 1'bx )
begin
  if ($time > 0) begin
    if (WEN_int == 1'b0) begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning : WCLK went unknown at time %0.1f. Instance: %m\n",$realtime);
    end
  end
end

always @(RCLK_int === 1'bx )
begin
  if ($time > 0) begin
    if (REN_int == 1'b0) begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning : RCLK went unknown at time %0.1f. Instance: %m\n",$realtime);
    end
  end
end

  always @(RESET_int )
      begin
	  if(RESET_int === 1'b0 )
	      begin
		  
		  case({RW1,RW0})
		     2'b01 : begin
			 RDP0 = 1'b0;
			 RDP1 = 1'b0;
			 RDP2 = 1'b0;
			 RDP3 = 1'b0;
			 RDP4 = 1'b0;
			 RDP5 = 1'b0;
			 RDP6 = 1'b0;
			 RDP7 = 1'b0;
			 RDP8 = 1'b0;
			 if (PIPE_int == 1'b1) begin
			     RDP0_stg = 1'b0;
			     RDP1_stg = 1'b0;
			     RDP2_stg = 1'b0;
			     RDP3_stg = 1'b0;
			     RDP4_stg = 1'b0;
			     RDP5_stg = 1'b0;
			     RDP6_stg = 1'b0;
			     RDP7_stg = 1'b0;
			     RDP8_stg = 1'b0;
			 end
		     end
		     2'b10 : begin
			 RDP0 = 1'b0;
			 RDP1 = 1'b0;
			 RDP2 = 1'b0;
			 RDP3 = 1'b0;
			 RDP4 = 1'b0;
			 RDP5 = 1'b0;
			 RDP6 = 1'b0;
			 RDP7 = 1'b0;
			 RDP8 = 1'b0;
			 RDP9 = 1'b0;
			 RDP10 = 1'b0;
			 RDP11 = 1'b0;
			 RDP12 = 1'b0;
			 RDP13 = 1'b0;
			 RDP14 = 1'b0;
			 RDP15 = 1'b0;
			 RDP16 = 1'b0;
			 RDP17 = 1'b0;
			 if (PIPE_int == 1'b1) begin
			     RDP0_stg = 1'b0;
			     RDP1_stg = 1'b0;
			     RDP2_stg = 1'b0;
			     RDP3_stg = 1'b0;
			     RDP4_stg = 1'b0;
			     RDP5_stg = 1'b0;
			     RDP6_stg = 1'b0;
			     RDP7_stg = 1'b0;
			     RDP8_stg = 1'b0;
			     RDP9_stg = 1'b0;
			     RDP10_stg = 1'b0;
			     RDP11_stg = 1'b0;
			     RDP12_stg = 1'b0;
			     RDP13_stg = 1'b0;
			     RDP14_stg = 1'b0;
			     RDP15_stg = 1'b0;
			     RDP16_stg = 1'b0;
			     RDP17_stg = 1'b0;
			 end
		     end
		     default : begin
			// if ( WARNING_MSGS_ON == 1 )
			 //    $display ("Warning: RW at time %d ns.", $time);
		     end
		  endcase
	      end
      end // Reset

always @(posedge WCLK_int) begin

  WEN_lat = WEN_int;

  if ((WEN_int == 1'b0) && (RESET_int == 1'b1))  begin

    WCLK_re     = $time;
    WADDR       = get_address(`WADDR_BUS); // call address calculation function to get write address
    WADDR_VALID = 1;

    if ((^WADDR) === 1'bx) begin
      WADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on write port at time %0.1f! Instance: %m", $realtime);
    end
    else if (({WW1,WW0} == 2'b01) && (WADDR > 511)) begin
      WADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on write port at time %0.1f! Instance: %m", $realtime);
    end
    else if (({WW1,WW0} == 2'b10) && (WADDR > 255)) begin
      WADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display(" Warning: Illegal address on write port at time %0.1f! Instance: %m", $realtime);
    end

    if (WADDR_VALID) begin

      // Check for Write and Read to the same address, write is not affected
      if ( (REN_lat == 1'b0) && same_addr(WADDR, RADDR, {WW1,WW0}, {RW1,RW0} ) &&
                                                 ((RCLK_re + TC2CRWH) > WCLK_re) ) begin
        $display (" ** Warning: Read and Write to same address at same time.  RD is unpredictable, driving RD to X ");
        $display (" Time: %0.1f Instance: %m ", $realtime );

        if (PIPE_int == 1'b1)
          `DATAP_WIDTH_18 = drive_rd_x (WADDR, RADDR, {WW1,WW0}, {RW1,RW0}, `DATAP_WIDTH_18);
        else if (PIPE_int == 1'b0)
          `DATA_WIDTH_18 = drive_rd_x (WADDR, RADDR, {WW1,WW0}, {RW1,RW0}, `DATA_WIDTH_18);
      end

      case ({WW1,WW0})
            2'b01 : begin
                    MEM_512_9 [ WADDR ] = {WD8_int, WD7_int, WD6_int, WD5_int, WD4_int, WD3_int, WD2_int, WD1_int, WD0_int};
                    end
            2'b10 : begin
                    MEM_512_9 [ WADDR * 2 ] = {WD8_int,WD7_int,WD6_int,WD5_int,WD4_int,WD3_int,WD2_int,WD1_int,WD0_int};
                    MEM_512_9 [ WADDR * 2 + 1 ] = {WD17_int,WD16_int,WD15_int,WD14_int,WD13_int,WD12_int,WD11_int,WD10_int,WD9_int};
                    end
          default : begin
                      if ( WARNING_MSGS_ON == 1 )
                        $display("Warning: WW value unknown at time %d. Instance: %m",$time);
                    end
      endcase
    end
    else begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning: Illegal Write Address, Write Not Initiated. Instance: %m");
    end
  end else if (WEN_int == 1'bx) begin
    if ( WARNING_MSGS_ON == 1 )
      $display ("Warning: WEN went unknown at time %d ns. Instance: %m", $time);
  end 
end


always @(posedge RCLK_int) begin

    REN_lat = REN_int;

    if (PIPE_int == 1'b1) begin
     case({RW1,RW0})
       2'b01 : begin
                RDP0 = RDP0_stg;
                RDP1 = RDP1_stg;
                RDP2 = RDP2_stg;
                RDP3 = RDP3_stg;
                RDP4 = RDP4_stg;
                RDP5 = RDP5_stg;
                RDP6 = RDP6_stg;
                RDP7 = RDP7_stg;
                RDP8 = RDP8_stg;
               end
       2'b10 : begin
                RDP0 = RDP0_stg;
                RDP1 = RDP1_stg;
                RDP2 = RDP2_stg;
                RDP3 = RDP3_stg;
                RDP4 = RDP4_stg;
                RDP5 = RDP5_stg;
                RDP6 = RDP6_stg;
                RDP7 = RDP7_stg;
                RDP8 = RDP8_stg;
                RDP9 = RDP9_stg;
                RDP10 = RDP10_stg;
                RDP11 = RDP11_stg;
                RDP12 = RDP12_stg;
                RDP13 = RDP13_stg;
                RDP14 = RDP14_stg;
                RDP15 = RDP15_stg;
                RDP16 = RDP16_stg;
                RDP17 = RDP17_stg;
              end
       default : begin
                  if ( WARNING_MSGS_ON == 1 )
                    $display ("Warning: RW unknown at time %d ns. Instance: %m", $time);
                 end
     endcase
    end 
    else if (PIPE_int == 1'bx) begin
      if ( WARNING_MSGS_ON == 1 )
        $display ("Warning: PIPE unknown at time %d ns, no data was read. Instance: %m", $time);
      RDP0 = 1'bx;
      RDP1 = 1'bx;
      RDP2 = 1'bx;
      RDP3 = 1'bx;
      RDP4 = 1'bx;
      RDP5 = 1'bx;
      RDP6 = 1'bx;
      RDP7 = 1'bx;
      RDP8 = 1'bx;
      RDP9 = 1'bx;
      RDP10 = 1'bx;
      RDP11 = 1'bx;
      RDP12 = 1'bx;
      RDP13 = 1'bx;
      RDP14 = 1'bx;
      RDP15 = 1'bx;
      RDP16 = 1'bx;
      RDP17 = 1'bx;
    end


  if ((REN_int == 1'b0 ) && (RESET_int == 1'b1)) begin

    RCLK_re     = $time;
    RADDR       = get_address(`RADDR_BUS);
    RADDR_VALID = 1;
    
    if ((^RADDR) === 1'bx) begin
      RADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning: Illegal address on read port at time %0.1f! Instance: %m", $realtime);
    end
    else if (({RW1,RW0} == 2'b01) && (RADDR > 511)) begin
      RADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning: Illegal address on read port at time %0.1f! Instance: %m", $realtime);
    end
    else if (({RW1,RW0} == 2'b10) && (RADDR > 255)) begin
      RADDR_VALID = 0;
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning: Illegal address on read port at time %0.1f! Instance: %m", $realtime);
    end

    if (RADDR_VALID) begin

      if (PIPE_int == 1'b0) begin
        case({RW1,RW0})
          2'b01 : begin
                  {RDP8, RDP7, RDP6, RDP5, RDP4, RDP3, RDP2, RDP1, RDP0} = MEM_512_9 [ RADDR ];
                end
          2'b10 : begin
                    {RDP8, RDP7, RDP6, RDP5, RDP4, RDP3, RDP2, RDP1, RDP0} = MEM_512_9 [ RADDR * 2 ];
                    {RDP17, RDP16, RDP15, RDP14, RDP13, RDP12, RDP11, RDP10, RDP9} = MEM_512_9 [ RADDR * 2 + 1 ];
                  end
        default : begin
                    if ( WARNING_MSGS_ON == 1 )
                      $display ("Warning: RW at time %d ns. Instance: %m", $time);
                  end
        endcase

        // Check for Write and Read to the same address
        if ( (WEN_lat == 1'b0) && same_addr(WADDR, RADDR, {WW1,WW0}, {RW1,RW0}) &&
                            ((WCLK_re + TC2CWRH) > RCLK_re)) begin
          $display (" ** Warning: Write and Read to same address at same time.  RD is unpredictable, driving RD to X");
          $display (" Time: %0.1f Instance: %m ", $realtime );
          `DATA_WIDTH_18 = drive_rd_x (WADDR, RADDR, {WW1,WW0}, {RW1,RW0}, `DATA_WIDTH_18);
        end

      end else if (PIPE_int == 1'b1) begin
        case({RW1,RW0})
          2'b01 : begin
                    {RDP8_stg,RDP7_stg,RDP6_stg,RDP5_stg,RDP4_stg,RDP3_stg,RDP2_stg,RDP1_stg,RDP0_stg} = MEM_512_9 [ RADDR ];
                  end
          2'b10 : begin
                    {RDP8_stg,RDP7_stg,RDP6_stg,RDP5_stg,RDP4_stg,RDP3_stg,RDP2_stg,RDP1_stg,RDP0_stg} = MEM_512_9 [ RADDR * 2 ];
                    {RDP17_stg,RDP16_stg,RDP15_stg,RDP14_stg,RDP13_stg,RDP12_stg,RDP11_stg,RDP10_stg,RDP9_stg} = MEM_512_9 [ RADDR * 2 + 1 ];
                  end
          default : begin
                      if ( WARNING_MSGS_ON == 1 )
                        $display ("Warning: RW unknown at time %d ns. Instance: %m", $time);
                    end
        endcase 

        // Check for Write and Read to the same address
        if ( (WEN_lat == 1'b0) && same_addr(WADDR, RADDR, {WW1,WW0}, {RW1,RW0}) &&
                            ((WCLK_re + TC2CWRH) > RCLK_re)) begin
          $display (" ** Warning: Write and Read to same address at same time.  RD is unpredictable, driving RD to X");
          $display (" Time: %0.1f Instance: %m ", $realtime );
          `DATAP_WIDTH_18 = drive_rd_x (WADDR, RADDR, {WW1,WW0}, {RW1,RW0}, `DATAP_WIDTH_18);
        end

      end else begin
                if ( WARNING_MSGS_ON == 1 )
                  $display ("Warning: PIPE unknown at time %d ns, no data was read. Instance: %m", $time);
                RDP0 = 1'bx;
                RDP1 = 1'bx;
                RDP2 = 1'bx;
                RDP3 = 1'bx;
                RDP4 = 1'bx;
                RDP5 = 1'bx;
                RDP6 = 1'bx;
                RDP7 = 1'bx;
                RDP8 = 1'bx;
                RDP9 = 1'bx;
                RDP10 = 1'bx;
                RDP11 = 1'bx;
                RDP12 = 1'bx;
                RDP13 = 1'bx;
                RDP14 = 1'bx;
                RDP15 = 1'bx;
                RDP16 = 1'bx;
                RDP17 = 1'bx;
              end
    end else begin
      if ( WARNING_MSGS_ON == 1 )
        $display("Warning: Illegal Read Address, Read Not Initiated. Instance: %m");
    end

  end else if (REN_int == 1'bx) begin
    if ( WARNING_MSGS_ON == 1 )
      $display ("Warning: REN went unknown at time %d ns. Instance: %m", $time);
  end 

 end

 // function to check if write and read operations are accessing the same memory location

 function same_addr;
   input integer waddr, raddr;
   input [1:0]   ww, rw;
   integer wr_addr, rd_addr;
   begin
     same_addr = 1'b0;
     if ( ww > rw ) begin
       rd_addr = raddr >> (  ww - rw );
       wr_addr = waddr;
     end
     else if ( rw > ww )begin
       rd_addr = raddr;
       wr_addr = waddr >> (  rw - ww );
     end
     else begin
       rd_addr = raddr;
       wr_addr = waddr;
     end
     if ( wr_addr == rd_addr ) begin
       same_addr = 1'b1;
     end
   end
 endfunction


 // function to check if write and read operations are accessing the same memory location
 // function to drive read data bus to "x" depending on width configuration

 function [17:0] drive_rd_x;
   input integer waddr, raddr;
   input [1:0]   ww, rw;
   input [17:0]  rd_data;
   integer       index, i;
   begin
     drive_rd_x = rd_data;
     case(rw)
       2'b01 : begin
                 drive_rd_x [ 8:0 ] =  9'bx;
               end
       2'b10 : begin
                 if ( ww == 2'b01 ) begin
                   index = waddr[0] * 9;
                   for ( i=index; i<index+9; i=i+1 )
                     drive_rd_x [ i ] =  1'bx;
                 end else
                   drive_rd_x [ 17:0 ] =  18'bx;
               end
       default: begin
                  $display("Warning : Invalid READ WIDTH at time %d ns,Legal Width: 9,18. Instance: %m",$time);
                end
      endcase
   end
 
 endfunction

 
 function integer get_address;
  input [8:0] addr_signal;
  integer ADDR;
   begin
    // the address calculation is based on  width,  because we assume that
    // users (or actgen) will connect upper unused address pin to GND (1'b0), otherwise it may cause problem !
          ADDR =  addr_signal[8]*256 + addr_signal[7]*128 + addr_signal[6]*64 + addr_signal[5]*32
                + addr_signal[4]*16 + addr_signal[3]*8 + addr_signal[2]*4 + addr_signal[1]*2 + addr_signal[0]*1;
  get_address =ADDR;
  end
 endfunction


   specify

      specparam   LibName     = "iglooplus";
      (posedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD8+:RD8) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD9+:RD9) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD10+:RD10) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD11+:RD11) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD12+:RD12) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD13+:RD13) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD14+:RD14) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD15+:RD15) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD16+:RD16) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD17+:RD17) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (negedge RESET => (RD0+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD1+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD2+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD3+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD4+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD5+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD6+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD7+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD8+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD9+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD10+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD11+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD12+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD13+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD14+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD15+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD16+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RESET => (RD17+:1'b0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

 
      $setup(posedge RADDR8, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG);
      $setup(negedge RADDR8, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RENABLE, posedge RADDR8, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RENABLE, negedge RADDR8, 0.0, NOTIFY_REG);
      $setup(posedge RADDR7, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR7, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR7, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR7, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR6, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR6, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR6, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR6, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR5, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR5, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR5, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR5, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR4, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR4, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR4, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR4, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR3, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR3, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR3, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR3, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR2, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR2, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR2, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR2, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR1, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR1, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR1, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR1, 0.0, NOTIFY_REG); 
      $setup(posedge RADDR0, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge RADDR0, posedge RCLK &&& RENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, posedge RADDR0, 0.0, NOTIFY_REG); 
      $hold(posedge RCLK &&& RENABLE, negedge RADDR0, 0.0, NOTIFY_REG);

      $setup(posedge REN, posedge RCLK, 0.0, NOTIFY_REG);
      $setup(negedge REN, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, negedge REN, 0.0, NOTIFY_REG);
 

      $setup(posedge WADDR8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR8, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR8, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR7, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR7, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR6, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR6, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR5, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR5, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR4, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR4, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR3, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR3, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR2, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR2, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR1, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR1, 0.0, NOTIFY_REG); 
      $setup(posedge WADDR0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WADDR0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WADDR0, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WADDR0, 0.0, NOTIFY_REG); 

      $setup(posedge WD17, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD17, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD17, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD17, 0.0, NOTIFY_REG); 
      $setup(posedge WD16, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD16, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD16, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD16, 0.0, NOTIFY_REG); 
      $setup(posedge WD15, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD15, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD15, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD15, 0.0, NOTIFY_REG); 
      $setup(posedge WD14, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD14, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD14, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD14, 0.0, NOTIFY_REG); 
      $setup(posedge WD13, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD13, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD13, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD13, 0.0, NOTIFY_REG); 
      $setup(posedge WD12, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD12, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD12, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD12, 0.0, NOTIFY_REG); 
      $setup(posedge WD11, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD11, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD11, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD11, 0.0, NOTIFY_REG); 
      $setup(posedge WD10, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD10, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD10, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD10, 0.0, NOTIFY_REG); 
      $setup(posedge WD9, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD9, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD9, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD9, 0.0, NOTIFY_REG);

      $setup(posedge WD8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD8, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD8, 0.0, NOTIFY_REG); 
      $setup(posedge WD7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD7, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD7, 0.0, NOTIFY_REG); 
      $setup(posedge WD6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD6, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD6, 0.0, NOTIFY_REG); 
      $setup(posedge WD5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD5, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD5, 0.0, NOTIFY_REG); 
      $setup(posedge WD4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD4, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD4, 0.0, NOTIFY_REG); 
      $setup(posedge WD3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD3, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD3, 0.0, NOTIFY_REG); 
      $setup(posedge WD2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD2, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD2, 0.0, NOTIFY_REG); 
      $setup(posedge WD1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD1, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD1, 0.0, NOTIFY_REG); 
      $setup(posedge WD0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $setup(negedge WD0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, posedge WD0, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK &&& WENABLE, negedge WD0, 0.0, NOTIFY_REG);

      $setup(posedge WEN, posedge WCLK, 0.0, NOTIFY_REG); 
      $setup(negedge WEN, posedge WCLK, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK, posedge WEN, 0.0, NOTIFY_REG); 
      $hold(posedge WCLK, negedge WEN, 0.0, NOTIFY_REG); 
 
      $recovery(posedge RESET, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK,posedge RESET, 0.0, NOTIFY_REG);

      $recovery(posedge RESET, posedge WCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK,posedge RESET, 0.0, NOTIFY_REG);

      $width(negedge RESET, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK, 0.0, 0, NOTIFY_REG);
      $width(posedge WCLK, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK, 0.0, 0, NOTIFY_REG);
 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : FIFO4K18
 CELL TYPE : FIFO
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 10 ps

module FIFO4K18 (AEVAL11, AEVAL10, AEVAL9, AEVAL8, AEVAL7, AEVAL6, 
                 AEVAL5, AEVAL4, AEVAL3, AEVAL2, AEVAL1, AEVAL0, 
                 AFVAL11, AFVAL10, AFVAL9, AFVAL8, AFVAL7, AFVAL6, 
                 AFVAL5, AFVAL4, AFVAL3, AFVAL2, AFVAL1, AFVAL0, 
                 REN, RBLK, RCLK, RESET, RPIPE, WEN, WBLK, WCLK,
                 RW2, RW1, RW0, WW2, WW1, WW0, ESTOP, FSTOP,
                 WD17, WD16, WD15, WD14, WD13, WD12, WD11, WD10, 
                 WD9, WD8, WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, 
                 RD17, RD16, RD15, RD14, RD13, RD12, RD11, RD10, 
                 RD9, RD8, RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0, 
                 FULL, AFULL, EMPTY, AEMPTY
                );

input AEVAL11, AEVAL10, AEVAL9, AEVAL8, AEVAL7, AEVAL6;
input AEVAL5, AEVAL4, AEVAL3, AEVAL2, AEVAL1, AEVAL0;
input AFVAL11, AFVAL10, AFVAL9, AFVAL8, AFVAL7, AFVAL6;
input AFVAL5, AFVAL4, AFVAL3, AFVAL2, AFVAL1, AFVAL0;
input REN, RBLK, RCLK, RESET, RPIPE, WEN, WBLK, WCLK;
input RW2, RW1, RW0, WW2, WW1, WW0, ESTOP, FSTOP;
input WD17, WD16, WD15, WD14, WD13, WD12, WD11, WD10;
input WD9, WD8, WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0;

output RD17, RD16, RD15, RD14, RD13, RD12, RD11, RD10;
output RD9, RD8, RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;
output FULL, AFULL, EMPTY, AEMPTY;

reg FULLP, AFULLP, EMPTYP, AEMPTYP;
reg [18:0] FIFO[0:512];
reg NOTIFY_REG;

wire AEVAL11_int, AEVAL10_int, AEVAL9_int, AEVAL8_int, AEVAL7_int;
wire AEVAL6_int, AEVAL5_int, AEVAL4_int, AEVAL3_int, AEVAL2_int;
wire AEVAL1_int, AEVAL0_int;
wire AFVAL11, AFVAL10_int, AFVAL9_int, AFVAL8_int, AFVAL7_int;
wire AFVAL6_int, AFVAL5_int, AFVAL4_int, AFVAL3_int, AFVAL2_int;
wire AFVAL1_int, AFVAL0_int;
wire REN_int, RBLK_int, RCLK_int, RESET_int, RPIPE_int;
wire WEN_int, WBLK_int, WCLK_int;
wire RW2_int, RW1_int, RW0_int;
wire WW2_int, WW1_int, WW0_int;
wire ESTOP_int, FSTOP_int;  
wire WD17_int, WD16_int, WD15_int, WD14_int, WD13_int, WD12_int;
wire WD11_int, WD10_int, WD9_int, WD8_int, WD7_int, WD6_int;
wire WD5_int, WD4_int, WD3_int, WD2_int, WD1_int, WD0_int;

reg RDP17, RDP16, RDP15, RDP14, RDP13, RDP12, RDP11, RDP10, RDP9;
reg RDP8, RDP7, RDP6, RDP5, RDP4, RDP3, RDP2, RDP1, RDP0;

reg RD17_stg, RD16_stg, RD15_stg, RD14_stg, RD13_stg, RD12_stg;
reg RD11_stg, RD10_stg, RD9_stg, RD8_stg, RD7_stg;
reg RD6_stg, RD5_stg, RD4_stg, RD3_stg, RD2_stg, RD1_stg, RD0_stg;

`define RDATAP_WIDTH_18 {RDP17, RDP16, RDP15, RDP14, RDP13, RDP12, RDP11, RDP10, RDP9, RDP8, RDP7, RDP6, RDP5, RDP4, RDP3, RDP2, RDP1, RDP0}
`define RWIDTH_CFG_VECTOR {RW2_int, RW1_int, RW0_int}
`define WWIDTH_CFG_VECTOR {WW2_int, WW1_int, WW0_int}
`define AEMPTY_CFG_VECTOR {AEVAL11_int, AEVAL10_int, AEVAL9_int, AEVAL8_int, AEVAL7_int, AEVAL6_int, AEVAL5_int, AEVAL4_int, AEVAL3_int, AEVAL2_int, AEVAL1_int, AEVAL0_int}
`define AFULL_CFG_VECTOR  {AFVAL11_int, AFVAL10_int, AFVAL9_int, AFVAL8_int, AFVAL7_int, AFVAL6_int, AFVAL5_int, AFVAL4_int, AFVAL3_int, AFVAL2_int, AFVAL1_int, AFVAL0_int}

integer MAX_DEPTH;

  
reg [4095:0] MEM;
reg [511 :0] MEM9;

wire WENABLE; 
wire RENABLE;

reg [3:0] mask;
reg RCLK_prev, WCLK_prev;  
reg RBLK_lastvalue = 1, RBLK_hold = 1;
reg WBLK_lastvalue = 1, WBLK_hold=1;
reg REN_lastvalue = 0, REN_hold=0;
reg WEN_lastvalue = 1, WEN_hold=1;
reg issue_WEN = 0;
reg issue_WBLK = 0;
reg issue_RBLK = 0;
reg issue_REN = 0; 
reg issue_afval = 0;
reg issue_aeval = 0;
reg [11:0] AFVAL_lastvalue = 0;
reg [11:0] AEVAL_lastvalue = 0;
reg [11:0] AFVAL_hold = 0;
reg [11:0] AEVAL_hold = 0;  
reg xor_aeval, xor_afval;
  
buf AFU0  (AFVAL0_int,  AFVAL0);
buf AFU1  (AFVAL1_int,  AFVAL1);
buf AFU2  (AFVAL2_int,  AFVAL2);
buf AFU3  (AFVAL3_int,  AFVAL3);
buf AFU4  (AFVAL4_int,  AFVAL4);
buf AFU5  (AFVAL5_int,  AFVAL5);
buf AFU6  (AFVAL6_int,  AFVAL6);
buf AFU7  (AFVAL7_int,  AFVAL7);
buf AFU8  (AFVAL8_int,  AFVAL8);
buf AFU9  (AFVAL9_int,  AFVAL9);
buf AFU10 (AFVAL10_int, AFVAL10);
buf AFU11 (AFVAL11_int, AFVAL11);

buf AEU0  (AEVAL0_int,  AEVAL0);
buf AEU1  (AEVAL1_int,  AEVAL1);
buf AEU2  (AEVAL2_int,  AEVAL2);
buf AEU3  (AEVAL3_int,  AEVAL3);
buf AEU4  (AEVAL4_int,  AEVAL4);
buf AEU5  (AEVAL5_int,  AEVAL5);
buf AEU6  (AEVAL6_int,  AEVAL6);
buf AEU7  (AEVAL7_int,  AEVAL7);
buf AEU8  (AEVAL8_int,  AEVAL8);
buf AEU9  (AEVAL9_int,  AEVAL9);
buf AEU10 (AEVAL10_int, AEVAL10);
buf AEU11 (AEVAL11_int, AEVAL11);

buf WDU0  (WD0_int,     WD0);
buf WDU1  (WD1_int,     WD1);
buf WDU2  (WD2_int,     WD2);
buf WDU3  (WD3_int,     WD3);
buf WDU4  (WD4_int,     WD4);
buf WDU5  (WD5_int,     WD5);
buf WDU6  (WD6_int,     WD6);
buf WDU7  (WD7_int,     WD7);
buf WDU8  (WD8_int,     WD8);
buf WDU9  (WD9_int,     WD9);
buf WDU10 (WD10_int,    WD10);
buf WDU11 (WD11_int,    WD11);
buf WDU12 (WD12_int,    WD12);
buf WDU13 (WD13_int,    WD13);
buf WDU14 (WD14_int,    WD14);
buf WDU15 (WD15_int,    WD15);
buf WDU16 (WD16_int,    WD16);
buf WDU17 (WD17_int,    WD17);

buf WWU2  (WW2_int,     WW2);
buf WWU1  (WW1_int,     WW1);
buf WWU0  (WW0_int,     WW0);

buf RWU2  (RW2_int,     RW2);
buf RWU1  (RW1_int,     RW1);
buf RWU0  (RW0_int,     RW0);

buf RENU  (REN_int,     REN);
buf WENU  (WEN_int,     WEN);
buf RBLKU (RBLK_int,    RBLK);
buf WBLKU (WBLK_int,    WBLK);

buf WCLKU (WCLK_int,    WCLK);
buf RCLKU (RCLK_int,    RCLK);

buf RESETU (RESET_int,  RESET);
buf ESTOPU (ESTOP_int,  ESTOP);
buf FSTOPU (FSTOP_int,  FSTOP);
buf RPIPEU (RPIPE_int,  RPIPE);


pmos RDU0  (RD0,  RDP0,  0);
pmos RDU1  (RD1,  RDP1,  0);
pmos RDU2  (RD2,  RDP2,  0);
pmos RDU3  (RD3,  RDP3,  0);
pmos RDU4  (RD4,  RDP4,  0);
pmos RDU5  (RD5,  RDP5,  0);
pmos RDU6  (RD6,  RDP6,  0);
pmos RDU7  (RD7,  RDP7,  0);
pmos RDU8  (RD8,  RDP8,  0);
pmos RDU9  (RD9,  RDP9,  0);
pmos RDU10 (RD10, RDP10, 0);
pmos RDU11 (RD11, RDP11, 0);
pmos RDU12 (RD12, RDP12, 0);
pmos RDU13 (RD13, RDP13, 0);
pmos RDU14 (RD14, RDP14, 0);
pmos RDU15 (RD15, RDP15, 0);
pmos RDU16 (RD16, RDP16, 0);
pmos RDU17 (RD17, RDP17, 0);

pmos AEMPTYU (AEMPTY, AEMPTYP, 0);
pmos EMPTYU  (EMPTY,  EMPTYP,  0);
pmos AFULLU  (AFULL,  AFULLP,  0);
pmos FULLU   (FULL,   FULLP,   0);

integer MAX_ADDR;
integer WADDR;
integer WADDR_P1;
integer WADDR_P2;
integer RADDR;
integer RADDR_P1;
integer RADDR_P2;
integer BIT_WADDR;
integer BIT_RADDR;
integer WADDR_wrap;
integer WADDR_wrap_P1;
integer WADDR_wrap_P2;
integer RADDR_wrap;
integer RADDR_wrap_P1;
integer RADDR_wrap_P2;

integer AEVAL;
integer AFVAL;

integer wdepth;
integer rdepth;

assign WENABLE = RESET_int & ~WEN_int & ~WBLK_int; 
assign RENABLE = RESET_int &  REN_int & ~RBLK_int; 

  always @(WCLK_int or RESET_int)
      begin
	  if (WCLK_int === 1'bx && RESET_int == 1 ) begin
	      $display("Warning : WCLK went unknown at time %0.1f\n", $realtime);
	  end
      end

  always @(RCLK_int or RESET_int or RENABLE)
      begin
	  if (RCLK_int === 1'bx && RESET_int == 1 ) begin
	      $display("Warning : RCLK went unknown at time %0.1f\n", $realtime);
	      if (RENABLE == 1'b1) begin
		  `RDATAP_WIDTH_18 <= 18'bx;
	      end // if (RENABLE == 1'b1)
	  end 
      end 
    
always @(WCLK_int)
    begin
	WCLK_prev <= WCLK_int;
    end 
  
always @(RCLK_int)
    begin
	RCLK_prev <= RCLK_int;
    end 

  always @(RBLK_int)
      begin
	  RBLK_hold <=  RBLK_int;
	  RBLK_lastvalue <= RBLK_hold;
      end 

 always @(REN_int)
      begin
	  REN_hold <=  REN_int;
	  REN_lastvalue <= REN_hold;
      end  

  always @(WBLK_int)
      begin
	  WBLK_lastvalue <= WBLK_hold;	  
	  WBLK_hold <=  WBLK_int;
      end 
 
 always @(WEN_int)
      begin
	  WEN_hold <=  WEN_int;
	  WEN_lastvalue <= WEN_hold;
      end 

 always @(`AFULL_CFG_VECTOR)
      begin
	  AFVAL_hold <=  `AFULL_CFG_VECTOR;
	  AFVAL_lastvalue <= AFVAL_hold;
      end       

always @(`AEMPTY_CFG_VECTOR)
      begin
	  AEVAL_hold <=  `AEMPTY_CFG_VECTOR;
	  AEVAL_lastvalue <= AEVAL_hold;
      end       
  
// FIFO RESET behavior section

always @(RESET_int) begin
  if (RESET_int == 1'b0) begin
    WADDR         <= 0;
    WADDR_P1      <= 0;
    WADDR_P2      <= 0;
    WADDR_wrap    <= 0;
    WADDR_wrap_P1 <= 0;
    WADDR_wrap_P2 <= 0;
    RADDR         <= 0;
    RADDR_P1      <= 0;
    RADDR_P2      <= 0;
    RADDR_wrap    <= 0;
    RADDR_wrap_P1 <= 1;
    RADDR_wrap_P2 <= 1;
    FULLP         <= 1'b0;
    EMPTYP        <= 1'b1;
    AFULLP        <= 1'b0;
    AEMPTYP       <= 1'b1;
    `RDATAP_WIDTH_18 <= 18'b0;
    RD0_stg       <= 1'b0;
    RD1_stg       <= 1'b0;
    RD2_stg       <= 1'b0;
    RD3_stg       <= 1'b0;
    RD4_stg       <= 1'b0;
    RD5_stg       <= 1'b0;
    RD6_stg       <= 1'b0;
    RD7_stg       <= 1'b0;
    RD8_stg       <= 1'b0;
    RD9_stg       <= 1'b0;
    RD10_stg      <= 1'b0;
    RD11_stg      <= 1'b0;
    RD12_stg      <= 1'b0;
    RD13_stg      <= 1'b0;
    RD14_stg      <= 1'b0;
    RD15_stg      <= 1'b0;
    RD16_stg      <= 1'b0;
    RD17_stg      <= 1'b0;
      
  end else if (RESET_int === 1'bx) begin
      if ($time > 0) begin
	  $display("Warning : RESET went unknown at time %0.1f\n", $realtime);
      end
  end
end

  // FIFO WRITE behavior section

always @(posedge WCLK_int ) begin
  if (RESET_int == 1'b1 && WCLK_prev == 1'b0 && WCLK_int == 1'b1 ) begin
    // Synchronizer needs two WCLKs to generate empty flag
      RADDR_P2 = RADDR_P1;
      RADDR_P1 = RADDR;
      RADDR_wrap_P2 = RADDR_wrap_P1;
 if (RADDR_wrap == 0) 
      RADDR_wrap_P1 = 1;
    else
      RADDR_wrap_P1 = 0;

    if ((WBLK_int == 1'b0) && (WEN_int == 1'b0)) begin
      if ( ! ((FULLP == 1'b1) && (FSTOP_int == 1'b1))) begin
        case (`WWIDTH_CFG_VECTOR)
          3'b000 : begin
            MEM[WADDR] <= WD0_int;
            wdepth = 4096;
            if (WADDR < wdepth - 1 ) begin
              WADDR = #0 WADDR + 1;
            end else begin
              WADDR = #0 0;
              WADDR_wrap = 1 - WADDR_wrap;
            end
          end
          3'b001 : begin
            MEM[(WADDR * 2) + 0] <= WD0_int;
            MEM[(WADDR * 2) + 1] <= WD1_int;
            wdepth = 2048;
            if (WADDR < wdepth - 1 ) begin
              WADDR = #0 WADDR + 1;
            end else begin
              WADDR = #0 0;
              WADDR_wrap = 1 - WADDR_wrap;
            end
          end
          3'b010 : begin
            MEM[(WADDR * 4) + 0] <= WD0_int;
            MEM[(WADDR * 4) + 1] <= WD1_int;
            MEM[(WADDR * 4) + 2] <= WD2_int;
            MEM[(WADDR * 4) + 3] <= WD3_int;
            wdepth = 1024; 
            if (WADDR < wdepth - 1 ) begin
              WADDR = #0 WADDR + 1;
            end else begin
              WADDR = #0 0;
              WADDR_wrap = 1 - WADDR_wrap;
            end
          end
          3'b011 : begin
            MEM[(WADDR * 8) + 0] <= WD0_int;
            MEM[(WADDR * 8) + 1] <= WD1_int;
            MEM[(WADDR * 8) + 2] <= WD2_int;
            MEM[(WADDR * 8) + 3] <= WD3_int;
            MEM[(WADDR * 8) + 4] <= WD4_int;
            MEM[(WADDR * 8) + 5] <= WD5_int;
            MEM[(WADDR * 8) + 6] <= WD6_int;
            MEM[(WADDR * 8) + 7] <= WD7_int;
            MEM9[WADDR] = WD8_int;
            wdepth = 512; 
            if (WADDR < wdepth - 1 ) begin
              WADDR = #0 WADDR + 1;
            end else begin
              WADDR = #0 0;
              WADDR_wrap = 1 - WADDR_wrap;
		
            end
          end
          3'b100 : begin
            MEM[(WADDR * 16) + 0] <= WD0_int;
            MEM[(WADDR * 16) + 1] <= WD1_int;
            MEM[(WADDR * 16) + 2] <= WD2_int;
            MEM[(WADDR * 16) + 3] <= WD3_int;
            MEM[(WADDR * 16) + 4] <= WD4_int;
            MEM[(WADDR * 16) + 5] <= WD5_int;
            MEM[(WADDR * 16) + 6] <= WD6_int;
            MEM[(WADDR * 16) + 7] <= WD7_int;
            MEM9[WADDR *   2 + 0] <= WD8_int;
            MEM[(WADDR * 16) + 8] <= WD9_int;
            MEM[(WADDR * 16) + 9] <= WD10_int;
            MEM[(WADDR * 16) + 10] <= WD11_int;
            MEM[(WADDR * 16) + 11] <= WD12_int;
            MEM[(WADDR * 16) + 12] <= WD13_int;
            MEM[(WADDR * 16) + 13] <= WD14_int;
            MEM[(WADDR * 16) + 14] <= WD15_int;
            MEM[(WADDR * 16) + 15] <= WD16_int;
            MEM9[WADDR * 2 + 1] <= WD17_int;
            wdepth = 256; 
            if (WADDR < wdepth - 1 ) begin
              WADDR = #0 WADDR + 1;
            end else begin
              WADDR = #0 0;
              WADDR_wrap = 1 - WADDR_wrap;
            end
          end
          default: begin
	      $display("Warning: Illegal Write port width configuration");
          end
	endcase
      end // not (FULL and FSTOP)
	else if(FSTOP === 1'bx)
	    begin
		$display("Warning : FSTOP is unknown");
		$display("When FULL, to stop writing set FSTOP = 1, to overwrite set FSTOP= 0");
		$display("Time : %0.1fns Instance : %m",$realtime);
	    end 
	
    end // WBLK = 0 and WEN = 0
      else begin
	  if (WBLK_int === 1'bx &&  issue_WBLK == 0 && (WEN_int ==0 ||
							WEN_int === 1'bx))
	      begin
		  if ( WBLK_lastvalue !== 1'bx)
		      begin
			  $display("Warning : WBLK signal is unknown");
			  $display("Time : %0.1fns Instance : %m",$realtime);
			  issue_WBLK = 1;
		      end 
	      end 
	  else if(WBLK_int !== 1'bx)
	      issue_WBLK = 0;
	  
	  if (WEN_int === 1'bx && issue_WEN == 0 && (WBLK_int == 0 ||
						     WBLK_int === 1'bx))
	      begin
		  if ( WEN_lastvalue !== 1'bx)
		      begin	      
			  $display("Warning : WEN signal is unknown");
			  $display("Time : %0.1fns Instance : %m",$realtime);
			  issue_WEN = 1;
		      end // if ( WEN_lastvalue !== 1'bx)
	      end // if (WEN_int === 1'bx && issue_WEN == 0)
	  else if(WEN_int !== 1'bx)
	      issue_WEN = 0;
	  
      end 

      fifo_flags(`AFULL_CFG_VECTOR, `AEMPTY_CFG_VECTOR, `RWIDTH_CFG_VECTOR,
		 `WWIDTH_CFG_VECTOR);

      mask = get_mask(`RWIDTH_CFG_VECTOR,`WWIDTH_CFG_VECTOR);
      xor_afval = ^ (`AFULL_CFG_VECTOR & {8'hff,mask});
      if ( xor_afval !== 1'bx)
	  issue_afval = 0;
      else if ( xor_afval === 1'bx && issue_afval == 0)
	  begin
	      $display("Warning : Invalid AFVAL %b",`AFULL_CFG_VECTOR);
	      $display("Holding the value of AFULL FLAG ");
	      $display("Time : %0.1fns Instance : %m",$realtime);
	      issue_afval = 1;	  
	  end 

  end // if RESET deasserted
end  // Write section

  // FIFO READ behavior section

  always @(posedge RCLK_int) begin
      if (RESET_int == 1'b1  && RCLK_prev == 1'b0 && RCLK_int == 1'b1) begin
    // Synchronizer needs two RCLKs to generate empty flag
      WADDR_P2 = WADDR_P1;
      WADDR_P1 = WADDR;
      WADDR_wrap_P2 = WADDR_wrap_P1;
      WADDR_wrap_P1 = WADDR_wrap;
 
    if (RPIPE_int == 1'b1) begin // Pipelining on
      RDP0  <= RD0_stg;
      RDP1  <= RD1_stg;
      RDP2  <= RD2_stg;
      RDP3  <= RD3_stg;
      RDP4  <= RD4_stg;
      RDP5  <= RD5_stg;
      RDP6  <= RD6_stg;
      RDP7  <= RD7_stg;
      RDP8  <= RD8_stg;
      RDP9  <= RD9_stg;
      RDP10 <= RD10_stg;
      RDP11 <= RD11_stg;
      RDP12 <= RD12_stg;
      RDP13 <= RD13_stg;
      RDP14 <= RD14_stg;
      RDP15 <= RD15_stg;
      RDP16 <= RD16_stg;
      RDP17 <= RD17_stg;
    end
    else if (RPIPE_int === 1'bx ) begin // RPIPE unknown
      $display("Warning : RPIPE signal unknown.");

      RDP0  <= 1'bx;
      RDP1  <= 1'bx;
      RDP2  <= 1'bx;
      RDP3  <= 1'bx;
      RDP4  <= 1'bx;
      RDP5  <= 1'bx;
      RDP6  <= 1'bx;
      RDP7  <= 1'bx;
      RDP8  <= 1'bx;
      RDP9  <= 1'bx;
      RDP10 <= 1'bx;
      RDP11 <= 1'bx;
      RDP12 <= 1'bx;
      RDP13 <= 1'bx;
      RDP14 <= 1'bx;
      RDP15 <= 1'bx;
      RDP16 <= 1'bx;
      RDP17 <= 1'bx;
    end

    if ((RBLK_int == 1'b0) && (REN_int == 1'b1)) begin
      if ( ! ((EMPTYP == 1'b1) && (ESTOP_int == 1'b1))) begin // OK to Read
        if (RPIPE_int == 1'b0) begin // Pipelining off 
          case (`RWIDTH_CFG_VECTOR)
            3'b000 : begin
              RDP0  <= MEM[RADDR];
              rdepth = 4096;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b001 : begin
              RDP0  <= MEM[(RADDR * 2) + 0];
              RDP1  <= MEM[(RADDR * 2) + 1];
              rdepth = 2048;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b010 : begin
              RDP0  <= MEM[(RADDR * 4) + 0];
              RDP1  <= MEM[(RADDR * 4) + 1];
              RDP2  <= MEM[(RADDR * 4) + 2];
              RDP3  <= MEM[(RADDR * 4) + 3];
              rdepth = 1024;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b011 : begin
              RDP0  <= MEM[(RADDR * 8) + 0];
              RDP1  <= MEM[(RADDR * 8) + 1];
              RDP2  <= MEM[(RADDR * 8) + 2];
              RDP3  <= MEM[(RADDR * 8) + 3];
              RDP4  <= MEM[(RADDR * 8) + 4];
              RDP5  <= MEM[(RADDR * 8) + 5];
              RDP6  <= MEM[(RADDR * 8) + 6];
              RDP7  <= MEM[(RADDR * 8) + 7];
              RDP8  <= MEM9[RADDR];
              rdepth = 512;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b100 : begin
              RDP0  <= MEM[(RADDR * 16) + 0];
              RDP1  <= MEM[(RADDR * 16) + 1];
              RDP2  <= MEM[(RADDR * 16) + 2];
              RDP3  <= MEM[(RADDR * 16) + 3];
              RDP4  <= MEM[(RADDR * 16) + 4];
              RDP5  <= MEM[(RADDR * 16) + 5];
              RDP6  <= MEM[(RADDR * 16) + 6];
              RDP7  <= MEM[(RADDR * 16) + 7];
              RDP8  <= MEM9[RADDR*2 +0];
              RDP9  <= MEM[(RADDR * 16) + 8];
              RDP10 <= MEM[(RADDR * 16) + 9];
              RDP11 <= MEM[(RADDR * 16) + 10];
              RDP12 <= MEM[(RADDR * 16) + 11];
              RDP13 <= MEM[(RADDR * 16) + 12];
              RDP14 <= MEM[(RADDR * 16) + 13];
              RDP15 <= MEM[(RADDR * 16) + 14];
              RDP16 <= MEM[(RADDR * 16) + 15];
              RDP17 <= MEM9[RADDR * 2 + 1];
              rdepth = 256;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            default: begin
              $display("Warning: Illegal Read port width configuration");
            end
          endcase
        end else if (RPIPE_int == 1'b1) begin // Pipelining on
          case (`RWIDTH_CFG_VECTOR)
            3'b000 : begin
              RD0_stg  <= MEM[RADDR];
              rdepth = 4096;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b001 : begin
              RD0_stg  <= MEM[(RADDR * 2) + 0];
              RD1_stg  <= MEM[(RADDR * 2) + 1];
              rdepth = 2048;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b010 : begin
              RD0_stg  <= MEM[(RADDR * 4) + 0];
              RD1_stg  <= MEM[(RADDR * 4) + 1];
              RD2_stg  <= MEM[(RADDR * 4) + 2];
              RD3_stg  <= MEM[(RADDR * 4) + 3];
              rdepth = 1024;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b011 : begin
              RD0_stg  <= MEM[(RADDR * 8) + 0];
              RD1_stg  <= MEM[(RADDR * 8) + 1];
              RD2_stg  <= MEM[(RADDR * 8) + 2];
              RD3_stg  <= MEM[(RADDR * 8) + 3];
              RD4_stg  <= MEM[(RADDR * 8) + 4];
              RD5_stg  <= MEM[(RADDR * 8) + 5];
              RD6_stg  <= MEM[(RADDR * 8) + 6];
              RD7_stg  <= MEM[(RADDR * 8) + 7];
              RD8_stg  <= MEM9[RADDR];
              rdepth = 512;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            3'b100 : begin
              RD0_stg  <= MEM[(RADDR * 16) + 0];
              RD1_stg  <= MEM[(RADDR * 16) + 1];
              RD2_stg  <= MEM[(RADDR * 16) + 2];
              RD3_stg  <= MEM[(RADDR * 16) + 3];
              RD4_stg  <= MEM[(RADDR * 16) + 4];
              RD5_stg  <= MEM[(RADDR * 16) + 5];
              RD6_stg  <= MEM[(RADDR * 16) + 6];
              RD7_stg  <= MEM[(RADDR * 16) + 7];
              RD8_stg  <= MEM9[RADDR*2 +0];
              RD9_stg  <= MEM[(RADDR * 16) + 8];
              RD10_stg <= MEM[(RADDR * 16) + 9];
              RD11_stg <= MEM[(RADDR * 16) + 10];
              RD12_stg <= MEM[(RADDR * 16) + 11];
              RD13_stg <= MEM[(RADDR * 16) + 12];
              RD14_stg <= MEM[(RADDR * 16) + 13];
              RD15_stg <= MEM[(RADDR * 16) + 14];
              RD16_stg <= MEM[(RADDR * 16) + 15];
              RD17_stg <= MEM9[RADDR * 2 + 1];
              rdepth = 256;
              if (RADDR < rdepth - 1) begin
                RADDR = #0 RADDR + 1;
              end else begin
                RADDR = #0 0;
                RADDR_wrap = 1 - RADDR_wrap;
              end
            end
            default: begin
              $display("Warning: Illegal Read port width configuration");
            end
          endcase
        end // RPIPE == 1
      end // if (EMPTY and ESTOP)
	else if (ESTOP === 1'bx )
	    begin
		$display("Warning : ESTOP is unknown");
		$display("When FIFO is EMPTY, to stop reading ESTOP=1 or to continue reading old data ESTOP=0");
		$display("Time : %0.1fns Instance : %m",$realtime);
	    end 
    end // if REN = 1 and RBLK = 0

      else begin
	  if (RBLK_int === 1'bx &&  issue_RBLK == 0 && (REN_int == 1 ||
							REN_int === 1'bx) )
	      begin
		  if ( RBLK_lastvalue !== 1'bx)
		      begin
			  $display("Warning : RBLK signal is unknown");
			  $display("Time : %0.1fns Instance : %m",$realtime);
			  issue_RBLK = 1;
		      end 
	      end 
	  else if(RBLK_int !== 1'bx)
	      issue_RBLK = 0;
	  
	  if (REN_int === 1'bx && issue_REN == 0 && (RBLK_int == 0 ||
						     RBLK_int === 1'bx))
	      begin
		  if ( REN_lastvalue !== 1'bx)
		      begin	      
			  $display("Warning : REN signal is unknown");
			  $display("Time : %0.1fns Instance : %m",$realtime);
			  issue_REN = 1;
		      end 
	      end 
	  else if (REN_int !== 1'bx )
	      issue_REN = 0;
      end 
      
	  fifo_flags(`AFULL_CFG_VECTOR, `AEMPTY_CFG_VECTOR,
		     `RWIDTH_CFG_VECTOR, `WWIDTH_CFG_VECTOR);
	  mask = get_mask(`RWIDTH_CFG_VECTOR,`WWIDTH_CFG_VECTOR);
	  xor_aeval = ^ (`AFULL_CFG_VECTOR & {8'hff,mask});
	  if ( xor_aeval !== 1'bx)
	      issue_aeval = 0;
	  else if ( xor_aeval === 1'bx && issue_aeval == 0)
	      begin
		  $display("Warning : Invalid AEVAL %b",`AEMPTY_CFG_VECTOR);
		  $display("Holding the value of AEMPTY FLAG ");
		  $display("Time : %0.1fns Instance : %m",$realtime);
		  issue_aeval = 1;	  
	      end 
      end // if RESET deasserted
  end // Read section
  
function integer get_rel_value;
   input [11:0] addr_signal;
   input [3:0] 	mask;
   integer 	value;
    begin
	value =  addr_signal[11] * 2048 + addr_signal[10] * 1024 
		 + addr_signal[9] *  512  + addr_signal[8]  * 256
		 + addr_signal[7] *  128  + addr_signal[6]  * 64 
		 + addr_signal[5] *  32   + addr_signal[4]  * 16
		 + (addr_signal[3] & mask[3]) * 8
		 + (addr_signal[2] & mask[2]) * 4 
		 + (addr_signal[1] & mask[1]) * 2
		 + (addr_signal[0] & mask[0]) * 1;
	
	get_rel_value = value / (16-mask);
    end
endfunction

function [3:0] get_mask;
     input [2:0] rw;
     input [2:0] ww;
     reg [3:0] 	 rmask,wmask;
      begin
	  rmask = 4'b1111 << rw;
	  wmask = 4'b1111 << ww;
	  get_mask = rmask & wmask;
      end
endfunction // get_mask
  
task fifo_flags;

  input [11:0] afval_cfg_bus;
  input [11:0] aeval_cfg_bus;
  input [2:0]  rwidth_cfg_bus; 
  input [2:0]  wwidth_cfg_bus;

  integer raddr_rel;
  integer raddr_rel_p2;
  integer waddr_rel;
  integer waddr_rel_p2;    
  integer afval_rel, aeval_rel;    
  integer rel_depth;
   integer num_fifo_entries;
 
    begin
	if (^(wwidth_cfg_bus) === 1'bx || (wwidth_cfg_bus > 4))
	    begin
		$display("Warning: Illegal Write port width configuration");
	    end
	else if (^(rwidth_cfg_bus) === 1'bx || (rwidth_cfg_bus > 4))
	    begin
		$display("Warning: Illegal Read port width configuration");
	    end	    
	else if (wwidth_cfg_bus >= rwidth_cfg_bus)
	    begin
		
		raddr_rel = RADDR >> (wwidth_cfg_bus - rwidth_cfg_bus);
		raddr_rel_p2 = RADDR_P2 >> (wwidth_cfg_bus - rwidth_cfg_bus);
		waddr_rel = WADDR;
		waddr_rel_p2 = WADDR_P2;
		rel_depth = 1 << (12 - wwidth_cfg_bus);
	    end 
	else
	    begin
		waddr_rel = WADDR >> (rwidth_cfg_bus - wwidth_cfg_bus);
		waddr_rel_p2 = WADDR_P2 >> (rwidth_cfg_bus - wwidth_cfg_bus);
		raddr_rel = RADDR;
		raddr_rel_p2 = RADDR_P2;
		rel_depth = 1 << (12 - rwidth_cfg_bus);
	    end 

      aeval_rel = get_rel_value(aeval_cfg_bus, get_mask(rwidth_cfg_bus, wwidth_cfg_bus));
      afval_rel = get_rel_value(afval_cfg_bus, get_mask(rwidth_cfg_bus, wwidth_cfg_bus));
 
    // Pipelined addresses used for FULL and EMPTY calculations

	if ((WADDR_wrap == RADDR_wrap_P2) && (waddr_rel == raddr_rel_p2))
	    FULLP = 1'b1;
	else
	    FULLP = 1'b0;

	if ((RADDR_wrap == WADDR_wrap_P2) && (waddr_rel_p2 == raddr_rel))
	    EMPTYP = 1'b1;
	else
	    EMPTYP = 1'b0;

	//Number of FIFO ENTRIES	
	if (waddr_rel >= raddr_rel)
	    num_fifo_entries = waddr_rel - raddr_rel;
	else
	    num_fifo_entries = rel_depth + waddr_rel - raddr_rel;
	//aempty, afull generation
	if (FULLP == 1'b1)
	    AEMPTYP = 1'b0;
	else
	    begin
		if (num_fifo_entries > aeval_rel) 
		    AEMPTYP = 1'b0;
		else if (num_fifo_entries <= aeval_rel)
		    AEMPTYP = 1'b1;
	    end 

	if (EMPTYP == 1'b1) 
	    AFULLP = 1'b0;
	else if (FULLP == 1'b1) 
	    AFULLP = 1'b1;
	else
	    begin
		if (num_fifo_entries < afval_rel) 
		    AFULLP = 1'b0;
		else if (num_fifo_entries >= afval_rel)  
		    AFULLP = 1'b1;
	    end
    end
endtask
 
specify

      specparam   LibName     = "iglooplus";
      
      (posedge RCLK => (RD0+:RD0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD1+:RD1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD2+:RD2) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD3+:RD3) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD4+:RD4) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD5+:RD5) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD6+:RD6) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD7+:RD7) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD8+:RD8) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD9+:RD9) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD10+:RD10) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD11+:RD11) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD12+:RD12) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD13+:RD13) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD14+:RD14) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD15+:RD15) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD16+:RD16) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge RCLK => (RD17+:RD17) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (posedge RCLK => (EMPTY +: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      if (AEMPTYP)
      (posedge RCLK => (AEMPTY+: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      if (!AFULLP)
      (posedge RCLK => (AFULL +: 1'b0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      if (!AEMPTYP)
      (posedge WCLK => (AEMPTY+: 1'b0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      if (AFULLP)
      (posedge WCLK => (AFULL +: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (posedge WCLK => (FULL  +: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge RESET => (RD0+:RD0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD1+:RD1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD2+:RD2) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD3+:RD3) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD4+:RD4) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD5+:RD5) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD6+:RD6) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD7+:RD7) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD8+:RD8) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD9+:RD9) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD10+:RD10) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD11+:RD11) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD12+:RD12) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD13+:RD13) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD14+:RD14) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD15+:RD15) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD16+:RD16) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (RD17+:RD17) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge RESET => (EMPTY +: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (AEMPTY+: 1'b1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (FULL  +: 1'b0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge RESET => (AFULL +: 1'b0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      $setup(posedge WD17, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD17, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD17, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD17, 0.0, NOTIFY_REG);
      $setup(posedge WD16, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD16, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD16, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD16, 0.0, NOTIFY_REG);
      $setup(posedge WD15, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD15, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD15, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD15, 0.0, NOTIFY_REG);
      $setup(posedge WD14, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD14, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD14, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD14, 0.0, NOTIFY_REG);
      $setup(posedge WD13, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD13, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD13, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD13, 0.0, NOTIFY_REG);
      $setup(posedge WD12, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD12, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD12, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD12, 0.0, NOTIFY_REG);
      $setup(posedge WD11, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD11, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD11, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD11, 0.0, NOTIFY_REG);
      $setup(posedge WD10, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD10, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD10, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD10, 0.0, NOTIFY_REG);
      $setup(posedge WD9, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD9, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD9, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD9, 0.0, NOTIFY_REG);

      $setup(posedge WD8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD8, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD8, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD8, 0.0, NOTIFY_REG);
      $setup(posedge WD7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD7, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD7, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD7, 0.0, NOTIFY_REG);
      $setup(posedge WD6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD6, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD6, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD6, 0.0, NOTIFY_REG);
      $setup(posedge WD5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD5, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD5, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD5, 0.0, NOTIFY_REG);
      $setup(posedge WD4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD4, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD4, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD4, 0.0, NOTIFY_REG);
      $setup(posedge WD3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD3, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD3, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD3, 0.0, NOTIFY_REG);
      $setup(posedge WD2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD2, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD2, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD2, 0.0, NOTIFY_REG);
      $setup(posedge WD1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD1, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD1, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD1, 0.0, NOTIFY_REG);
      $setup(posedge WD0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $setup(negedge WD0, posedge WCLK &&& WENABLE, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, posedge WD0, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& WENABLE, negedge WD0, 0.0, NOTIFY_REG);

      $setup(posedge WEN, posedge WCLK &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge WEN, posedge WCLK &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& RESET, posedge WEN, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& RESET, negedge WEN, 0.0, NOTIFY_REG);
      $setup(posedge WBLK, posedge WCLK &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge WBLK, posedge WCLK &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& RESET, posedge WBLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK &&& RESET, negedge WBLK, 0.0, NOTIFY_REG);

      $setup(posedge FSTOP, posedge WCLK, 0.0, NOTIFY_REG);
      $setup(negedge FSTOP, posedge WCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, posedge FSTOP, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, negedge FSTOP, 0.0, NOTIFY_REG);

      $setup(posedge WW2, posedge WCLK, 0.0, NOTIFY_REG);
      $setup(negedge WW2, posedge WCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, posedge WW2, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, negedge WW2, 0.0, NOTIFY_REG);
      $setup(posedge WW1, posedge WCLK, 0.0, NOTIFY_REG);
      $setup(negedge WW1, posedge WCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, posedge WW1, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, negedge WW1, 0.0, NOTIFY_REG);
      $setup(posedge WW0, posedge WCLK, 0.0, NOTIFY_REG);
      $setup(negedge WW0, posedge WCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, posedge WW0, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, negedge WW0, 0.0, NOTIFY_REG);

      $setup(posedge REN, posedge RCLK &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge REN, posedge RCLK &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RESET, posedge REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RESET, negedge REN, 0.0, NOTIFY_REG);
      $setup(posedge RBLK, posedge RCLK &&& RESET, 0.0, NOTIFY_REG);
      $setup(negedge RBLK, posedge RCLK &&& RESET, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RESET, posedge RBLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK &&& RESET, negedge RBLK, 0.0, NOTIFY_REG);

      $setup(posedge ESTOP, posedge RCLK, 0.0, NOTIFY_REG);
      $setup(negedge ESTOP, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge ESTOP, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, negedge ESTOP, 0.0, NOTIFY_REG);

      $setup(posedge RW2, posedge RCLK, 0.0, NOTIFY_REG);
      $setup(negedge RW2, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge RW2, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, negedge RW2, 0.0, NOTIFY_REG);
      $setup(posedge RW1, posedge RCLK, 0.0, NOTIFY_REG);
      $setup(negedge RW1, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge RW1, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, negedge RW1, 0.0, NOTIFY_REG);
      $setup(posedge RW0, posedge RCLK, 0.0, NOTIFY_REG);
      $setup(negedge RW0, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge RW0, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, negedge RW0, 0.0, NOTIFY_REG);

      $width(posedge WCLK, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK, 0.0, 0, NOTIFY_REG);

      $recovery(posedge RESET, posedge WCLK, 0.0, NOTIFY_REG);
      $recovery(posedge RESET, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, posedge RESET, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, posedge RESET, 0.0, NOTIFY_REG);

      $width(negedge RESET, 0.0, 0, NOTIFY_REG);

endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
//---- END MODULE FIFO4K18 ----
    
/*---------------------------------------------------------------
 CELL NAME : UFROM
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module UFROM( ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0, CLK,
              DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0 );

input     ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0, CLK;
output    DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0;

reg [7:0] memory_array [0:127];

wire      ADDR6_int, ADDR5_int, ADDR4_int, ADDR3_int, ADDR2_int, ADDR1_int, ADDR0_int;
reg       DO7_int, DO6_int, DO5_int, DO4_int, DO3_int, DO2_int, DO1_int, DO0_int;

reg [6:0] ADDR;
reg       addr_is_x;
reg       NOTIFY_REG;

`define   ADDR_BUS    {ADDR6_int, ADDR5_int, ADDR4_int, ADDR3_int, ADDR2_int, ADDR1_int, ADDR0_int}
`define   ROM_DO_BUS  {DO7_int, DO6_int, DO5_int, DO4_int, DO3_int, DO2_int, DO1_int, DO0_int}

buf BUF_U0 (ADDR0_int, ADDR0);
buf BUF_U1 (ADDR1_int, ADDR1);
buf BUF_U2 (ADDR2_int, ADDR2);
buf BUF_U3 (ADDR3_int, ADDR3);
buf BUF_U4 (ADDR4_int, ADDR4);
buf BUF_U5 (ADDR5_int, ADDR5);
buf BUF_U6 (ADDR6_int, ADDR6);
buf BUF_U7 (CLK_int, CLK);

buf OUTBUF_U34 (DO0, DO0_int);
buf OUTBUF_U35 (DO1, DO1_int);
buf OUTBUF_U36 (DO2, DO2_int);
buf OUTBUF_U37 (DO3, DO3_int);
buf OUTBUF_U38 (DO4, DO4_int);
buf OUTBUF_U39 (DO5, DO5_int);
buf OUTBUF_U40 (DO6, DO6_int);
buf OUTBUF_U41 (DO7, DO7_int);

parameter MEMORYFILE = "";
parameter DATA_X     = 1;

// Parameter for maintaining programing file info in design flow.
parameter ACT_PROGFILE   = "";

  initial
    begin
      if ( MEMORYFILE != "" )
        $readmemb ( MEMORYFILE, memory_array );
      else
        begin
          $display ( "Error: Module %m, memory initialization file parameter MEMORYFILE not defined" );
          $finish;
        end
    end

  // latch input address on rising edge of CLK_int

  always @( posedge CLK_int )
    begin
      ADDR      = `ADDR_BUS;   
      addr_is_x = address_is_x ( ADDR );
      // users can turn-off data being driven to "X" on posedge CLK_ipd, by setting DATA_X to 0
      if ( DATA_X == 1 )
        `ROM_DO_BUS = 8'bx;
    end

  // updated DO only on the falling edge of CLK

  always @ ( negedge CLK_int )
    begin
      read_memory ( `ROM_DO_BUS, ADDR );
    end

  // task to read the contents of an addressed memory location.

  task  read_memory;

    output   [7:0] data_out;
    input    [6:0] address;
    reg      [7:0] temp_reg;
    reg      [7:0] data_out;

    begin
      if ( addr_is_x == 1'b0)
        begin
          temp_reg = memory_array[address];
          data_out = temp_reg;
        end
      else
        data_out = 8'bx;
    end

  endtask

  // function to check if any of the address bits is unknown

  function address_is_x;

    input    [6:0] address;
    integer        i;

    begin
      address_is_x = 1'b0;
      begin : CHECK_ADDRESS
        for ( i = 0; i <= 6; i = i+1 )
          if ( address[i] === 1'bx )
            begin
              // generate warning message only if input address is previously at known state
              if ( addr_is_x !== 1'b1 )
                $display("Warning : Address (%b) unknown at time %10g", address, $realtime);
              address_is_x = 1'b1;
              disable CHECK_ADDRESS;
            end
      end // CHECK_ADDRESS
    end

  endfunction // address_is_x

//--------------------------------------------------------------
//              Timing Checking Section
//-------------------------------------------------------------

  specify

    //checking setup and hold timing for inputs

    $setup ( posedge ADDR6, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR6, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR6, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR6, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR5, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR5, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR5, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR5, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR4, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR4, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR4, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR4, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR3, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR3, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR3, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR3, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR2, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR2, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR2, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR2, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR1, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR1, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR1, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR1, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR0, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR0, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR0, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR0, 0.0, NOTIFY_REG );

    //checking the pulse width on CLK pin

    $width ( posedge CLK, 0, 0, NOTIFY_REG );
    $width ( negedge CLK, 0, 0, NOTIFY_REG );

    //IOPATH delay from CLK to DO

    ( CLK => DO7 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );   
    ( CLK => DO6 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO5 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO4 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO3 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO2 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO1 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO0 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );

    specparam PATHPULSE$CLK$DO7 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO6 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO5 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO4 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO3 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO2 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO1 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO0 = ( 0.1 , 0.1 );

  endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : UFROMH
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module UFROMH( ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0, CLK,
               DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0 );

input     ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0, CLK;
output    DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0;

reg [7:0] memory_array [0:127];

wire      ADDR6_int, ADDR5_int, ADDR4_int, ADDR3_int, ADDR2_int, ADDR1_int, ADDR0_int;
reg       DO7_int, DO6_int, DO5_int, DO4_int, DO3_int, DO2_int, DO1_int, DO0_int;

reg [6:0] ADDR;
reg       addr_is_x;
reg       NOTIFY_REG;

`define   ADDR_BUS    {ADDR6_int, ADDR5_int, ADDR4_int, ADDR3_int, ADDR2_int, ADDR1_int, ADDR0_int}
`define   ROM_DO_BUS  {DO7_int, DO6_int, DO5_int, DO4_int, DO3_int, DO2_int, DO1_int, DO0_int}

buf BUF_U0 (ADDR0_int, ADDR0);
buf BUF_U1 (ADDR1_int, ADDR1);
buf BUF_U2 (ADDR2_int, ADDR2);
buf BUF_U3 (ADDR3_int, ADDR3);
buf BUF_U4 (ADDR4_int, ADDR4);
buf BUF_U5 (ADDR5_int, ADDR5);
buf BUF_U6 (ADDR6_int, ADDR6);
buf BUF_U7 (CLK_int, CLK);

buf OUTBUF_U34 (DO0, DO0_int);
buf OUTBUF_U35 (DO1, DO1_int);
buf OUTBUF_U36 (DO2, DO2_int);
buf OUTBUF_U37 (DO3, DO3_int);
buf OUTBUF_U38 (DO4, DO4_int);
buf OUTBUF_U39 (DO5, DO5_int);
buf OUTBUF_U40 (DO6, DO6_int);
buf OUTBUF_U41 (DO7, DO7_int);

parameter MEMORYFILE = "";
parameter DATA_X     = 1;

// Parameter for maintaining programing file info in design flow.
parameter ACT_PROGFILE   = "";

  initial
    begin
      if ( MEMORYFILE != "" )
        $readmemb ( MEMORYFILE, memory_array );
      else
        begin
          $display ( "Error: Module %m, memory initialization file parameter MEMORYFILE not defined" );
          $finish;
        end
    end

  // latch input address on rising edge of CLK_int

  always @( posedge CLK_int )
    begin
      ADDR      = `ADDR_BUS;   
      addr_is_x = address_is_x ( ADDR );
      // users can turn-off data being driven to "X" on posedge CLK_ipd, by setting DATA_X to 0
      if ( DATA_X == 1 )
        `ROM_DO_BUS = 8'bx;
    end

  // updated DO only on the falling edge of CLK

  always @ ( negedge CLK_int )
    begin
      read_memory ( `ROM_DO_BUS, ADDR );
    end

  // task to read the contents of an addressed memory location.

  task  read_memory;

    output   [7:0] data_out;
    input    [6:0] address;
    reg      [7:0] temp_reg;
    reg      [7:0] data_out;

    begin
      if ( addr_is_x == 1'b0)
        begin
          temp_reg = memory_array[address];
          data_out = temp_reg;
        end
      else
        data_out = 8'bx;
    end

  endtask

  // function to check if any of the address bits is unknown

  function address_is_x;

    input    [6:0] address;
    integer        i;

    begin
      address_is_x = 1'b0;
      begin : CHECK_ADDRESS
        for ( i = 0; i <= 6; i = i+1 )
          if ( address[i] === 1'bx )
            begin
              // generate warning message only if input address is previously at known state
              if ( addr_is_x !== 1'b1 )
                $display("Warning : Address (%b) unknown at time %10g", address, $realtime);
              address_is_x = 1'b1;
              disable CHECK_ADDRESS;
            end
      end // CHECK_ADDRESS
    end

  endfunction // address_is_x

//--------------------------------------------------------------
//              Timing Checking Section
//-------------------------------------------------------------

  specify

    //checking setup and hold timing for inputs

    $setup ( posedge ADDR6, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR6, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR6, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR6, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR5, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR5, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR5, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR5, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR4, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR4, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR4, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR4, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR3, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR3, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR3, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR3, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR2, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR2, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR2, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR2, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR1, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR1, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR1, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR1, 0.0, NOTIFY_REG );

    $setup ( posedge ADDR0, posedge CLK, 0.0, NOTIFY_REG );
    $setup ( negedge ADDR0, posedge CLK, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, posedge ADDR0, 0.0, NOTIFY_REG );
    $hold  ( posedge CLK, negedge ADDR0, 0.0, NOTIFY_REG );

    //checking the pulse width on CLK pin

    $width ( posedge CLK, 0, 0, NOTIFY_REG );
    $width ( negedge CLK, 0, 0, NOTIFY_REG );

    //IOPATH delay from CLK to DO

    ( CLK => DO7 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );   
    ( CLK => DO6 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO5 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO4 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO3 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO2 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO1 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );
    ( CLK => DO0 ) = ( 0.1:0.1:0.1, 0.1:0.1:0.1 );

    specparam PATHPULSE$CLK$DO7 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO6 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO5 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO4 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO3 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO2 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO1 = ( 0.1 , 0.1 );
    specparam PATHPULSE$CLK$DO0 = ( 0.1 , 0.1 );

  endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*
`timescale 1 ps/1 ps

module CLKDIVDLY1 (
        CLK,
        ODIV0,
        ODIV1,
        ODIV2,
        ODIV3,
        ODIV4,
        DLYY0,
        DLYY1,
        DLYY2,
        DLYY3,
        DLYY4,
        DLYGL0,
        DLYGL1,
        DLYGL2,
        DLYGL3,
        DLYGL4,
        GL,
        Y);


 output GL, Y;
 input  CLK, ODIV0, ODIV1, ODIV2, ODIV3, ODIV4, DLYY0, DLYY1, DLYY2, DLYY3, DLYY4, DLYGL0, DLYGL1, DLYGL2,DLYGL3,DLYGL4;

parameter       t_rise = 0;
parameter       t_fall = 0;

time            GLDELAY;
time            YDELAY;
time            timemult;
reg              Q;
integer         num_edges;

integer         DelayVal1,DelayVal2;
integer         i;
integer          DivVal2;
integer         DIV;

wire [4:0] ODIV_ipd;
wire [4:0] DLYY_ipd;
wire [4:0] DLYGL_ipd;
wire       CLK_ipd;

assign    #(t_rise,t_fall) ODIV_ipd[0] = ODIV0;
assign    #(t_rise,t_fall) ODIV_ipd[1] = ODIV1;
assign    #(t_rise,t_fall) ODIV_ipd[2] = ODIV2;
assign    #(t_rise,t_fall) ODIV_ipd[3] = ODIV3;
assign    #(t_rise,t_fall) ODIV_ipd[4] = ODIV4;
assign    #(t_rise,t_fall) DLYY_ipd[0] = DLYY0;
assign    #(t_rise,t_fall) DLYY_ipd[1] = DLYY1;
assign    #(t_rise,t_fall) DLYY_ipd[2] = DLYY2;
assign    #(t_rise,t_fall) DLYY_ipd[3] = DLYY3;
assign    #(t_rise,t_fall) DLYY_ipd[4] = DLYY4;
assign    #(t_rise,t_fall) DLYGL_ipd[0] = DLYGL0;
assign    #(t_rise,t_fall) DLYGL_ipd[1] = DLYGL1;
assign    #(t_rise,t_fall) DLYGL_ipd[2] = DLYGL2;
assign    #(t_rise,t_fall) DLYGL_ipd[3] = DLYGL3;
assign    #(t_rise,t_fall) DLYGL_ipd[4] = DLYGL4;
assign    #(t_rise,t_fall) CLK_ipd = CLK;
assign  # GLDELAY GL = Q;
assign  # YDELAY Y = Q; 

// get GL delay
//

always @( DLYGL_ipd )
begin

        for(i = 0; i < 5; i = i + 1)
                begin
                if (DLYGL_ipd[i] == 1)
                                DelayVal1 = DelayVal1 + (1 << i);
                end
        GLDELAY <= (DelayVal1 * timemult) + 400;
        DelayVal1 <= 0;
end


//
// get Y delay
//

always @( DLYY_ipd )
begin
        DelayVal2 <= 0;
        for(i = 0; i < 5; i = i + 1)
                begin
                if (DLYY_ipd[i] == 1)
                                DelayVal2 = DelayVal2 + (1 << i);
                end
        YDELAY <= (DelayVal2 * timemult) + 400;
end



//Get DIV value Block

always@(ODIV_ipd)
begin
         DivVal2 <= 0;
        for(i = 0; i < 5; i = i + 1)
         begin
           if (ODIV_ipd[i] == 1)
                    DivVal2 = DivVal2 + (1 << i);
         end
        DIV <= DivVal2 + 1;
        num_edges = -1;
end





 //
 //  Output of Divider 
 //  Assumes input 50/50 duty cycle
 //

 
  always@ (CLK_ipd)
  begin
  if (CLK_ipd == 1'bx)
    Q = 1'bx;
  else if (DIV == 1)
    Q = CLK_ipd;
  else
  begin
   if ((Q == 1'b0) || (Q == 1'b1))
    begin
     num_edges = num_edges + 1;
     if (num_edges == 0)
        Q = CLK_ipd;
     else
      if (num_edges % DIV == 1)
        Q = !Q;
      else
        Q = Q;
   end else
       Q = CLK_ipd;
   end
  end


 initial
   begin
        DelayVal1 = 0;
        DelayVal2 = 0;
        DivVal2 = 0;
        DIV = 1;
        timemult = 125;
        YDELAY = 0;
        GLDELAY = 0;
        Q = 1'bx;
        num_edges = -1;
        Q = 1'bx;
   end

endmodule
*/

/*
`timescale 1 ps/1 ps

module CLKDIVDLY (
        CLK,
        ODIV0,
        ODIV1,
        ODIV2,
        ODIV3,
        ODIV4,
        DLYGL0,
        DLYGL1,
        DLYGL2,
        DLYGL3,
        DLYGL4,
        GL);


 output GL;
 input  CLK, ODIV0, ODIV1, ODIV2, ODIV3, ODIV4, DLYGL0, DLYGL1, DLYGL2,DLYGL3,DLYGL4;

parameter       t_rise = 0;
parameter       t_fall = 0;

time            GLDELAY;
time            timemult;
reg              Q;
integer         num_edges;

integer         DelayVal1;
integer         i;
integer          DivVal2;
integer         DIV;

wire [4:0] ODIV_ipd;
wire [4:0] DLYGL_ipd;
wire       CLK_ipd;


assign    #(t_rise,t_fall) ODIV_ipd[0] = ODIV0;
assign    #(t_rise,t_fall) ODIV_ipd[1] = ODIV1;
assign    #(t_rise,t_fall) ODIV_ipd[2] = ODIV2;
assign    #(t_rise,t_fall) ODIV_ipd[3] = ODIV3;
assign    #(t_rise,t_fall) ODIV_ipd[4] = ODIV4;
assign    #(t_rise,t_fall) DLYGL_ipd[0] = DLYGL0;
assign    #(t_rise,t_fall) DLYGL_ipd[1] = DLYGL1;
assign    #(t_rise,t_fall) DLYGL_ipd[2] = DLYGL2;
assign    #(t_rise,t_fall) DLYGL_ipd[3] = DLYGL3;
assign    #(t_rise,t_fall) DLYGL_ipd[4] = DLYGL4;
assign    #(t_rise,t_fall) CLK_ipd = CLK;
assign  # GLDELAY GL = Q;

// get GL delay
//

always @( DLYGL_ipd )
begin
        DelayVal1 <= 0;
        for(i = 0; i < 5; i = i + 1)
                begin
                if (DLYGL_ipd[i] == 1)
                                DelayVal1 = DelayVal1 + (1 << i);
                end
        GLDELAY <= (DelayVal1 * timemult) + 400;
end


//Get DIV value Block

 always@(ODIV_ipd)
begin
        DivVal2 <= 0;
        for(i = 0; i < 5; i = i + 1)
         begin
           if (ODIV_ipd[i] == 1)
                    DivVal2 = DivVal2 + (1 << i);
         end
        DIV <= DivVal2 + 1;
        num_edges = -1;
end






 //
 //  Output of Divider
 //  Assumes input 50/50 duty cycle
 //

  always@ (CLK_ipd)
  begin
  if (CLK_ipd == 1'bx)
    Q = 1'bx;
  else if (DIV == 1)
    Q = CLK_ipd;
  else
  begin
   if ((Q == 1'b0) || (Q == 1'b1))
    begin
     num_edges = num_edges + 1;
     if (num_edges == 1)
        Q = CLK_ipd;
     else
      if (num_edges % DIV == 1)
        Q = !Q;
      else
        Q = Q;
   end else
       Q = CLK_ipd;
   end
  end





 initial
   begin
        DelayVal1 = 0;
        DIV = 1;
        DivVal2 = 0;
        timemult = 125;
        GLDELAY = 0;
        Q = 1'bx;
        num_edges = -1;
   end

endmodule
*/

/*--------------------------------------------------------------------
 CELL NAME : CLKDLY 
---------------------------------------------------------------------*/

`timescale 1 ps/1 ps

module CLKDLY (
  CLK,
  DLYGL0,
  DLYGL1,
  DLYGL2,
  DLYGL3,
  DLYGL4,
  GL);

  output GL;
  input  CLK, DLYGL0, DLYGL1, DLYGL2,DLYGL3,DLYGL4;

  parameter       t_rise = 0;
  parameter       t_fall = 0;
  parameter       INTRINSIC_DELAY     = 470;
  parameter       PROG_INIT_DELAY     = 1610;
  parameter       PROG_STEP_INCREMENT = 360;

  time            GLDELAY;

  integer         DelayVal1;
  integer         i;

  wire [4:0]      DLYGL_ipd;
  wire            CLK_ipd;

  reg             CLK_ipd_delayed;

  reg             dlygl_xor;
  integer         dlygl_step;

  assign    #(t_rise,t_fall) DLYGL_ipd[0] = DLYGL0;
  assign    #(t_rise,t_fall) DLYGL_ipd[1] = DLYGL1;
  assign    #(t_rise,t_fall) DLYGL_ipd[2] = DLYGL2;
  assign    #(t_rise,t_fall) DLYGL_ipd[3] = DLYGL3;
  assign    #(t_rise,t_fall) DLYGL_ipd[4] = DLYGL4;
  assign    #(t_rise,t_fall) CLK_ipd = CLK;

  buf  BUF_DLY_0( GL, CLK_ipd_delayed ); 
  
  // GLDELAY, picked up worst case numbers between
  // CLKLDYIO and CLKDLYINT 

  always @( DLYGL_ipd )
  begin
    dlygl_xor = ^ DLYGL_ipd;
    if ( dlygl_xor === 1'bX )
    begin
      GLDELAY <= 0;
    end else
    begin
      dlygl_step = DLYGL_ipd;
      GLDELAY <= ( dlygl_step == 0 ) ?
                 INTRINSIC_DELAY :
                 ( INTRINSIC_DELAY + ( dlygl_step * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY );
    end
  end
  
  always @( GLDELAY or CLK_ipd)
  begin
     CLK_ipd_delayed <= #(GLDELAY) CLK_ipd;
  end

  initial
  begin
    GLDELAY = 0;
  end

endmodule

/*--------------------------------------------------------------------
 CELL NAME : CLKDLYIO
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ps / 1 ps

module CLKDLYIO (
  CLK,
  DLYGL0,
  DLYGL1,
  DLYGL2,
  DLYGL3,
  DLYGL4,
  GL);

  output GL;
  input  CLK, DLYGL0, DLYGL1, DLYGL2, DLYGL3, DLYGL4;

  parameter       t_rise = 0;
  parameter       t_fall = 0;

  time            GLDELAY;

  integer         DelayVal1;
  integer         i;

  wire [4:0]      DLYGL_ipd;
  wire            CLK_ipd;

  reg             CLK_ipd_delayed;
  reg             NOTIFY_REG;

  assign    #(t_rise,t_fall) DLYGL_ipd[0] = DLYGL0;
  assign    #(t_rise,t_fall) DLYGL_ipd[1] = DLYGL1;
  assign    #(t_rise,t_fall) DLYGL_ipd[2] = DLYGL2;
  assign    #(t_rise,t_fall) DLYGL_ipd[3] = DLYGL3;
  assign    #(t_rise,t_fall) DLYGL_ipd[4] = DLYGL4;
  
  buf   U0 ( CLK_ipd, CLK );
  buf  BUF_DLY_1( GL, CLK_ipd_delayed ); 

  always @( GLDELAY or CLK_ipd)
  begin
     CLK_ipd_delayed <= #(GLDELAY) CLK_ipd;
  end

  initial
  begin
    GLDELAY = 470;
  end

  specify

    specparam tpdLH_CLK_to_GL = ( 100 : 100 : 100 );
    specparam tpdHL_CLK_to_GL = ( 100 : 100 : 100 );

    // pin to pin path delay

    ( CLK => GL ) = ( tpdLH_CLK_to_GL, tpdHL_CLK_to_GL );

  endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults

/*--------------------------------------------------------------------
 CELL NAME : CLKDLYINT
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ps / 1 ps

module CLKDLYINT (
  CLK,
  DLYGL0,
  DLYGL1,
  DLYGL2,
  DLYGL3,
  DLYGL4,
  GL);

  output GL;
  input  CLK, DLYGL0, DLYGL1, DLYGL2,DLYGL3,DLYGL4;

  parameter       t_rise = 0;
  parameter       t_fall = 0;

  time            GLDELAY;

  integer         DelayVal1;
  integer         i;

  wire [4:0]      DLYGL_ipd;
  wire            CLK_ipd;

  reg             CLK_ipd_delayed;
  reg             NOTIFY_REG;

  assign    #(t_rise,t_fall) DLYGL_ipd[0] = DLYGL0;
  assign    #(t_rise,t_fall) DLYGL_ipd[1] = DLYGL1;
  assign    #(t_rise,t_fall) DLYGL_ipd[2] = DLYGL2;
  assign    #(t_rise,t_fall) DLYGL_ipd[3] = DLYGL3;
  assign    #(t_rise,t_fall) DLYGL_ipd[4] = DLYGL4;
  
  buf   U0 ( CLK_ipd, CLK );
  buf  BUF_DLY_2( GL, CLK_ipd_delayed ); 

  always @( GLDELAY or CLK_ipd)
  begin
     CLK_ipd_delayed <= #(GLDELAY) CLK_ipd;
  end

  initial
  begin
    GLDELAY = 921;
  end

  specify

    specparam tpdLH_CLK_to_GL = ( 100 : 100 : 100 );
    specparam tpdHL_CLK_to_GL = ( 100 : 100 : 100 );

    // pin to pin path delay

    ( CLK => GL ) = ( tpdLH_CLK_to_GL, tpdHL_CLK_to_GL );

  endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults

/*--------------------------------------------------------------------
 CELL NAME : ULSICC 
 CELL TYPE : comb
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ULSICC(LSICC);
 input LSICC; 

 wire  tmp;

 buf      U2(tmp, LSICC);

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults

/*--------------------------------------------------------------------
 CELL NAME : ULSICC_INT
 CELL TYPE : comb
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ULSICC_INT(USTDBY, LPENA);
 input USTDBY;
 input LPENA;

 wire  tmp1, tmp2;

 buf      U1(tmp1, USTDBY);
 buf      U2(tmp2, LPENA);

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults

/*--------------------------------------------------------------------
 CELL NAME : ULSICC_AUTH
 CELL TYPE : comb
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ULSICC_AUTH(AUTHEN, LSICC);
 input AUTHEN;
 input LSICC;

 wire  tmp1, tmp2;

 buf      U1(tmp1, AUTHEN);
 buf      U2(tmp2, LSICC);

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults
    
/*--------------------------------------------------------------------
 CELL NAME : PLL_TIMING_V2
 This is the timing for the 1.2 Volt PLL
---------------------------------------------------------------------*/

`timescale 1 ps/1 ps
module PLL_TIMING_V2 (
  );
  parameter       CLKA_TO_REF_DELAY     =  900;
  parameter       EMULATED_SYSTEM_DELAY = 5700;
  parameter       IN_DIV_DELAY          =  850; // Input dividers intrinsic delay
  parameter       OUT_DIV_DELAY         = 1510; // Output dividers intrinsic delay
  parameter       MUX_DELAY             = 1700; // MUXA/MUXB/MUXC intrinsic delay
  parameter       IN_DELAY_BYP1         = 1523; // Instrinsic delay for CLKDIVDLY bypass mode - TIMING NOT UPDATED
  parameter       BYP_MUX_DELAY         =  250; // Bypass MUX intrinsic delay, not used for Ys
  parameter       GL_DRVR_DELAY         =  550; // Global Driver intrinsic delay
  parameter       Y_DRVR_DELAY          =    0; // Y Driver intrinsic delay
  parameter       FB_MUX_DELAY          = 1420; // FBSEL MUX intrinsic delay
  parameter       BYP0_CLK_GL           = 1360; // Instrinsic delay for CLKDLY bypass mode
  parameter       X_MUX_DELAY           =  160; // XDLYSEL MUX intrinsic delay
  parameter       FIN_LOCK_DELAY        = 2050; // FIN to LOCK propagation delay
  parameter       LOCK_OUT_DELAY        =  820; // LOCK to OUT propagation delay
  parameter       PROG_STEP_INCREMENT   =  580;
  parameter       PROG_INIT_DELAY       = 2300;
endmodule
//---- END MODULE PLL_TIMING_V2 ----


/*--------------------------------------------------------------------
 CELL NAME : PLLPRIM
 Timing is for the 1.5 Volt PLL - must be overwritten for the 1.2 Volt
---------------------------------------------------------------------*/

`timescale 1 ps/1 ps

module PLLPRIM (
         DYNSYNC,
         CLKA,
         EXTFB,
         POWERDOWN,
         CLKB,
         CLKC,
         OADIVRST,
         OADIVHALF,
         OADIV0,
         OADIV1,
         OADIV2,
         OADIV3,
         OADIV4,
         OAMUX0,
         OAMUX1,
         OAMUX2,
         DLYGLA0,
         DLYGLA1,
         DLYGLA2,
         DLYGLA3,
         DLYGLA4,
         OBDIVRST,
         OBDIVHALF,
         OBDIV0,
         OBDIV1,
         OBDIV2,
         OBDIV3,
         OBDIV4,
         OBMUX0,
         OBMUX1,
         OBMUX2,
         DLYYB0,
         DLYYB1,
         DLYYB2,
         DLYYB3,
         DLYYB4,
         DLYGLB0,
         DLYGLB1,
         DLYGLB2,
         DLYGLB3,
         DLYGLB4,
         OCDIVRST,
         OCDIVHALF,
         OCDIV0,
         OCDIV1,
         OCDIV2,
         OCDIV3,
         OCDIV4,
         OCMUX0,
         OCMUX1,
         OCMUX2,
         DLYYC0,
         DLYYC1,
         DLYYC2,
         DLYYC3,
         DLYYC4,
         DLYGLC0,
         DLYGLC1,
         DLYGLC2,
         DLYGLC3,
         DLYGLC4,
         FINDIV0,
         FINDIV1,
         FINDIV2,
         FINDIV3,
         FINDIV4,
         FINDIV5,
         FINDIV6,
         FBDIV0,
         FBDIV1,
         FBDIV2,
         FBDIV3,
         FBDIV4,
         FBDIV5,
         FBDIV6,
         FBDLY0,
         FBDLY1,
         FBDLY2,
         FBDLY3,
         FBDLY4,
         FBSEL0,
         FBSEL1,
         XDLYSEL,
         VCOSEL0,
         VCOSEL1,
         VCOSEL2,
         GLA,
         LOCK,
         GLB,
         YB,
         GLC,
         YC
        );

  output GLA, LOCK, GLB, YB, GLC, YC;
  input  VCOSEL2, VCOSEL1, VCOSEL0, XDLYSEL, FBSEL1, FBSEL0; 
  input  FBDLY4, FBDLY3, FBDLY2, FBDLY1, FBDLY0;
  input  FBDIV6, FBDIV5, FBDIV4, FBDIV3;
  input  FBDIV2, FBDIV1, FBDIV0;
  input  FINDIV6, FINDIV5, FINDIV4, FINDIV3, FINDIV2, FINDIV1, FINDIV0;
  input  DLYGLC4, DLYGLC3, DLYGLC2, DLYGLC1, DLYGLC0;
  input  DLYYC4, DLYYC3, DLYYC2, DLYYC1, DLYYC0;
  input  OCMUX2, OCMUX1, OCMUX0, OCDIV4, OCDIV3, OCDIV2, OCDIV1, OCDIV0;
  input  DLYGLB4, DLYGLB3, DLYGLB2, DLYGLB1, DLYGLB0;
  input  DLYYB4, DLYYB3, DLYYB2, DLYYB1, DLYYB0;
  input  OBMUX2, OBMUX1, OBMUX0;
  input  OBDIV4, OBDIV3, OBDIV2, OBDIV1, OBDIV0;
  input  DLYGLA4, DLYGLA3, DLYGLA2, DLYGLA1, DLYGLA0;
  input  OAMUX2, OAMUX1, OAMUX0;
  input  OADIV4, OADIV3, OADIV2, OADIV1, OADIV0;
  input  OADIVHALF;
  input  OADIVRST;
  input  OBDIVHALF;
  input  OBDIVRST;
  input  OCDIVHALF;
  input  OCDIVRST;
  input  POWERDOWN, EXTFB, CLKA;
  input  CLKB;
  input  CLKC;
  input  DYNSYNC;

  parameter       VCOFREQUENCY   = 0.0;
  parameter       f_CLKA_LOCK    = 3;
  parameter       CLKA_TO_REF_DELAY     =  600;
  parameter       EMULATED_SYSTEM_DELAY = 3500;
  parameter       IN_DIV_DELAY          =  550; // Input dividers intrinsic delay
  parameter       OUT_DIV_DELAY         =  960; // Output dividers intrinsic delay
  parameter       MUX_DELAY             = 1100; // MUXA/MUXB/MUXC intrinsic delay
  parameter       IN_DELAY_BYP1         = 1523; // Instrinsic delay for CLKDIVDLY bypass mode - TIMING NOT UPDATED
  parameter       BYP_MUX_DELAY         =  200; // Bypass MUX intrinsic delay, not used for Ys
  parameter       GL_DRVR_DELAY         =  350; // Global Driver intrinsic delay
  parameter       Y_DRVR_DELAY          =    0; // Y Driver intrinsic delay
  parameter       FB_MUX_DELAY          =  900; // FBSEL MUX intrinsic delay
  parameter       BYP0_CLK_GL           =  920; // Instrinsic delay for CLKDLY bypass mode
  parameter       X_MUX_DELAY           =  110; // XDLYSEL MUX intrinsic delay
  parameter       FIN_LOCK_DELAY        = 1025; // FIN to LOCK propagation delay
  parameter       LOCK_OUT_DELAY        =  410; // LOCK to OUT propagation delay
  parameter       PROG_STEP_INCREMENT   =  360;
  parameter       PROG_INIT_DELAY       =  1250;
  parameter       t_rise = 0;
  parameter       t_fall = 0;

  reg             GLB;
  reg             GLA;
  reg             GLC;
  reg             YB;
  reg             YC;

  reg             AOUT;
  reg             BOUT;
  reg             COUT;
  
  reg             RESET1;
  reg             RESET2;
  reg             RESET3;

  time            PLLDELAY;
  time            PLLCLK_pw;
  time            PLLCLK_period;
  time            DTDELAY;
  time            FBDELAY;
  time            negative_delay;
  time            tmp_delay;
  time            LOCK_re;
  time            UIN_re;
  time            VIN_re;
  time            WIN_re;
  time            UIN_prev_re;
  time            VIN_prev_re;
  time            WIN_prev_re;
  integer         UIN_period;
  integer         VIN_period;
  integer         WIN_period;
  
  //Additional delay value variables for GLA and GLB path

  time            GLBDELAY;
  time            GLADELAY;
  time            GLCDELAY;
  time            YBDELAY;
  time            YCDELAY;

  time            CLKA_period;
  time            CLKA_re;

  reg             PLLCLK;

  reg             halveA;
  reg             halveB;
  reg             halveC;
  reg             CLKA2X;
  reg             CLKB2X;
  reg             CLKC2X;
  time            CLKA2X_CLKA_re;
  time            CLKA2X_CLKA_period;
  time            CLKB2X_CLKB_re;
  time            CLKB2X_CLKB_period;
  time            CLKC2X_CLKC_re;
  time            CLKC2X_CLKC_period;

  wire            UIN;
  wire            VIN;
  wire            WIN;

  integer         DelayVal1;
  integer         DelayVal2;
  integer         DelayVal3;
  integer         DelayVal4;
  integer         DelayVal5;
  integer         DelayVal6;
  integer         i;
  integer         DIVN;
  integer         DIVM;
  integer         DIVU;
  integer         DIVV;
  integer         DIVW;
  integer         fb_loop_div; // Total division of feedback loop
  integer         DivVal;
  integer         DivVal1;
  integer         DivVal2;
  integer         DivVal3;
  integer         DivVal4;
  integer         A_num_edges;
  integer         B_num_edges;
  integer         C_num_edges;
  integer         FBSEL_illegal;
  integer         UIN_num_res;
  integer         UIN_num_fes;
  integer         VIN_num_res;
  integer         VIN_num_fes;
  integer         WIN_num_res;
  integer         WIN_num_fes;

  integer         dlygla_step;
  integer         dlyglb_step;
  integer         dlyglc_step;


  // internal PLL control signal

  wire [4:0] OADIV_ipd;
  wire [4:0] OBDIV_ipd;
  wire [4:0] OCDIV_ipd;
  wire [2:0] OAMUX_ipd;
  wire [2:0] OBMUX_ipd;
  wire [2:0] OCMUX_ipd;
  wire [4:0] DLYGLA_ipd;
  wire [4:0] DLYGLB_ipd;
  wire [4:0] DLYGLC_ipd;
  wire [4:0] DLYYB_ipd;
  wire [4:0] DLYYC_ipd;
  wire [6:0] FINDIV_ipd;
  wire [6:0] FBDIV_ipd;
  wire [4:0] FBDLY_ipd;
  wire [1:0] FBSEL_ipd;
  wire [2:0] VCOSEL_ipd;
  wire       XDLYSEL_ipd;
  wire       CLKA_ipd;
  wire       CLKB_ipd;
  wire       CLKC_ipd;
  wire       POWERDOWN_ipd;
  wire       EXTFB_ipd;
  wire       OADIVHALF_ipd;
  wire       OADIVRST_ipd;
  wire       OBDIVHALF_ipd;
  wire       OBDIVRST_ipd;
  wire       OCDIVHALF_ipd;
  wire       OCDIVRST_ipd;

  integer    res_post_reseta1;
  integer    fes_post_reseta1;
  integer    res_post_reseta0;
  integer    fes_post_reseta0;
  reg        AOUT_CLKA_last_value;
  reg        OADIVRST_ipd_last_value;
  reg        UIN_last_value;
  reg        POWERDOWNA_ipd_last_value;
  reg        forcea_0;
  integer    res_post_resetb1;
  integer    fes_post_resetb1;
  integer    res_post_resetb0;
  integer    fes_post_resetb0;
  reg        BOUT_CLKB_last_value;
  reg        OBDIVRST_ipd_last_value;
  reg        VIN_last_value;
  reg        POWERDOWNB_ipd_last_value;
  reg        forceb_0;
  integer    res_post_resetc1;
  integer    fes_post_resetc1;
  integer    res_post_resetc0;
  integer    fes_post_resetc0;
  reg        COUT_CLKC_last_value;
  reg        OCDIVRST_ipd_last_value;
  reg        WIN_last_value;
  reg        POWERDOWNC_ipd_last_value;
  reg        forcec_0;
  reg        internal_lock;
  time       fin_period;
  reg        locked_fin_last_value;
  time       extfbin_fin_drift;
  time       fin_last_re;
  reg        locked;
  reg        vco0_divu;
  reg        vco0_divv;
  reg        vco0_divw;
  wire       vco180;
  integer    locked_vco_edges;
  integer    CLKA_num_re_stable;
  integer    core_config;
  integer    core_config_last_value;
  reg        CLKA_ipd_last_value;
  time       CLKA_to_VCO0_delay;

  reg        fin;
  reg        CLKA_period_stable;

  wire       using_EXTFB;
  reg        EXTFB_delay_dtrmd;
  reg        calibrate_EXTFB_delay;
  reg        GLA_free_running;
  reg        AOUT_using_EXTFB;
  time       GLA_pw;
  time       GLA_EXTFB_rise_dly;
  time       GLA_EXTFB_fall_dly;
  time       EXTFB_period;
  time       EXTFB_re;
  reg        expected_EXTFB;
  wire       external_dly_correct;

  time       gla_muxed_delay;
  time       glb_muxed_delay;
  time       glc_muxed_delay;

  time       internal_fb_delay;
  time       external_fb_delay;
  time       normalized_fb_delay;

  time       CLKA_2_GLA_dly;
  time       CLKA_2_GLA_bypass0_dly;
  time       CLKA_2_GLA_bypass1_dly;
  time       CLKA_2_GLB_dly;
  time       CLKB_2_GLB_bypass0_dly;
  time       CLKB_2_GLB_bypass1_dly;
  time       CLKA_2_YB_dly;
  time       CLKB_2_YB_bypass1_dly;
  time       CLKA_2_GLC_dly;
  time       CLKC_2_GLC_bypass0_dly;
  time       CLKC_2_GLC_bypass1_dly;
  time       CLKA_2_YC_dly;
  time       CLKC_2_YC_bypass1_dly;
  time       CLKA_2_LOCK_dly;

  integer    fin_num_CLKA_re;
  time       EXTFB_CLKA_edge;
  time       num_freerun_edges;
  reg  [2:0] prev_OAMUX;
  reg  [2:0] prev_OBMUX;
  reg  [2:0] prev_OCMUX;

  function time output_mux_delay;
    input [ 2 : 0 ] outmux;
    input [ 2 : 0]  vcoconfig;
    input time      fbdly_delay;
    input time      vco_pw;
    begin
       case ( outmux )
          1       : output_mux_delay = IN_DELAY_BYP1;
          2       : output_mux_delay = MUX_DELAY + fbdly_delay;
          5       : output_mux_delay = ( ( 1'b1 === vcoconfig[2] ) && ( 1'b1 === vcoconfig[1] ) ) ?
                       MUX_DELAY + ( vco_pw / 2.0 ) :
                       MUX_DELAY + ( vco_pw * 1.5 );
          6       : output_mux_delay = MUX_DELAY + vco_pw;
          7       : output_mux_delay = ( ( 1'b1 === vcoconfig[2] ) && ( 1'b1 === vcoconfig[1] ) ) ?
                       MUX_DELAY + ( vco_pw * 1.5 ) :
                       MUX_DELAY + ( vco_pw / 2.0 );
          default : output_mux_delay = MUX_DELAY;
        endcase
     end
  endfunction


  function output_mux_driver;
    input [ 2 : 0 ] outmux;
    input           halved;
    input           bypass;
    input           bypass2x;
    input           vco;
    begin
       case ( outmux )
             1  : if ( 1'b1 === halved )
                     output_mux_driver = bypass2x;
                  else if ( 1'b0 === halved )
                     output_mux_driver = bypass;
                  else
                     output_mux_driver = 1'bx;
             2  : output_mux_driver = vco;
             4  : output_mux_driver = vco;
             5  : output_mux_driver = vco;
             6  : output_mux_driver = vco;
             7  : output_mux_driver = vco;
        default : output_mux_driver = 1'bx;
     endcase
     end
  endfunction

  // Interconnect Delays

  // The following buf instantiations needed to enable SDF back annotation of 
  // PORT delays

  buf U0 ( CLKA_ipd,      CLKA      );
  buf U1 ( CLKB_ipd,      CLKB      );
  buf U2 ( CLKC_ipd,      CLKC      );
  buf U3 ( POWERDOWN_ipd, POWERDOWN );
  buf U4 ( EXTFB_ipd,     EXTFB     );
  
  assign    # ( t_rise, t_fall ) OADIV_ipd[0]  = OADIV0;
  assign    # ( t_rise, t_fall ) OADIV_ipd[1]  = OADIV1;
  assign    # ( t_rise, t_fall ) OADIV_ipd[2]  = OADIV2;
  assign    # ( t_rise, t_fall ) OADIV_ipd[3]  = OADIV3;
  assign    # ( t_rise, t_fall ) OADIV_ipd[4]  = OADIV4;
  assign    # ( t_rise, t_fall ) OADIVHALF_ipd = OADIVHALF;
  assign    # ( t_rise, t_fall ) OADIVRST_ipd  = OADIVRST;
  assign    # ( t_rise, t_fall ) OAMUX_ipd[0]  = OAMUX0;
  assign    # ( t_rise, t_fall ) OAMUX_ipd[1]  = OAMUX1;
  assign    # ( t_rise, t_fall ) OAMUX_ipd[2]  = OAMUX2;
  assign    # ( t_rise, t_fall ) DLYGLA_ipd[0] = DLYGLA0;
  assign    # ( t_rise, t_fall ) DLYGLA_ipd[1] = DLYGLA1;
  assign    # ( t_rise, t_fall ) DLYGLA_ipd[2] = DLYGLA2;
  assign    # ( t_rise, t_fall ) DLYGLA_ipd[3] = DLYGLA3;
  assign    # ( t_rise, t_fall ) DLYGLA_ipd[4] = DLYGLA4;
  assign    # ( t_rise, t_fall ) OBDIV_ipd[0]  = OBDIV0;
  assign    # ( t_rise, t_fall ) OBDIV_ipd[1]  = OBDIV1;
  assign    # ( t_rise, t_fall ) OBDIV_ipd[2]  = OBDIV2;
  assign    # ( t_rise, t_fall ) OBDIV_ipd[3]  = OBDIV3;
  assign    # ( t_rise, t_fall ) OBDIV_ipd[4]  = OBDIV4;
  assign    # ( t_rise, t_fall ) OBDIVHALF_ipd = OBDIVHALF;
  assign    # ( t_rise, t_fall ) OBDIVRST_ipd  = OBDIVRST;
  assign    # ( t_rise, t_fall ) OBMUX_ipd[0]  = OBMUX0;
  assign    # ( t_rise, t_fall ) OBMUX_ipd[1]  = OBMUX1;
  assign    # ( t_rise, t_fall ) OBMUX_ipd[2]  = OBMUX2;
  assign    # ( t_rise, t_fall ) DLYYB_ipd[0]  = DLYYB0;
  assign    # ( t_rise, t_fall ) DLYYB_ipd[1]  = DLYYB1;
  assign    # ( t_rise, t_fall ) DLYYB_ipd[2]  = DLYYB2;
  assign    # ( t_rise, t_fall ) DLYYB_ipd[3]  = DLYYB3;
  assign    # ( t_rise, t_fall ) DLYYB_ipd[4]  = DLYYB4;
  assign    # ( t_rise, t_fall ) DLYGLB_ipd[0] = DLYGLB0;
  assign    # ( t_rise, t_fall ) DLYGLB_ipd[1] = DLYGLB1;
  assign    # ( t_rise, t_fall ) DLYGLB_ipd[2] = DLYGLB2;
  assign    # ( t_rise, t_fall ) DLYGLB_ipd[3] = DLYGLB3;
  assign    # ( t_rise, t_fall ) DLYGLB_ipd[4] = DLYGLB4;
  assign    # ( t_rise, t_fall ) OCDIV_ipd[0]  = OCDIV0;
  assign    # ( t_rise, t_fall ) OCDIV_ipd[1]  = OCDIV1;
  assign    # ( t_rise, t_fall ) OCDIV_ipd[2]  = OCDIV2;
  assign    # ( t_rise, t_fall ) OCDIV_ipd[3]  = OCDIV3;
  assign    # ( t_rise, t_fall ) OCDIV_ipd[4]  = OCDIV4;
  assign    # ( t_rise, t_fall ) OCDIVHALF_ipd = OCDIVHALF;
  assign    # ( t_rise, t_fall ) OCDIVRST_ipd  = OCDIVRST;
  assign    # ( t_rise, t_fall ) OCMUX_ipd[0]  = OCMUX0;
  assign    # ( t_rise, t_fall ) OCMUX_ipd[1]  = OCMUX1;
  assign    # ( t_rise, t_fall ) OCMUX_ipd[2]  = OCMUX2;
  assign    # ( t_rise, t_fall ) DLYYC_ipd[0]  = DLYYC0;
  assign    # ( t_rise, t_fall ) DLYYC_ipd[1]  = DLYYC1;
  assign    # ( t_rise, t_fall ) DLYYC_ipd[2]  = DLYYC2;
  assign    # ( t_rise, t_fall ) DLYYC_ipd[3]  = DLYYC3;
  assign    # ( t_rise, t_fall ) DLYYC_ipd[4]  = DLYYC4;
  assign    # ( t_rise, t_fall ) DLYGLC_ipd[0] = DLYGLC0;
  assign    # ( t_rise, t_fall ) DLYGLC_ipd[1] = DLYGLC1;
  assign    # ( t_rise, t_fall ) DLYGLC_ipd[2] = DLYGLC2;
  assign    # ( t_rise, t_fall ) DLYGLC_ipd[3] = DLYGLC3;
  assign    # ( t_rise, t_fall ) DLYGLC_ipd[4] = DLYGLC4;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[0] = FINDIV0;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[1] = FINDIV1;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[2] = FINDIV2;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[3] = FINDIV3;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[4] = FINDIV4;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[5] = FINDIV5;
  assign    # ( t_rise, t_fall ) FINDIV_ipd[6] = FINDIV6;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[0]  = FBDIV0;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[1]  = FBDIV1;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[2]  = FBDIV2;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[3]  = FBDIV3;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[4]  = FBDIV4;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[5]  = FBDIV5;
  assign    # ( t_rise, t_fall ) FBDIV_ipd[6]  = FBDIV6;
  assign    # ( t_rise, t_fall ) FBDLY_ipd[0]  = FBDLY0;
  assign    # ( t_rise, t_fall ) FBDLY_ipd[1]  = FBDLY1;
  assign    # ( t_rise, t_fall ) FBDLY_ipd[2]  = FBDLY2;
  assign    # ( t_rise, t_fall ) FBDLY_ipd[3]  = FBDLY3;
  assign    # ( t_rise, t_fall ) FBDLY_ipd[4]  = FBDLY4;
  assign    # ( t_rise, t_fall ) FBSEL_ipd[0]  = FBSEL0;
  assign    # ( t_rise, t_fall ) FBSEL_ipd[1]  = FBSEL1;
  assign    # ( t_rise, t_fall ) XDLYSEL_ipd   = XDLYSEL;
  assign    # ( t_rise, t_fall ) VCOSEL_ipd[0] = VCOSEL0;
  assign    # ( t_rise, t_fall ) VCOSEL_ipd[1] = VCOSEL1;
  assign    # ( t_rise, t_fall ) VCOSEL_ipd[2] = VCOSEL2;

  assign # ( CLKA_2_LOCK_dly, 0 ) LOCK = locked;

  always @ ( fin_period or normalized_fb_delay or gla_muxed_delay or GLADELAY )
  begin
     CLKA_2_GLA_dly         <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + gla_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLADELAY + GL_DRVR_DELAY;
  end

  always @ ( GLADELAY )
  begin
     CLKA_2_GLA_bypass0_dly <= BYP0_CLK_GL + GLADELAY;
  end

  always @ ( gla_muxed_delay, GLADELAY )
  begin
     CLKA_2_GLA_bypass1_dly <= gla_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLADELAY + GL_DRVR_DELAY;
  end

  always @ ( fin_period or normalized_fb_delay or glb_muxed_delay or GLBDELAY )
  begin
     CLKA_2_GLB_dly         <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + glb_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLBDELAY + GL_DRVR_DELAY;
  end

  always @ ( GLBDELAY )
  begin
     CLKB_2_GLB_bypass0_dly <= BYP0_CLK_GL + GLBDELAY;
  end

  always @ ( glb_muxed_delay or GLBDELAY )
  begin
     CLKB_2_GLB_bypass1_dly <= glb_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLBDELAY + GL_DRVR_DELAY;
  end

  always @ ( fin_period or normalized_fb_delay or glb_muxed_delay or YBDELAY )
  begin
     CLKA_2_YB_dly          <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + glb_muxed_delay + OUT_DIV_DELAY + YBDELAY + Y_DRVR_DELAY;
  end

  always @ ( glb_muxed_delay or YBDELAY )
  begin
     CLKB_2_YB_bypass1_dly  <= glb_muxed_delay + OUT_DIV_DELAY + YBDELAY + Y_DRVR_DELAY;
  end

  always @ ( fin_period or normalized_fb_delay or glc_muxed_delay or GLCDELAY )
  begin
     CLKA_2_GLC_dly         <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + glc_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLCDELAY + GL_DRVR_DELAY;
  end

  always @ ( GLCDELAY )
  begin
     CLKC_2_GLC_bypass0_dly <= BYP0_CLK_GL + GLCDELAY;
  end

  always @ ( glc_muxed_delay or GLCDELAY )
  begin
     CLKC_2_GLC_bypass1_dly <= glc_muxed_delay + OUT_DIV_DELAY + BYP_MUX_DELAY + GLCDELAY + GL_DRVR_DELAY;
  end

  always @ ( fin_period or normalized_fb_delay or glc_muxed_delay or YCDELAY )
  begin
     CLKA_2_YC_dly          <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + glc_muxed_delay + OUT_DIV_DELAY + YCDELAY + Y_DRVR_DELAY;
  end

  always @ ( glc_muxed_delay or YCDELAY )
  begin
     CLKC_2_YC_bypass1_dly  <= glc_muxed_delay + OUT_DIV_DELAY + YCDELAY + Y_DRVR_DELAY;
  end

  always @ ( fin_period or normalized_fb_delay )
  begin
     CLKA_2_LOCK_dly        <= CLKA_TO_REF_DELAY + IN_DIV_DELAY + fin_period - normalized_fb_delay + LOCK_OUT_DELAY;
  end

  //
  // Deskew
  //

  always @ ( XDLYSEL_ipd )
  begin

    if ( XDLYSEL_ipd === 1'b1 )
      DTDELAY = EMULATED_SYSTEM_DELAY;
    else
      DTDELAY = 0;

  end

  always @ ( FBDLY_ipd )
  begin
    FBDELAY <= ( FBDLY_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY;
  end

  always @ ( DLYGLB_ipd )
  begin
    GLBDELAY = ( DLYGLB_ipd == 0 ) ? 0 : ( ( DLYGLB_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY );
  end

  always @ ( DLYYB_ipd )
  begin
    YBDELAY = ( DLYYB_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY;
  end

  always @ ( DLYGLC_ipd )
  begin
    GLCDELAY = ( DLYGLC_ipd == 0 ) ? 0 : ( ( DLYGLC_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY );
  end

  always @ ( DLYYC_ipd )
  begin
    YCDELAY = ( DLYYC_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY;
  end


  always @ ( DLYGLA_ipd )
  begin
    GLADELAY = ( DLYGLA_ipd == 0 ) ? 0 : ( ( DLYGLA_ipd * PROG_STEP_INCREMENT ) + PROG_INIT_DELAY );
  end

  always @ ( FBDIV_ipd )
  begin
    DIVM = FBDIV_ipd + 1;
  end


  always @ ( FINDIV_ipd )
  begin
    DIVN <= FINDIV_ipd + 1;
  end

  always @ ( OADIV_ipd )
  begin
    DIVU <= OADIV_ipd + 1;
  end

  always @ ( OBDIV_ipd )
  begin
    DIVV <= OBDIV_ipd + 1;
  end

  always @ ( OCDIV_ipd )
  begin
    DIVW <= OCDIV_ipd + 1;
  end

  // Check OADIVHALF
  always @( OADIVHALF_ipd or DIVU or OAMUX_ipd )
  begin
     if ( 1'b1 === OADIVHALF_ipd ) begin
        if ( 3'b001 !== OAMUX_ipd ) begin
           $display( " ** Warning: Illegal configuration.  OADIVHALF can only be used when OAMUX = 001. OADIVHALF ignored.");
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveA <= 1'b0;
        end else if ( ( DIVU < 3 ) || ( DIVU > 29 ) || ( ( DIVU % 2 ) != 1 ) ) begin
           $display( " ** Warning: Illegal configuration. Only even OADIV values from 2 to 28 (inclusive) are allowed with OADIVHALF." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveA <= 1'bx;
        end else begin
           halveA <= 1'b1;
        end
     end else if ( 1'bx === OADIVHALF_ipd ) begin
        $display( " ** Warning: OADIVHALF unknown." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
        halveA <= 1'bx;
     end else begin
        halveA <= 1'b0;
     end
  end

  // Check OBDIVHALF
  always @( OBDIVHALF_ipd or DIVV or OBMUX_ipd )
  begin
     if ( 1'b1 === OBDIVHALF_ipd ) begin
        if ( 3'b001 !== OBMUX_ipd ) begin
           $display( " ** Warning: Illegal configuration.  OBDIVHALF can only be used when OBMUX = 001. OBDIVHALF ignored.");
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveB <= 1'b0;
        end else if ( ( DIVV < 3 ) || ( DIVV > 29 ) || ( ( DIVV % 2 ) != 1 ) ) begin
           $display( " ** Warning: Illegal configuration. Only even OBDIV values from 2 to 28 (inclusive) are allowed with OBDIVHALF." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveB <= 1'bx;
        end else begin
           halveB <= 1'b1;
        end
     end else if ( 1'bx === OBDIVHALF_ipd ) begin
        $display( " ** Warning: OBDIVHALF unknown." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
        halveB <= 1'bx;
     end else begin
        halveB <= 1'b0;
     end
  end

  // Check OCDIVHALF
  always @( OCDIVHALF_ipd or DIVW or OCMUX_ipd )
  begin
     if ( 1'b1 === OCDIVHALF_ipd ) begin
        if ( 3'b001 !== OCMUX_ipd ) begin
           $display( " ** Warning: Illegal configuration.  OCDIVHALF can only be used when OCMUX = 001. OCDIVHALF ignored.");
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveC <= 1'b0;
        end else if ( ( DIVW < 3 ) || ( DIVW > 29 ) || ( ( DIVW % 2 ) != 1 ) ) begin
           $display( " ** Warning: Illegal configuration. Only even OCDIV values from 2 to 28 (inclusive) are allowed with OCDIVHALF." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
           halveC <= 1'bx;
        end else begin
           halveC <= 1'b1;
        end
     end else if ( 1'bx === OCDIVHALF_ipd ) begin
        $display( " ** Warning: OCDIVHALF unknown." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
        halveC <= 1'bx;
     end else begin
        halveC <= 1'b0;
     end
  end

  always @( OAMUX_ipd or VCOSEL_ipd or FBDELAY or PLLCLK_pw )
  begin
     gla_muxed_delay <= output_mux_delay( OAMUX_ipd, VCOSEL_ipd, FBDELAY, PLLCLK_pw );
  end

  always @( OBMUX_ipd or VCOSEL_ipd or FBDELAY or PLLCLK_pw )
  begin
    glb_muxed_delay <= output_mux_delay( OBMUX_ipd, VCOSEL_ipd, FBDELAY, PLLCLK_pw );
  end

  always @( OCMUX_ipd or VCOSEL_ipd or  FBDELAY or PLLCLK_pw )
  begin
     glc_muxed_delay <= output_mux_delay( OCMUX_ipd, VCOSEL_ipd, FBDELAY, PLLCLK_pw );
  end

  // Get internal (not using external feedback pin) feeback delay
  always @( FBSEL_ipd or FBDELAY or DTDELAY or fin_period )
  begin
     if ( 2'b10 === FBSEL_ipd ) begin
        internal_fb_delay <= IN_DIV_DELAY + X_MUX_DELAY + DTDELAY + FB_MUX_DELAY + FBDELAY;
     end else begin
        internal_fb_delay <= IN_DIV_DELAY + X_MUX_DELAY + DTDELAY + FB_MUX_DELAY;
     end
  end

  // Get external (using external feedback pin) feedback delay
  always @( DTDELAY or GLADELAY or gla_muxed_delay or GLA_EXTFB_rise_dly )
  begin
    external_fb_delay <= IN_DIV_DELAY + X_MUX_DELAY + DTDELAY + FB_MUX_DELAY + GL_DRVR_DELAY + GLADELAY + BYP_MUX_DELAY + OUT_DIV_DELAY + gla_muxed_delay + GLA_EXTFB_rise_dly;
  end

  // Normalize appropriate feedback delay
  always @( using_EXTFB or internal_fb_delay or external_fb_delay or fin_period )
  begin
     if ( 0 >= fin_period ) begin
        normalized_fb_delay <= 0;
     end else if ( using_EXTFB === 1'b1 ) begin
        normalized_fb_delay <= ( external_fb_delay > fin_period ) ? ( external_fb_delay % fin_period ) : external_fb_delay;
     end else begin
        normalized_fb_delay <= ( internal_fb_delay > fin_period ) ? ( internal_fb_delay % fin_period ) : internal_fb_delay;
     end
  end

  // Check FBSEL
  always @( FBSEL_ipd or OAMUX_ipd or OBMUX_ipd or OCMUX_ipd or DIVM or DIVU or DIVN or CLKA_period_stable or PLLCLK_period or external_fb_delay )
  begin
     if ( 1'bx === ^FBSEL_ipd ) begin
        FBSEL_illegal <= 1'b1;
        $display( " ** Warning: FBSEL is unknown." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
     end else if ( 2'b00 === FBSEL_ipd ) begin // Grounded.
        FBSEL_illegal <= 1'b1;
        $display( " ** Warning: Illegal FBSEL configuration 00." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
     end else if ( 2'b11 === FBSEL_ipd ) begin // External feedback
        if ( 2 >  OAMUX_ipd ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Warning: Illegal configuration. GLA cannot be in bypass mode (OAMUX = 000 or OAMUX = 001) when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( DIVM < 5 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: FBDIV must be greater than 4 when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( DIVM * DIVU ) > 232 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Product of FBDIV and OADIV must be less than 233 when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( DIVN % DIVU ) != 0 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Division factor FINDIV must be a multiple of OADIV when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( 1'b1 === CLKA_period_stable ) && ( 1'b1 === EXTFB_delay_dtrmd ) &&
                ( ( 1 < OBMUX_ipd ) || ( 1 < OCMUX_ipd ) ) &&
                ( ( external_fb_delay >= CLKA_period ) || ( external_fb_delay >= PLLCLK_period ) ) ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Total sum of delays in the feedback path must be less than 1 VCO period AND less than 1 CLKA period when V and/or W dividers when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else begin
           FBSEL_illegal <= 1'b0;
        end
     end else begin
        FBSEL_illegal <= 1'b0;
     end
  end

  // Generate fin
  // Mimicing silicon - no need for a 50/50 duty cycle and this way fin only changes on rising edge of CLKA (except when DIVN is 1)
  // Uses prefix fin for registers used locally
  always @( CLKA_ipd )
  begin
     if ( 1'bx === CLKA_ipd ) begin
        fin_num_CLKA_re = -1;
     end else if ( 1 == DIVN ) begin
        fin = CLKA;
     end else if ( 1'b1 === CLKA_ipd ) begin
        fin_num_CLKA_re = fin_num_CLKA_re + 1;
        if ( 0 == ( fin_num_CLKA_re % DIVN  ) ) begin
           fin = 1'b1;
           fin_num_CLKA_re = 0;
        end else if ( 1 == ( fin_num_CLKA_re % DIVN  ) ) begin
           fin = 1'b0;
        end
     end
  end

  always @ ( normalized_fb_delay or DIVN or DIVM )
  begin
    core_config = core_config + 1;
  end

  // Calculate CLKA period and establish internal lock
  always @ ( CLKA_ipd or POWERDOWN_ipd or FBSEL_illegal or core_config or locked_vco_edges or external_dly_correct )
    // locked_vco_edges is in the sensitivity list so that we periodically check for CLKA stopped.
  begin
    if ( ( POWERDOWN_ipd === 1'b1 ) && ( FBSEL_illegal === 1'b0 ) ) begin
      if ( ( core_config != core_config_last_value ) ||
           ( ( 1'b1 === using_EXTFB ) && ( 1'b1 !== external_dly_correct ) ) ) begin
        internal_lock <= 1'b0;
        CLKA_num_re_stable <= -1;
        core_config_last_value <= core_config;
      end
      if ( CLKA_ipd_last_value !== CLKA_ipd ) begin
        CLKA_ipd_last_value <= CLKA_ipd;
        if ( CLKA_ipd === 1'b1 ) begin
          if ( CLKA_period != ( $time - CLKA_re ) ) begin
             CLKA_period <= $time - CLKA_re;
             CLKA_num_re_stable <= -1;
             internal_lock <= 1'b0;
             CLKA_period_stable <= 1'b0;
          end else begin
            if ( f_CLKA_LOCK > CLKA_num_re_stable ) begin
               CLKA_num_re_stable <= CLKA_num_re_stable + 1;
            end else if ( f_CLKA_LOCK == CLKA_num_re_stable ) begin
               internal_lock <= 1'b1;
            end
            CLKA_period_stable <= 1'b1;
          end
          CLKA_re <= $time;
        end
      end else if ( CLKA_period < ( $time - CLKA_re ) ) begin
        CLKA_num_re_stable <= -1;
        internal_lock <= 1'b0;
        CLKA_period_stable <= 1'b0;
      end
    end else begin
      CLKA_num_re_stable <= -1;
      internal_lock <= 1'b0;
      CLKA_period_stable <= 1'b0;
    end
  end

  always @( CLKA_period_stable or CLKA_period or DIVN )
  begin
    if ( CLKA_period_stable) begin
      fin_period <= CLKA_period * ( DIVN * 1.0 );
    end
  end

  always @( PLLCLK_pw or DIVU )
  begin
    GLA_pw <= PLLCLK_pw * ( DIVU * 1.0 );
  end

  always @( GLA_pw or DIVM or fin_period )
  begin
    extfbin_fin_drift <= ( GLA_pw * DIVM * 2.0 ) - fin_period;
  end

  always @( fin_period or fb_loop_div )
  begin
    PLLCLK_period <= fin_period / ( fb_loop_div * 1.0 );
    PLLCLK_pw     <= fin_period / ( fb_loop_div * 2.0 );
  end

  // Calculate feedback loop divider
  always @( DIVM or DIVU or using_EXTFB )
  begin
     if ( 1'b1 === using_EXTFB ) begin
        fb_loop_div <= DIVM * DIVU; 
     end else begin
        fb_loop_div <= DIVM;
     end        
  end 

  // Generated locked
  // Uses prefix locked for internal registers
  always @( fin or internal_lock or DYNSYNC )
  begin
    if ( ( 1'b0 === internal_lock ) || ( 1'b1 === DYNSYNC ) ) begin
      locked <= 1'b0;       
    end else if ( ( 1'b1 === fin ) && ( 1'b0 === locked_fin_last_value ) ) begin
      locked <= 1'b1;
    end
    locked_fin_last_value <= fin;
  end

  // Use vco180 to count locked edges since it will have all edges delayed from locked by uniform PLLCLK_pw.
  // Initial edge count is set to 0 by locked rising (below).
  // Need inertial delay
  assign # PLLCLK_pw vco180 = ( locked === 1'b1 ) ? ~vco180 : 1'b0;

  always @ ( vco180 )
  begin
    if ( ( locked_vco_edges % ( DIVU * DIVV * DIVW * DIVM * 2 ) ) == 0 ) begin
      locked_vco_edges <= 1;
    end else begin
      locked_vco_edges <= locked_vco_edges + 1;
    end
  end

  always @ ( locked )
  begin
    if ( locked === 1'b1 ) begin
      assign locked_vco_edges = 0;
      deassign locked_vco_edges;
    end else begin
      assign locked_vco_edges = -1;
    end
  end

  always @ ( locked_vco_edges )
  begin
    if ( locked_vco_edges == -1 ) begin
       vco0_divu <= 1'b0;
       vco0_divv <= 1'b0;
       vco0_divw <= 1'b0;
    end else begin
       if ( ( locked_vco_edges % DIVU ) == 0 ) begin
         vco0_divu <= ~vco0_divu;
       end
       if ( ( locked_vco_edges % DIVV ) == 0 ) begin
         vco0_divv <= ~vco0_divv;
       end
       if ( ( locked_vco_edges % DIVW ) == 0 ) begin
         vco0_divw <= ~vco0_divw;
       end
    end
  end

  assign UIN = output_mux_driver(  OAMUX_ipd, halveA, CLKA_ipd, CLKA2X, vco0_divu );
  assign VIN = output_mux_driver(  OBMUX_ipd, halveB, CLKB_ipd, CLKB2X, vco0_divv );
  assign WIN = output_mux_driver(  OCMUX_ipd, halveC, CLKC_ipd, CLKC2X, vco0_divw );

  // Generate doubled CLKA
  // Uses prefix CLKA2X for internal registers
  always @( CLKA_ipd )
  begin
    if ( 1'b1 === CLKA_ipd ) begin
      CLKA2X_CLKA_period = $time - CLKA2X_CLKA_re;
      CLKA2X_CLKA_re = $time;
      if ( CLKA2X_CLKA_period > 0 ) begin
        CLKA2X <= 1'b1;
        CLKA2X <= # ( CLKA2X_CLKA_period / 4.0 ) 1'b0;
        CLKA2X <= # ( CLKA2X_CLKA_period / 2.0 ) 1'b1;
        CLKA2X <= # ( CLKA2X_CLKA_period * 3.0 / 4.0 ) 1'b0;
      end
    end
  end

  // Generate doubled CLKB
  // Uses prefix CLKB2X for internal registers
  always @( CLKB_ipd )
  begin
    if ( 1'b1 === CLKB_ipd ) begin
      CLKB2X_CLKB_period = $time - CLKB2X_CLKB_re;
      CLKB2X_CLKB_re = $time;
      if ( CLKB2X_CLKB_period > 0 ) begin
        CLKB2X <= 1'b1;
        CLKB2X <= # ( CLKB2X_CLKB_period / 4.0 ) 1'b0;
        CLKB2X <= # ( CLKB2X_CLKB_period / 2.0 ) 1'b1;
        CLKB2X <= # ( CLKB2X_CLKB_period * 3.0 / 4.0 ) 1'b0;
      end
    end
  end

  // Generate doubled CLKC
  // Uses prefix CLKC2X for internal registers
  always @( CLKC_ipd )
  begin
    if ( 1'b1 === CLKC_ipd ) begin
      CLKC2X_CLKC_period = $time - CLKC2X_CLKC_re;
      CLKC2X_CLKC_re = $time;
      if ( CLKC2X_CLKC_period > 0 ) begin
        CLKC2X <= 1'b1;
        CLKC2X <= # ( CLKC2X_CLKC_period / 4.0 ) 1'b0;
        CLKC2X <= # ( CLKC2X_CLKC_period / 2.0 ) 1'b1;
        CLKC2X <= # ( CLKC2X_CLKC_period * 3.0 / 4.0 ) 1'b0;
      end
    end
  end

  // AOUT Output of Divider U
  always @ ( UIN or CLKA_ipd or POWERDOWN_ipd or OADIVRST_ipd or OADIVHALF_ipd )
  begin
  
    if ( OAMUX_ipd === 3'b001 ) begin
    
      // PLL core bypassed.  OADIVRST active.

      if ( CLKA_ipd !== AOUT_CLKA_last_value ) begin
        if ( ( CLKA_ipd === 1'b1 ) && ( AOUT_CLKA_last_value === 1'b0 ) ) begin
          if ( 4 > res_post_reseta1 ) begin
            res_post_reseta1 = res_post_reseta1 + 1;
          end
          if ( 4 > res_post_reseta0 ) begin
            res_post_reseta0 = res_post_reseta0 + 1;
          end
          if ( res_post_reseta1 == 3 ) begin
            forcea_0 = 1'b0;
            A_num_edges = -1;
          end
        end else if ( ( CLKA_ipd === 1'b0 ) && ( AOUT_CLKA_last_value === 1'b1 ) ) begin
          if ( 4 > fes_post_reseta1 ) begin
            fes_post_reseta1 = fes_post_reseta1 + 1;
          end
          if ( 4 > fes_post_reseta0 ) begin
            fes_post_reseta0 = fes_post_reseta0 + 1;
          end
          if ( fes_post_reseta1 == 1 ) begin
            forcea_0 = 1'b1;
          end
        end
        AOUT_CLKA_last_value = CLKA;
      end

      if ( OADIVRST_ipd !== OADIVRST_ipd_last_value ) begin
        if ( OADIVRST_ipd === 1'b1 ) begin
          if ( ( OADIVRST_ipd_last_value === 1'b0 ) &&
               ( ( res_post_reseta0 < 1 ) || ( fes_post_reseta0 < 1 ) ) ) begin
            $display( " ** Error: OADIVRST must be held low for at least one CLKA period for the reset operation to work correctly: reset operation may not be successful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_reseta1 = 0;
          fes_post_reseta1 = 0;
        end else if ( OADIVRST_ipd === 1'b0 ) begin
          if ( ( OADIVRST_ipd_last_value === 1'b1 ) &&
               ( ( res_post_reseta1 < 3 ) || ( fes_post_reseta1 < 3 ) ) ) begin
            $display( " ** Error: OADIVRST must be held high for at least three CLKA periods for the reset operation to work correctly: reset operation may not be succesful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_reseta0 = 0;
          fes_post_reseta0 = 0;
        end else begin
          $display( " ** Error: OADIVRST is unknown. Edge alignment unpredictable." );
          $display( " Time: %0.1f Instance: %m ", $realtime );
        end
        OADIVRST_ipd_last_value = OADIVRST_ipd;
      end
  
      if ( UIN !== UIN_last_value ) begin
        A_num_edges = A_num_edges + 1;
        if ( forcea_0 === 1'b1 ) begin
          AOUT <= 1'b0;
        end else if ( UIN === 1'bx ) begin
          AOUT <= 1'bx;
        end else if ( ( A_num_edges % DIVU ) == 0 ) begin
          if ( AOUT === 1'bx ) begin
            AOUT <= UIN;
          end else begin
            AOUT <= !AOUT;
          end
        end
      end

    end else if ( ( UIN !== UIN_last_value ) || ( POWERDOWN_ipd !== POWERDOWNA_ipd_last_value ) ) begin
    // PLL core not bypassed.  OADIVRST inactive.
      if ( POWERDOWN_ipd === 1'b0 ) begin
        AOUT <= 1'b0;
      end else if ( POWERDOWN_ipd === 1'b1 ) begin
         AOUT <= UIN;
      end else begin // POWERDOWN unknown
        AOUT <= 1'bx;
      end
    end

    if ( UIN !== UIN_last_value ) begin
       UIN_last_value = UIN;
    end
    if ( POWERDOWN_ipd !== POWERDOWNA_ipd_last_value ) begin
       POWERDOWNA_ipd_last_value = POWERDOWN_ipd;
    end
  
  end


  //
  // BOUT Output of Divider V
  //

  always @ ( VIN or CLKB_ipd or POWERDOWN_ipd or OBDIVRST_ipd or OBDIVHALF_ipd )
  begin
  
    if ( OBMUX_ipd === 3'b000 ) begin
      BOUT <= 1'bx;
    end else if ( OBMUX_ipd === 3'b001 ) begin
    
      // PLL core bypassed.  OBDIVRST active.
      if ( CLKB_ipd !== BOUT_CLKB_last_value ) begin
        if ( ( CLKB_ipd === 1'b1 ) && ( BOUT_CLKB_last_value === 1'b0 ) ) begin
          if ( 4 > res_post_resetb1 ) begin
            res_post_resetb1 = res_post_resetb1 + 1;
          end
          if ( 4 > res_post_resetb0 ) begin
            res_post_resetb0 = res_post_resetb0 + 1;
          end
          if ( res_post_resetb1 == 3 ) begin
            forceb_0 = 1'b0;
            B_num_edges = -1;
          end
        end else if ( ( CLKB_ipd === 1'b0 ) && ( BOUT_CLKB_last_value === 1'b1 ) ) begin
          if ( 4 > fes_post_resetb1 ) begin
            fes_post_resetb1 = fes_post_resetb1 + 1;
          end
          if ( 4 > fes_post_resetb0 ) begin
            fes_post_resetb0 = fes_post_resetb0 + 1;
          end
          if ( fes_post_resetb1 == 1 ) begin
            forceb_0 = 1'b1;
          end
        end
        BOUT_CLKB_last_value = CLKB_ipd;
      end

      if ( OBDIVRST_ipd !== OBDIVRST_ipd_last_value ) begin
        if ( OBDIVRST_ipd === 1'b1 ) begin
          if ( ( OBDIVRST_ipd_last_value === 1'b0 ) &&
               ( ( res_post_resetb0 < 1 ) || ( fes_post_resetb0 < 1 ) ) ) begin
            $display( " ** Error: OBDIVRST must be held low for at least one CLKB period for the reset operation to work correctly: reset operation may not be successful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_resetb1 = 0;
          fes_post_resetb1 = 0;
        end else if ( OBDIVRST_ipd === 1'b0 ) begin
          if ( ( OBDIVRST_ipd_last_value === 1'b1 ) &&
               ( ( res_post_resetb1 < 3 ) || ( fes_post_resetb1 < 3 ) ) ) begin
            $display( " ** Error: OBDIVRST must be held high for at least three CLKB periods for the reset operation to work correctly: reset operation may not be succesful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_resetb0 = 0;
          fes_post_resetb0 = 0;
        end else begin
          $display( " ** Error: OBDIVRST is unknown. Edge alignment unpredictable." );
          $display( " Time: %0.1f Instance: %m ", $realtime );
        end
        OBDIVRST_ipd_last_value = OBDIVRST_ipd;
      end

      if ( VIN !== VIN_last_value ) begin
        B_num_edges = B_num_edges + 1;
        if ( forceb_0 === 1'b1 ) begin
          BOUT <= 1'b0;
        end else if ( VIN === 1'bx ) begin
          BOUT <= 1'bx;
        end else if ( ( B_num_edges % DIVV ) == 0 ) begin
          if ( BOUT === 1'bx ) begin
            BOUT <= VIN;
          end else begin
            BOUT <= !BOUT;
          end
        end
      end

    end else if ( ( VIN !== VIN_last_value ) || ( POWERDOWN_ipd !== POWERDOWNB_ipd_last_value ) ) begin
      if ( POWERDOWN_ipd === 1'b0 ) begin
        BOUT <= 1'b0;
      end else if ( POWERDOWN_ipd === 1'b1 ) begin
        BOUT <= VIN;
      end else begin
        BOUT <= 1'bx;
      end
    end

    if ( VIN !== VIN_last_value ) begin
       VIN_last_value = VIN;
    end
    if ( POWERDOWN_ipd !== POWERDOWNB_ipd_last_value ) begin
       POWERDOWNB_ipd_last_value = POWERDOWN_ipd;
    end
    
  end


  //
  // COUT Output of Divider W
  //

  always @ ( WIN or CLKC_ipd or POWERDOWN_ipd or OCDIVRST_ipd or OCDIVHALF_ipd )
  begin
  
    if ( OCMUX_ipd === 3'b000 ) begin
      COUT <= 1'bx;
    end else if ( OCMUX_ipd === 3'b001 ) begin
    
      // PLL core bypassed.  OCDIVRST active.
     if ( CLKC_ipd !== COUT_CLKC_last_value ) begin
        if ( ( CLKC_ipd === 1'b1 ) && ( COUT_CLKC_last_value === 1'b0 ) ) begin
          if ( 4 > res_post_resetc1 ) begin
            res_post_resetc1 = res_post_resetc1 + 1;
          end
          if ( 4 > res_post_resetc0 ) begin
            res_post_resetc0 = res_post_resetc0 + 1;
          end
          if ( res_post_resetc1 == 3 ) begin
            forcec_0 = 1'b0;
            C_num_edges = -1;
          end
        end else if ( ( CLKC_ipd === 1'b0 ) && ( COUT_CLKC_last_value === 1'b1 ) ) begin
          if ( 4 > fes_post_resetc1 ) begin
            fes_post_resetc1 = fes_post_resetc1 + 1;
          end
          if ( 4 > fes_post_resetc0 ) begin
            fes_post_resetc0 = fes_post_resetc0 + 1;
          end
          if ( fes_post_resetc1 == 1 ) begin
            forcec_0 = 1'b1;
          end
        end
        COUT_CLKC_last_value = CLKC_ipd;
      end

      if ( OCDIVRST_ipd !== OCDIVRST_ipd_last_value ) begin
        if ( OCDIVRST_ipd === 1'b1 ) begin
          if ( ( OCDIVRST_ipd_last_value === 1'b0 ) &&
               ( ( res_post_resetc0 < 1 ) || ( fes_post_resetc0 < 1 ) ) ) begin
            $display( " ** Error: OCDIVRST must be held low for at least one CLKC period for the reset operation to work correctly: reset operation may not be successful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_resetc1 = 0;
          fes_post_resetc1 = 0;
        end else if ( OCDIVRST_ipd === 1'b0 ) begin
          if ( ( OCDIVRST_ipd_last_value === 1'b1 ) &&
               ( ( res_post_resetc1 < 3 ) || ( fes_post_resetc1 < 3 ) ) ) begin
            $display( " ** Error: OCDIVRST must be held high for at least three CLKC periods for the reset operation to work correctly: reset operation may not be succesful, edge alignment unpredictable" );
            $display( " Time: %0.1f Instance: %m ", $realtime );
          end
          res_post_resetc0 = 0;
          fes_post_resetc0 = 0;
        end else begin
          $display( " ** Error: OCDIVRST is unknown. Edge alignment unpredictable." );
          $display( " Time: %0.1f Instance: %m ", $realtime );
        end
        OCDIVRST_ipd_last_value = OCDIVRST_ipd;
      end

      if ( WIN !== WIN_last_value ) begin
        C_num_edges = C_num_edges + 1;
        if ( forcec_0 === 1'b1 ) begin
          COUT <= 1'b0;
        end else if ( WIN === 1'bx ) begin
          COUT <= 1'bx;
        end else if ( ( C_num_edges % DIVW ) == 0 ) begin
          if ( COUT === 1'bx ) begin
            COUT <= WIN;
          end else begin
            COUT <= !COUT;
          end
        end
      end

    end else if ( ( WIN !== WIN_last_value ) || ( POWERDOWN_ipd !== POWERDOWNC_ipd_last_value ) ) begin
      if ( POWERDOWN_ipd === 1'b0 ) begin
        COUT <= 1'b0;
      end else if ( POWERDOWN_ipd === 1'b1 ) begin
        COUT <= WIN;
      end else begin
        COUT <= 1'bx;
      end
    end

    if ( WIN !== WIN_last_value ) begin
       WIN_last_value = WIN;
    end
    if ( POWERDOWN_ipd !== POWERDOWNC_ipd_last_value ) begin
       POWERDOWNC_ipd_last_value = POWERDOWN_ipd;
    end
    
  end

  assign using_EXTFB = ( FBSEL_ipd[1] && FBSEL_ipd[0] );

  assign #1 external_dly_correct = expected_EXTFB ^~ EXTFB_ipd;

  // Get EXTFB period, rising edge, and falling edge
  always @( posedge EXTFB_ipd )
  begin
    EXTFB_period <= $time - EXTFB_re;
    EXTFB_re <= $time;
  end

  // Calculate EXTFB delay
  always
  begin
    EXTFB_delay_dtrmd = 1'b0;
    if ( ( 1'b1 !== using_EXTFB ) || ( 1'b1 !== CLKA_period_stable ) ) begin
      wait ( ( 1'b1 === using_EXTFB ) && ( 1'b1 === CLKA_period_stable ) );
    end
    #GLA_EXTFB_rise_dly;
    GLA_EXTFB_fall_dly = 0;
    GLA_EXTFB_rise_dly = 0;
    # ( CLKA_2_GLA_dly * 2 );
    calibrate_EXTFB_delay = 1'b1;
    if ( 1'b1 !== EXTFB_ipd ) begin
      wait ( 1'b1 === EXTFB_ipd );
    end
    @ ( negedge CLKA_ipd );
    EXTFB_CLKA_edge = $time;
    calibrate_EXTFB_delay = 1'b0;
    @ ( negedge EXTFB_ipd );
    GLA_EXTFB_fall_dly = $time - EXTFB_CLKA_edge - CLKA_2_GLA_dly;
    @ ( posedge CLKA_ipd );
    EXTFB_CLKA_edge = $time;
    calibrate_EXTFB_delay = 1'b1;
    @ ( posedge EXTFB_ipd );
    GLA_EXTFB_rise_dly = $time - EXTFB_CLKA_edge - CLKA_2_GLA_dly;
    @ ( posedge CLKA_ipd );
    wait ( 1'b1 === CLKA_period_stable );
    @ ( posedge fin );
    EXTFB_delay_dtrmd = 1'b1;
    @ ( negedge expected_EXTFB );
    if ( 1'b1 !== external_dly_correct ) begin
      $display( " ** Error: EXTFB must be a simple, time-delayed derivative of GLA. Simulation cannot continue until user-logic is corrected" );
      $display( " Time: %0.1f Instance: %m ", $realtime );
      $finish;
    end
    wait ( 1'b1 !== external_dly_correct );
  end

  // Generate GLA directly from CLA, includes drift adjustment so everything syncs up when PLL is locked
  always @( GLA_free_running or EXTFB_delay_dtrmd )
  begin
    if ( EXTFB_delay_dtrmd ) begin
      if ( ( num_freerun_edges % ( DIVM * 2 ) ) == 0 ) begin
        GLA_free_running <= # ( GLA_pw - extfbin_fin_drift ) ~GLA_free_running;
        num_freerun_edges <= 0;
      end else begin
        GLA_free_running <= # GLA_pw ~GLA_free_running;
      end
      num_freerun_edges <= num_freerun_edges + 1;
    end else begin
      num_freerun_edges <= 1;
      GLA_free_running <= # GLA_pw 1'b1;
    end
  end

  // Generate AOUT_using_EXTFB
  always @( AOUT or GLA_free_running or calibrate_EXTFB_delay or locked_vco_edges or EXTFB_delay_dtrmd )
  begin
    if ( 0 <= locked_vco_edges ) begin
      AOUT_using_EXTFB <= AOUT;
    end else if ( EXTFB_delay_dtrmd ) begin
      AOUT_using_EXTFB <= GLA_free_running;
    end else begin
      AOUT_using_EXTFB <= calibrate_EXTFB_delay;
    end
  end

  always @( GLA or EXTFB_delay_dtrmd )
  begin
    if ( 1'b1 !== EXTFB_delay_dtrmd ) begin
      expected_EXTFB <= 1'bx;
    end else if ( 1'b1 === GLA ) begin
      expected_EXTFB <= # GLA_EXTFB_rise_dly GLA;
    end else begin
      expected_EXTFB <= # GLA_EXTFB_fall_dly GLA;
    end
  end

  // GLA
  always @ ( AOUT or CLKA_ipd or AOUT_using_EXTFB or OAMUX_ipd )
  begin
    if ( 3'b000 === OAMUX_ipd ) begin
      GLA <= # CLKA_2_GLA_bypass0_dly CLKA_ipd;
      A_num_edges <= -1;
    end else if ( ( 3'b001 === OAMUX_ipd ) || ( 3'b011 === OAMUX_ipd ) ) begin
      GLA <= # CLKA_2_GLA_dly 1'bx;
      if ( OAMUX_ipd !== prev_OAMUX ) begin
        $display( " ** Warning: Illegal OAMUX configuration" );
        $display( " Time: %0.1f Instance: %m ", $realtime );
      end
    end else if ( 1'b1 === using_EXTFB ) begin
      GLA <= # CLKA_2_GLA_dly AOUT_using_EXTFB;
    end else begin
      GLA <= # CLKA_2_GLA_dly AOUT;
    end
    if ( OAMUX_ipd !== prev_OAMUX ) begin
      prev_OAMUX <= OAMUX_ipd;
    end
  end

  // GLB and YB
  always @ ( BOUT or CLKB_ipd or OBMUX_ipd )
  begin
    if ( 3'b000 === OBMUX_ipd ) begin
      GLB <= # CLKB_2_GLB_bypass0_dly CLKB_ipd;
      YB  <= 1'bx;
      B_num_edges <= -1;
    end else if ( ( 3'b001 === OBMUX_ipd ) || ( 3'b011 === OBMUX_ipd ) ) begin
      GLB <= # CLKA_2_GLB_dly 1'bx;
      YB  <= # CLKA_2_YB_dly  1'bx;
      if ( OBMUX_ipd !== prev_OBMUX ) begin
        $display( " ** Warning: Illegal OBMUX configuration" );
        $display( " Time: %0.1f Instance: %m ", $realtime );
      end
    end else begin
      GLB <= # CLKA_2_GLB_dly BOUT;
      YB  <= # CLKA_2_YB_dly  BOUT;
    end
    if ( OBMUX_ipd !== prev_OBMUX ) begin
      prev_OBMUX <= OBMUX_ipd;
    end
  end

  // GLC and YC
  always @ ( COUT or CLKC_ipd or OCMUX_ipd )
  begin
    if ( 3'b000 === OCMUX_ipd ) begin
      GLC <= # CLKC_2_GLC_bypass0_dly CLKC_ipd;
      YC  <= 1'bx;
      C_num_edges <= -1;
    end else if ( ( 3'b001 === OCMUX_ipd ) || ( 3'b011 === OCMUX_ipd ) ) begin
      GLC <= # CLKA_2_GLC_dly 1'bx;
      YC  <= # CLKA_2_YC_dly  1'bx;
      if ( OCMUX_ipd !== prev_OCMUX ) begin
        $display( " ** Warning: Illegal OCMUX configuration" );
        $display( " Time: %0.1f Instance: %m ", $realtime );
      end
    end else begin
      GLC <= # CLKA_2_GLC_dly COUT;
      YC  <= # CLKA_2_YC_dly  COUT;
    end
    if ( OCMUX_ipd !== prev_OCMUX ) begin
      prev_OCMUX <= OCMUX_ipd;
    end
  end

  //
  // Initialization
  //

  initial
  begin
  
    PLLCLK = 1'bx;
    CLKA_re = 0;
    DTDELAY = 0;
    DelayVal1 = 0;
    DelayVal2 = 0;
    DelayVal3 = 0;
    DelayVal4 = 0;
    DelayVal5 = 0;
    DelayVal6 = 0;
    DIVN = 1;
    DIVM = 1;
    DIVU = 1;
    DIVV = 1;
    DIVW = 1;
    FBDELAY = 0;
    YBDELAY = 0;
    YCDELAY = 0;
    GLADELAY = 0;
    GLBDELAY = 0;
    GLCDELAY = 0;
    PLLDELAY = 0;
    DivVal = 0;
    DivVal1 = 0;
    DivVal2 = 0;
    DivVal3 = 0;
    DivVal4 = 0;
    CLKA_period = 0;
    AOUT = 1'bx;
    A_num_edges = -1;
    UIN_num_res = 0;
    UIN_num_fes = 0;
    BOUT = 1'bx;
    B_num_edges = -1;
    VIN_num_res = 0;
    VIN_num_fes = 0;
    COUT = 1'bx;
    C_num_edges = -1;
    WIN_num_res = 0;
    WIN_num_fes = 0;
    FBSEL_illegal = 0;
    UIN_re = 0;
    UIN_prev_re = 0;
    UIN_period = 0;
    VIN_re = 0;
    VIN_prev_re = 0;
    VIN_period = 0;
    WIN_re = 0;
    WIN_prev_re = 0;
    WIN_period = 0;

    RESET1 = 1'b1;
    RESET2 = 1'b1;
    RESET3 = 1'b1;

    res_post_reseta1          = 0;
    fes_post_reseta1          = 0;
    res_post_reseta0          = 0;
    fes_post_reseta0          = 0;
    AOUT_CLKA_last_value      = 1'bx;
    OADIVRST_ipd_last_value   = 1'bx;
    UIN_last_value            = 1'bx;
    POWERDOWNA_ipd_last_value = 1'bx;
    forcea_0                  = 1'b1;
    res_post_resetb1          = 0;
    fes_post_resetb1          = 0;
    res_post_resetb0          = 0;
    fes_post_resetb0          = 0;
    BOUT_CLKB_last_value      = 1'bx;
    OBDIVRST_ipd_last_value   = 1'bx;
    VIN_last_value            = 1'bx;
    POWERDOWNB_ipd_last_value = 1'bx;
    forceb_0                  = 1'b1;
    res_post_resetc1          = 0;
    fes_post_resetc1          = 0;
    res_post_resetc0          = 0;
    fes_post_resetc0          = 0;
    COUT_CLKC_last_value      = 1'bx;
    OCDIVRST_ipd_last_value   = 1'bx;
    WIN_last_value            = 1'bx;
    POWERDOWNC_ipd_last_value = 1'bx;
    forcec_0                  = 1'b1;
    PLLCLK_pw                 = 10000;
    PLLCLK_period             = 10000;
    internal_lock             = 1'b0;
    fin_period                = 0;
    fin_last_re               = 0;
    CLKA_num_re_stable        = -1;
    core_config               = 0;
    core_config_last_value    = -1;
    CLKA_ipd_last_value       = 1'bx;
    CLKA_to_VCO0_delay        = 0;
    locked_vco_edges          = -1;

    halveA                    = 1'bx;
    halveB                    = 1'bx;
    halveC                    = 1'bx;
    CLKA2X                    = 1'bx;
    CLKB2X                    = 1'bx;
    CLKC2X                    = 1'bx;
    CLKA2X_CLKA_re            = 0;
    CLKA2X_CLKA_period        = 0;
    CLKB2X_CLKB_re            = 0;
    CLKB2X_CLKB_period        = 0;
    CLKC2X_CLKC_re            = 0;
    CLKC2X_CLKC_period        = 0;
    fin                       = 1'b0;
    CLKA_period_stable        = 1'b0;
    EXTFB_delay_dtrmd         = 1'b0;
    calibrate_EXTFB_delay     = 1'b0;
    GLA_free_running          = 1'b1;
    AOUT_using_EXTFB          = 1'b1;
    GLA_pw                    = 10000;
    GLA_EXTFB_rise_dly        = 0;
    GLA_EXTFB_fall_dly        = 0;
    EXTFB_period              = 20000;
    EXTFB_re                  = 0;
    expected_EXTFB            = 1'bx;
    gla_muxed_delay           = 0;
    glb_muxed_delay           = 0;
    glc_muxed_delay           = 0;
    internal_fb_delay         = 0;
    external_fb_delay         = 0;
    normalized_fb_delay       = 0;
    CLKA_2_GLA_dly            = 0;
    CLKA_2_GLA_bypass0_dly    = 0;
    CLKA_2_GLA_bypass1_dly    = 0;
    CLKA_2_GLB_dly            = 0;
    CLKB_2_GLB_bypass0_dly    = 0;
    CLKB_2_GLB_bypass1_dly    = 0;
    CLKA_2_YB_dly             = 0;
    CLKB_2_YB_bypass1_dly     = 0;
    CLKA_2_GLC_dly            = 0;
    CLKC_2_GLC_bypass0_dly    = 0;
    CLKC_2_GLC_bypass1_dly    = 0;
    CLKA_2_YC_dly             = 0;
    CLKC_2_YC_bypass1_dly     = 0;
    fin_num_CLKA_re           = -1;
    extfbin_fin_drift         = 0;
    fb_loop_div               = 1;
    locked_fin_last_value     = 1'bx;
    EXTFB_CLKA_edge           = 0;
    num_freerun_edges         = 1;
    prev_OAMUX                = 1'bx;
    prev_OBMUX                = 1'bx;
    prev_OCMUX                = 1'bx;
  end

endmodule
//---- END MODULE PLLPRIM ----

/*--------------------------------------------------------------------
 CELL NAME : PLL
---------------------------------------------------------------------*/

`timescale 1 ps/1 ps

module PLL (
         CLKA,
         EXTFB,
         POWERDOWN,
         OADIV0,
         OADIV1,
         OADIV2,
         OADIV3,
         OADIV4,
         OAMUX0,
         OAMUX1,
         OAMUX2,
         DLYGLA0,
         DLYGLA1,
         DLYGLA2,
         DLYGLA3,
         DLYGLA4,
         OBDIV0,
         OBDIV1,
         OBDIV2,
         OBDIV3,
         OBDIV4,
         OBMUX0,
         OBMUX1,
         OBMUX2,
         DLYYB0,
         DLYYB1,
         DLYYB2,
         DLYYB3,
         DLYYB4,
         DLYGLB0,
         DLYGLB1,
         DLYGLB2,
         DLYGLB3,
         DLYGLB4,
         OCDIV0,
         OCDIV1,
         OCDIV2,
         OCDIV3,
         OCDIV4,
         OCMUX0,
         OCMUX1,
         OCMUX2,
         DLYYC0,
         DLYYC1,
         DLYYC2,
         DLYYC3,
         DLYYC4,
         DLYGLC0,
         DLYGLC1,
         DLYGLC2,
         DLYGLC3,
         DLYGLC4,
         FINDIV0,
         FINDIV1,
         FINDIV2,
         FINDIV3,
         FINDIV4,
         FINDIV5,
         FINDIV6,
         FBDIV0,
         FBDIV1,
         FBDIV2,
         FBDIV3,
         FBDIV4,
         FBDIV5,
         FBDIV6,
         FBDLY0,
         FBDLY1,
         FBDLY2,
         FBDLY3,
         FBDLY4,
         FBSEL0,
         FBSEL1,
         XDLYSEL,
         VCOSEL0,
         VCOSEL1,
         VCOSEL2,
         GLA,
         LOCK,
         GLB,
         YB,
         GLC,
         YC
        );

  output GLA, LOCK, GLB, YB, GLC, YC;
  input  VCOSEL2, VCOSEL1, VCOSEL0, XDLYSEL, FBSEL1, FBSEL0; 
  input  FBDLY4, FBDLY3, FBDLY2, FBDLY1, FBDLY0;
  input  FBDIV6, FBDIV5, FBDIV4, FBDIV3;
  input  FBDIV2, FBDIV1, FBDIV0;
  input  FINDIV6, FINDIV5, FINDIV4, FINDIV3, FINDIV2, FINDIV1, FINDIV0;
  input  DLYGLC4, DLYGLC3, DLYGLC2, DLYGLC1, DLYGLC0;
  input  DLYYC4, DLYYC3, DLYYC2, DLYYC1, DLYYC0;
  input  OCMUX2, OCMUX1, OCMUX0, OCDIV4, OCDIV3, OCDIV2, OCDIV1, OCDIV0;
  input  DLYGLB4, DLYGLB3, DLYGLB2, DLYGLB1, DLYGLB0;
  input  DLYYB4, DLYYB3, DLYYB2, DLYYB1, DLYYB0;
  input  OBMUX2, OBMUX1, OBMUX0;
  input  OBDIV4, OBDIV3, OBDIV2, OBDIV1, OBDIV0;
  input  DLYGLA4, DLYGLA3, DLYGLA2, DLYGLA1, DLYGLA0;
  input  OAMUX2, OAMUX1, OAMUX0;
  input  OADIV4, OADIV3, OADIV2, OADIV1, OADIV0;
  input  POWERDOWN, EXTFB, CLKA;
  
  parameter       VCOFREQUENCY = 0;
  parameter       f_CLKA_LOCK  = 3;   // Number of CLKA cycles to wait before raising LOCK

  supply0 GND;
  wire    unused;
  wire    CLKA_ipd;
  wire    EXTFB_ipd;
  wire    POWERDOWN_ipd;

  buf    U0 ( CLKA_ipd, CLKA ); // Add SDF PORT delay
  buf    U1 ( EXTFB_ipd, EXTFB ); // Add SDF PORT delay
  buf    U2 ( POWERDOWN_ipd, POWERDOWN ); // Add SDF PORT delay

  defparam P1.VCOFREQUENCY = VCOFREQUENCY;
  defparam P1.f_CLKA_LOCK  = f_CLKA_LOCK;

  PLLPRIM P1   (
                .DYNSYNC ( GND ),
                .CLKA ( CLKA_ipd ),
                .EXTFB ( EXTFB_ipd ),
                .POWERDOWN ( POWERDOWN_ipd ),
                .CLKB ( unused ),
                .CLKC ( unused ),
                .OADIVRST ( GND ),
                .OADIVHALF ( GND ),
                .OADIV0 ( OADIV0 ),
                .OADIV1 ( OADIV1 ),
                .OADIV2 ( OADIV2 ),
                .OADIV3 ( OADIV3 ),
                .OADIV4 ( OADIV4 ),
                .OAMUX0 ( OAMUX0 ),
                .OAMUX1 ( OAMUX1 ),
                .OAMUX2 ( OAMUX2 ),
                .DLYGLA0 ( DLYGLA0 ),
                .DLYGLA1 ( DLYGLA1 ),
                .DLYGLA2 ( DLYGLA2 ),
                .DLYGLA3 ( DLYGLA3 ),
                .DLYGLA4 ( DLYGLA4 ),
                .OBDIVRST ( GND ),
                .OBDIVHALF ( GND ),
                .OBDIV0 ( OBDIV0 ),
                .OBDIV1 ( OBDIV1 ),
                .OBDIV2 ( OBDIV2 ),
                .OBDIV3 ( OBDIV3 ),
                .OBDIV4 ( OBDIV4 ),
                .OBMUX0 ( OBMUX0 ),
                .OBMUX1 ( OBMUX1 ),
                .OBMUX2 ( OBMUX2 ),
                .DLYYB0 ( DLYYB0 ),
                .DLYYB1 ( DLYYB1 ),
                .DLYYB2 ( DLYYB2 ),
                .DLYYB3 ( DLYYB3 ),
                .DLYYB4 ( DLYYB4 ),
                .DLYGLB0 ( DLYGLB0 ),
                .DLYGLB1 ( DLYGLB1 ),
                .DLYGLB2 ( DLYGLB2 ),
                .DLYGLB3 ( DLYGLB3 ),
                .DLYGLB4 ( DLYGLB4 ),
                .OCDIVRST ( GND ),
                .OCDIVHALF ( GND ),
                .OCDIV0 ( OCDIV0 ),
                .OCDIV1 ( OCDIV1 ),
                .OCDIV2 ( OCDIV2 ),
                .OCDIV3 ( OCDIV3 ),
                .OCDIV4 ( OCDIV4 ),
                .OCMUX0 ( OCMUX0 ),
                .OCMUX1 ( OCMUX1 ),
                .OCMUX2 ( OCMUX2 ),
                .DLYYC0 ( DLYYC0 ),
                .DLYYC1 ( DLYYC1 ),
                .DLYYC2 ( DLYYC2 ),
                .DLYYC3 ( DLYYC3 ),
                .DLYYC4 ( DLYYC4 ),
                .DLYGLC0 ( DLYGLC0 ),
                .DLYGLC1 ( DLYGLC1 ),
                .DLYGLC2 ( DLYGLC2 ),
                .DLYGLC3 ( DLYGLC3 ),
                .DLYGLC4 ( DLYGLC4 ),
                .FINDIV0 ( FINDIV0 ),
                .FINDIV1 ( FINDIV1 ),
                .FINDIV2 ( FINDIV2 ),
                .FINDIV3 ( FINDIV3 ),
                .FINDIV4 ( FINDIV4 ),
                .FINDIV5 ( FINDIV5 ),
                .FINDIV6 ( FINDIV6 ),
                .FBDIV0 ( FBDIV0 ),
                .FBDIV1 ( FBDIV1 ),
                .FBDIV2 ( FBDIV2 ),
                .FBDIV3 ( FBDIV3 ),
                .FBDIV4 ( FBDIV4 ),
                .FBDIV5 ( FBDIV5 ),
                .FBDIV6 ( FBDIV6 ),
                .FBDLY0 ( FBDLY0 ),
                .FBDLY1 ( FBDLY1 ),
                .FBDLY2 ( FBDLY2 ),
                .FBDLY3 ( FBDLY3 ),
                .FBDLY4 ( FBDLY4 ),
                .FBSEL0 ( FBSEL0 ),
                .FBSEL1 ( FBSEL1 ),
                .XDLYSEL ( XDLYSEL ),
                .VCOSEL0 ( VCOSEL0 ),
                .VCOSEL1 ( VCOSEL1 ),
                .VCOSEL2 ( VCOSEL2 ),
                .GLA ( GLA ),
                .LOCK ( LOCK ),
                .GLB ( GLB ),
                .YB ( YB ),
                .GLC ( GLC ),
                .YC ( YC )
             );
             
 specify

    // Timing paths for PLL related signals

    (CLKA      => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
    (CLKA      => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
   
    (CLKA      => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
    (CLKA      => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
    (CLKA      => LOCK) = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
 endspecify

endmodule

/*--------------------------------------------------------------------
 CELL NAME : PLL_V2
---------------------------------------------------------------------*/

`timescale 1 ps/1 ps

module PLL_V2 (
         CLKA,
         EXTFB,
         POWERDOWN,
         OADIV0,
         OADIV1,
         OADIV2,
         OADIV3,
         OADIV4,
         OAMUX0,
         OAMUX1,
         OAMUX2,
         DLYGLA0,
         DLYGLA1,
         DLYGLA2,
         DLYGLA3,
         DLYGLA4,
         OBDIV0,
         OBDIV1,
         OBDIV2,
         OBDIV3,
         OBDIV4,
         OBMUX0,
         OBMUX1,
         OBMUX2,
         DLYYB0,
         DLYYB1,
         DLYYB2,
         DLYYB3,
         DLYYB4,
         DLYGLB0,
         DLYGLB1,
         DLYGLB2,
         DLYGLB3,
         DLYGLB4,
         OCDIV0,
         OCDIV1,
         OCDIV2,
         OCDIV3,
         OCDIV4,
         OCMUX0,
         OCMUX1,
         OCMUX2,
         DLYYC0,
         DLYYC1,
         DLYYC2,
         DLYYC3,
         DLYYC4,
         DLYGLC0,
         DLYGLC1,
         DLYGLC2,
         DLYGLC3,
         DLYGLC4,
         FINDIV0,
         FINDIV1,
         FINDIV2,
         FINDIV3,
         FINDIV4,
         FINDIV5,
         FINDIV6,
         FBDIV0,
         FBDIV1,
         FBDIV2,
         FBDIV3,
         FBDIV4,
         FBDIV5,
         FBDIV6,
         FBDLY0,
         FBDLY1,
         FBDLY2,
         FBDLY3,
         FBDLY4,
         FBSEL0,
         FBSEL1,
         XDLYSEL,
         VCOSEL0,
         VCOSEL1,
         VCOSEL2,
         GLA,
         LOCK,
         GLB,
         YB,
         GLC,
         YC
        );

  output GLA, LOCK, GLB, YB, GLC, YC;
  input  VCOSEL2, VCOSEL1, VCOSEL0, XDLYSEL, FBSEL1, FBSEL0;
  input  FBDLY4, FBDLY3, FBDLY2, FBDLY1, FBDLY0;
  input  FBDIV6, FBDIV5, FBDIV4, FBDIV3;
  input  FBDIV2, FBDIV1, FBDIV0;
  input  FINDIV6, FINDIV5, FINDIV4, FINDIV3, FINDIV2, FINDIV1, FINDIV0;
  input  DLYGLC4, DLYGLC3, DLYGLC2, DLYGLC1, DLYGLC0;
  input  DLYYC4, DLYYC3, DLYYC2, DLYYC1, DLYYC0;
  input  OCMUX2, OCMUX1, OCMUX0, OCDIV4, OCDIV3, OCDIV2, OCDIV1, OCDIV0;
  input  DLYGLB4, DLYGLB3, DLYGLB2, DLYGLB1, DLYGLB0;
  input  DLYYB4, DLYYB3, DLYYB2, DLYYB1, DLYYB0;
  input  OBMUX2, OBMUX1, OBMUX0;
  input  OBDIV4, OBDIV3, OBDIV2, OBDIV1, OBDIV0;
  input  DLYGLA4, DLYGLA3, DLYGLA2, DLYGLA1, DLYGLA0;
  input  OAMUX2, OAMUX1, OAMUX0;
  input  OADIV4, OADIV3, OADIV2, OADIV1, OADIV0;
  input  POWERDOWN, EXTFB, CLKA;

  parameter       VCOFREQUENCY = 0;
  parameter       f_CLKA_LOCK  = 3;   // Number of CLKA cycles to wait before raising LOCK

  supply0 GND;
  wire    unused;
  wire    CLKA_ipd;
  wire    EXTFB_ipd;
  wire    POWERDOWN_ipd;

  buf    U0 ( CLKA_ipd, CLKA ); // Add SDF PORT delay
  buf    U1 ( EXTFB_ipd, EXTFB ); // Add SDF PORT delay
  buf    U2 ( POWERDOWN_ipd, POWERDOWN ); // Add SDF PORT delay

  defparam P1.VCOFREQUENCY = VCOFREQUENCY;
  defparam P1.f_CLKA_LOCK  = f_CLKA_LOCK;


  PLLPRIM #(
                .CLKA_TO_REF_DELAY(     TIMING_V2.CLKA_TO_REF_DELAY ),
                .EMULATED_SYSTEM_DELAY( TIMING_V2.EMULATED_SYSTEM_DELAY ),
                .IN_DIV_DELAY(          TIMING_V2.IN_DIV_DELAY ),
                .OUT_DIV_DELAY(         TIMING_V2.OUT_DIV_DELAY ),
                .MUX_DELAY(             TIMING_V2.MUX_DELAY ),
                .IN_DELAY_BYP1(         TIMING_V2.IN_DELAY_BYP1 ),
                .BYP_MUX_DELAY(         TIMING_V2.BYP_MUX_DELAY ),
                .GL_DRVR_DELAY(         TIMING_V2.GL_DRVR_DELAY ),
                .Y_DRVR_DELAY(          TIMING_V2.Y_DRVR_DELAY ),
                .FB_MUX_DELAY(          TIMING_V2.FB_MUX_DELAY ),
                .BYP0_CLK_GL(           TIMING_V2.BYP0_CLK_GL ),
                .X_MUX_DELAY(           TIMING_V2.X_MUX_DELAY ),
                .FIN_LOCK_DELAY(        TIMING_V2.FIN_LOCK_DELAY ),
                .LOCK_OUT_DELAY(        TIMING_V2.LOCK_OUT_DELAY ),
                .PROG_STEP_INCREMENT(   TIMING_V2.PROG_STEP_INCREMENT ),
                .PROG_INIT_DELAY(       TIMING_V2.PROG_INIT_DELAY ) )
          P1   (
                .DYNSYNC ( GND ),
                .CLKA ( CLKA_ipd ),
                .EXTFB ( EXTFB_ipd ),
                .POWERDOWN ( POWERDOWN_ipd ),
                .CLKB ( unused ),
                .CLKC ( unused ),
                .OADIVRST ( GND ),
                .OADIVHALF ( GND ),
                .OADIV0 ( OADIV0 ),
                .OADIV1 ( OADIV1 ),
                .OADIV2 ( OADIV2 ),
                .OADIV3 ( OADIV3 ),
                .OADIV4 ( OADIV4 ),
                .OAMUX0 ( OAMUX0 ),
                .OAMUX1 ( OAMUX1 ),
                .OAMUX2 ( OAMUX2 ),
                .DLYGLA0 ( DLYGLA0 ),
                .DLYGLA1 ( DLYGLA1 ),
                .DLYGLA2 ( DLYGLA2 ),
                .DLYGLA3 ( DLYGLA3 ),
                .DLYGLA4 ( DLYGLA4 ),
                .OBDIVRST ( GND ),
                .OBDIVHALF ( GND ),
                .OBDIV0 ( OBDIV0 ),
                .OBDIV1 ( OBDIV1 ),
                .OBDIV2 ( OBDIV2 ),
                .OBDIV3 ( OBDIV3 ),
                .OBDIV4 ( OBDIV4 ),
                .OBMUX0 ( OBMUX0 ),
                .OBMUX1 ( OBMUX1 ),
                .OBMUX2 ( OBMUX2 ),
                .DLYYB0 ( DLYYB0 ),
                .DLYYB1 ( DLYYB1 ),
                .DLYYB2 ( DLYYB2 ),
                .DLYYB3 ( DLYYB3 ),
                .DLYYB4 ( DLYYB4 ),
                .DLYGLB0 ( DLYGLB0 ),
                .DLYGLB1 ( DLYGLB1 ),
                .DLYGLB2 ( DLYGLB2 ),
                .DLYGLB3 ( DLYGLB3 ),
                .DLYGLB4 ( DLYGLB4 ),
                .OCDIVRST ( GND ),
                .OCDIVHALF ( GND ),
                .OCDIV0 ( OCDIV0 ),
                .OCDIV1 ( OCDIV1 ),
                .OCDIV2 ( OCDIV2 ),
                .OCDIV3 ( OCDIV3 ),
                .OCDIV4 ( OCDIV4 ),
                .OCMUX0 ( OCMUX0 ),
                .OCMUX1 ( OCMUX1 ),
                .OCMUX2 ( OCMUX2 ),
                .DLYYC0 ( DLYYC0 ),
                .DLYYC1 ( DLYYC1 ),
                .DLYYC2 ( DLYYC2 ),
                .DLYYC3 ( DLYYC3 ),
                .DLYYC4 ( DLYYC4 ),
                .DLYGLC0 ( DLYGLC0 ),
                .DLYGLC1 ( DLYGLC1 ),
                .DLYGLC2 ( DLYGLC2 ),
                .DLYGLC3 ( DLYGLC3 ),
                .DLYGLC4 ( DLYGLC4 ),
                .FINDIV0 ( FINDIV0 ),
                .FINDIV1 ( FINDIV1 ),
                .FINDIV2 ( FINDIV2 ),
                .FINDIV3 ( FINDIV3 ),
                .FINDIV4 ( FINDIV4 ),
                .FINDIV5 ( FINDIV5 ),
                .FINDIV6 ( FINDIV6 ),
                .FBDIV0 ( FBDIV0 ),
                .FBDIV1 ( FBDIV1 ),
                .FBDIV2 ( FBDIV2 ),
                .FBDIV3 ( FBDIV3 ),
                .FBDIV4 ( FBDIV4 ),
                .FBDIV5 ( FBDIV5 ),
                .FBDIV6 ( FBDIV6 ),
                .FBDLY0 ( FBDLY0 ),
                .FBDLY1 ( FBDLY1 ),
                .FBDLY2 ( FBDLY2 ),
                .FBDLY3 ( FBDLY3 ),
                .FBDLY4 ( FBDLY4 ),
                .FBSEL0 ( FBSEL0 ),
                .FBSEL1 ( FBSEL1 ),
                .XDLYSEL ( XDLYSEL ),
                .VCOSEL0 ( VCOSEL0 ),
                .VCOSEL1 ( VCOSEL1 ),
                .VCOSEL2 ( VCOSEL2 ),
                .GLA ( GLA ),
                .LOCK ( LOCK ),
                .GLB ( GLB ),
                .YB ( YB ),
                .GLC ( GLC ),
                .YC ( YC )
             );

  PLL_TIMING_V2 TIMING_V2   (
             );

 specify

    // Timing paths for PLL related signals

    (CLKA      => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => LOCK) = (0.00:0.00:0.00, 0.00:0.00:0.00);

 endspecify

endmodule

//------------------------
// CELL NAME: SHREG
//------------------------

`timescale 1 ps / 1 ps

module SHREG (
              SDOUT,
              SUPDATELATCH,
              SDIN,
              SCLK,
              SSHIFT,	
              SUPDATE	
       	     );

input	SDIN;    // Serial data input.  Applies data to a 81-bit shift register.
input	SCLK;    // Serial Clock signal for the shift register.
input	SSHIFT;  // Serial shift enable signal for the shift register.
input	SUPDATE; // Load data from the shift register into the update latch.
output	SDOUT;   // Serial data output.  Data from LSB of the shift register is shifted out.
output  [ 80 : 0 ] SUPDATELATCH;

reg	[ 80 : 0 ] SH_REG;       // 81-bit shift register
reg	[ 80 : 0 ] SUPDATELATCH; // 81-bit latch
reg	SDOUT;

always @ ( posedge SCLK )
  begin
    if ( SSHIFT ) begin
      // Serial input data enters through the MSB of the shift register 
      SH_REG [ 80 : 0 ] <= { SDIN, SH_REG [ 80 : 1 ] }; 
      // Serial output data comes from the LSB of the shift register
      SDOUT <= SH_REG [ 0 ]; 
      // SDOUT gets the LSB value after one SCLK delay
    end else
      SH_REG [ 80 : 0 ] <= SH_REG [ 80 : 0 ];
  end	


always @ ( SUPDATE or SH_REG )
  begin
    if ( SUPDATE )
      // SUPDATE latch gets SH_REG value with one SCLK delay
      SUPDATELATCH [ 80 : 0 ] <= SH_REG [ 80 : 0 ]; 
    else
      SUPDATELATCH [ 80 : 0 ] <= SUPDATELATCH [ 80 : 0 ];
  end

endmodule


//------------------------
// CELL NAME: DYNCCC
//------------------------

// SHREG shifts in 81 bits, but only bits 79 - 0 are included in the  
// configuration bit string.  Bit 80 used as the RESET ENABLE.  Bits
// 71 - 73 and 77 - 49 not used by simulation model.

`timescale 1 ps / 1 ps

module DYNCCC ( 
		CLKA,
		EXTFB,
		POWERDOWN,
		CLKB,
		CLKC,
		SDIN,
		SCLK,
		SSHIFT,
		SUPDATE,
		MODE,
                OADIV0,
                OADIV1,
                OADIV2,
                OADIV3,
                OADIV4,
                OAMUX0,
                OAMUX1,
                OAMUX2,
                DLYGLA0,
                DLYGLA1,
                DLYGLA2,
                DLYGLA3,
                DLYGLA4,
                OBDIV0,
                OBDIV1,
                OBDIV2,
                OBDIV3,
                OBDIV4,
                OBMUX0,
                OBMUX1,
                OBMUX2,
                DLYYB0,
                DLYYB1,
                DLYYB2,
                DLYYB3,
                DLYYB4,
                DLYGLB0,
                DLYGLB1,
                DLYGLB2,
                DLYGLB3,
                DLYGLB4,
                OCDIV0,
                OCDIV1,
                OCDIV2,
                OCDIV3,
                OCDIV4,
                OCMUX0,
                OCMUX1,
                OCMUX2,
                DLYYC0,
                DLYYC1,
                DLYYC2,
                DLYYC3,
                DLYYC4,
                DLYGLC0,
                DLYGLC1,
                DLYGLC2,
                DLYGLC3,
                DLYGLC4,
                FINDIV0,
                FINDIV1,
                FINDIV2,
                FINDIV3,
                FINDIV4,
                FINDIV5,
                FINDIV6,
                FBDIV0,
                FBDIV1,
                FBDIV2,
                FBDIV3,
                FBDIV4,
                FBDIV5,
                FBDIV6,
                FBDLY0,
                FBDLY1,
                FBDLY2,
                FBDLY3,
                FBDLY4,
                FBSEL0,
                FBSEL1,
                XDLYSEL,
                VCOSEL0,
                VCOSEL1,
                VCOSEL2,
                GLA,
		LOCK,
		GLB,
		YB,
		GLC,
		YC,
		SDOUT
              );

output GLA;
output LOCK;
output GLB;
output YB;
output GLC;
output YC;
output SDOUT;

input CLKA;
input EXTFB;
input POWERDOWN;
input CLKB;
input CLKC;
input SDIN;
input SCLK;
input SSHIFT;
input SUPDATE;
input MODE;
input OADIV0;
input OADIV1;
input OADIV2;
input OADIV3;
input OADIV4;
input OAMUX0;
input OAMUX1;
input OAMUX2;
input DLYGLA0;
input DLYGLA1;
input DLYGLA2;
input DLYGLA3;
input DLYGLA4;
input OBDIV0;
input OBDIV1;
input OBDIV2;
input OBDIV3;
input OBDIV4;
input OBMUX0;
input OBMUX1;
input OBMUX2;
input DLYYB0;
input DLYYB1;
input DLYYB2;
input DLYYB3;
input DLYYB4;
input DLYGLB0;
input DLYGLB1;
input DLYGLB2;
input DLYGLB3;
input DLYGLB4;
input OCDIV0;
input OCDIV1;
input OCDIV2;
input OCDIV3;
input OCDIV4;
input OCMUX0;
input OCMUX1;
input OCMUX2;
input DLYYC0;
input DLYYC1;
input DLYYC2;
input DLYYC3;
input DLYYC4;
input DLYGLC0;
input DLYGLC1;
input DLYGLC2;
input DLYGLC3;
input DLYGLC4;
input FINDIV0;
input FINDIV1;
input FINDIV2;
input FINDIV3;
input FINDIV4;
input FINDIV5;
input FINDIV6;
input FBDIV0;
input FBDIV1;
input FBDIV2;
input FBDIV3;
input FBDIV4;
input FBDIV5;
input FBDIV6;
input FBDLY0;
input FBDLY1;
input FBDLY2;
input FBDLY3;
input FBDLY4;
input FBSEL0;
input FBSEL1;
input XDLYSEL;
input VCOSEL0;
input VCOSEL1;
input VCOSEL2;

wire [ 79 : 0 ] C;
wire [ 80 : 0 ] SUPDATELATCH;
wire [ 79 : 0 ] PC;

wire SDOUT_int;

wire CLKA_ipd;
wire EXTFB_ipd;
wire POWERDOWN_ipd;
wire CLKB_ipd;
wire CLKC_ipd;
wire SDIN_ipd;
wire SCLK_ipd;
wire SSHIFT_ipd;
wire SUPDATE_ipd;
wire MODE_ipd;

// Unused configuration bits
wire DYNCSEL;
wire DYNBSEL;
wire DYNASEL;
wire STATCSEL;
wire STATBSEL;
wire STATASEL;

reg  NOTIFY_REG;

supply0 GND;
reg     RESETENA_latched;
reg     DYNSYNC;

  parameter       VCOFREQUENCY = 0;
  parameter       f_CLKA_LOCK  = 3;      // Number of CLKA cycles to wait before raising LOCK

  buf SDOUT_BUF     ( SDOUT, SDOUT_int );

  buf CLKA_BUF      ( CLKA_ipd,      CLKA      );
  buf EXTFB_BUF     ( EXTFB_ipd,     EXTFB     );
  buf POWERDOWN_BUF ( POWERDOWN_ipd, POWERDOWN );
  buf CLKB_BUF      ( CLKB_ipd,      CLKB      );
  buf CLKC_BUF      ( CLKC_ipd,      CLKC      );
  buf SDIN_BUF      ( SDIN_ipd,      SDIN      );
  buf SCLK_BUF      ( SCLK_ipd,      SCLK      );
  buf SSHIFT_BUF    ( SSHIFT_ipd,    SSHIFT    );
  buf SUPDATE_BUF   ( SUPDATE_ipd,   SUPDATE   );
  buf MODE_BUF      ( MODE_ipd,      MODE      );

  assign PC [ 79 : 0 ] = { DYNCSEL,        // 79
                         DYNBSEL,        // 78
                         DYNASEL,        // 77
                         VCOSEL2,
                         VCOSEL1, 
                         VCOSEL0,
                         STATCSEL,       // 73
                         STATBSEL,       // 72
                         STATASEL,       // 71
                         DLYYC4,
                         DLYYC3,
                         DLYYC2,
                         DLYYC1,
                         DLYYC0,
                         DLYYB4,
                         DLYYB3,
                         DLYYB2,
                         DLYYB1,
                         DLYYB0,
                         DLYGLC4,
                         DLYGLC3,
                         DLYGLC2,
                         DLYGLC1,
                         DLYGLC0,
                         DLYGLB4,
                         DLYGLB3,
                         DLYGLB2,
                         DLYGLB1,
                         DLYGLB0,
                         DLYGLA4,
                         DLYGLA3,
                         DLYGLA2,
                         DLYGLA1,
                         DLYGLA0,
                         XDLYSEL,
                         FBDLY4,
                         FBDLY3,
                         FBDLY2,
                         FBDLY1,
                         FBDLY0,
                         FBSEL1,
                         FBSEL0,
                         OCMUX2,
                         OCMUX1,
                         OCMUX0,
                         OBMUX2,
                         OBMUX1,
                         OBMUX0,
                         OAMUX2,
                         OAMUX1,
                         OAMUX0,
                         OCDIV4,
                         OCDIV3,
                         OCDIV2,
                         OCDIV1,
                         OCDIV0,
                         OBDIV4,
                         OBDIV3,
                         OBDIV2,
                         OBDIV1,
                         OBDIV0,
                         OADIV4,
                         OADIV3,
                         OADIV2,
                         OADIV1,
                         OADIV0,
                         FBDIV6,
                         FBDIV5,
                         FBDIV4,
                         FBDIV3,
                         FBDIV2,
                         FBDIV1,
                         FBDIV0,
                         FINDIV6,
                         FINDIV5,
                         FINDIV4,
                         FINDIV3,
                         FINDIV2,
                         FINDIV1,
                         FINDIV0
                       };


  //Multiplexer functionality

  assign C [ 79 : 0 ] = MODE_ipd ? SUPDATELATCH [ 79 : 0 ] : PC [ 79 : 0 ];


  //Logic for generating DYNSYNC

  always @ ( SUPDATE_ipd )
  begin

    if ( SUPDATE_ipd == 1'b1 )
    begin
      if ( MODE_ipd == 1'b1 && RESETENA_latched == 1'b1 )
      begin
        DYNSYNC <= 1'b1;
      end
    end
    else if ( SUPDATE_ipd == 1'b0 )
    begin
      DYNSYNC <= 1'b0;
      RESETENA_latched <= SUPDATELATCH [ 80 ];
    end

  end

  //instantiating the PLL module

  defparam P1.VCOFREQUENCY = VCOFREQUENCY;
  defparam P1.f_CLKA_LOCK  = f_CLKA_LOCK;

  PLLPRIM  P1 (
                .DYNSYNC   ( DYNSYNC       ),
                .CLKA      ( CLKA_ipd      ),
                .EXTFB     ( EXTFB_ipd     ),
                .POWERDOWN ( POWERDOWN_ipd ),
                .CLKB      ( CLKB_ipd      ),
                .CLKC      ( CLKC_ipd      ),
                .OADIVRST  ( GND ),
                .OADIVHALF ( GND ),
                .OADIV0  ( C [ 14 ] ),
                .OADIV1  ( C [ 15 ] ),
                .OADIV2  ( C [ 16 ] ),
                .OADIV3  ( C [ 17 ] ),
                .OADIV4  ( C [ 18 ] ),
                .OAMUX0  ( C [ 29 ] ),
                .OAMUX1  ( C [ 30 ] ),
                .OAMUX2  ( C [ 31 ] ),
                .DLYGLA0 ( C [ 46 ] ),
                .DLYGLA1 ( C [ 47 ] ),
                .DLYGLA2 ( C [ 48 ] ),
                .DLYGLA3 ( C [ 49 ] ),
                .DLYGLA4 ( C [ 50 ] ),
                .OBDIVRST  ( GND ),
                .OBDIVHALF ( GND ),
                .OBDIV0  ( C [ 19 ] ),
                .OBDIV1  ( C [ 20 ] ),
                .OBDIV2  ( C [ 21 ] ),
                .OBDIV3  ( C [ 22 ] ),
                .OBDIV4  ( C [ 23 ] ),
                .OBMUX0  ( C [ 32 ] ),
                .OBMUX1  ( C [ 33 ] ),
                .OBMUX2  ( C [ 34 ] ),
                .DLYYB0  ( C [ 61 ] ),
                .DLYYB1  ( C [ 62 ] ),
                .DLYYB2  ( C [ 63 ] ),
                .DLYYB3  ( C [ 64 ] ),
                .DLYYB4  ( C [ 65 ] ),
                .DLYGLB0 ( C [ 51 ] ),
                .DLYGLB1 ( C [ 52 ] ),
                .DLYGLB2 ( C [ 53 ] ),
                .DLYGLB3 ( C [ 54 ] ),
                .DLYGLB4 ( C [ 55 ] ),
                .OCDIVRST  ( GND ),
                .OCDIVHALF ( GND ),
                .OCDIV0  ( C [ 24 ] ),
                .OCDIV1  ( C [ 25 ] ),
                .OCDIV2  ( C [ 26 ] ),
                .OCDIV3  ( C [ 27 ] ),
                .OCDIV4  ( C [ 28 ] ),
                .OCMUX0  ( C [ 35 ] ),
                .OCMUX1  ( C [ 36 ] ),
                .OCMUX2  ( C [ 37 ] ),
                .DLYYC0  ( C [ 66 ] ),
                .DLYYC1  ( C [ 67 ] ),
                .DLYYC2  ( C [ 68 ] ),
                .DLYYC3  ( C [ 69 ] ),
                .DLYYC4  ( C [ 70 ] ),
                .DLYGLC0 ( C [ 56 ] ),
                .DLYGLC1 ( C [ 57 ] ),
                .DLYGLC2 ( C [ 58 ] ),
                .DLYGLC3 ( C [ 59 ] ),
                .DLYGLC4 ( C [ 60 ] ),
                .FINDIV0 ( C [  0 ] ),
                .FINDIV1 ( C [  1 ] ),
                .FINDIV2 ( C [  2 ] ),
                .FINDIV3 ( C [  3 ] ),
                .FINDIV4 ( C [  4 ] ),
                .FINDIV5 ( C [  5 ] ),
                .FINDIV6 ( C [  6 ] ),
                .FBDIV0  ( C [  7 ] ),
                .FBDIV1  ( C [  8 ] ),
                .FBDIV2  ( C [  9 ] ),
                .FBDIV3  ( C [ 10 ] ),
                .FBDIV4  ( C [ 11 ] ),
                .FBDIV5  ( C [ 12 ] ),
                .FBDIV6  ( C [ 13 ] ),
                .FBDLY0  ( C [ 40 ] ),
                .FBDLY1  ( C [ 41 ] ),
                .FBDLY2  ( C [ 42 ] ),
                .FBDLY3  ( C [ 43 ] ),
                .FBDLY4  ( C [ 44 ] ),
                .FBSEL0  ( C [ 38 ] ),
                .FBSEL1  ( C [ 39 ] ),
                .XDLYSEL ( C [ 45 ] ),
                .VCOSEL0 ( C [ 74 ] ),
                .VCOSEL1 ( C [ 75 ] ),
                .VCOSEL2 ( C [ 76 ] ),
                .GLA     ( GLA  ),
                .LOCK    ( LOCK ),
                .GLB     ( GLB  ),
                .YB      ( YB   ),
                .GLC     ( GLC  ),
                .YC      ( YC   )
               );

  //instantiating the shift register

  SHREG      Sh1 (
                .SDOUT        ( SDOUT_int    ),
                .SUPDATELATCH ( SUPDATELATCH ),
                .SDIN         ( SDIN_ipd     ),
                .SCLK         ( SCLK_ipd     ),
                .SSHIFT       ( SSHIFT_ipd   ),
                .SUPDATE      ( SUPDATE_ipd  )
               );


  specify

    specparam   LibName     = "iglooplus";

    // Timing paths for PLL related signals
                
    (CLKA      => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
    (CLKA      => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
   
    (CLKA      => LOCK) = (0.00:0.00:0.00, 0.00:0.00:0.00);

    // Timing paths and timing checks for SHREG related signals

    // IOPATH delay between rising edge of SCLK and SDOUT

    ( posedge SCLK => (SDOUT+:SDOUT) ) =  ( 0.1:0.1:0.1, 0.1:0.1:0.1 );

    // setup and hold checks on SDIN when SSHIFT is active

    $setup( posedge SDIN, posedge SCLK &&& SSHIFT, 0.0, NOTIFY_REG );
    $setup( negedge SDIN, posedge SCLK &&& SSHIFT, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK &&& SSHIFT, posedge SDIN, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK &&& SSHIFT, negedge SDIN, 0.0, NOTIFY_REG );

    // setup and hold checks on SSHIFT

    $setup( posedge SSHIFT, posedge SCLK, 0.0, NOTIFY_REG );
    $setup( negedge SSHIFT, posedge SCLK, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK, posedge SSHIFT, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK, negedge SSHIFT, 0.0, NOTIFY_REG );

    // pulse width check on SUPDATE and SCLK

    $width( posedge SUPDATE, 0.0, 0, NOTIFY_REG );
    $width( negedge SUPDATE, 0.0, 0, NOTIFY_REG );  // is this required??
    $width( posedge SCLK,    0.0, 0, NOTIFY_REG );
    $width( negedge SCLK,    0.0, 0, NOTIFY_REG );

  endspecify


endmodule

//------------------------
// CELL NAME: DYNCCC_V2
//------------------------

// SHREG shifts in 81 bits, but only bits 79 - 0 are included in the  
// configuration bit string.  Bit 80 used as the RESET ENABLE.  Bits
// 71 - 73 and 77 - 49 not used by simulation model.

`timescale 1 ps / 1 ps

module DYNCCC_V2 ( 
		CLKA,
		EXTFB,
		POWERDOWN,
		CLKB,
		CLKC,
		SDIN,
		SCLK,
		SSHIFT,
		SUPDATE,
		MODE,
                OADIV0,
                OADIV1,
                OADIV2,
                OADIV3,
                OADIV4,
                OAMUX0,
                OAMUX1,
                OAMUX2,
                DLYGLA0,
                DLYGLA1,
                DLYGLA2,
                DLYGLA3,
                DLYGLA4,
                OBDIV0,
                OBDIV1,
                OBDIV2,
                OBDIV3,
                OBDIV4,
                OBMUX0,
                OBMUX1,
                OBMUX2,
                DLYYB0,
                DLYYB1,
                DLYYB2,
                DLYYB3,
                DLYYB4,
                DLYGLB0,
                DLYGLB1,
                DLYGLB2,
                DLYGLB3,
                DLYGLB4,
                OCDIV0,
                OCDIV1,
                OCDIV2,
                OCDIV3,
                OCDIV4,
                OCMUX0,
                OCMUX1,
                OCMUX2,
                DLYYC0,
                DLYYC1,
                DLYYC2,
                DLYYC3,
                DLYYC4,
                DLYGLC0,
                DLYGLC1,
                DLYGLC2,
                DLYGLC3,
                DLYGLC4,
                FINDIV0,
                FINDIV1,
                FINDIV2,
                FINDIV3,
                FINDIV4,
                FINDIV5,
                FINDIV6,
                FBDIV0,
                FBDIV1,
                FBDIV2,
                FBDIV3,
                FBDIV4,
                FBDIV5,
                FBDIV6,
                FBDLY0,
                FBDLY1,
                FBDLY2,
                FBDLY3,
                FBDLY4,
                FBSEL0,
                FBSEL1,
                XDLYSEL,
                VCOSEL0,
                VCOSEL1,
                VCOSEL2,
                GLA,
		LOCK,
		GLB,
		YB,
		GLC,
		YC,
		SDOUT
              );

output GLA;
output LOCK;
output GLB;
output YB;
output GLC;
output YC;
output SDOUT;

input CLKA;
input EXTFB;
input POWERDOWN;
input CLKB;
input CLKC;
input SDIN;
input SCLK;
input SSHIFT;
input SUPDATE;
input MODE;
input OADIV0;
input OADIV1;
input OADIV2;
input OADIV3;
input OADIV4;
input OAMUX0;
input OAMUX1;
input OAMUX2;
input DLYGLA0;
input DLYGLA1;
input DLYGLA2;
input DLYGLA3;
input DLYGLA4;
input OBDIV0;
input OBDIV1;
input OBDIV2;
input OBDIV3;
input OBDIV4;
input OBMUX0;
input OBMUX1;
input OBMUX2;
input DLYYB0;
input DLYYB1;
input DLYYB2;
input DLYYB3;
input DLYYB4;
input DLYGLB0;
input DLYGLB1;
input DLYGLB2;
input DLYGLB3;
input DLYGLB4;
input OCDIV0;
input OCDIV1;
input OCDIV2;
input OCDIV3;
input OCDIV4;
input OCMUX0;
input OCMUX1;
input OCMUX2;
input DLYYC0;
input DLYYC1;
input DLYYC2;
input DLYYC3;
input DLYYC4;
input DLYGLC0;
input DLYGLC1;
input DLYGLC2;
input DLYGLC3;
input DLYGLC4;
input FINDIV0;
input FINDIV1;
input FINDIV2;
input FINDIV3;
input FINDIV4;
input FINDIV5;
input FINDIV6;
input FBDIV0;
input FBDIV1;
input FBDIV2;
input FBDIV3;
input FBDIV4;
input FBDIV5;
input FBDIV6;
input FBDLY0;
input FBDLY1;
input FBDLY2;
input FBDLY3;
input FBDLY4;
input FBSEL0;
input FBSEL1;
input XDLYSEL;
input VCOSEL0;
input VCOSEL1;
input VCOSEL2;

wire [ 79 : 0 ] C;
wire [ 80 : 0 ] SUPDATELATCH;
wire [ 79 : 0 ] PC;

wire SDOUT_int;

wire CLKA_ipd;
wire EXTFB_ipd;
wire POWERDOWN_ipd;
wire CLKB_ipd;
wire CLKC_ipd;
wire SDIN_ipd;
wire SCLK_ipd;
wire SSHIFT_ipd;
wire SUPDATE_ipd;
wire MODE_ipd;

// Unused configuration bits
wire DYNCSEL;
wire DYNBSEL;
wire DYNASEL;
wire STATCSEL;
wire STATBSEL;
wire STATASEL;

reg  NOTIFY_REG;

supply0 GND;
reg     RESETENA_latched;
reg     DYNSYNC;

  parameter       VCOFREQUENCY = 0;
  parameter       f_CLKA_LOCK  = 3;      // Number of CLKA cycles to wait before raising LOCK

  buf SDOUT_BUF     ( SDOUT, SDOUT_int );

  buf CLKA_BUF      ( CLKA_ipd,      CLKA      );
  buf EXTFB_BUF     ( EXTFB_ipd,     EXTFB     );
  buf POWERDOWN_BUF ( POWERDOWN_ipd, POWERDOWN );
  buf CLKB_BUF      ( CLKB_ipd,      CLKB      );
  buf CLKC_BUF      ( CLKC_ipd,      CLKC      );
  buf SDIN_BUF      ( SDIN_ipd,      SDIN      );
  buf SCLK_BUF      ( SCLK_ipd,      SCLK      );
  buf SSHIFT_BUF    ( SSHIFT_ipd,    SSHIFT    );
  buf SUPDATE_BUF   ( SUPDATE_ipd,   SUPDATE   );
  buf MODE_BUF      ( MODE_ipd,      MODE      );

  assign PC [ 79 : 0 ] = { DYNCSEL,        // 79
                         DYNBSEL,        // 78
                         DYNASEL,        // 77
                         VCOSEL2,
                         VCOSEL1, 
                         VCOSEL0,
                         STATCSEL,       // 73
                         STATBSEL,       // 72
                         STATASEL,       // 71
                         DLYYC4,
                         DLYYC3,
                         DLYYC2,
                         DLYYC1,
                         DLYYC0,
                         DLYYB4,
                         DLYYB3,
                         DLYYB2,
                         DLYYB1,
                         DLYYB0,
                         DLYGLC4,
                         DLYGLC3,
                         DLYGLC2,
                         DLYGLC1,
                         DLYGLC0,
                         DLYGLB4,
                         DLYGLB3,
                         DLYGLB2,
                         DLYGLB1,
                         DLYGLB0,
                         DLYGLA4,
                         DLYGLA3,
                         DLYGLA2,
                         DLYGLA1,
                         DLYGLA0,
                         XDLYSEL,
                         FBDLY4,
                         FBDLY3,
                         FBDLY2,
                         FBDLY1,
                         FBDLY0,
                         FBSEL1,
                         FBSEL0,
                         OCMUX2,
                         OCMUX1,
                         OCMUX0,
                         OBMUX2,
                         OBMUX1,
                         OBMUX0,
                         OAMUX2,
                         OAMUX1,
                         OAMUX0,
                         OCDIV4,
                         OCDIV3,
                         OCDIV2,
                         OCDIV1,
                         OCDIV0,
                         OBDIV4,
                         OBDIV3,
                         OBDIV2,
                         OBDIV1,
                         OBDIV0,
                         OADIV4,
                         OADIV3,
                         OADIV2,
                         OADIV1,
                         OADIV0,
                         FBDIV6,
                         FBDIV5,
                         FBDIV4,
                         FBDIV3,
                         FBDIV2,
                         FBDIV1,
                         FBDIV0,
                         FINDIV6,
                         FINDIV5,
                         FINDIV4,
                         FINDIV3,
                         FINDIV2,
                         FINDIV1,
                         FINDIV0
                       };


  //Multiplexer functionality

  assign C [ 79 : 0 ] = MODE_ipd ? SUPDATELATCH [ 79 : 0 ] : PC [ 79 : 0 ];


  //Logic for generating DYNSYNC

  always @ ( SUPDATE_ipd )
  begin

    if ( SUPDATE_ipd == 1'b1 )
    begin
      if ( MODE_ipd == 1'b1 && RESETENA_latched == 1'b1 )
      begin
        DYNSYNC <= 1'b1;
      end
    end
    else if ( SUPDATE_ipd == 1'b0 )
    begin
      DYNSYNC <= 1'b0;
      RESETENA_latched <= SUPDATELATCH [ 80 ];
    end

  end

  //instantiating the PLL module

  defparam P1.VCOFREQUENCY = VCOFREQUENCY;
  defparam P1.f_CLKA_LOCK  = f_CLKA_LOCK;

  PLLPRIM #(
                .CLKA_TO_REF_DELAY(     TIMING_V2.CLKA_TO_REF_DELAY ),
                .EMULATED_SYSTEM_DELAY( TIMING_V2.EMULATED_SYSTEM_DELAY ),
                .IN_DIV_DELAY(          TIMING_V2.IN_DIV_DELAY ),
                .OUT_DIV_DELAY(         TIMING_V2.OUT_DIV_DELAY ),
                .MUX_DELAY(             TIMING_V2.MUX_DELAY ),
                .IN_DELAY_BYP1(         TIMING_V2.IN_DELAY_BYP1 ),
                .BYP_MUX_DELAY(         TIMING_V2.BYP_MUX_DELAY ),
                .GL_DRVR_DELAY(         TIMING_V2.GL_DRVR_DELAY ),
                .Y_DRVR_DELAY(          TIMING_V2.Y_DRVR_DELAY ),
                .FB_MUX_DELAY(          TIMING_V2.FB_MUX_DELAY ),
                .BYP0_CLK_GL(           TIMING_V2.BYP0_CLK_GL ),
                .X_MUX_DELAY(           TIMING_V2.X_MUX_DELAY ),
                .FIN_LOCK_DELAY(        TIMING_V2.FIN_LOCK_DELAY ),
                .LOCK_OUT_DELAY(        TIMING_V2.LOCK_OUT_DELAY ),
                .PROG_STEP_INCREMENT(   TIMING_V2.PROG_STEP_INCREMENT ),
                .PROG_INIT_DELAY(       TIMING_V2.PROG_INIT_DELAY ) )
           P1 (
                .DYNSYNC   ( DYNSYNC       ),
                .CLKA      ( CLKA_ipd      ),
                .EXTFB     ( EXTFB_ipd     ),
                .POWERDOWN ( POWERDOWN_ipd ),
                .CLKB      ( CLKB_ipd      ),
                .CLKC      ( CLKC_ipd      ),
                .OADIVRST  ( GND ),
                .OADIVHALF ( GND ),
                .OADIV0  ( C [ 14 ] ),
                .OADIV1  ( C [ 15 ] ),
                .OADIV2  ( C [ 16 ] ),
                .OADIV3  ( C [ 17 ] ),
                .OADIV4  ( C [ 18 ] ),
                .OAMUX0  ( C [ 29 ] ),
                .OAMUX1  ( C [ 30 ] ),
                .OAMUX2  ( C [ 31 ] ),
                .DLYGLA0 ( C [ 46 ] ),
                .DLYGLA1 ( C [ 47 ] ),
                .DLYGLA2 ( C [ 48 ] ),
                .DLYGLA3 ( C [ 49 ] ),
                .DLYGLA4 ( C [ 50 ] ),
                .OBDIVRST  ( GND ),
                .OBDIVHALF ( GND ),
                .OBDIV0  ( C [ 19 ] ),
                .OBDIV1  ( C [ 20 ] ),
                .OBDIV2  ( C [ 21 ] ),
                .OBDIV3  ( C [ 22 ] ),
                .OBDIV4  ( C [ 23 ] ),
                .OBMUX0  ( C [ 32 ] ),
                .OBMUX1  ( C [ 33 ] ),
                .OBMUX2  ( C [ 34 ] ),
                .DLYYB0  ( C [ 61 ] ),
                .DLYYB1  ( C [ 62 ] ),
                .DLYYB2  ( C [ 63 ] ),
                .DLYYB3  ( C [ 64 ] ),
                .DLYYB4  ( C [ 65 ] ),
                .DLYGLB0 ( C [ 51 ] ),
                .DLYGLB1 ( C [ 52 ] ),
                .DLYGLB2 ( C [ 53 ] ),
                .DLYGLB3 ( C [ 54 ] ),
                .DLYGLB4 ( C [ 55 ] ),
                .OCDIVRST  ( GND ),
                .OCDIVHALF ( GND ),
                .OCDIV0  ( C [ 24 ] ),
                .OCDIV1  ( C [ 25 ] ),
                .OCDIV2  ( C [ 26 ] ),
                .OCDIV3  ( C [ 27 ] ),
                .OCDIV4  ( C [ 28 ] ),
                .OCMUX0  ( C [ 35 ] ),
                .OCMUX1  ( C [ 36 ] ),
                .OCMUX2  ( C [ 37 ] ),
                .DLYYC0  ( C [ 66 ] ),
                .DLYYC1  ( C [ 67 ] ),
                .DLYYC2  ( C [ 68 ] ),
                .DLYYC3  ( C [ 69 ] ),
                .DLYYC4  ( C [ 70 ] ),
                .DLYGLC0 ( C [ 56 ] ),
                .DLYGLC1 ( C [ 57 ] ),
                .DLYGLC2 ( C [ 58 ] ),
                .DLYGLC3 ( C [ 59 ] ),
                .DLYGLC4 ( C [ 60 ] ),
                .FINDIV0 ( C [  0 ] ),
                .FINDIV1 ( C [  1 ] ),
                .FINDIV2 ( C [  2 ] ),
                .FINDIV3 ( C [  3 ] ),
                .FINDIV4 ( C [  4 ] ),
                .FINDIV5 ( C [  5 ] ),
                .FINDIV6 ( C [  6 ] ),
                .FBDIV0  ( C [  7 ] ),
                .FBDIV1  ( C [  8 ] ),
                .FBDIV2  ( C [  9 ] ),
                .FBDIV3  ( C [ 10 ] ),
                .FBDIV4  ( C [ 11 ] ),
                .FBDIV5  ( C [ 12 ] ),
                .FBDIV6  ( C [ 13 ] ),
                .FBDLY0  ( C [ 40 ] ),
                .FBDLY1  ( C [ 41 ] ),
                .FBDLY2  ( C [ 42 ] ),
                .FBDLY3  ( C [ 43 ] ),
                .FBDLY4  ( C [ 44 ] ),
                .FBSEL0  ( C [ 38 ] ),
                .FBSEL1  ( C [ 39 ] ),
                .XDLYSEL ( C [ 45 ] ),
                .VCOSEL0 ( C [ 74 ] ),
                .VCOSEL1 ( C [ 75 ] ),
                .VCOSEL2 ( C [ 76 ] ),
                .GLA     ( GLA  ),
                .LOCK    ( LOCK ),
                .GLB     ( GLB  ),
                .YB      ( YB   ),
                .GLC     ( GLC  ),
                .YC      ( YC   )
               );

  PLL_TIMING_V2 TIMING_V2   (
             );

  //instantiating the shift register

  SHREG      Sh1 (
                .SDOUT        ( SDOUT_int    ),
                .SUPDATELATCH ( SUPDATELATCH ),
                .SDIN         ( SDIN_ipd     ),
                .SCLK         ( SCLK_ipd     ),
                .SSHIFT       ( SSHIFT_ipd   ),
                .SUPDATE      ( SUPDATE_ipd  )
               );


  specify

    specparam   LibName     = "iglooplus";

    // Timing paths for PLL related signals
                
    (CLKA      => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLA)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLB)  = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => GLC)  = (0.00:0.00:0.00, 0.00:0.00:0.00);
    
    (CLKA      => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YB)   = (0.00:0.00:0.00, 0.00:0.00:0.00);

    (CLKA      => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (EXTFB     => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
    (POWERDOWN => YC)   = (0.00:0.00:0.00, 0.00:0.00:0.00);
   
    (CLKA      => LOCK) = (0.00:0.00:0.00, 0.00:0.00:0.00);

    // Timing paths and timing checks for SHREG related signals

    // IOPATH delay between rising edge of SCLK and SDOUT

    ( posedge SCLK => (SDOUT+:SDOUT) ) =  ( 0.1:0.1:0.1, 0.1:0.1:0.1 );

    // setup and hold checks on SDIN when SSHIFT is active

    $setup( posedge SDIN, posedge SCLK &&& SSHIFT, 0.0, NOTIFY_REG );
    $setup( negedge SDIN, posedge SCLK &&& SSHIFT, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK &&& SSHIFT, posedge SDIN, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK &&& SSHIFT, negedge SDIN, 0.0, NOTIFY_REG );

    // setup and hold checks on SSHIFT

    $setup( posedge SSHIFT, posedge SCLK, 0.0, NOTIFY_REG );
    $setup( negedge SSHIFT, posedge SCLK, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK, posedge SSHIFT, 0.0, NOTIFY_REG );
    $hold ( posedge SCLK, negedge SSHIFT, 0.0, NOTIFY_REG );

    // pulse width check on SUPDATE and SCLK

    $width( posedge SUPDATE, 0.0, 0, NOTIFY_REG );
    $width( negedge SUPDATE, 0.0, 0, NOTIFY_REG );  // is this required??
    $width( posedge SCLK,    0.0, 0, NOTIFY_REG );
    $width( negedge SCLK,    0.0, 0, NOTIFY_REG );

  endspecify


endmodule


//------------------------
// CELL NAME: UJTAG
//------------------------

/*
 * Simple TAP for simulation of designs using the ProASIC user JTAG interface
 * Note:
 * 1. This TAP is not a model of the actual TAP used in the ProASIC. The
 *    only instruction implemented is BYPASS. An instruction scan operation
 *    will capture the pattern 8'bxxxxxx01
 * 2. This model should not be used for the A500K family, as it uses
 *    a different set of interface signals.
 *
 */

`timescale 1ns/10ps

`define Bypass            8'hff

`define Test_Logic_Reset  4'hf
`define Run_Test_Idle     4'hc
`define Select_DR         4'h7
`define Capture_DR        4'h6
`define Shift_DR          4'h2
`define Exit1_DR          4'h1
`define Pause_DR          4'h3
`define Exit2_DR          4'h0
`define Update_DR         4'h5
`define Select_IR         4'h4
`define Capture_IR        4'he
`define Shift_IR          4'ha
`define Exit1_IR          4'h9
`define Pause_IR          4'hb
`define Exit2_IR          4'h8
`define Update_IR         4'hd

module UJTAG ( UIREG0, UIREG1, UIREG2, UIREG3, UIREG4, UIREG5, UIREG6, UIREG7,
               URSTB, UDRCK, UDRCAP, UDRSH, UDRUPD, UTDI, UTDO,
               TDO, TMS, TDI, TCK, TRSTB );

output  UIREG0, UIREG1, UIREG2, UIREG3, UIREG4, UIREG5, UIREG6, UIREG7;

output  UTDI, URSTB, UDRCK, UDRCAP, UDRSH, UDRUPD;
input   UTDO;

input   TMS, TDI, TCK, TRSTB;
output  TDO;

reg [3:0] STATE;
reg [7:0] IR, SHREG;
//reg       TDO, UDRUPD, UDRCAP, UDRSH;
reg       TDO_zd, UDRUPD_zd, UDRCAP_zd, UDRSH_zd, URSTB_zd;
reg       NOTIFY_REG;

buf  buf_tdi      ( TDI_int,   TDI   );
buf  buf_tms      ( TMS_int,   TMS   );
buf  buf_tck      ( TCK_int,   TCK   );
buf  buf_trstb    ( TRSTB_int, TRSTB );
buf  buf_utdo     ( UTDO_int,  UTDO  );

pmos pmos_uireg0  ( UIREG0, UIREG0_zd, 0 );
pmos pmos_uireg1  ( UIREG1, UIREG1_zd, 0 );
pmos pmos_uireg2  ( UIREG2, UIREG2_zd, 0 );
pmos pmos_uireg3  ( UIREG3, UIREG3_zd, 0 );
pmos pmos_uireg4  ( UIREG4, UIREG4_zd, 0 );
pmos pmos_uireg5  ( UIREG5, UIREG5_zd, 0 );
pmos pmos_uireg6  ( UIREG6, UIREG6_zd, 0 );
pmos pmos_uireg7  ( UIREG7, UIREG7_zd, 0 );

pmos pmos_tdo     ( TDO,    TDO_zd,    0 );
pmos pmos_urstb   ( URSTB,  URSTB_zd,  0 );
//pmos pmos_udrck   ( UDRCK,  UDRCK_zd,  0 );
pmos pmos_udrcap  ( UDRCAP, UDRCAP_zd, 0 );
pmos pmos_udrsh   ( UDRSH,  UDRSH_zd,  0 );
pmos pmos_udrupd  ( UDRUPD, UDRUPD_zd, 0 );
//pmos pmos_utdi    ( UTDI,   UTDI_zd,   0 );

//assign { UIREG7, UIREG6, UIREG5, UIREG4, UIREG3, UIREG2, UIREG1, UIREG0 } = IR;
assign { UIREG7_zd, UIREG6_zd, UIREG5_zd, UIREG4_zd, UIREG3_zd, UIREG2_zd, UIREG1_zd, UIREG0_zd } = IR;
assign UTDI  = TDI_int;
assign UDRCK = TCK_int;
//assign URSTB = STATE != `Test_Logic_Reset;

always @( negedge TCK_int or negedge TRSTB_int )
begin
        if ( !TRSTB_int ) begin
                UDRUPD_zd <= 0;
                UDRSH_zd  <= 0;
                UDRCAP_zd <= 0;
                URSTB_zd  <= 0;
        end else begin
                UDRUPD_zd <= ( STATE == `Update_DR        );
                UDRSH_zd  <= ( STATE == `Shift_DR         );
                UDRCAP_zd <= ( STATE == `Capture_DR       );
                URSTB_zd  <= ( STATE != `Test_Logic_Reset );
        end
end

always @( posedge TCK_int or negedge TRSTB_int )
begin
        if ( !TRSTB_int ) begin
                STATE <= `Test_Logic_Reset;
        end
        else begin
             case ( STATE )
                `Test_Logic_Reset: STATE <= TMS_int ? `Test_Logic_Reset : `Run_Test_Idle;
                `Run_Test_Idle   : STATE <= TMS_int ? `Select_DR : `Run_Test_Idle;
                `Select_DR       : STATE <= TMS_int ? `Select_IR : `Capture_DR;
                `Capture_DR,
                `Shift_DR        : STATE <= TMS_int ? `Exit1_DR : `Shift_DR;
                `Exit1_DR        : STATE <= TMS_int ? `Update_DR : `Pause_DR;
                `Pause_DR        : STATE <= TMS_int ? `Exit2_DR : `Pause_DR;
                `Exit2_DR        : STATE <= TMS_int ? `Update_DR : `Shift_DR;
                `Select_IR       : STATE <= TMS_int ? `Test_Logic_Reset :  `Capture_IR;
                `Capture_IR,
                `Shift_IR        : STATE <= TMS_int ? `Exit1_IR : `Shift_IR;
                `Exit1_IR        : STATE <= TMS_int ? `Update_IR : `Pause_IR;
                `Pause_IR        : STATE <= TMS_int ? `Exit2_IR : `Pause_IR;
                `Exit2_IR        : STATE <= TMS_int ? `Update_IR : `Shift_IR;
                `Update_DR,
                `Update_IR       : STATE <= TMS_int ? `Select_DR : `Run_Test_Idle;
             endcase
        end
end

always @( posedge TCK_int )
begin
        case ( STATE )
                `Capture_IR : SHREG <=  8'bxxxxxx01;
                `Capture_DR : SHREG <=  8'b00000000;
                `Shift_IR,
                `Shift_DR   : SHREG <= { TDI_int, SHREG[7:1] };
        endcase
end

always @( negedge TCK_int or negedge TRSTB_int )
begin
       if ( !TRSTB_int ) begin
         IR  <= `Bypass;
         TDO_zd <= 'bz;
       end else if ( STATE == `Shift_IR )
         TDO_zd <= SHREG[0];
       else if ( STATE == `Shift_DR ) begin
         casez ( IR )
           8'b01??????,
           8'b0?1?????,
           8'b0??1????: TDO_zd <= UTDO;
           default    : TDO_zd <= SHREG[7];
         endcase
       end
       else if ( STATE == `Update_IR ) begin
         TDO_zd <= 'bz;
         IR  <= SHREG;
       end else begin
         TDO_zd <= 'bz;
       end
end

    specify

      specparam   LibName     = "iglooplus";

      (negedge TCK   => (UIREG0+:UIREG0) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG1+:UIREG1) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG2+:UIREG2) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG3+:UIREG3) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG4+:UIREG4) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG5+:UIREG5) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG6+:UIREG6) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UIREG7+:UIREG7) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (posedge TCK   => (UDRCK +:1'b1  ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UDRCK +:1'b0  ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (posedge TDI   => (UTDI +:1'b1   ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TDI   => (UTDI +:1'b0   ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge TCK   => (URSTB +:URSTB ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UDRSH +:UDRSH ) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UDRCAP+:UDRCAP) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TCK   => (UDRUPD+:UDRUPD) ) = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge TCK   => (TDO+:TDO ) )      = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge TRSTB => (UIREG0+:1'b1) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG1+:1'b1) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG2+:1'b1) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG3+:1'b1) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG4+:1'b1) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG5+:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG6+:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UIREG7+:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge TRSTB => (URSTB +:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UDRSH +:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UDRCAP+:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);
      (negedge TRSTB => (UDRUPD+:1'b0) )   = (0.1:0.1:0.1, 0.1:0.1:0.1);

      (negedge TRSTB => (TDO+:1'b0) )      = (0.1:0.1:0.1, 0.1:0.1:0.1);

      $setup(posedge TDI, posedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $setup(negedge TDI, posedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $hold(posedge TCK &&& TRSTB, posedge TDI, 0.0, NOTIFY_REG);
      $hold(posedge TCK &&& TRSTB, negedge TDI, 0.0, NOTIFY_REG);

      $setup(posedge TMS, posedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $setup(negedge TMS, posedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $hold(posedge TCK &&& TRSTB, posedge TMS, 0.0, NOTIFY_REG);
      $hold(posedge TCK &&& TRSTB, negedge TMS, 0.0, NOTIFY_REG);

      $setup(posedge UTDO, negedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $setup(negedge UTDO, negedge TCK &&& TRSTB, 0.0, NOTIFY_REG);
      $hold(negedge TCK &&& TRSTB, posedge UTDO, 0.0, NOTIFY_REG);
      $hold(negedge TCK &&& TRSTB, negedge UTDO, 0.0, NOTIFY_REG);

      $recovery(posedge TRSTB, posedge TCK, 0.0, NOTIFY_REG);
      $hold(posedge TCK,posedge TRSTB, 0.0, NOTIFY_REG);

      $width(negedge TRSTB, 0.0, 0, NOTIFY_REG);
      $width(posedge TCK, 0.0, 0, NOTIFY_REG);
      $width(negedge TCK, 0.0, 0, NOTIFY_REG);


    endspecify

endmodule


//---- MODULE SIMBUF ----
/*--------------------------------------------------------------------
 CELL NAME : SIMBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module SIMBUF(PAD,D);
 input D;
 output PAD;
 reg NOTIFY_REG;

 buf	BUF_U_00(PAD,D);

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults
//---- END MODULE SIMBUF ----
//*********************************************************************
//*********************************************************************
// Detailed Revision History:
//
// Rev. Date(MM/DD/YY)              Description
//
// 1.0  10/08/09         Kiran Yerribandi     First Version
// 

/*--------------------------------------------------------------------
 CELL NAME : PLL_SDF
---------------------------------------------------------------------*/

// PLL_SDF and PLL_DLY_SDF macros are used to model backannotated pll model.
//  In the backannotated netlist PLL is split up into two macros PLL_SDF and
//  PLL_DLY_SDF. PLL_SDF macro has all the functionality and PLL_DLY_SDF
//  modules all the delays.
// PLL_SDF macro doesn;t have any delays in it.
//     #########################################################
//     #                    PLLBA                              #   
//     #                                                       #
//     #     ----------               -----------              #
//     #    |          |             |           |             #
//     #    |          |-----------> |           |             #
//     #    |PLL_SDF   |             |PLL_DLY_SDF|             #
//     #    |          |             |           |             #
//     #    |          |             |           |             #
//     #    |          |             |           |---          #
//     #  --|          |             |           |   |         #
//     #  |  ----------               -----------    |         #
//     #  |                                          |         #
//     #   -------------------------------------------         #
//     #                                                       #
//     #########################################################

`timescale 1 ps/1 ps

module PLL_SDF (
	       CLKA,
	       EXTFB,
	       INTFB,
	       POWERDOWN,
	       OADIV0,
	       OADIV1,
	       OADIV2,
	       OADIV3,
	       OADIV4,
	       OAMUX0,
	       OAMUX1,
	       OAMUX2,
	       DLYGLA0,
	       DLYGLA1,
	       DLYGLA2,
	       DLYGLA3,
	       DLYGLA4,
	       OBDIV0,
	       OBDIV1,
	       OBDIV2,
	       OBDIV3,
	       OBDIV4,
	       OBMUX0,
	       OBMUX1,
	       OBMUX2,
	       DLYYB0,
	       DLYYB1,
	       DLYYB2,
	       DLYYB3,
	       DLYYB4,
	       DLYGLB0,
	       DLYGLB1,
	       DLYGLB2,
	       DLYGLB3,
	       DLYGLB4,
	       OCDIV0,
	       OCDIV1,
	       OCDIV2,
	       OCDIV3,
	       OCDIV4,
	       OCMUX0,
	       OCMUX1,
	       OCMUX2,
	       DLYYC0,
	       DLYYC1,
	       DLYYC2,
	       DLYYC3,
	       DLYYC4,
	       DLYGLC0,
	       DLYGLC1,
	       DLYGLC2,
	       DLYGLC3,
	       DLYGLC4,
	       FINDIV0,
	       FINDIV1,
	       FINDIV2,
	       FINDIV3,
	       FINDIV4,
	       FINDIV5,
	       FINDIV6,
	       FBDIV0,
	       FBDIV1,
	       FBDIV2,
	       FBDIV3,
	       FBDIV4,
	       FBDIV5,
	       FBDIV6,
	       FBDLY0,
	       FBDLY1,
	       FBDLY2,
	       FBDLY3,
	       FBDLY4,
	       FBSEL0,
	       FBSEL1,
	       XDLYSEL,
	       VCOSEL0,
	       VCOSEL1,
	       VCOSEL2,
	       GLAOUT,
	       LOCKOUT,
	       GLBOUT,
	       YBOUT,
	       GLCOUT,
	       YCOUT,
	       VCOOUT
	       );
    output GLAOUT, LOCKOUT, GLBOUT, YBOUT, GLCOUT, YCOUT;
   output VCOOUT;//pll output- vcofrequency
  //Static Inputs
  input  VCOSEL2, VCOSEL1, VCOSEL0, XDLYSEL, FBSEL1, FBSEL0; 
  input  FBDLY4, FBDLY3, FBDLY2, FBDLY1, FBDLY0;
  input  FBDIV6, FBDIV5, FBDIV4, FBDIV3;
  input  FBDIV2, FBDIV1, FBDIV0;
  input  FINDIV6, FINDIV5, FINDIV4, FINDIV3, FINDIV2, FINDIV1, FINDIV0;
  input  DLYGLC4, DLYGLC3, DLYGLC2, DLYGLC1, DLYGLC0;
  input  DLYYC4, DLYYC3, DLYYC2, DLYYC1, DLYYC0;
  input  OCMUX2, OCMUX1, OCMUX0, OCDIV4, OCDIV3, OCDIV2, OCDIV1, OCDIV0;
  input  DLYGLB4, DLYGLB3, DLYGLB2, DLYGLB1, DLYGLB0;
  input  DLYYB4, DLYYB3, DLYYB2, DLYYB1, DLYYB0;
  input  OBMUX2, OBMUX1, OBMUX0;
  input  OBDIV4, OBDIV3, OBDIV2, OBDIV1, OBDIV0;
  input  DLYGLA4, DLYGLA3, DLYGLA2, DLYGLA1, DLYGLA0;
  input  OAMUX2, OAMUX1, OAMUX0;
  input  OADIV4, OADIV3, OADIV2, OADIV1, OADIV0;
  //Dynamic inputs
  input  POWERDOWN, EXTFB, INTFB, CLKA;
    reg GLAOUT,  GLBOUT, YBOUT, GLCOUT, YCOUT;
  
   parameter VCOFREQUENCY = 0;
  // Number of CLKA cycles to wait before raising LOCK
   parameter f_CLKA_LOCK  = 3;  

  
  reg             GLB;
  reg             GLA;
  reg             GLC;
  reg             YB;
  reg             YC;

  reg             AOUT;
  reg             BOUT;
  reg             COUT;
  
  reg             RESET1;
  reg             RESET2;
  reg             RESET3;

  time            PLLDELAY;
  time            PLLCLK_pw;
  time            PLLCLK_period;
  time            DTDELAY;
  time            FBDELAY;
  time            negative_delay;
  time            tmp_delay;
  time            LOCK_re;
  time            UIN_re;
  time            VIN_re;
  time            WIN_re;
  time            UIN_prev_re;
  time            VIN_prev_re;
  time            WIN_prev_re;
  integer         UIN_period;
  integer         VIN_period;
  integer         WIN_period;
  
  //Additional delay value variables for GLA and GLB path

  time            GLBDELAY;
  time            GLADELAY;
  time            GLCDELAY;
  time            YBDELAY;
  time            YCDELAY;

  time            CLKA_period;
  time            CLKA_re;

  reg             PLLCLK;

  reg             CLKA2X;
  time            CLKA2X_CLKA_re;
  time            CLKA2X_CLKA_period;

  wire            UIN;
  wire            VIN;
  wire            WIN;

  integer         i;
  integer         DIVN;
  integer         DIVM;
  integer         DIVU;
  integer         DIVV;
  integer         DIVW;
  integer         fb_loop_div; // Total division of feedback loop
  integer         DivVal;
  integer         DivVal1;
  integer         DivVal2;
  integer         DivVal3;
  integer         DivVal4;
  integer         A_num_edges;
  integer         B_num_edges;
  integer         C_num_edges;
  integer         FBSEL_illegal;
  integer         UIN_num_res;
  integer         UIN_num_fes;
  integer         VIN_num_res;
  integer         VIN_num_fes;
  integer         WIN_num_res;
  integer         WIN_num_fes;

    wire       CLKA_ipd;
  wire       POWERDOWN_ipd;
  wire       EXTFB_ipd;
   wire      INTFB_ipd;

    integer    res_post_reseta1;
  integer    fes_post_reseta1;
  integer    res_post_reseta0;
  integer    fes_post_reseta0;
  reg        AOUT_CLKA_last_value;
  reg        OADIVRST_ipd_last_value;
  reg        UIN_last_value;
  reg        POWERDOWNA_ipd_last_value;
  reg        forcea_0;
  integer    res_post_resetb1;
  integer    fes_post_resetb1;
  integer    res_post_resetb0;
  integer    fes_post_resetb0;
  reg        VIN_last_value;
  reg        POWERDOWNB_ipd_last_value;
  reg        forceb_0;
  integer    res_post_resetc1;
  integer    fes_post_resetc1;
  integer    res_post_resetc0;
  integer    fes_post_resetc0;
  reg        WIN_last_value;
  reg        POWERDOWNC_ipd_last_value;
  reg        forcec_0;
  reg        internal_lock;
  time       fin_period;
  reg        locked_fin_last_value;
  time       extfbin_fin_drift;
  time       fin_last_re;
  reg        locked;
  reg        dly_locked;
  reg        final_lock;
   reg 	     vcoout_int;  
  reg        vco0_divu;
  reg        vco0_divv;
  reg        vco0_divw;
  reg       vco180;
  integer    locked_vco_edges;
  integer    CLKA_num_re_stable;
  integer    core_config;
  integer    core_config_last_value;
  reg        CLKA_ipd_last_value;
  reg        INTFB_last_value;
  reg        INTFB_period_stable;
   time      INTFB_period=0;
   time      INTFB_re;
  integer    INTFB_num_re_stable=-1;
  reg        EXTFB_last_value;
  reg        EXTFB_period_stable;
   time      EXTFB_period=0;
   time      EXTFB_re;
  integer    EXTFB_num_re_stable=-1;  

  reg        fin;
  reg        CLKA_period_stable;

  reg        extfb_dly_dtrmd;
  time       GLA_pw;

  time       internal_fb_delay;
  time       external_fb_delay;
   time      fb_delay;  

  integer    fin_num_CLKA_re;
  time       EXTFB_CLKA_edge;
  time       num_freerun_edges;
   time      internal_fb_re;
   time      external_fb_re;
     time      clka_fb_re;
   time      vco_re;
   reg 	     start_pll;
  reg 	  intfb_dly_dtrmd=0;
   reg 	  GLA_free_running;
  
  function output_mux_driver;
    input [ 2 : 0 ] outmux;
    input           halved;
    input           bypass;
    input           bypass2x;
    input           vco;
    begin
       case ( outmux )
             1  : if ( 1'b1 === halved )
                     output_mux_driver = bypass2x;
                  else if ( 1'b0 === halved )
                     output_mux_driver = bypass;
                  else
                     output_mux_driver = 1'bx;
             2  : output_mux_driver = vco;
             4  : output_mux_driver = vco;
             5  : output_mux_driver = vco;
             6  : output_mux_driver = vco;
             7  : output_mux_driver = vco;
        default : output_mux_driver = 1'bx;
     endcase
     end
  endfunction

    buf    U0 ( CLKA_ipd, CLKA ); // Add SDF PORT delay
  buf    U1 ( EXTFB_ipd, EXTFB ); // Add SDF PORT delay
  buf    U2 ( INTFB_ipd, INTFB ); // Add SDF PORT delay
  buf    U3 ( POWERDOWN_ipd, POWERDOWN ); // Add SDF PORT delay

   wire [6:0] 	  FBDIV = {  FBDIV6, FBDIV5, FBDIV4, FBDIV3,
			     FBDIV2, FBDIV1, FBDIV0 };

   wire [6:0] 	  FINDIV = { FINDIV6, FINDIV5, FINDIV4, FINDIV3,
			     FINDIV2, FINDIV1, FINDIV0 };

   wire [4:0] 	  OADIV = {  OADIV4, OADIV3,
			     OADIV2, OADIV1, OADIV0 };  

   wire [4:0] 	  OBDIV = {  OBDIV4, OBDIV3,
			     OBDIV2, OBDIV1, OBDIV0 };

   wire [4:0] 	  OCDIV = {  OCDIV4, OCDIV3,
			     OCDIV2, OCDIV1, OCDIV0 };

   wire [2:0] 	  OAMUX = { OAMUX2, OAMUX1, OAMUX0};
   wire [2:0] 	  OBMUX = { OBMUX2, OBMUX1, OBMUX0};
   wire [2:0] 	  OCMUX = { OCMUX2, OCMUX1, OCMUX0};
   wire [2:0] 	  VCOSEL = { VCOSEL2, VCOSEL1, VCOSEL0};
   wire [1:0] 	  FBSEL = { FBSEL1, FBSEL0};

  localparam PLL_pw_param = 1000.0 * 1000.0 / (VCOFREQUENCY * 2.0);  


  wire using_EXTFB = ( FBSEL1 & FBSEL0 );
  wire using_INTFB = ( FBSEL1 ^ FBSEL0 );  
  assign  LOCKOUT = final_lock;
  assign VCOOUT = vcoout_int;

  always @ ( FBDIV )
  begin
    DIVM = FBDIV + 1;
  end


  always @ ( FINDIV )
  begin
    DIVN <= FINDIV + 1;
  end

  always @ ( OADIV )
  begin
    DIVU <= OADIV + 1;
  end

  always @ ( OBDIV )
  begin
    DIVV <= OBDIV + 1;
  end

  always @ ( OCDIV )
  begin
    DIVW <= OCDIV + 1;
  end
  
  // Check FBSEL
  always @( FBSEL or OAMUX or OBMUX or OCMUX or DIVM or DIVU or DIVN or CLKA_period_stable or PLLCLK_period or external_fb_delay )
  begin
     if ( 1'bx === ^FBSEL ) begin
        FBSEL_illegal <= 1'b1;
        $display( " ** Warning: FBSEL is unknown." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
     end else if ( 2'b00 === FBSEL ) begin // Grounded.
        FBSEL_illegal <= 1'b1;
        $display( " ** Warning: Illegal FBSEL configuration 00." );
        $display( " Time: %0.1f Instance: %m ", $realtime );
     end else if ( 2'b11 === FBSEL ) begin // External feedback
        if ( 2 >  OAMUX ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Warning: Illegal configuration. GLA cannot be in bypass mode (OAMUX = 000 or OAMUX = 001) when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( DIVM < 5 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: FBDIV must be greater than 4 when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( DIVM * DIVU ) > 232 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Product of FBDIV and OADIV must be less than 233 when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( DIVN % DIVU ) != 0 ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Division factor FINDIV must be a multiple of OADIV when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else if ( ( 1'b1 === CLKA_period_stable ) && ( 1'b1 === extfb_dly_dtrmd ) &&
                ( ( 1 < OBMUX ) || ( 1 < OCMUX ) ) &&
                ( ( external_fb_delay >= CLKA_period ) || ( external_fb_delay >= PLLCLK_period ) ) ) begin
           FBSEL_illegal <= 1'b1;
           $display( " ** Error: Total sum of delays in the feedback path must be less than 1 VCO period AND less than 1 CLKA period when V and/or W dividers when using external feedback (FBSEL = 11)." );
           $display( " Time: %0.1f Instance: %m ", $realtime );
        end else begin
           FBSEL_illegal <= 1'b0;
        end
     end else begin
        FBSEL_illegal <= 1'b0;
     end
  end 

  // Generate fin
  // Mimicing silicon - no need for a 50/50 duty cycle and this way fin only changes on rising edge of CLKA (except when DIVN is 1)
  // Uses prefix fin for registers used locally
  always @( CLKA_ipd )
  begin
     if ( 1'bx === CLKA_ipd ) begin
        fin_num_CLKA_re = -1;
     end else if ( 1 == DIVN ) begin
        fin = CLKA;
     end else if ( 1'b1 === CLKA_ipd ) begin
        fin_num_CLKA_re = fin_num_CLKA_re + 1;
	 if ( 0 == ( fin_num_CLKA_re % DIVN  ) ) begin
	     fin = 1'b1;
	     start_pll = 1;
	     fin_num_CLKA_re = 0;
        end else if ( 1 == ( fin_num_CLKA_re % DIVN  ) ) begin
           fin = 1'b0;
        end
     end
  end
//Generate VCOOUTPUT
  always
      begin
	  wait (start_pll === 1'b1);
	  vcoout_int = 1'b1;
	 //#PLL_pw_param test_clk = 1'b1;
	 #PLL_pw_param vcoout_int = 1'b0;
	  #PLL_pw_param;	  
      end // always @ (start_pll)

  always @(INTFB_ipd or POWERDOWN_ipd)
      begin
	  if ( POWERDOWN_ipd === 1'b0 ) begin
	      INTFB_num_re_stable = -1;
	      INTFB_period_stable = 1'b0;
	  end
	  else if ( INTFB_last_value !== INTFB_ipd ) begin	      
	      INTFB_last_value <= INTFB_ipd;
	      if ( INTFB_ipd === 1'b1 ) begin
		  if ( INTFB_period != ( $time - INTFB_re ) ) begin
		      INTFB_period <= $time - INTFB_re;
		      INTFB_num_re_stable <= -1;
		      INTFB_period_stable <= 1'b0;
		  end 
		  else begin
		      if ( 3 > INTFB_num_re_stable )
			  INTFB_num_re_stable <= INTFB_num_re_stable + 1;
		      else if ( 3 == INTFB_num_re_stable )
			  INTFB_period_stable <= 1'b1;
		  end
		  INTFB_re <= $time;
	      end 
	  end // if ( INTFB_last_value !== INTFB_ipd )	  
	  else if ( INTFB_period < ( $time - INTFB_re ) ) begin
	      INTFB_num_re_stable <= -1;
	      INTFB_period_stable <= 1'b0;
	  end 
      end // always
  //  
//Calculate delay between INTFB and VCOOUT. This is internal feedback delay
  always @(INTFB_period_stable)
      begin
	  	  intfb_dly_dtrmd = 0;
	  wait (INTFB_period_stable === 1)
	      @(posedge vcoout_int)
	      vco_re = $time;
	  @(posedge INTFB_ipd)
		  internal_fb_re = $time;
	  internal_fb_delay = internal_fb_re - vco_re;
	  if (internal_fb_delay == INTFB_period)
	      internal_fb_delay = 0;	  
	  intfb_dly_dtrmd = 1;
	  
      end // always begin
  
  always @(EXTFB_ipd or POWERDOWN_ipd)
      begin
	  if ( POWERDOWN_ipd === 1'b0 ) begin
	      EXTFB_num_re_stable = -1;
	      EXTFB_period_stable = 1'b0;
	  end
	  else if ( EXTFB_last_value !== EXTFB_ipd ) begin	      
	      EXTFB_last_value <= EXTFB_ipd;
	      if ( EXTFB_ipd === 1'b1 ) begin
		  if ( EXTFB_period != ( $time - EXTFB_re ) ) begin
		      EXTFB_period <= $time - EXTFB_re;
		      EXTFB_num_re_stable <= -1;
		      EXTFB_period_stable <= 1'b0;
		  end 
		  else begin
		      if ( 3 > EXTFB_num_re_stable )
			  EXTFB_num_re_stable <= EXTFB_num_re_stable + 1;
		      else if ( 3 == EXTFB_num_re_stable )
			  EXTFB_period_stable <= 1'b1;
		  end
		  EXTFB_re <= $time;
	      end 
	  end // if ( EXTFB_last_value !== EXTFB_ipd )	  
	  else if ( EXTFB_period < ( $time - EXTFB_re ) ) begin
	      EXTFB_num_re_stable <= -1;
	      EXTFB_period_stable <= 1'b0;
	  end 
      end // always
  //   
  //
  //Calculate delay between EXTFB and CLKA. This is external feedback delay
  always 
      begin
	  	  extfb_dly_dtrmd = 0;
	  wait (CLKA_period_stable === 1 && using_EXTFB === 1);
	  
//	  if (CLKA_period_stable === 1 && using_EXTFB === 1) begin
	      @(posedge CLKA_ipd)
	      clka_fb_re = $time;
	  @(posedge EXTFB_ipd)
		  external_fb_re = $time;
	  external_fb_delay = external_fb_re - clka_fb_re;
	  if (external_fb_delay == (2.0 * PLL_pw_param) ||
	      external_fb_delay == CLKA_period)
	      external_fb_delay = 0;	  
	  extfb_dly_dtrmd = 1;
	      @(negedge dly_locked);
	      
//	      end
      end // always begin
  always @(external_fb_delay, internal_fb_delay)
      begin
	  if (using_EXTFB === 1)
	      fb_delay = external_fb_delay;
	  else
	      fb_delay = internal_fb_delay;
      end
	    
  wire fb_dly_dtrmd = using_EXTFB ? extfb_dly_dtrmd : intfb_dly_dtrmd;
  always @ ( fb_delay or DIVN or DIVM )
  begin
    core_config = core_config + 1;
  end
  
  // Calculate CLKA period and establish internal lock
  always @ ( CLKA_ipd or POWERDOWN_ipd or FBSEL_illegal or core_config or locked_vco_edges )
    // locked_vco_edges is in the sensitivity list so that we periodically check for CLKA stopped.
  begin
    if ( ( POWERDOWN_ipd === 1'b1 ) && ( FBSEL_illegal === 1'b0 ) ) begin
      if ( ( core_config != core_config_last_value ) || fb_dly_dtrmd == 0 
            ) begin
        internal_lock <= 1'b0;
        CLKA_num_re_stable <= -1;
        core_config_last_value <= core_config;
      end
      if ( CLKA_ipd_last_value !== CLKA_ipd ) begin
        CLKA_ipd_last_value <= CLKA_ipd;
        if ( CLKA_ipd === 1'b1 ) begin
          if ( CLKA_period != ( $time - CLKA_re ) ) begin
             CLKA_period <= $time - CLKA_re;
             CLKA_num_re_stable <= -1;
             internal_lock <= 1'b0;
             CLKA_period_stable <= 1'b0;
          end else begin
            if ( f_CLKA_LOCK > CLKA_num_re_stable ) begin
               CLKA_num_re_stable <= CLKA_num_re_stable + 1;
            end else if ( f_CLKA_LOCK <= CLKA_num_re_stable
			  && fb_dly_dtrmd === 1) begin
               internal_lock <= 1'b1;
            end
            CLKA_period_stable <= 1'b1;
          end
          CLKA_re <= $time;
        end
      end else if ( CLKA_period < ( $time - CLKA_re ) ) begin
        CLKA_num_re_stable <= -1;
        internal_lock <= 1'b0;
        CLKA_period_stable <= 1'b0;
      end
    end else begin
      CLKA_num_re_stable <= -1;
      internal_lock <= 1'b0;
      CLKA_period_stable <= 1'b0;
    end
  end

  always @( CLKA_period_stable or CLKA_period or DIVN )
  begin
    if ( CLKA_period_stable) begin
      fin_period <= CLKA_period * ( DIVN * 1.0 );
    end
  end

  always @( PLLCLK_pw or DIVU )
  begin
    GLA_pw <= PLLCLK_pw * ( DIVU * 1.0 );
  end

  always @( GLA_pw or DIVM or fin_period )
  begin
    extfbin_fin_drift <= ( GLA_pw * DIVM * 2.0 ) - fin_period;
  end

  always @( fin_period or fb_loop_div )
  begin
    PLLCLK_period <= fin_period / ( fb_loop_div * 1.0 );
    PLLCLK_pw     <= fin_period / ( fb_loop_div * 2.0 );
  end

  // Calculate feedback loop divider
  always @( DIVM or DIVU or using_EXTFB )
  begin
     if ( 1'b1 === using_EXTFB ) begin
        fb_loop_div <= DIVM * DIVU; 
     end else begin
        fb_loop_div <= DIVM;
     end        
  end   


    // Generated locked
  // Uses prefix locked for internal registers
  always @( fin or internal_lock)
  begin
    if (  1'b0 === internal_lock  ) begin
      locked <= 1'b0;  
	final_lock <= 1'b0;     
    end else if ( ( 1'b1 === fin ) && ( 1'b0 === locked_fin_last_value ) ) begin
      locked <= 1'b1;
//	final_lock <= locked;	
    end
    locked_fin_last_value <= fin;
  end

  always @(POWERDOWN_ipd, posedge CLKA_ipd)
      begin
	  if (POWERDOWN_ipd == 0)
	      final_lock <= 1'b0;
	  else if (CLKA_ipd == 1'bx)
	      final_lock <= 1'b0;
	  else	      
	      final_lock <= locked;
      end // always @ (posedge CLKA_ipd)
  
  // Use vco180 to count locked edges since it will have all edges delayed from locked by uniform PLLCLK_pw.
  // Initial edge count is set to 0 by locked rising (below).
  // Need inertial delay
//  assign # PLLCLK_pw vco180 = ( locked === 1'b1 ) ? ~vco180 : 1'b0;

    always 
	begin
	    if (dly_locked !== 1'b1)
		vco180 = 0;	    
	  wait (dly_locked === 1'b1);
	  vco180 = 1'b0;
	 #PLLCLK_pw vco180 = 1'b1;
	  #PLLCLK_pw;	  
      end // always begin


//  assign # PLLCLK_pw vco180 = (dly_locked == 1) ? ~vco180 : 1'b0;
  
always @(locked)
    begin
	dly_locked <= #(CLKA_period - fb_delay) locked;
    end // always @ (locked)

  always @ ( vco180 )
  begin
    if ( ( locked_vco_edges % ( DIVU * DIVV * DIVW * DIVM * 2 ) ) == 0 ) begin
      locked_vco_edges <= 1;
    end else begin
      locked_vco_edges <= locked_vco_edges + 1;
    end
  end

  always @ ( dly_locked )
  begin
    if ( locked === 1'b1 ) begin
      assign locked_vco_edges = 0;
      deassign locked_vco_edges;
    end else begin
      assign locked_vco_edges = -1;
    end
  end

  always @ ( locked_vco_edges )
      begin
	  if ( locked_vco_edges == -1 ) begin
       vco0_divu <= 1'b0;
       vco0_divv <= 1'b0;
       vco0_divw <= 1'b0;
    end else begin
       if ( ( locked_vco_edges % DIVU ) == 0 ) begin
         vco0_divu <= ~vco0_divu;
       end
       if ( ( locked_vco_edges % DIVV ) == 0 ) begin
         vco0_divv <= ~vco0_divv;
       end
       if ( ( locked_vco_edges % DIVW ) == 0 ) begin
         vco0_divw <= ~vco0_divw;
       end
    end
  end

  assign UIN = output_mux_driver(  OAMUX, 1'b0, CLKA_ipd, CLKA2X, vco0_divu );
  assign VIN = output_mux_driver(  OBMUX, 1'b0, 1'b0, 1'b0, vco0_divv );
  assign WIN = output_mux_driver(  OCMUX, 1'b0, 1'b0, 1'b0, vco0_divw );


  // Generate doubled CLKA
  // Uses prefix CLKA2X for internal registers
  always @( CLKA_ipd )
  begin
    if ( 1'b1 === CLKA_ipd ) begin
      CLKA2X_CLKA_period = $time - CLKA2X_CLKA_re;
      CLKA2X_CLKA_re = $time;
      if ( CLKA2X_CLKA_period > 0 ) begin
        CLKA2X <= 1'b1;
        CLKA2X <= # ( CLKA2X_CLKA_period / 4.0 ) 1'b0;
        CLKA2X <= # ( CLKA2X_CLKA_period / 2.0 ) 1'b1;
        CLKA2X <= # ( CLKA2X_CLKA_period * 3.0 / 4.0 ) 1'b0;
      end
    end
  end // always @ ( CLKA_ipd )


    // AOUT Output of Divider U
  always @ ( UIN or CLKA_ipd or POWERDOWN_ipd )
  begin
  
    if ( OAMUX === 3'b001 ) begin
    
      // PLL core bypassed.  OADIVRST active.

      if ( CLKA_ipd !== AOUT_CLKA_last_value ) begin
        if ( ( CLKA_ipd === 1'b1 ) && ( AOUT_CLKA_last_value === 1'b0 ) ) begin
          if ( 4 > res_post_reseta1 ) begin
            res_post_reseta1 = res_post_reseta1 + 1;
          end
          if ( 4 > res_post_reseta0 ) begin
            res_post_reseta0 = res_post_reseta0 + 1;
          end
          if ( res_post_reseta1 == 3 ) begin
            forcea_0 = 1'b0;
            A_num_edges = -1;
          end
        end else if ( ( CLKA_ipd === 1'b0 ) &&
		      ( AOUT_CLKA_last_value === 1'b1 ) ) begin
          if ( 4 > fes_post_reseta1 ) begin
            fes_post_reseta1 = fes_post_reseta1 + 1;
          end
          if ( 4 > fes_post_reseta0 ) begin
            fes_post_reseta0 = fes_post_reseta0 + 1;
          end
          if ( fes_post_reseta1 == 1 ) begin
            forcea_0 = 1'b1;
          end
        end
        AOUT_CLKA_last_value = CLKA;
      end
 
      if ( UIN !== UIN_last_value ) begin
	  A_num_edges = A_num_edges + 1;
	  if ( forcea_0 === 1'b1 )
	      AOUT <= 1'b0;
	  else if ( UIN === 1'bx )
	      AOUT <= 1'bx;
	  else if ( ( A_num_edges % DIVU ) == 0 ) begin
	      if ( AOUT === 1'bx )
		  AOUT <= UIN;
	      else
		  AOUT <= !AOUT;	      
	  end
      end
    end // if ( OAMUX === 3'b001 )      
     else if ( ( UIN !== UIN_last_value ) ||
	      ( POWERDOWN_ipd !== POWERDOWNA_ipd_last_value ) ) begin
		  // PLL core not bypassed.  OADIVRST inactive.
		  if ( POWERDOWN_ipd === 1'b0 )
		      AOUT <= 1'b0;
       else if ( POWERDOWN_ipd === 1'b1 )
         AOUT <= UIN;
       else  // POWERDOWN unknown
        AOUT <= 1'bx;     
    end

    if ( UIN !== UIN_last_value )
       UIN_last_value = UIN;

    if ( POWERDOWN_ipd !== POWERDOWNA_ipd_last_value )
       POWERDOWNA_ipd_last_value = POWERDOWN_ipd;
  
  end


  //
  // BOUT Output of Divider V

  always @ ( VIN or POWERDOWN_ipd )
  begin
  
    if ( OBMUX === 3'b000 )
	BOUT <= 1'bx;
      else if ( OBMUX === 3'b001 ) begin    
	  if ( VIN !== VIN_last_value ) begin
	      B_num_edges = B_num_edges + 1;
	      if ( forceb_0 === 1'b1 )
		  BOUT <= 1'b0;
	      else if ( VIN === 1'bx )
		  BOUT <= 1'bx;
	      else if ( ( B_num_edges % DIVV ) == 0 ) begin
		  if ( BOUT === 1'bx )
		      BOUT <= VIN;
		  else
		      BOUT <= !BOUT;
	      end // if ( ( B_num_edges % DIVV ) == 0 )
	      
	  end // if ( VIN !== VIN_last_value )	
      end // if ( OBMUX === 3'b001 )      
      else if ( ( VIN !== VIN_last_value )
		|| ( POWERDOWN_ipd !== POWERDOWNB_ipd_last_value ) ) begin
		    if ( POWERDOWN_ipd === 1'b0 )
			BOUT <= 1'b0;
		    else if ( POWERDOWN_ipd === 1'b1 )
			BOUT <= VIN;
		    else 
			BOUT <= 1'bx;
		end       
      if ( VIN !== VIN_last_value )
	  VIN_last_value = VIN;
      if ( POWERDOWN_ipd !== POWERDOWNB_ipd_last_value )
	  POWERDOWNB_ipd_last_value = POWERDOWN_ipd;
      
  end // always @ ( VIN or POWERDOWN_ipd )
  
////
  always @ ( WIN or POWERDOWN_ipd )
  begin
  
    if ( OCMUX === 3'b000 )
	COUT <= 1'bx;
      else if ( OCMUX === 3'b001 ) begin    
	  if ( WIN !== WIN_last_value ) begin
	      C_num_edges = C_num_edges + 1;
	      if ( forcec_0 === 1'b1 )
		  COUT <= 1'b0;
	      else if ( WIN === 1'bx )
		  COUT <= 1'bx;
	      else if ( ( C_num_edges % DIVV ) == 0 ) begin
		  if ( COUT === 1'bx )
		      COUT <= WIN;
		  else
		      COUT <= !COUT;
	      end // if ( ( C_num_edges % DIVV ) == 0 )
	      
	  end // if ( WIN !== WIN_last_value )	
      end // if ( OCMUX === 3'b001 )      
      else if ( ( WIN !== WIN_last_value )
		|| ( POWERDOWN_ipd !== POWERDOWNC_ipd_last_value ) ) begin
		    if ( POWERDOWN_ipd === 1'b0 )
					COUT <= 1'b0;
		    else if ( POWERDOWN_ipd === 1'b1 )
			COUT <= WIN;
		    else 
			COUT <= 1'bx;
		end       
      if ( WIN !== WIN_last_value )
	  WIN_last_value = WIN;
      if ( POWERDOWN_ipd !== POWERDOWNC_ipd_last_value )
	  POWERDOWNC_ipd_last_value = POWERDOWN_ipd;
      
  end // always @ ( WIN or POWERDOWN_ipd )
  
  // Generate GLA directly from CLA, includes drift adjustment so everything syncs up when PLL is locked

/*
  always
  begin
      wait (start_pll === 1'b1);
      GLA_free_running = CLKA_ipd;      
      
      
      if ( ( num_freerun_edges % ( DIVM * 2 ) ) == 0 ) begin
	  GLA_free_running = # ( GLA_pw - extfbin_fin_drift ) 1'b0;
	  num_freerun_edges = 0;
      end else
	  GLA_free_running = # GLA_pw 1'b0;
      num_freerun_edges = num_freerun_edges + 1;
      # GLA_pw;      
 
  end
*/
  // GLAOUT
  always @ ( AOUT or CLKA_ipd or OAMUX )
  begin
    if ( 3'b000 === OAMUX ) begin
      GLAOUT <=  CLKA_ipd;
      A_num_edges <= -1;
    end else if ( ( 3'b001 === OAMUX ) || ( 3'b011 === OAMUX ) ) begin
      GLAOUT <= 1'bx;
    end else if (fb_dly_dtrmd == 0 && using_EXTFB == 1)
        GLAOUT <=  CLKA_ipd;
      else begin
          GLAOUT <=  AOUT;
    end
  end

  // GLB and YB
  always @ ( BOUT or OBMUX )
  begin
    if ( (3'b000 === OBMUX) || ( 3'b001 === OBMUX ) ||
	 ( 3'b011 === OBMUX ) ) begin
      GLBOUT <=  1'bx;
      YBOUT  <=   1'bx;
    end else begin
      GLBOUT <= BOUT;
      YBOUT  <=  BOUT;
    end
  end

  // GLC and YC
  always @ ( COUT or OCMUX )
  begin
    if ( (3'b000 === OCMUX) || ( 3'b001 === OCMUX ) || ( 3'b011 === OCMUX ) ) begin
      GLCOUT <=  1'bx;
      YCOUT  <=  1'bx;
    end else begin
      GLCOUT <=  COUT;
      YCOUT  <=   COUT;
    end
  end
  
  // Get EXTFB period, rising edge, and falling edge
    initial
  begin
  
    PLLCLK = 1'bx;
    CLKA_re = 0;
    DivVal = 0;
    DivVal1 = 0;
    DivVal2 = 0;
    DivVal3 = 0;
    DivVal4 = 0;
    CLKA_period = 0;
    AOUT = 1'bx;
    A_num_edges = -1;
    UIN_num_res = 0;
    UIN_num_fes = 0;
    BOUT = 1'bx;
    B_num_edges = -1;
    VIN_num_res = 0;
    VIN_num_fes = 0;
    COUT = 1'bx;
    C_num_edges = -1;
    WIN_num_res = 0;
    WIN_num_fes = 0;
    FBSEL_illegal = 0;
    UIN_re = 0;
    UIN_prev_re = 0;
    UIN_period = 0;
    VIN_re = 0;
    VIN_prev_re = 0;
    VIN_period = 0;
    WIN_re = 0;
    WIN_prev_re = 0;
    WIN_period = 0;

    RESET1 = 1'b1;
    RESET2 = 1'b1;
    RESET3 = 1'b1;

    res_post_reseta1          = 0;
    fes_post_reseta1          = 0;
    res_post_reseta0          = 0;
    fes_post_reseta0          = 0;
    AOUT_CLKA_last_value      = 1'bx;
    UIN_last_value            = 1'bx;
    POWERDOWNA_ipd_last_value = 1'bx;
    forcea_0                  = 1'b1;
    res_post_resetb1          = 0;
    fes_post_resetb1          = 0;
    res_post_resetb0          = 0;
    fes_post_resetb0          = 0;
    VIN_last_value            = 1'bx;
    POWERDOWNB_ipd_last_value = 1'bx;
    forceb_0                  = 1'b1;
    res_post_resetc1          = 0;
    fes_post_resetc1          = 0;
    res_post_resetc0          = 0;
    fes_post_resetc0          = 0;
    WIN_last_value            = 1'bx;
    POWERDOWNC_ipd_last_value = 1'bx;
    forcec_0                  = 1'b1;
    PLLCLK_pw                 = 10000;
    PLLCLK_period             = 10000;
    internal_lock             = 1'b0;
    fin_period                = 0;
    fin_last_re               = 0;
    CLKA_num_re_stable        = -1;
    core_config               = 0;
    core_config_last_value    = -1;
    CLKA_ipd_last_value       = 1'bx;
    locked_vco_edges          = -1;

    CLKA2X                    = 1'bx;
    CLKA2X_CLKA_re            = 0;
    CLKA2X_CLKA_period        = 0;
    fin                       = 1'b0;
    CLKA_period_stable        = 1'b0;
    GLA_pw                    = 10000;
    EXTFB_period              = 20000;
    EXTFB_re                  = 0;
    internal_fb_delay         = 0;
    external_fb_delay         = 0;
    fin_num_CLKA_re           = -1;
    fb_loop_div               = 1;
    locked_fin_last_value     = 1'bx;
    EXTFB_CLKA_edge           = 0;
  end

endmodule
//***********************************************************************
//***********************************************************************
// Detailed Revision History:
//
// Rev. Date(MM/DD/YY)   Submitter              Description
//
// 1.0  10/08/09         Kiran Yerribandi     First Version
// 

/*--------------------------------------------------------------------
 CELL NAME : PLL_DLY_SDF
--------------------------------------------------------------------*/
`timescale 1 ps / 1 ps
module PLL_DLY_SDF(GLAIN, GLBIN, GLCIN,
		   YBIN, YCIN, VCOIN, LOCKIN, EXTFBIN,
		   GLA, GLB, GLC,
		   YB, YC, PLLOUT, LOCK, EXTFBOUT
		   );
  
   input GLAIN, GLBIN, GLCIN;
   input YBIN, YCIN, VCOIN, LOCKIN, EXTFBIN;
   output  GLA, GLB, GLC;
   output  YB, YC, PLLOUT, LOCK, EXTFBOUT;
   parameter VCOFREQUENCY = 0.0;

  buf glabuf(GLA, GLAIN);
  buf glbbuf(GLB, GLBIN);
  buf glcbuf(GLC, GLCIN);
  buf ybbuf(YB, YBIN);
  buf ycbuf(YC, YCIN);
  buf lockbuf(LOCK, LOCKIN);
  buf pllbuf (PLLOUT, VCOIN);
  buf extfbbuf(EXTFBOUT, EXTFBIN);
  
 
specify
   
    ( GLAIN => GLA ) = (0.1:0.1:0.1);
    specparam PATHPULSE$GLAIN$GLA = (0.0, 0.0);

    ( GLBIN => GLB ) = (0.1:0.1:0.1);
    specparam PATHPULSE$GLBIN$GLB = (0.0, 0.0);

    ( GLCIN => GLC ) = (0.1:0.1:0.1);
    specparam PATHPULSE$GLCIN$GLC = (0.0, 0.0);

    ( YBIN => YB ) = (0.1:0.1:0.1);
    specparam PATHPULSE$YBIN$YB = (0.0, 0.0);

    ( YCIN => YC ) = (0.1:0.1:0.1);
    specparam PATHPULSE$YCIN$YC = (0.0, 0.0);

    ( LOCKIN => LOCK ) = (0.1:0.1:0.1);
    specparam PATHPULSE$LOCKIN$LOCK = (0.0, 0.0);

    ( VCOIN => PLLOUT ) = (0.1:0.1:0.1);   
    specparam PATHPULSE$VCOIN$PLLOUT = (0.0, 0.0);

    ( EXTFBIN => EXTFBOUT ) = (0.1:0.1:0.1);
    specparam PATHPULSE$EXTFBIN$EXTFBOUT = (0.0, 0.0); 
endspecify


endmodule // PLL_DLY_SDF
