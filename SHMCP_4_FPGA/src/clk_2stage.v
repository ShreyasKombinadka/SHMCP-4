module clk_2stage
#(
    parameter clk_freq = 100_000_000
)(
    input clk_in,
    input rst,
    input state,
    output reg clk_out
);

reg state_prev ;

localparam cycles0_l = $clog2((clk_freq / 2) + 1);
reg [(cycles0_l - 1):0] cycles0 = (clk_freq / 2);

localparam cycles1_l = $clog2($sqrt(clk_freq) + 1);
reg [(cycles1_l - 1):0] cycles1 = $sqrt(clk_freq);

reg [(cycles0_l - 1):0] count0;
reg [(cycles1_l - 1):0] count1_1;
reg [(cycles1_l - 1):0] count1_2;

always @(posedge clk_in or posedge rst)
begin
    if(rst)
    begin
        count0 <= 0;
        count1_1 <= 0;
        count1_2 <= 0;
        clk_out <= 0;
    end
    else
    begin
        if(~state)
        begin
            count0 <= count0 + 1;
            if(count0 >= cycles0)
            begin
                count0 <= 0;
                clk_out <= clk_out ^ 1;
            end
        end
        else
        begin
            count1_1 <= count1_1 + 1;
            if(count1_1 >= cycles1)
            begin
                count1_1 <= 0;
                count1_2 <= count1_2 + 1;
                if(count1_2 >= cycles1)
                begin
                    count1_2 <= 0;
                    clk_out <= clk_out ^ 1;
                end
            end
        end

        if(state != state_prev)
        begin
            state_prev <= state;
            count0 <= 0;
            count1_1 <= 0;
            count1_2 <= 0;
        end
    end
end

endmodule