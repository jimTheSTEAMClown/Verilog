---
## Verilog Labs
---
> [!NOTE] - The following are the Labs that are in the [Basic Music - Hackation](https://github.com/yuri-panchul/basics-graphics-music/tree/main) in the [Problems](https://github.com/yuri-panchul/basics-graphics-music/tree/main/hackathon/problems) directory.  What other labs should we have to teach basic Verilog?  
> [!NOTE] - STEAM CLown - I think that we should have a few more Labs to show using the GPIO board.  Also, maybe we should change the order of the labs, so we can do all the labs focused on the GPIO module before we start looking at the Display. Thoughts?  

### Gates & Muxes
#### Gates & Muxes Introduction
In this first set of Verilog Labs, you are going to learn about Verilog **Logic Gates** and **Multiplexers** (Mux).  

**Logic gates** are the building blocks of digital circuits. They process binary input values (0 or 1) and produce binary outputs based on specific logical rules. You use logic gates to build everything from simple decision-making circuits to complex CPUs and FPGAs.
* Learn how to create simple logic gates using Verilog.
* Use wire and assign statements to build AND, OR, XOR, NAND, NOR, and XNOR gates.
* Control onboard LEDs using push button inputs to visualize the gate behavior.

A **Multiplexer** (MUX) is a digital switch that selects one of several input signals and forwards it to a single output, based on control (select) signals.
* Build a 2-to-1 MUX using assign out = sel ? in1 : in0;
* Observe how changing the select signal affects the output LED
* Learn how to extend MUX structures to support more inputs or wider data

In the following labs you will explore the Verilog syntax and coding structurs to build Logic Gates and Mux's

#### Logic Gates Verilog Code
Logic gates form the foundation of all digital electronics. These basic building blocks process two or more binary input values/signals (0 and 1) and produce a single binary output based on logical rules. Gates like AND, OR, and XOR enable a wide range of operations.   

They can be simple LED control to complex logic. In Verilog, logic gates are implemented using continuous assignments (assign) and basic bitwise operators such as &, |, and ^. The following labs will introduces you to the Verilog syntax used to model and test these gates using Verilog on an FPGA platform, preparing you to build decision making circuits.  

This set of labs will introduce and let you build Verilog code to implement six fundamental logic gates. You will have an opertunity to build AND, OR, XOR, NAND,  NOR, and XNOR Verilog implementations, connecting Push Button switches to LED's.   

Each gate processes two binary inputs (0 = LOW, 1 = HIGH) and produces a binary output based on a specific logical rule. Let's take a look at the Logic Gate logical rules:
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

#### OR 
An **OR** gate outputs 1 if at least one input is 1. It’s used when any of several inputs can activate a result.  An example would let an ouput LED turn on if either button A or button B were presed.  Only one of the inputs needs to be active to create a logical result of a 1 on the output.  

**Logical Rules**  
| Gate     | Symbol | Description                                | Output Rule |  
| -------- | ------ | ------------------------------------------ | ----------- |   
| **OR**  | \|    | Output is `1` if **at least one input is 1** | a \| b      |

**Verilog Example**  
```Verilog
assign led[1] = key[0] | key[1];  
```

**Logic Diagram**  
<pre> key[0] ----\ 
             OR ---> led[0] 
 key[1] ----/ </pre>

**Truth Table**  
| Input[1] | Input[0] | Output (OR) |
| ------- | ------- | ------------ |
| 0       | 0       | 0            |
| 0       | 1       | 1            |
| 1       | 0       | 1            |
| 1       | 1       | 1            |  

[!NOTE] I'll add the XOR, NOR,NAND, XNOR later

#### Logic Gates Verilog Code Introduction

If you followed the GITHub clone instructions, you should have the following directory path:  
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
We are going to only look at the GPIO Board - Switches & LEDs section
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
   
```
    //------------------------------------------------------------------------

    // Gates, wires and continuous assignments

    assign led [0] = key [0] & key [1];

    // Exercise 1: Change the code above.
    // Assign to led [0] the result of OR operation (|).
```
##### Exercise 1: Change AND to OR
change the code **assign led [0] = key [0] & key [1];** to preform an **OR** assignment 

**Hint**: \| is the bitwise OR operator. When you replace the & bitwise operator with \| the the result assigned to the led[0] is true (1) if either key[0] or key[1] is pressed. 
<pre>   key[0] ----\ 
               OR ---> led[0] 
   key[1] ----/ </pre>

Edit your code, save it, and in your consol window, run the bash script **03_synthesize_for_fpga.bash**

**Success?** When you press the key[0] the led[0] should now light up.  if you then only press key[1], the led[0] should also still light up.  If you press both key[0] and key[1], led[0] should also ligh up, because this is a bitwise **OR** will respond to either key[0], key[1] or both.

#### Wire assigments - Aliasing signals  
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

##### Exercise 2: Use a wire assigment

```
    wire a = key [0];  // Note a new construct - wire
    wire b = key [1];

    assign led [1] = a ^ b; // XOR - eXclusive OR

    //------------------------------------------------------------------------

    // Signals for demoing multiplexers

    assign sel = key [7];
    assign d1  = key [6];
    assign d0  = key [5];

    //------------------------------------------------------------------------

    // Five different implementations

    always_comb  // Combinational always block
    begin
        if (sel == 1)     // If sel == 1
            led [7] = d1;  //    Output value of "a" to led [0]
        else
            led [7] = d0;  //    Output value of "b" to led [0]
    end

    //------------------------------------------------------------------------

    /*

    // "== 1" is not necessary
    // because Boolean value can be used as an "if" condition

    always_comb  // Combinational always block
    begin
        if (sel)
            led [7] = d1;
        else
            led [7] = d0;
    end

    */

    //------------------------------------------------------------------------

    assign led [6] = sel ? d1 : d0;  // If sel == 1, choose d1, otherwise d0

    //------------------------------------------------------------------------

    // You can also use "case" like "switch" in "C"

    always_comb
    begin
        case (sel)
        1: led [5] = d1;
        0: led [5] = d0;
        endcase
    end

    //------------------------------------------------------------------------

    /*

    // If you have only one statement you can omit "begin/end"

    always_comb
        if (sel)
            led [7] = d1;
        else
            led [7] = d0;

    always_comb
        case (sel)
        1: led [5] = d1;
        0: led [5] = d0;
        endcase

    */

    //------------------------------------------------------------------------

    // The construct "{ , }" is called "concatenation"

    wire [1:0] d = { d1, d0 };
    assign led [4] = d [sel];

    // If sel == 0, we choose d [0] which is equal to d0
    // If sel == 1, we choose d [1] which is equal to d1

    //------------------------------------------------------------------------

    // Exercise: Implement mux
    // without using "?" operation, "if", "case" or a bit selection.
    // Use only operations "&", "|", "~" and parenthesis, "(" and ")".

    //------------------------------------------------------------------------

    // Exercise: Implement a mux that chooses between four inputs
    // using two-bit selector.

endmodule

##### Target Hardware Setup and Pin Description
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


##### Target Software, Tools, Libraries & Drivers Setup
> [!NOTE] - This section will cover any specific software, tools, Libraries or Drivers that are used

##### Verilog Logic Gate Labs / Challenges
> [!NOTE] - This section will explain the specific Verilog Lab, what the goals are and outline the challenges.
```Verilog
Some code in Verilog
```
###### 🛠️ LAB Activity: Challenge Name #1
**Verilog Code**
Explain the challenge
```Verilog
Some code in Verilog
```
**What Success Looks Like**
describe what a successful completion of the lab looks like

###### 🛠️ LAB Activity: Challenge Name #2
**Verilog Code**
Explain the challenge
```Verilog
Some code in Verilog
```
**Running the FPGA Bash scripts**
This section will cover how and where to run the Verilog compile scripts to target the FPGA

**What Success Looks Like**
Describe what a successful completion of the lab looks like

##### Next Steps - Dig Deeper
Provide some additional resourses or assignments to look at

#### Multiplexer Verilog Code
