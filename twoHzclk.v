module twoHzclk (input clkin, rst ,output reg clk);
	reg [25:0] count;
	always @ (posedge clkin, posedge rst) 
	begin 
	if (rst==1) begin
			clk<=0; count<=0;
		end
		else begin 
	count<=count+1;
	if (count==12500000) begin clk<=~clk; count<=0;end
	end 
	end
endmodule  


The 2 sec clock delay counter is an up counter with positive edge clkin and rst. The counter has 26 bits and total count of 12500000. By calculating the CPLD clock delay using the formula, the clock delay of the counter is 1 sec. The counter begins to count when the rst is set as 0, the count starts looping with increment by 1 until the count reach 12500000, then the counter will stop looping. After the count ends, the clkin will reset back into default which is 0.
