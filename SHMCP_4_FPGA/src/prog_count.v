module prog_count (
    input clk, rsbt,
    input state,    // State of programm
    input load, // Enable for instruction load
    input [3:0] pc_count,   // Jump address
    input [7:0] instr,
    output [3:0] pc, // Instruction mem pointer
    output reg trm  // Termination flag
);

reg state_prev;
reg load_prev;

reg [2:0] nop_c;

reg [3:0] i;

always @(posedge clk or posedge rsbt)
begin
    if(rsbt)
    begin
        load_prev <= 0 ;
        state_prev <= 0;
        nop_c <= 0;
        trm <= 0;
        i <= 1;
    end
    else
    begin
        if(state != state_prev)
        begin
            i <= 1;
            trm <= 0;
            nop_c <= 0;
            state_prev <= state;
        end
        else
        begin
            if(state)
            begin
                if(instr == 0 && nop_c <= 3 && ~trm) nop_c <= nop_c + 1;
                else nop_c <= 0;

                if(i == 15 || nop_c >= 3) trm <= 1;

                if(pc_count != 0) i <= pc_count;    // Jump to the pointed address
                else if (pc_count == 0 && i < 15 && ~trm) i <= i + 1;    // No jump instructions incriment address
                else i <= 0;
            end
            else
            begin
                if(load != load_prev)
                begin
                    if(load)
                    begin
                        if(i > 0 && i < 15) i <= i + 1;
                        else if(i == 15) i <= 15;
                    end

                    load_prev <= load;
                end
            end
        end
    end
end

assign pc = ( i <= 15 ) ? i : 0;

endmodule