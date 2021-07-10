```
module keyboard(
	GPIO_1,
	clkin,
	ans0,
	ans1
);

// Keypad Reading

input clkin;
inout [7:0] GPIO_1;
reg reset = 0;
wire myclock;

tenHzclk u2 (.rst(reset), .clkin(clkin), .clk(myclock));

reg [3:0] GOUT = 4'bzzzz;	// GPIO outputs
reg [15:0] OUT;				// LED outputs
reg [7:0] index;				// index of read row
reg [1:0] status;				// 0 = preparing to read a row, 1 = reading row, 2 = end of read
reg new_key;					// turned on when new key is read; automatically turned off
reg [3:0] new_key_char;		// index of new key

assign GPIO_1 = { GOUT, 4'bzzzz };  // GPIO_1 used bidirectional

// Reset
always@(posedge myclock) begin
	if (~reset)
		reset = 1'b0;
end

/* Custom clocks at 1 kHz.
 * This "loop" scans keypad horizontally, each line in every
 * cycle. Each line scan is divided into 3 patrs:
 *  1) Set current line output to 0 (groud).
 *  2) Read inputs.
 *  3) Set current line output to 1 (VCC).
 */
always@(posedge myclock) begin
	if (status == 0) begin
		// set current line output to 0 (ground)
		GOUT[index] <= 0;
		status <= 1;		
	end else if (status == 1) begin
	
		// detect key press		
		if ((!GPIO_1[0]) && (OUT[4*index] != !GPIO_1[0])) begin
			new_key_char <= 4*index;
			new_key <= 1;
		end
		if ((!GPIO_1[1]) && (OUT[4*index+1] != !GPIO_1[1])) begin
			new_key_char <= 4*index+1;
			new_key <= 1;
		end
		if ((!GPIO_1[2]) && (OUT[4*index+2] != !GPIO_1[2])) begin
			new_key_char <= 4*index+2;
			new_key <= 1;
		end
		if ((!GPIO_1[3]) && (OUT[4*index+3] != !GPIO_1[3])) begin
			new_key_char <= 4*index+3;
			new_key <= 1;
		end
		
		// change state of LEDs
		OUT[4*index] <= !GPIO_1[0];
		OUT[4*index+1] <= !GPIO_1[1];
		OUT[4*index+2] <= !GPIO_1[2];
		OUT[4*index+3] <= !GPIO_1[3];
		status <= 2;
	end else begin
		// set all line outputs to high impedance (do not set to VCC here!)
		GOUT <= 4'bzzzz;
		
		if (index < 3)
			// keypad not yet scanned -> scan new line
			index <= index + 1;
		else
			// whole keypad scanned -> new scan
			index <= 0;
			
		status <= 0;
		new_key <= 0;	// reset key press flag
	end;
end

// ----------------------------------------------------------------------------
// Segment Display

output [3:0] ans0;
output [3:0] ans1;

reg [3:0] ANS0 =0;
reg [3:0] ANS1 =0;

assign ans0 = ANS0;
assign ans1 = ANS1;


/* Insert new char at the end of display
 * and push all the other characters left.
 * This block is run when "new_key" flag is set (<=> new key was just pressed).
 */
always@(posedge new_key) begin
	// Push characters left.
	ANS1<=ANS0;

	// Show a new character.
	case (new_key_char) 
		 0 : ANS0 <= 4'b0001; // 1
		 1 : ANS0 <= 4'b0010;// 2
		 2 : ANS0 <= 4'b0011; // 3
		 4 : ANS0 <= 4'b0100; // 4
		 5 : ANS0 <= 4'b0101; // 5
		 6 : ANS0 <= 4'b0110; // 6
		 8 : ANS0 <= 4'b0111; // 7
		 9 : ANS0 <= 4'b1000; // 8
		10 : ANS0 <= 4'b1001; // 9
		13 : ANS0 <= 4'b0000; // 0
		default : begin
			ANS0 <= 0;
			ANS1 <= 0;
		end
	endcase
end

endmodule
```
4x4 matrix keypad uses a combination of four rows and four columns as shown in Figure 1 to provide button states to the host device. Underneath each key is a push button, with one end connected to one row, and the other end connected to one column. However, there is no connection between rows and also column but the button make it connect if pressed. Thus, to interface the keypad with DE1 board, the rows and columns pins are connected to the GPIO pins of the DE1 board and make the proper pin assignment. Thus, to scan which button is pressed, the users need to scan it column by column and row by row every certain short period. The row pins should be connected to input port and then the column pins are connected to the output port.


![image](https://user-images.githubusercontent.com/87056506/125169479-eb336200-e1dc-11eb-9367-8af8d2c1bd9f.png)

Figure 1 : 4x4 Matrix Keypad columns and rows

