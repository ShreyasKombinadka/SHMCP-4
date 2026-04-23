module regfile_ctrl (
    input [2:0] rs, // Read select
    input [1:0] ws, // Write select
    output reg rs1,rs2,rs3,rs4,rs5,ws1,ws2,ws3 // Read and write buffer enable
);

always @( * )
begin
    //-----------------------------------------------------
    // Default state for enable falgs
    //-----------------------------------------------------
    rs1 = 0 ; rs2 = 0 ; rs3 = 0 ; rs4 = 0 ; rs5 = 0 ;
    ws1 = 0 ; ws2 = 0 ; ws3 = 0 ;

    //-----------------------------------------------------
    // Read buffer ccontrol
    //-----------------------------------------------------
    case( rs )
        3'b001 : rs1 = 1 ;  // Enable read buffer 1 ( immediate to A )
        3'b010 : rs2 = 1 ;  // Enable read buffer 4 ( BUS to A )
        3'b011 : rs3 = 1 ;  // Enable read buffer 2 ( immediate to B )
        3'b100 : rs4 = 1 ;  // Enable read buffer 4 ( BUS to B )
        3'b101 : rs5 = 1 ;  // Enable read buffer 3 ( immediate to OP )
    endcase

    //-----------------------------------------------------
    // Write buffer ccontrol
    //-----------------------------------------------------
    case( ws )
        2'b01 : ws1 = 1 ;  // Enable write buffer 1 ( A to BUS )
        2'b10 : ws2 = 1 ;  // Enable write buffer 2 ( B to BUS )
        2'b11 : ws3 = 1 ;  // Enable write buffer 3 ( OP to BUS )
    endcase
end

endmodule