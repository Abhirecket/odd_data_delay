`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 19:28:24
// Design Name: 
// Module Name: tb_odd_data_delay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// tb_odd_data_delay.v
`timescale 1ns/1ps

module tb_odd_data_delay;

    // Parameters
    localparam WIDTH = 8;

    // Signals
    reg clk;
    reg rst;
    reg  [WIDTH-1:0] din;
    wire [WIDTH-1:0] dout;

    // DUT instantiation
    odd_data_delay #(.WIDTH(WIDTH)) DUT (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    // Clock generation: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // init
        rst = 1;
        din = 0;

        // waveform dump (for Vivado, you’ll see in GUI, this is useful in other sims)
        $dumpfile("tb_odd_data_delay.vcd");
        $dumpvars(0, tb_odd_data_delay);

        // hold reset for 2 cycles
        repeat (6) @(posedge clk);
        rst = 0;

        // Apply a sequence of data
        din = 8'h11;
        @(posedge clk);
        din = 8'h22;
        @(posedge clk);
        din = 8'h33;
        @(posedge clk);
        din = 8'h44;
        @(posedge clk);
        din = 8'h55;
        @(posedge clk);
        din = 8'h66;
        @(posedge clk);

        // hold value
        din = 8'h77;
        @(posedge clk);
        din = 8'h0;
        repeat (1) @(posedge clk);

        // end sim
        $display("Simulation finished at %0t", $time);
        $finish;
    end

endmodule
