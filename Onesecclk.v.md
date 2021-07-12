```
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

```
The 1 sec clock delay counter is an up counter with positive edge clkin and rst. The counter has 32 bits and total count of 25000000. By calculating the CPLD clock delay using the formula, the clock delay of the counter is 1 sec. The counter begins to count when the rst is set as 0, the count starts looping with increment by 1 until the count reach 25000000, then the counter will stop looping. After the count ends, the clkin will reset back into default which is 0.

Since the CPLD originally has 50MHz, the count is required to slow down the timer, hence the CPLD clock delay formula :

New clk=(CPLD clk)/(2*count)

New clk=50M/(2*count)
