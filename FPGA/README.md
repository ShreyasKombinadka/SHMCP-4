
# **Simple Hierarchical MicroCode Processor - 4bit ( SHMCP-4 )**

This is the FPGA implimentation dessign of the SHMCP4 for Spartan-7 FPGA.   

---
 
### **Overview :**
- The processor is designed from scratch.
- The Processor operates on 4-bit data.
- Has custom ISA built from ground up to perforom specific operations.
- It follows Harvard architecture.
- The design is built with a hierarchical flow of instructions.
- It is controlled by 8-bit instructions.
- Each bit is given specific function to optimise the instruction set by using as less instructions as possible.
- The full design is available here,   
    [**SHMCP_4**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/FPGA/SHMCP_4)  

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
 
### **Elaborated design**    
![Failed to load the image!](SHMCP_4/doc/sim_schematic.png "Elaborated design of SHMCP-4")  
