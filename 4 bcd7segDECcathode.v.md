```
module bcd7segDECcathode(
	input [3:0] bcd,
	output reg [1:7] led
	);
	// led= {a,b,c,d,e,f,g}; 0 is off and 1 is on (active high output)
	always @ (bcd)
		case (bcd) //abcdefg
		0: led = ~7'b0000001;
		1: led = ~7'b1001111;
		2: led = ~7'b0010010;
		3: led = ~7'b0000110;
		4: led = ~7'b1001100;
		5: led = ~7'b0100100;
		6: led = ~7'b0100000;
		7: led = ~7'b0001111;
		8: led = ~7'b0000000;
		9: led = ~7'b0000100;
		default: led = 7'b0000000;
		endcase
endmodule				
```
bcd7segDECcathode is almost the same with bcd7segDECcathode. The only changes is the decoder output is active-high so that it tie the anode (+) of the LED to the ground
