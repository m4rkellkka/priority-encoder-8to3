`timescale 1ns / 1ps

// 8-to-3 Priority Encoder with Valid Signal
module priority_encoder_8to3 (
    input  wire [7:0] D, // 8-bit input
    output reg  [2:0] Y, // 3-bit encoded output
    output wire       V  // 1-bit valid signal
);

    // Valid signal is high if any input bit is 1
    // The bitwise OR reduction operator (|D) checks if there's at least one active bit
    assign V = |D;

    // Priority logic: find the highest active bit
    // Using an always block to define combinational logic
    always @(*) begin
        if      (D[7]) Y = 3'd7; // Highest priority
        else if (D[6]) Y = 3'd6;
        else if (D[5]) Y = 3'd5;
        else if (D[4]) Y = 3'd4;
        else if (D[3]) Y = 3'd3;
        else if (D[2]) Y = 3'd2;
        else if (D[1]) Y = 3'd1;
        else if (D[0]) Y = 3'd0; // Lowest priority
        else           Y = 3'd0; // Default case when no bit is active
    end

endmodule
