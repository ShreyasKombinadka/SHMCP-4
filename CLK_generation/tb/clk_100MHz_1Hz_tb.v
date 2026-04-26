module clk_100MHz_1Hz_tb;
reg clk_in;
reg rst;
wire clk_out;

clk_100MHz_1Hz dut(.clk_in(clk_in), .rst(rst), .clk_out(clk_out));

initial clk_in = 0;
always #5 clk_in = ~clk_in;

initial
begin
    rst = 1 ;
    @(posedge clk_in) ; rst = 0;
    repeat(3) @(posedge clk_out) ; $finish;
end

endmodule