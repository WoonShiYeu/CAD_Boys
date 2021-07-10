# Datapath Unit (DU)

```
module DU (
	input clk,rst,clkin,
	input [3:0] num1,num2,
	inout [7:0] GPIO_1,
	output reg correct, finish,
	output lose,
	output [6:0] marks1led,marks0led,ans1led,ans0led,num1led,num2led,timer1led,timer0led
); 

reg [7:0] marks, correctans, useranswer,timer;
wire [3:0] ans1,ans0,marks1,marks0,timer1,timer0;
wire [7:0] markshold, marksbcd,timerbcd,cnt;
reg [2:0] correctcounter;

keyboard u1 (.GPIO_1(GPIO_1), .clkin(clkin), .ans0(ans0), .ans1(ans1));
bcd7segDECcathode u2 (.bcd(ans0), .led(ans0led));
bcd7segDECcathode u3 (.bcd(ans1), .led(ans1led));
countdown u4(.clk(clk), .rst(rst), .correct(correct), .cnt(cnt), .marks(markshold), .lose(lose));
bcd7segDECcathode u5 (.bcd(num1), .led(num1led));
bcd7segDECcathode u6 (.bcd(num2), .led(num2led));
bin2bcd u7 (.bin(marks), .bcd1(marksbcd));
assign marks1={marksbcd[7:4]};
assign marks0={marksbcd[3:0]};
bcd7segDECcathode u8 (.bcd(marks1), .led(marks1led));
bcd7segDECcathode u9 (.bcd(marks0), .led(marks0led));
bin2bcd u10 (.bin(timer), .bcd1(timerbcd));
assign timer1={timerbcd[7:4]};
assign timer0={timerbcd[3:0]};
bcd7segDECanode u11 (.bcd(timer1), .led(timer1led));
bcd7segDECanode u12 (.bcd(timer0), .led(timer0led));

always @ (posedge rst, posedge clk) begin
	if (rst) begin correctans<=0; correct<=0; correctcounter<=0; finish=0; marks=0; end
	else begin
		correctans=num1*num2;
		useranswer=(ans1*10)+ans0;
		correct=0;
		timer<=cnt;
		if (useranswer==correctans) begin
			correct<=1; 
			correctcounter<=correctcounter+1;
			end
			else
			correct<=0;
		if (correctcounter==5)
		begin
			finish<=1;
			marks<=markshold;
			timer<=0;
		end
		if (lose==1) begin
			correctcounter<=0;
			correctans<=0;
			timer<=0;
			end
		end
	end

endmodule
```
