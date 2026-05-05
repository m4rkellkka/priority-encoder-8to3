`timescale 1ns / 1ps

module priority_encoder_8to3_tb;

    // Inputs
    reg [7:0] D;

    // Outputs
    wire [2:0] Y;
    wire V;

    // Instantiate the Unit Under Test (UUT)
    priority_encoder_8to3 uut (
        .D(D), 
        .Y(Y), 
        .V(V)
    );

    initial begin
        // Mandatory dump files for waveform analysis
        $dumpfile("waveform.vcd");
        $dumpvars(0, priority_encoder_8to3_tb);

        $display("Starting Simulation...");

        // 1. Test when no signals are active
        D = 8'b0000_0000;
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=0, V=0", $time, D, Y, V);

        // 2. Test single active signals (especially D[0])
        D = 8'b0000_0001; // Only D[0] is active
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=0, V=1", $time, D, Y, V);

        D = 8'b0000_0100; // Only D[2] is active
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=2, V=1", $time, D, Y, V);

        D = 8'b1000_0000; // Only D[7] is active
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=7, V=1", $time, D, Y, V);

        // 3. Test multiple signals active simultaneously (priority check)
        D = 8'b0000_0101; // D[2] and D[0] are active, D[2] should have priority
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=2, V=1", $time, D, Y, V);

        D = 8'b0001_1010; // D[4], D[3], D[1] are active, D[4] should have priority
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=4, V=1", $time, D, Y, V);

        D = 8'b1111_1111; // All signals active, D[7] should have priority
        #10;
        $display("Time=%0t | D=%b -> Y=%d, V=%b | Expected: Y=7, V=1", $time, D, Y, V);

        $display("Simulation Finished.");
        
        // Finish simulation
        #10;
        $finish;
    end
      
endmodule