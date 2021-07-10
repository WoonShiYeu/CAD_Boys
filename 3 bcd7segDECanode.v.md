```
module bcd7segDECanode(
	input [3:0] bcd,
	output reg [1:7] led
	);
	// led= {a,b,c,d,e,f,g}; 1 is off and 0 is on (active low output)
	always @ (bcd)
		case (bcd) //abcdefg
		0: led = 7'b0000001;
		1: led = 7'b1001111;
		2: led = 7'b0010010;
		3: led = 7'b0000110;
		4: led = 7'b1001100;
		5: led = 7'b0100100;
		6: led = 7'b0100000;
		7: led = 7'b0001111;
		8: led = 7'b0000000;
		9: led = 7'b0000100;
		default: led = 7'b1111111;
		endcase
endmodule
```
The BCD-to-7-segment display decoder for use with a seven-segment LED display. The decoder output is active-low so that it tie the cathode (-) of the LED to the ground to allow for a brighter LED, hence requiring a low signal to turn LED. 
![image](https://user-images.githubusercontent.com/87056506/125169640-b96ecb00-e1dd-11eb-9e0c-4875ff1daf61.png)  

Figure 2: 7-segment LED display

![image](https://user-images.githubusercontent.com/87056506/125169652-ca1f4100-e1dd-11eb-9a62-30833ee79d5a.png)

Figure 3 : iobd diagram of bcd7segDEC





