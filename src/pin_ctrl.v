`default_nettype none

module pin_ctrl (

    // inputs
    input wire clk,
    input wire rst_n,
    input wire wr_en,
    input wire [7:0] wr_data,
    input wire [7:0] wr_mask,
    input wire [1:0] wr_sel,   // 00 = uo_out, 01 = uio_out, 10 = uio_oe, 11 = reserved

    // outputs
    output reg [7:0] uo_out,
    output reg [7:0] uio_out,
    output reg [7:0] uio_oe
);

  always @(posedge clk) begin
    if (!rst_n) begin
      uo_out <= 8'b00000000;
      uio_out <= 8'b00000000;
      uio_oe <= 8'b00000000;
    end
    else if (wr_en) begin
      case (wr_sel)
          2'b00: uo_out <= (uo_out & ~wr_mask) | (wr_data & wr_mask);
          2'b01: uio_out <= (uio_out & ~wr_mask) | (wr_data & wr_mask);
          2'b10: uio_oe <= (uio_oe & ~wr_mask) | (wr_data & wr_mask);
          default: ;
      endcase
    end
  end

endmodule
