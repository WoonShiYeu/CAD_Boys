module Onesecclk (input clkin, rst ,output reg clk);
	reg [31:0] count;
	always @ (posedge clkin, posedge rst) 
	begin 
	if (rst==1) begin
			clk<=0; count<=0;
		end
		else begin 
	count<=count+1;
	if (count==25000000) begin clk<=~clk; count<=0;end
	end 
	end
endmodule 