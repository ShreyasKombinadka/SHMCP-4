# **SHMCP-4**

The final block of the code which combines all the lower modules to form a processer.

### **Overview :**
- The final processor is completed by connecting the control and datapath blocks.   
- The processor is programmable by using the state and load signals.    

#### **CLK generation unit :**
- Since this is a simple processor design it needs different clocks for programming and executing state, for programming it needs a faster clock to capture load button input but for execution it needs a slower one to observe the actual execution of the code.
- For more info, 

    [**CLK Unit**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/FPGA/CLK_generation)

#### **Control unit :** 
- The processor state is controlled by the state input,
    | State value  | State              |
    |:------------:|:------------------:|
    | 0            | Programming        |
    | 1            | Execute/Run        |
>
- The instruction loading to the memory is enabled by the Load input.
- Has a instruction memory with 15 locations to store the instructions.
- Has a PC with a size of 4-bits.
- The PC will be incrimented every time a instruction is added
- The first memory location is left as startup location so it is skipped by the PC while programming.
-  When the State is set to 0 the PC resets to 1 and starts to incriment automatically.
- The Control block also contains a PC control block, which oversees the instrution passing from instruction memory to Datapath.
- The PC control block manages the jump operations.
- PC control overwrites the PC value to the given Instruction memory location to perform looping.
- When a JNZ instruction is given it first makes trhe ALU unit to write the flag values to the bus, by passing the 'MOV F, BUS' instrucion.
- The PC control then compares the ZERO flag and keeps jumping back to the specified instruction memory location till the Zero flag is raised.
- PC contains a termination(trm) flag which is used to indicate the end of programm, so the pc can halt counting and instruction passing and the clk is paused by the clk generation unit till either state is updated or flag is cleared.
- TRM flag is set for either PC count reaches max or 4 consecutive NOP instruction are passed to the PC by the instr memory.

#### **Datapath :** 
- Connects all the data blocks.
- By combining all the data blocks makes it easier to interface with the main coontrol unit.
- The instructions will be given to the Datapath by the control unit where it will be passed to the data units.
- For more info on each part(Simulation docs),   
    [**ROM**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/SIM/ROM)    
    [**Register file**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/SIM/Register_file)    
    [**ALU unit**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/SIM/ALU_unit)    
    [**RAM**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/SIM/RAM)


---

### **Elaborated design :**
![Failed to load the image!](./doc/SIM_schematic.png "Elaborated schematic")

---
 
### **Instruction set :**

| Hex code  | Operation          |
|:---------:|:------------------:|
| 00        | NOP                |
| 01        | MOV A, B           |
| 02        | MOV A, X1          |
| 03        | MOV B, A           |
| 04        | MOV B, X2          |
| 05        | MOV OP, X3         |
| 06        | MOV R, A           |
| 07        | MOV R, X1          |
| 08        | MOV R, B           |
| 09        | MOV R, X2          |
| 0A        | MOV F, BUS         |
| 0B        | LOGIC              |
| 0C        | ADD                |
| 0D        | SUB                |
| 0F        | CLEAR              |
| 20 - 2F	| LDI A & X1         |
| 40 - 4F	| LDI B & X2         |
| 60 - 6F	| LDI OP & X3        |
| A0 - AF	| MOV MEM, A         |
| B0 - BF	| MOV A, MEM         |
| C0 - CF	| MOV MEM, B         |
| D0 - DF	| MOV B, MEM         |
| F0 - FF	| MOV R, MEM         |
| 30 - 3F	| JNZ                |
| 70 - 7F	| J                  |

---

### **Simulation :**

#### **Test sequence :**
```sv ,
{
    input clk_in, rst,      // Clock and Reset
    input rbt,              // Reboot
    input state,            // State of the CPU
    input load,             // Enable for instruction load
    input [7:0] instr,      // Instruction input
    input [2:0] sel,        // Select lines for output muxing
    output [3:0] reg_disp,  // Regsiter value to output
    output state_o,         // State output
    output load_o,          // Load output
    output trm_f            // Termination flag output

}

begin

    rst = 1 ; rbt = 0;
    state = 0 ; load = 0 ; instr = 0 ; sel = 7;

    repeat(1000) @( negedge clk ) ; rst = 0 ; 
    @( negedge dut.clk ) ; instr = 8'h0F ; load = 1;  // CLEAR
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h2A ; load = 1;  // 10 -> A & a
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h41 ; load = 1;  // 1 -> B & b
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h0D ; load = 1;  // SUB ( A(a) - B(b) )
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h07 ; load = 1;  // R -> X1
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h34 ; load = 1;  // JNZ
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h06 ; load = 1;  // R -> A
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h00 ; load = 1;  // NOP
    @( negedge dut.clk ) ; load = 0;
    
    @(negedge dut.clk) ; state = 1 ; load = 0 ; // Run the programm
    repeat(50000) @( negedge clk ) ; rbt = 1 ;  // Reboot
    repeat(1000) @( negedge clk ) ; rbt = 0;

    @(posedge trm_f) ;  // Let the programm run till Termonation flag is set
    repeat(50000) @( negedge clk ) ; state = 0 ; load = 0 ; instr = 0 ; sel = 0;
    
    repeat(50000) @( negedge clk ) ; rst = 1 ;
    repeat(1000) @( negedge clk ) ; rst = 0; 
    
    repeat(50000) @(negedge clk) ; state = 1;    // Run the programm
    @(posedge trm_f);

    repeat(50000) @(negedge clk) ; $finish;

end

```

#### **Waveform :**

![Failed to load the image!](./doc/waveform.png "Simulation waveform")

### **Implimentation :**
#### **Schematic :**
![Failed to load the image!](./doc/imp_schematic.png "Implimentation schematic")

#### **Reports :**
##### **1. Power**
![Failed to load the image!](./doc/power.png "Power")
##### **2. Timing**
![Failed to load the image!](./doc/timing.png "Timing")
##### **3. Utilization**
![Failed to load the image!](./doc/utilization.png "Utilization")
