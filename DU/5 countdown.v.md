```
module countdown(
input clk, rst, correct,
output reg [7:0] marks,
output reg lose,
output reg [7:0] cnt
 );
 
 always@(posedge rst, posedge clk) begin
	if(rst) begin cnt<=20; lose<=0;end
	else begin
	if(cnt==0) begin 
	cnt<=20;
	lose<=1;
	end
	else if (correct)
	cnt<=20;
	else
	cnt<=cnt-1;
	end
	end
	
	
always@ (posedge rst, posedge correct) begin
	if (rst) marks<=100;
	else
		marks<=marks-20+cnt;
	end
endmodule
```
The countdown verilog module is used to calculate and record the total marks of the multiplication game. The beginning total marks for each players are 100. There are 5 questions in total, the time limit for each questions is 20 seconds. The timer will start counting once the questions num1 and num2 are released. When rst is set at 1, the cnt will be loaded with 20 marks. If the answer inserted is wrong, the mark is 0 and this round is counted as a lose. If the answer inserted is correct, the maximum marks of 20 will subtract with the time usage for answering, then its the total marks of the user in that round. After five round of multiplication games, the total marks will be recorded. Hence, the higher scores indicates that the user is better in playing this game. 

				
				
