/*
 * Copyright (c) 2024 Biplove Baral
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_bbaral_eng_protocol_emulator (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output

    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

// pin control registers 
  wire       pc_wr_en   = 1'b0;
  wire [7:0] pc_wr_data = 8'b00000000;
  wire [7:0] pc_wr_mask = 8'b00000000;
  wire [1:0] pc_wr_sel  = 2'b00;

  pin_ctrl u_pin_ctrl (
      .clk     (clk),
      .rst_n   (rst_n),
      .wr_en   (pc_wr_en),
      .wr_data (pc_wr_data),
      .wr_mask (pc_wr_mask),
      .wr_sel  (pc_wr_sel),
      .uo_out  (uo_out),
      .uio_out (uio_out),
      .uio_oe  (uio_oe)
  );

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, 1'b0, ui_in, uio_in};

endmodule
