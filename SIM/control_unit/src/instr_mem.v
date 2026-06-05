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

always @( posedge clk or posedge rst )
begin
    if ( rst )
    begin
        for ( i = 0 ; i <= 15 ; i = i + 1 )
        begin
            instr_mem[i] <= 8'b0 ;
        end
    end
    else if ( ( ~state ) && ( load ) && ( pc > 0 ) )
    begin
        instr_mem[pc] <= instr_i ; // write instruction to memory
    end
end

assign instr_o = ( state ) ? instr_mem[pc] : 0 ;    // Pass the instruction to Datapath

endmodule