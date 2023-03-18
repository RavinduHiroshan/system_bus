//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Thu Mar 16 16:12:00 2023
//Host        : Hiroshan-Laptop running 64-bit major release  (build 9200)
//Command     : generate_target ram_wrapper.bd
//Design      : ram_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ram_wrapper
   (BRAM_PORTA_0_addr,
    BRAM_PORTA_0_clk,
    BRAM_PORTA_0_din,
    BRAM_PORTA_0_dout,
    BRAM_PORTA_0_en,
    BRAM_PORTA_0_rst,
    BRAM_PORTA_0_we,
    rsta_busy_0);
  input [12:0]BRAM_PORTA_0_addr;
  input BRAM_PORTA_0_clk;
  input [15:0]BRAM_PORTA_0_din;
  output [15:0]BRAM_PORTA_0_dout;
  input BRAM_PORTA_0_en;
  input BRAM_PORTA_0_rst;
  input [1:0]BRAM_PORTA_0_we;
  output rsta_busy_0;

  wire [12:0]BRAM_PORTA_0_addr;
  wire BRAM_PORTA_0_clk;
  wire [15:0]BRAM_PORTA_0_din;
  wire [15:0]BRAM_PORTA_0_dout;
  wire BRAM_PORTA_0_en;
  wire BRAM_PORTA_0_rst;
  wire [1:0]BRAM_PORTA_0_we;
  wire rsta_busy_0;

  ram ram_i
       (.BRAM_PORTA_0_addr(BRAM_PORTA_0_addr),
        .BRAM_PORTA_0_clk(BRAM_PORTA_0_clk),
        .BRAM_PORTA_0_din(BRAM_PORTA_0_din),
        .BRAM_PORTA_0_dout(BRAM_PORTA_0_dout),
        .BRAM_PORTA_0_en(BRAM_PORTA_0_en),
        .BRAM_PORTA_0_rst(BRAM_PORTA_0_rst),
        .BRAM_PORTA_0_we(BRAM_PORTA_0_we),
        .rsta_busy_0(rsta_busy_0));
endmodule
