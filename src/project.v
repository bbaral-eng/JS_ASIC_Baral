/*
 * Copyright (c) 2024 Your Name
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

    reg tx; // transmit, current level of UART line 
    reg [8:0] baud_count; // bit positions 
    reg [3:0] bit_index;  // we need 10 bits to send a byte of data, index represented with 4 bits 
    
    
    always @(posedge clk) begin
      if (!rst_n)
        baud_count <= 9'd0;
      else if (baud_count == 9'd433)
        baud_count <= 9'd0;
      else
        baud_count <= baud_count + 9'd1;
    end
    
    wire bit_done = (baud_count == 9'd433);

    always @(posedge clk) begin
      if (!rst_n)
        bit_index <= 4'd0;
      else if (bit_done) begin
        if (bit_index == 4'd9)
          bit_index <= 4'd0;
        else
          bit_index <= bit_index + 4'd1;
      end
    end

    wire [9:0] frame = {1'b1, 8'b01000001, 1'b0};
    
    always @(posedge clk) begin 
        if (!rst_n)
            tx <= 1'b1;
        else 
            tx <= frame[bit_index];
    end 

    assign uo_out  = tx ? 8'b00010000 : 8'b00000000;  
    assign uio_out = 0;
    assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, 1'b0, ui_in, uio_in};

endmodule
