# **Register file**

A basic register file with three registers and few operations.

The design could have been built with more registers but this is a simple start, so i kept it smaller and fewer..!

### **Overview :**
- The register file consists of 3 registers,
    1. General purpose - A & B
    2. Specia purpose - OP
- Contains two resets,
    1. GRST -> Global reset (Hardware reset)
    2. LRST -> Local reset (Software reset)
- All three registers are connected to a single shared 4bit bus.
- The registers can perform specific operations,
    1. A & B  -> Load immediate and Read or Write to the bus.
    2. OP -> Load immediate and Write to the bus.
- The read write operations are controlled by a register control block which enables te required register operations based on the instruction given.
- The instruction are given to the decoder in hex form where it is decoded to produce the requiered control signals.

---

### **Elaborated design :**
![Failed to load the image!](./doc/schematic.png "Loading...")

---
 
### **Instruction set :**

| Hex code | Operation          |
|:--------:|:------------------:|
| 0        | NOP                |
| 1        | LDI A              |
| 2        | LDI B              |
| 3        | LDI OP             |
| 4        | MOV BUS, A         |
| 5        | MOV BUS, B         |
| 6        | MOV A, BUS         |
| 7        | MOV B, BUS         |
| 8        | MOV OP, BUS        |
| 9        | MOV A, B           |
| A        | MOV B, A           |
| B        | MOV OP, A          |
| C        | MOV OP, B          |
| D        | (reserved)         |
| E        | (reserved)         |
| F        | CLEAR              |

---

### **Simulation :**

#### **Test sequence :**
```sv ,
{
    reg clk, grst,    // Clock and Global reset
    reg [3:0] imm,    // Immediate value
    reg [3:0] instr,  // Instruction
    wire [3:0] bus // Data bus
    
    reg bus_read ;  // Enable bus read
    reg [3:0] bus_temp ;    // Temporary bus value
}

begin
    grst = 1 ;
    imm = 4'h0 ; bus_read = 0 ; bus_temp = 4'h0 ; instr = 4'h0 ;    // NOP

    @( negedge clk ) ; grst = 0 ; imm = 4'hA ; instr = 4'h1 ;   // LDI A
    @( negedge clk ) ; imm = 4'h7 ; instr = 4'h2 ;  // LDI B
    @( negedge clk ) ; imm = 4'h5 ; instr = 4'h3 ;  // LDI OP
    @( negedge clk ) ; bus_read = 1 ; bus_temp = 4'h2 ; instr = 4'h4 ;  // MOV BUS, A
    @( negedge clk ) ; bus_read = 1 ; bus_temp = 4'h8 ; instr = 4'h5 ;  // MOV BUS, B
    @( negedge clk ) ; bus_read = 0 ; bus_temp = 4'h0 ; instr = 4'h6 ;  // MOV A, BUS
    @( negedge clk ) ; instr = 4'h7 ;   // MOV B, BUS
    @( negedge clk ) ; instr = 4'h8 ;   // MOV OP, BUS
    @( negedge clk ) ; instr = 4'h9 ;   // MOV A, B
    @( negedge clk ) ; instr = 4'h2 ;
    @( negedge clk ) ; instr = 4'hA ;   // MOV B, A
    @( negedge clk ) ; instr = 4'hB ;   // MOV OP, A
    @( negedge clk ) ; instr = 4'hC ;   // MOV OP, B
    @( negedge clk ) ; instr = 4'hF ;   // CLEAR
    @( negedge clk ) ; $finish ;
end
```

#### **Waveform :**

![Failed to load the image!](./doc/waveform.png "Loading...")