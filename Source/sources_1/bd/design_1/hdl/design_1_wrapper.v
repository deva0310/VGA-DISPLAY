//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Thu Jan  7 15:23:43 2021
//Host        : LAPTOP-HHGORFUC running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk,
    locked_0,
    pclk);
  output clk;
  output locked_0;
  input pclk;

  wire clk;
  wire locked_0;
  wire pclk;

  design_1 design_1_i
       (.clk(clk),
        .locked_0(locked_0),
        .pclk(pclk));
endmodule
