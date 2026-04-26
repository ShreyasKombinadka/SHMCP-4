module clk_100MHz_1Hz
(
    input clk_in,
    input rst,
    output reg clk_out
);

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
        if(count1 >= 10_000)
        begin
            count1 <= 0;
            count2 <= count2 + 1;
            if(count2 >= 10_000)
            begin
                count2 <= 0;
                clk_out <= clk_out ^ 1;
            end
        end
    end
end

endmodule