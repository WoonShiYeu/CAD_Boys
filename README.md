![LOGO-UTM](https://user-images.githubusercontent.com/87056506/125168182-b45a4d80-e1d6-11eb-9827-d544110897cc.png)
# CAD_Boys Group Details

SCHOOL OF ELECTRICAL ENGINEERING 
SESSION 2020/2021-2

SKEL 4273 CAD with HDL

Milestone 5 & 6

SECTION :         01

GROUP :  		CAD BOYS

| Name | Card Matrix |
|------|-------------|
|GOH KEAN WEI|A18KE0062|
|LOH ZHAO TIAN|A18KE0102|
|WOON SHI YEU|A18KE0298|

LECTURER :  DR MUHAMMAD MUN’IM BIN AHMAD ZABIDI

READ ME:
We have posted all of the verilog codes into their own files accociated with the explaination.

**1.0 Introduction**

In this Multiplication game, there are a few rules that we need to follow. The rules are as follow.


1.     A total of 5 multiplication questions will be asked and the user will try to use the shortest amount of time to get the answer.
2.     Time limit for each question=20 seconds, when time reached, user lose instantly.
3.     Total marks= 100 – time used.
4.     Question (2 different digit) will be displayed on seven segment display.
5.     User will input their answer using Keypad
6.     Marks will be displayed after the game.


**2.0 Prerequisites**

**2.1 Hardware**
1x ALTERA FPGA CycloneII EP2C5T144 Learning Board Development Board 

2x Common anode seven segment displays

6x Common cathode seven segment displays

3x Blue LEDs

11x 1kΩ resistor

Male to Female jumper wires

Male to Male jumper wires

**2.2 Software**

Quartus II Version 13.0 and above

**3.0 Hardware Setup**

Diagram below shows the pin assignment of the program in FPGA

![image](https://user-images.githubusercontent.com/87243212/125186312-3c366b00-e25c-11eb-8a2e-bebad3f4f376.png)

![image](https://user-images.githubusercontent.com/87243212/125186288-17da8e80-e25c-11eb-98bd-59a60ec6a4a7.png)

Diagram below shows the connection of the components to the FPGA

![20210711_161532](https://user-images.githubusercontent.com/87243212/125187777-d51cb480-e263-11eb-8010-26ff0aa5a241.jpg)

**4.0 Software Setup**

First, we need to compile all the codes in the files to check whether there is any error. If there is any, locate it and fix it.

Diagram below shows the compilation report of the Multiplicationgame.v

![image](https://user-images.githubusercontent.com/87243212/125187962-b965de00-e264-11eb-8c86-063f2d2d175d.png)

Then, we need to assign every input and output to a pin location on the FPGA. This can be done by going to Assignment>pin planner at the taskbar menu.

Diagram below shows the pin assignment of the input and output.

![image](https://user-images.githubusercontent.com/87243212/125188230-a30c5200-e265-11eb-95a1-a78eec0b732a.png)

Next, we need to program the output.sof file by going to the Tools>Programmer at the taskbar menu.

Diagram below shows the programmer windows when we were about to program the output file to the FPGA.

![image](https://user-images.githubusercontent.com/87243212/125188334-1f069a00-e266-11eb-95ce-11a0909deec3.png)

Press the start button and the program will be succesfully loaded into the FPGA.

youtube link that direct to hardware demonstration part: https://www.youtube.com/watch?v=NTQhZyFnFgo

