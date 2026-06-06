
# **Simple Hierarchical MicroCode Processor - 4bit ( SHMCP-4 )**

As the name suggests its a basic microcoded Processor that can run basic programs, i built it to get an basic understanding of computer architecture and it was also fun to design and build.   

---
 
### **Overview :**
- The processor is designed from scratch.
- It operates on 4-bit data.
- Has custom ISA built from ground up to perforom specific operations.
- It follows Harvard architecture.
- The design is built with a hierarchical flow of instructions.
- It is controlled by 8-bit instructions.
- Each bit is given specific function to optimise the instruction set by using as less instructions as possible.
- The full FPGA design is available here,   
    [**SHMCP_4**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/FPGA/SHMCP_4)  

---

### **Features :**
- 4-bit datapath with Harvard architecture.
- Hierarchical microcode control (3-tier ROM decode).
- Programmable instruction memory (15 locations).
- Data RAM (16 locations, 0-15).
- Complete ALU (7 logic ops + 2 arithmetic).
- Conditional branching (JNZ, J)
- Custom ISA optimized for minimal instruction encoding.

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

### **Progress :**  
- [x] Design
- [x] Building in verilog
- [x] Testing & verification(Vivado)
- [x] Implementation in FPGA board(Spartan-7)

---

### **Results :**
#### **1 Simulation :**   
##### **1.1 Elaborated design**    
![Failed to load the image!](FPGA/SHMCP_4/doc/sim_schematic.png "Elaborated design of SHMCP-4")  

##### **1.2 Test Programm**
##### 1.2.1 Down counter
| Hex code  | Operation          |
|:---------:|:------------------:|
| 0F        | CLEAR              |
| 2A        | 10 -> A & a        |
| 41        | 1 -> B & b         |
| 0D        | SUB (a - b)        |
| 07        | R -> X1            |
| 34        | JNZ                |
| 06        | R -> A             |
| 00        | NOP                |


##### **1.3 Waveform**
![Failed to load the image!](FPGA/SHMCP_4/doc/waveform.png "Simulation waveform")

#### **2 Implimentation :**
##### **2.1 Schematic**
![Failed to load the image!](FPGA/SHMCP_4/doc/imp_schematic.png "Implimentation schematic")

##### **2.2 Reports :**
##### 2.2.1 Power
![Failed to load the image!](FPGA/SHMCP_4/doc/power.png "Power")
##### 2.2.2 Timing
![Failed to load the image!](FPGA/SHMCP_4/doc/timing.png "Timing")
##### 2.2.3 Utilization
![Failed to load the image!](FPGA/SHMCP_4/doc/utilization.png "Utilization")

---

### **NOTE :**
- This is just a simple model for me to learn stuff so it has many flaws and potential failures but designing and building this was very fun and gave me a deeper insight into the hardware design.
- Also i am building the same design on real hardware using logic IC's on breadboards, its kind of a lagging behind because it takes more time to actually have the design working with real world limitations and problems, so if you wanna check it out heres the link,   
    [**Breadboard-CPU-4bit**](https://github.com/ShreyasKombinadka/Breadboard-CPU-4bit)