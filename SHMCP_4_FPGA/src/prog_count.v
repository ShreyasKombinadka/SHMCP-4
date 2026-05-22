module prog_count (
    input clk, rst,
    input state,    // State of programm
    input load, // Enable for instruction load
    input [3:0] pc_count,   // Jump address
    input [7:0] instr,
    output [3:0] pc, // Instruction mem pointer
    output trm
);

reg state_prev;
reg load_prev;

reg trm;   // Termination flag
reg [2:0] nop_c;

reg [3:0] i;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        load_prev <= 0 ;
        state_prev <= 0;
        i <= 1;
        nop_c <= 0;
        trm <= 0;
    end
    else
    begin
        if(state != state_prev)
        begin
            if (state) i <= 0;
            else if (~state) i <= 1;

            trm <= 0;
            state_prev <= state;
        end

        else if(state)
        begin
            if(instr == 0 && nop_c <= 3 && nop_c) nop_c <= nop_c + 1;
            else nop_c <= 0;

            if(i == 15 || nop_c >= 3) trm <= 1;

            if(pc_count != 0) i <= pc_count;    // Jump to the pointed address
            else if (pc_count == 0 && i < 15 && ~trm) i <= i + 1;    // No jump instructions incriment address
            else i <= 0;
        end

        else if(~state && load != load_prev)
        begin
            if(load && i <= 15) i <= i + 1;

            load_prev <= load;
        end
    end
end

assign pc = ( i <= 15 ) ? i : 0;

endmodule