```
module RNG(
  input  clk,
  input  rst,
  output reg [2:0] dataout1, dataout2
);
reg [10:0] data;


wire feedback = data[10] ^ data[8];
wire feedback2 = data[5] ^ data [2];


always @(posedge rst, posedge clk) begin
  if (rst) begin
    data <= 11'b11111111111;end
  else begin
  if (data[3] && data[9]) begin
    data <= {data[8:6], feedback,data[4:0],feedback2};
	 dataout1 <={data[6:4]};
	 dataout2 <={data[9:7]};
	 end
	else if (data[1] && data [7])begin
	 data <= {data[8:0], feedback,feedback2};
	 dataout1 <={data[5:3]};
	 dataout2 <={data[9:7]};

	 end
	else begin
	 data <= {feedback,data[8:0],feedback2};
	 dataout1 <={data[2:0]} + 5;
	 dataout2 <={data[7:5]} - 7 ;
	end
	 end
	 
	end 
endmodule					
```

Coding above shows RND.v which is used to generate 2 numbers for the question of the multiplication. In fact, Verilog does not have any build in function to generate random number. So, we have built a functional block to generate pseudo randomness number. Actually, this kind of pseudo randomness number can be a lot of way to do it, the purpose is to generate the number that look randomly, as long as the number is changing every time. In this coding, we use 11-bit data (data) to generate 2 numbers (dataout1 and dataout2) with 3-bit each of it. So, dataout1 and dataout2 are for the question of the multiplication. Both are retrieved from data which is the 11-bit numbers. Based on the condition, they will retrieve it from different position of this 11-bit numbers. For condition, we just simply set 3 condition, which are if (data[3] && data[9]), else if (data[1] && data [7]) and else. So that our next question (dataout1 and dataout2) will be based on our current data or the current data with addition and subtraction. The next data will be based on the condition to decide the shifting method. The shifting number will also be based on the exclusive or of its number.

![image](https://user-images.githubusercontent.com/87056506/125172419-399c2d00-e1ec-11eb-8cbd-d7f04c790551.png)

Figure above shows the simulation of RNG.v. From this figure, we can see that the number for dataout1 and dataout2 are look like a random number. So, it fulfils our purpose which is generate different number at every rising edge.
