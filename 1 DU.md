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
In datapath unit, the units of array instantiations written on the verilog module for the CPLD to execute all of the process of the multiplication game. In the keyboard instantiation, there are ans1 and ans2 function which represent the answers inserted by the user. The answer will be displayed on 7-segment LED display where ans0 is connected to ans0led, while ans1 is connected to ans1led. For the countdown instantiation, correct function indicates the correct answer is inserted, and lose function indicates the wrong answer is inserted. The cnt function is used to count the 20 second timer, and the marks function is the total score obtained by the user. The num1 and num2 are the correct answer preset in the system, both of them is connected to num1led and num2led function respectively and displayed on the LED board. In bin2bcd instantiation, the marks function is converted into BCD format which is represented by marksbcd function. After conversion, the marks1 and marks0 are displayed on the LED by connecting to marks1led and marks0led respectively. The timer1 and timer0 also converted into BCD format from function bcd to function timerbcd before being displayed on LED by connecting to timer1led and timer0led. When rst is set at 0, the values of num1 and num2 are generated and loaded into correctans register. Both of these values are the digit numbers for multiplication. Then the inserted values from the users are loaded into useranswer register, the first inserted value will be tenth decimals while the second inserted value will be one decimal. The correctcounter will loop five times to generate five multiplication questions. The timer will stop after the user key in the answer on the keypad. If the timer is up, the marks will automatically become zero and then proceed to the next question. After correctcounter finished looping, the total marks will be loaded and recorded in the marks register. The process of multiplication game is completed. 

