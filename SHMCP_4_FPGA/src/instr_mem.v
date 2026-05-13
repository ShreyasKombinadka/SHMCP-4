module instr_mem (
    input clk, rst,
    input state,    // Program state
    input load, // Enable for instruction load
    input [3:0] pc, // Program counter
    input [7:0] instr_i,    // Instruction in
    output [7:0] instr_o    // Instruction out
);

reg [7:0] instr_mem[15:0] ;  // Memory element
integer i ;

reg load_prev ;

always @( posedge clk or posedge rst )
begin
    if ( rst )
    begin
        load_prev <= 0 ;
        for ( i = 0 ; i <= 15 ; i = i + 1 )
        begin
            instr_mem[i] <= 8'b0 ;
        end
    end
    else
    begin
        if ( ( ~state ) && ( load == 1 && load != load_prev ) && ( pc > 0 ) )
        begin
            instr_mem[pc] <= instr_i ; // write instruction to memory
        end

        if( load != load_prev )
        begin
            load_prev <= load ;
        end
    end
end

assign instr_o = ( state ) ? instr_mem[pc] : 0 ;    // Pass the instruction to Datapath

endmodule