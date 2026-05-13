module prog_count (
    input clk, rst,
    input state,    // State of programm
    input load, // Enable for instruction load
    input [3:0] pc_count,   // Jump address
    output [3:0] pc // Instruction mem pointer
);

reg state_prev ;
reg load_prev ;

reg [3:0] i ;

always @( posedge clk or posedge rst )
begin
    if ( rst )
    begin
        load_prev <= 0 ;
        i <= 1 ;
    end
    else
    begin
        if (state && state != state_prev) i <= 0 ;
        else if (~state && state != state_prev) i <= 1 ;

        else if (state)
        begin
            if (pc_count != 0)
            begin
                i <= pc_count ;    // Jump to the pointed address
            end
            else if ( ( pc_count == 0 ) && ( i < 15 ) )    // No jump instructions
            begin
                i <= i + 1 ;    // Incriment address
            end
            else i <= 16 ;
        end

        else if (~state  && load != load_prev && load && i <= 15) i <= i + 1 ;

        if( load != load_prev ) load_prev <= load ;
        if (state != state_prev) state_prev <= state ;

    end
end

assign pc = ( i <= 15 ) ? i : 0 ;

endmodule