module prog_count ( // Programm counter
    input clk, rsbt,        // clock and reset or rebbot
    input state,            // State of programm
    input load,             // Enable for instruction load
    input [3:0] pc_count,   // Jump address
    input [7:0] instr,      // Instruction outputed by the instruction memory
    output [3:0] pc,        // Instruction mem pointer
    output reg trm          // Termination flag
);

reg state_prev; // Previous processor state
reg load_prev;  // Previous load button state

reg [2:0] nop_c;    // NOP instruction count

reg [3:0] i;    // Temporary PC value counter

always @(posedge clk or posedge rsbt)
begin
    if(rsbt)    // Clear on reset or reboot
    begin
        load_prev <= 0 ;
        state_prev <= 0;
        nop_c <= 0;
        trm <= 0;
        i <= 1; // Skip first location of instr memory
    end
    else
    begin
        if(state != state_prev) // Restart PC if state changes
        begin
            i <= 1;
            trm <= 0;
            nop_c <= 0;
            state_prev <= state;
        end
        else
        begin
            if(state)   // Programm run state(Auto incriment)
            begin
                if(instr == 0 && nop_c <= 3 && ~trm) nop_c <= nop_c + 1;    // NOP instruction count
                else nop_c <= 0;

                if(i == 15 || nop_c >= 3) trm <= 1; // Termination flag setting

                if(pc_count != 0) i <= pc_count;    // Jump to the pointed address
                else if (pc_count == 0 && i < 15 && ~trm) i <= i + 1;    // No jump instructions incriment address
                else i <= 0;
            end
            else        // Programm load state(Manual incriment)
            begin
                if(load != load_prev)
                begin
                    if(load)    // Incriment PC if load button has been pressed
                    begin
                        if(i > 0 && i < 15) i <= i + 1;
                        else if(i == 15) i <= 15;
                    end

                    load_prev <= load;  // Update load button previous state
                end
            end
        end
    end
end

assign pc = ( i <= 15 ) ? i : 0;    // Output PC value

endmodule