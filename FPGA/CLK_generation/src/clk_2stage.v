module clk_2stage
#(
    parameter clk_freq = 100_000_000
)(
    input clk_in,
    input rst,
    output reg clk_out
);

localparam cycles_l = $clog2($sqrt(clk_freq) + 1);
reg [(cycles_l - 1):0] cycles = $sqrt(clk_freq);

reg [9:0] count1;
reg [9:0] count2;

always @(posedge clk_in or posedge rst)
begin
    if(rst)
    begin
        count1 <= 0;
        count2 <= 0;
        clk_out <= 0;
    end
    else
    begin
        count1 <= count1 + 1;
        if(count1 >= cycles)
        begin
            count1 <= 0;
            count2 <= count2 + 1;
            if(count2 >= cycles)
            begin
                count2 <= 0;
                clk_out <= clk_out ^ 1;
            end
        end
    end
end

endmodule