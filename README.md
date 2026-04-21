
# **Simple Hierarchical MicroCode Processor - 4bit ( SHMCP-4 )**

As the name suggests its a basic microcoded Processor that can run basic programs, i built it to get an basic understanding of computer architecture and it was also fun to design and build.   

---
 
### **Overview :**
- The processor is designed from scratch.
- The Processor operates on 4-bit data.
- Has custom ISA built from ground up to perforom specific operations.
- It follows Harvard architecture.
- The design is built with a hierarchical flow of instructions.
- It is controlled by 8-bit instructions.
- Each bit is given specific function to optimise the instruction set by using as less instructions as possible.
- The full simulation design is available here,   
    [**SHMCP_4**](https://github.com/ShreyasKombinadka/Simple-Hierarchical-MicroCode-Processor-4bit/tree/main/SHMCP_4_simulation)  

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

### **Progress :**  
- [x] Design
- [x] Building in verilog
- [x] Testing & verification
- [ ] Implementation in FPGA board

---

### **Results :**
#### **1. Simulation :**   
##### **Elaborated design**    
![Failed to load the image!](SHMCP_4_simulation/doc/schematic.png "Elaborated design of SHMCP-4")  

##### **Test sequence**
```sv ,
{
    clk, rst ;  // Clock and Reset
    state ; // Enable for instruction load
    load ;  // Instruction load enable
    [7:0] instr ;   // Instruction input

}

begin

    rst = 1 ; state = 0 ; load = 0 ; instr = 0 ;
    @( negedge clk ) ; rst = 0 ; instr = 8'h0F ; load = 1 ;
    @( negedge clk ) ; instr = 8'h2A ;  // 10 -> A
    @( negedge clk ) ; instr = 8'h41 ;  // 1 -> B
    @( negedge clk ) ; instr = 8'h0D ;  // ADD ( A - B )
    @( negedge clk ) ; instr = 8'h07 ;  // R -> X1
    @( negedge clk ) ; instr = 8'h34 ;  // JNZ
    @( negedge clk ) ; instr = 8'h06 ;  // R -> A
    @( negedge clk ) ; instr = 8'h00 ;  // NOP
    
    #10
    @( negedge clk ) ; state = 1 ; load = 0 ;   // Run the programm
    #400 ; $finish ;

end

```

##### **Waveform**

![Failed to load the image!](SHMCP_4_simulation/doc/waveform.png "Simulation waveform")

#### **2. Implimentation :**
    FPGA implementation is yet to be done but will be updated once completed..!

---

### **NOTE :**
- This is just a simple model for me to learn stuff so it has many flaws and potential failures but designing and building this was very fun and gave me a deeper insight into the hardware design.
- Also i am building the same design on real hardware using logic IC's on breadboards, its kind of a lagging behind because it takes more time to actually have the design working with real world limitations and problems, so if you wanna check it out heres the link,   
    [**Breadboard-CPU-4bit**](https://github.com/ShreyasKombinadka/Breadboard-CPU-4bit)