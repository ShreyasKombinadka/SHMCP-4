module out_mux  // Output MUX
#(  parameter
    data_l = 4, // Number of bits
    data_c = 9, // Number of data to MUX
    sel_l = 3   // Number of select lines
)(
    input [(data_c * data_l)-1:0] data_i,   // Input pcket contaning data to MUX
    input [sel_l-1:0] sel,                  // Select lines
    output [data_l-1:0] data_o              // Selected data to output
);

assign data_o = data_i[(sel * data_l) +: data_l];   // Selecting required data out of the packet

endmodule