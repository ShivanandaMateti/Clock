module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output reg [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'h9);
    assign ena[2] = (q[7:0] == 8'h99);
    assign ena[3] = (q[11:0] == 12'h999);
    
    bcd_counter  D0 (clk,reset,1'd1,q[3:0]);
    bcd_counter  D1 (clk,reset,ena[1],q[7:4]);
    bcd_counter  D2 (clk,reset,ena[2],q[11:8]);
    bcd_counter  D3 (clk,reset,ena[3],q[15:12]);

endmodule

module bcd_counter (
					input clk,
					input reset,
					input enable,
    				output reg [3:0] q
					);
    
    always@(posedge clk)begin
        if(reset)
            q <= 4'd0;
        else
            begin
            	if(enable)
                	begin
                    	if(q == 4'd9)
                        	q <= 4'd0;
                    	else
                        	q <= q + 4'd1;
                	end
                else
                    q <= q;
            end
    end
endmodule
        
        
