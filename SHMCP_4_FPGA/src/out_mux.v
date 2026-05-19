module out_mux
#{  parameter
    data_l = 4,
    data_c = 9,
    sel_l = 3
}{
    input clk, rst,
    input [(data_c * data_l)-1:0] data_i,
    input [sel_l-1:0] sel,
    output reg [data_l-1:0] data_o
}

always @(posedge clk or posedge rst)
begin
    if(rst) data_o <= 0;

    else data_o <= data_i[((sel * data_l) - (data_l - 1)):(sel * data_l)];
end

endmodule