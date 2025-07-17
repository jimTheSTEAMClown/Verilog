---
## Verilog Labs - Level 2 heading
---
> [!NOTE] - The following is a Lab template for the [Basic Music - Hackation](https://github.com/yuri-panchul/basics-graphics-music/tree/main) in the [Problems](https://github.com/yuri-panchul/basics-graphics-music/tree/main/hackathon/problems) directory.  What other labs should we have to teach basic Verilog?  

### Lab Top level Lab Topic Title - Like - "Gates & Muxes" - Level 3 heading
#### Gates & Muxes Introduction - Level 4 heading
Provide an introduction paragraph for the lab topic - In this first set of Verilog Labs, you are going to learn about Verilog **Logic Gates** and **Multiplexers** (Mux).  

**Topic #1** - if there are mised topics, like "Gates" & "Mux", you can bold the topi c title and provide a introduction paragraph.
* List what you will learn, or
* learning goals or
* learning outcomes.

**Topic #2** - if there is a second tipic in this topic, then bold and introduce it with an introduction paragraph.
* List what you will learn, or
* learning goals or
* learning outcomes.

In the following labs you will explore the Verilog syntax and coding structurs to build **Topic #1** & **Topic #2**

#### Target Hardware Setup and Pin Description
> [!NOTE] - This section should link to a presentation.
> [!NOTE] - This section should have a picture showing the Gowin FPGA and GPIO module and the connections
**GPIO Module - Hardware:** discription of hardware module and pins description as it's used i this lab.
![Basic Board Setup For Gates & Mux Labs](https://github.com/verilog-meetup/verilog-hackathon-education-kit-manual/blob/main/images/verilog-gowin-gpio-01.png)

**GPIO Module - Pin Description:**
| HW-154 Board Pin  |     FPGA Pin      |          Description                                    |  
| ----------------- | ----------------- | ------------------------------------------------------- |  
| J1-DIO            | GPIO-25           | DIO data channel for HW-154 LED&Key Board               |  
| J1-CLK            | GPIO-26           | CLK (Clock) for synchronizing the data transfer         |  
| J1- STB           | GPIO-27           | STB (Strobe) chip select or enable for communication    |  
| J1- GND           | GND               | GND                                                     |  
| J1- VCC           | VCC 3.3 V         | VCC 3.3 V                                               |   


#### Target Software, Tools, Libraries & Drivers Setup
> [!NOTE] - This section will cover any specific software, tools, Libraries or Drivers that are used

#### **AND** Verilog Constructs & Structures
Introduction to new Verilog constructs and structures, like Logic Gates.  You can have a diagram and other text graphics ot sow it, like an AND Gate
#### AND 
An **AND** gate outputs 1 only if both inputs are 1. This gate is used when multiple conditions must be true to activate a signal. An example would be requiring two buttons to be pressed simultaneously.  
**Logical Rules**  
| Gate     | Symbol | Description                                 | Output Rule |  
| -------- | ------ | ------------------------------------------- | ----------- |   
| **AND**  | `&`    | Output is `1` only if **both inputs are 1** | a & b       |

**Verilog Example**  
```Verilog
assign led[0] = key[0] & key[1];
```

**Logic Diagram**  
<pre>   key[0] ----\ 
               AND ---> led[0] 
   key[1] ----/ </pre>

**Truth Table**  
| Input[1] | Input[0] | Output (AND) |
| ------- | ------- | ------------ |
| 0       | 0       | 0            |
| 0       | 1       | 0            |
| 1       | 0       | 0            |
| 1       | 1       | 1            |  


#### Logic Gates Verilog Code Introduction  - Level 4 heading

Show the directory path to the code you will be using in this part of the lab. like -- If you followed the GITHub clone instructions, you should have the following directory path:  
**~/gowin/basics-graphics-music/hackathon/problems/1_gates_and_muxes/** where you will find the file **hackathon_top.sv**  

Open the **hackathon_top.sv** in a code editor,  VS-Code is recomended, but any text editor will work.  

Let's review the Verilog syntax in this top level Verilog File.

---
**Comment Used To Control The FPGA Bash flow**

These 2 comments in Verilog is used by the Bash scripts that generate the FPGA files.  Please don't edit these comments.  
```
// Board configuration: tang_nano_9k_lcd_480_272_tm1638_hackathon
// This module uses few parameterization and relaxed typing rules
```

**Top Verilog Block Inputs and Outputs**  
This section of the Verilog file defines all the Inputs and Outputs of the top level block.  Think of these as physical pins comming into or out of your Top Level Verilog Block.  

```
module hackathon_top
(
    input  logic       clock,
    input  logic       slow_clock,
    input  logic       reset,

    // GPIO Board - Switches & LEDs
    input  logic [7:0] key,
    output logic [7:0] led,

    // A dynamic seven-segment display
    output logic [7:0] abcdefgh,
    output logic [7:0] digit,

    // LCD screen interface
    input  logic [8:0] x,
    input  logic [8:0] y,

    output logic [4:0] red,
    output logic [5:0] green,
    output logic [4:0] blue,

    //Serial Connection To GPIO Board
    inout  logic [3:0] gpio
);
```
Focus on the specific **New** code that will be used in this lab
```
// GPIO Board - Switches & LEDs
input  logic [7:0] key,
output logic [7:0] led,
```
**inout** defines the direction of the signal pin, **logic** defines the type of "wire", \[7:0\] defines how many signals are generated in this "bus", and **key** is the name of the signals.

**output** defines the direction of the signal pin, **logic** defines the type of "wire", \[7:0\] defines how many signals are generated in this "bus", and **led** is the name of the signals.

When this code is synthisized, if will generate the following pins/wires you can connect to:  
key[0]  
key[1]  
key[2]  
key[3]   
key[4]  
key[5]  
key[6]  
key[7]  

led[0]  
led[1]  
led[2]  
led[3]  
led[4]  
led[5]   
led[6]   
led[7]     

For this Logic Gates Lab, you are only going ot be using the **input  logic [7:0] key,** and **output logic [7:0] led,**. The other inout/outpus, input logic clock, input logic slow_clock, input logic reset, the dynamic seven-segment display & the LCD screen interface wires will be used and explained in subsiquent labs.  

While we actually pass signals between the Gowin FPGA board and the HW-154 GPIO board using a serial bus, that actially uses the inout  **logic [3:0] gpio** bus, for these first Logic and Mux labs, you can imagine the following block diagram reprisentation.  

<pre> 
┌────────────────────┐                ┌─────────────────┐
│Hackathon Top (FPGA)│                │    GPIO Module  │
│                    │                │                 │
│   input  key[0]    │ ◄───────────── │  Push Button 0  │
│   input  key[1]    │ ◄───────────── │  Push Button 1  │
│   input  key[2]    │ ◄───────────── │  Push Button 2  │
│   input  key[3]    │ ◄───────────── │  Push Button 3  │
│   input  key[4]    │ ◄───────────── │  Push Button 4  │
│   input  key[5]    │ ◄───────────── │  Push Button 5  │
│   input  key[6]    │ ◄───────────── │  Push Button 6  │
│   input  key[7]    │ ◄───────────── │  Push Button 7  │
│                    │                │                 │
│   output led[0]    │ ─────────────► │  LED 0          │
│   output led[1]    │ ─────────────► │  LED 1          │
│   output led[2]    │ ─────────────► │  LED 2          │
│   output led[3]    │ ─────────────► │  LED 3          │
│   output led[4]    │ ─────────────► │  LED 4          │
│   output led[5]    │ ─────────────► │  LED 5          │
│   output led[6]    │ ─────────────► │  LED 6          │
│   output led[7]    │ ─────────────► │  LED 7          │
└────────────────────┘                └─────────────────┘
</pre>

[!NOTE] We should have code in this first lab that startes with 
> assign led [0] = key [0];
> assign led [1] = key [1];
> And then have the first lab to connect Led [6] and led[7] to key[6] and key[7]
> before we have them do the logic gates.

**Gate, Wire, and Continus Assignments**  
Let's see how to connect and generate an **AND** gate. in the assign statment below, we are connecting the inputs key[0] and key[1] to the led[0].  the **&** that you see in the right hand side of the assignment **=** sign is telling this assign statment to preform a Bitwise AND operation between key[0] and key[1].

Only when both buttons **key[0]** and **key[1]** are pressed (value 1), **led[0]** will be turned ON (1).

**assign** is a continuous assignment, which creates combinational logic—the output updates automatically and immediately when inputs change.

This will look like the following schematic diagram:
**Logic Diagram**  
<pre>   key[0] ----\ 
               AND ---> led[0] 
   key[1] ----/ </pre>
   

> [!NOTE] Example of LAB Activity #1: Challenge Name - Level 4 heading 
#### 🛠️ LAB Activity #1: Change AND to OR
Describe the coding challenge  

**Example Verilog Code**
Explain the challenge
```
    //------------------------------------------------------------------------

    // Gates, wires and continuous assignments

    assign led [0] = key [0] & key [1];

    // Exercise 1: Change the code above.
    // Assign to led [0] the result of OR operation (|).
```

**Challenge**
Change the code **assign led [0] = key [0] & key [1];** to preform an **OR** assignment 

You can provide a hint section too...
**Hint**: \| is the bitwise OR operator. When you replace the & bitwise operator with \| the the result assigned to the led[0] is true (1) if either key[0] or key[1] is pressed. 
<pre>   key[0] ----\ 
               OR ---> led[0] 
   key[1] ----/ </pre>

**Running the FPGA Bash scripts**
This section will cover how and where to run the Verilog compile scripts to target the FPGA. Eplain what they should do... Edit your code, save it, and in your consol window, run the bash script **03_synthesize_for_fpga.bash**

**What Success Looks Like** - Describe what a successful completion of the lab looks like... When you press the key[0] the led[0] should now light up.  if you then only press key[1], the led[0] should also still light up.  If you press both key[0] and key[1], led[0] should also ligh up, because this is a bitwise **OR** will respond to either key[0], key[1] or both.

> [!NOTE] Example of LAB Activity #2: Challenge Name - Level 4 heading 
#### 🛠️ LAB Activity #1: Wire assigments - Aliasing signals  - Level 4 heading
**What is a Verilog "wire"?**  

In Verilog, a **wire** is one of the most fundamental data types used to model physical electrical connections. A wire represents a combinational signal. A wire is something that is driven by some other logic but does not store a value on its own.  
- Think of it like a copper wire on a breadboard. It connects components together.
- It simply carries signals from one point to another.
- It has no "memory". Wires are not like a register or variable that stores state. (You will learn about these later)

**Why and how should you use a "wire"**   
 - Connecting inputs to internal logic.
 - Connecting outputs of logic gates to module outputs.
 - Breaking up complex expressions into smaller parts.
 - Improving readability with aliases.

**Example Verilog Code With Wire Assignments**
```
  wire a = key[0];
  wire b = key[1];
  assign led[0] = a & b;
```
- wire a = key[0]; means: connect the wire a to the bit key[0].
- 'a' now acts exactly like key[0], it's just a more readable or convenient name.
- Then, you can write logic expressions using a and b like variables, but they are just "wires."

Take a look at these diagrams and make sure you understand that they are equvelent:
<pre>   key[0] ----\ 
               AND ---> led[0] 
   key[1] ----/ 

   key[0] ----> a ----\ 
                       AND ---> led[0] 
   key[1] ----> b ----/</pre>
</pre>

**Challenge** - Use a wire assigment
```
wire a = key[0];  
```

You can provide a hint section too...
**Hint**: 

**Running the FPGA Bash scripts**
This section will cover how and where to run the Verilog compile scripts to target the FPGA. Eplain what they should do... Edit your code, save it, and in your consol window, run the bash script **03_synthesize_for_fpga.bash**

**What Success Looks Like** - Describe what a successful completion of the lab looks like... 

    




##### Next Steps - Dig Deeper
Provide some additional resourses or assignments to look at

#### Multiplexer Verilog Code

#### 🛠️ LAB Activity #1: Change AND to OR
Describe the coding challenge  

**Example Verilog Code**
Explain the challenge
```
    //------------------------------------------------------------------------

    // Gates, wires and continuous assignments

    assign led [0] = key [0] & key [1];

    // Exercise 1: Change the code above.
    // Assign to led [0] the result of OR operation (|).
```

**Challenge**
Change the code **assign led [0] = key [0] & key [1];** to preform an **OR** assignment 

You can provide a hint section too...
**Hint**: \| is the bitwise OR operator. When you replace the & bitwise operator with \| the the result assigned to the led[0] is true (1) if either key[0] or key[1] is pressed. 
<pre>   key[0] ----\ 
               OR ---> led[0] 
   key[1] ----/ </pre>

**Running the FPGA Bash scripts**
This section will cover how and where to run the Verilog compile scripts to target the FPGA. Eplain what they should do... Edit your code, save it, and in your console window, run the bash script **03_synthesize_for_fpga.bash**

**What Success Looks Like** - Describe what a successful completion of the lab looks like... When you press the key[0] the led[0] should now light up.  if you then only press key[1], the led[0] should also still light up.  If you press both key[0] and key[1], led[0] should also ligh up, because this is a bitwise **OR** will respond to either key[0], key[1] or both.
