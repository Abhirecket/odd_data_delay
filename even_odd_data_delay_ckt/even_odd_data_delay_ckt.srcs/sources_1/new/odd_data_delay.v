`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 19:13:54
// Design Name: 
// Module Name: odd_data_delay
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


module odd_data_delay #(
    parameter WIDTH = 8    // default width = 8 bits
)(
    input  wire              clk,     // clock
    input  wire              rst,     // synchronous active-high reset
    input  wire [WIDTH-1:0]  din,     // data input
    output wire  [WIDTH-1:0]  dout     // data output (delayed by 1 cycle)
);
    reg [WIDTH-1:0] dout_q;
    wire [WIDTH-1:0] mux;
    
    
    // ping pong enable logic
    reg ping_q;
    wire ping_w;
    always @(posedge clk) begin
        if (rst)
            ping_q <= {WIDTH{1'b0}};   
        else
            ping_q <= ping_w;          
    end
    
    assign ping_w = ~ ping_q;
    
    
    
    
  
    
    //mux logic
   
    assign mux = ping_q ? dout_q : din;
    
    // even data flop logic
    always @(posedge clk) begin
        if (rst)
            dout_q <= {WIDTH{1'b0}};   // reset clears flop
        else
            dout_q <= mux;             // capture input
    end

    
    //output logic 
    
    assign dout = ping_q ? din : dout_q;
    
    
endmodule
