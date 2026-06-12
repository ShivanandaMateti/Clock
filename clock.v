module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    wire ena_h,ena_m_msb,ena_m_lsb,ena_s_msb;
    reg [4:0] count;
    
    // enables for seconds,minutes and hours hand;
    
    assign ena_m_msb = (ena && (mm[3:0] == 4'd9) && (ss==8'h59));
    assign ena_m_lsb = (ena && (ss==8'h59));
    assign ena_s_msb = (ena && (ss[3:0] == 4'd9));
    assign ena_h = (ena && (mm==8'h59) && (ss==8'h59));
    
    bcd_counter_9 seconds_lsb (clk,reset,ena,ss[3:0]);
    bcd_counter_5 seconds_msb (clk,reset,ena_s_msb,ss[7:4]);
    bcd_counter_9 minutes_lsb (clk,reset,ena_m_lsb,mm[3:0]);
    bcd_counter_5 minutes_msb (clk,reset,ena_m_msb,mm[7:4]);
    
    // for the hours hand
    
      always@(posedge clk)begin
        if(reset)
            	hh <= 8'h12;         
        else
            begin
                if(ena_h)
                    begin
                        if((hh == 8'h12))
                            	hh <= 8'h1;
                        else if(hh == 8'h9)
                            	hh <= 8'h10;
                        else
                            	hh <= hh + 8'h1;                         
                    end
                else
                    hh <= hh;
            end
      end
    
    // for AM and PM
    
    always@(posedge clk)
        begin
            if(reset)
                count <= 0;
            else if(ena_h)
                begin
                    count <= count + 5'd1;
                    if(count == 5'd23)
                        count <= 0;
                end
            else
                count <= count;
        end
            
    
    assign pm = (count < 5'd12) ? 1'b0 : 1'b1 ;
    
endmodule

// counter for counting lsb in minutes and hours 

module bcd_counter_9 (
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

// counter for counting msb in minutes and seconds
 
module bcd_counter_5 (
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
                        if(q == 4'd5)
                        	q <= 4'd0;
                    	else
                        	q <= q + 4'd1;
                	end
                else
                    q <= q;
            end
    end
endmodule
