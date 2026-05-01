module prog_count (
    input clk, rst,
    input state,    // State of programm
    input load, // Enable for instruction load
    input [3:0] pc_count,   // Jump address
    output [3:0] pc // Instruction mem pointer
);

reg load_prev ;

integer i = 0 ;

always @( state )
begin
    i <= 0 ;    // Start loading or execution from start
end

always @( posedge clk or posedge rst )
begin
    if ( rst )
    begin
        load_prev <= 0 ;
        i <= 1 ;
    end
    else if ( state )
    begin
        if ( pc_count != 0 )
        begin
            i <= pc_count ;    // Jump to the pointed address
        end
        else if ( ( pc_count == 0 ) && ( i < 15 ) )    // No jump instructions
        begin
            i <= i + 1 ;    // Incriment address
        end
        else
        begin
            i <= 16 ;
        end
    end
    else if ( ( ~state ) && ( load != load_prev && load ) && ( i <= 15 ) )
    begin
        i <= i + 1 ;
    end

    if( load != load_prev )
    begin
        load_prev <= load ;
    end
end

assign pc = ( i <= 15 ) ? i : 0 ;

endmodule