module out_mux
#(  parameter
    data_l = 4,
    data_c = 9,
    sel_l = 3
)(
    input [(data_c * data_l)-1:0] data_i,
    input [sel_l-1:0] sel,
    output [data_l-1:0] data_o
);

assign data_o = data_i[(sel * data_l) +: data_l];

endmodule