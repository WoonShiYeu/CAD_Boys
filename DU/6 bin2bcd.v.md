```
module bin2bcd(
    bin,
     bcd1
    );

    //input ports and their sizes
    input [7:0] bin;
    //output ports and, their size
    output reg [7:0] bcd1;
    //Internal variables
    reg [11:0] bcd; 
     reg [3:0] i;   
     
     //Always block - implement the Double Dabble algorithm
     always @(bin)
        begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < 8; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],bin[7-i]}; //concatenation
                    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < 7 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < 7 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3;  
            end
				bcd1={bcd[7:0]};
        end     
                
endmodule
```
This module takes an input binary number and converts it to Binary Coded Decimal (BCD). The algorithm used in the code below is known as a Double Dabble. BCD or Binary-coded decimal is a class of binary encodings of decimal numbers where each decimal digit is represented by four bits. This format is useful for displaying a value in a seven segment display or LCD panel. The verilog code is written for converting a 8 bit binary number into BCD format. The maximum value of a 8 bit binary number is 255 in decimal. This means we need 3 BCD digits in the output. So the size of the output as 3 digits*4 bits = 12 bits is chosen.
