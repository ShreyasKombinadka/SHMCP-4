module clk_2stage
#(
    parameter clk_freq = 100_000_000
)(
    input clk_i,
    input rst,
    input state,
    input trm,
    output clk_o
);

reg state_prev;

localparam cycles0_l = $clog2((clk_freq / 2) + 1);

localparam integer sqrt_clk = $sqrt(clk_freq);
localparam cycles1_l = $clog2(sqrt_clk + 1);

reg clk_temp;
reg [(cycles0_l - 1):0] count0;
reg [(cycles1_l - 1):0] count1_1;
reg [(cycles1_l - 1):0] count1_2;

always @(posedge clk_i or posedge rst)
begin
    if(rst)
    begin
        count0 <= 0;
        count1_1 <= 0;
        count1_2 <= 0;
        clk_temp <= 0;
        state_prev <= 0;
    end
    else
    begin
        if(state != state_prev)
        begin
            state_prev <= state;
            count0 <= 0;
            count1_1 <= 0;
            count1_2 <= 0;
        end
        else
        begin
            if(~state)
            begin
                count0 <= count0 + 1;
                if(count0 >= (clk_freq / 2))
                begin
                    count0 <= 0;
                    clk_temp <= clk_temp ^ 1;
                end
            end
            else
            begin
                count1_1 <= count1_1 + 1;
                if(count1_1 >= sqrt_clk)
                begin
                    count1_1 <= 0;
                    count1_2 <= count1_2 + 1;
                    if(count1_2 >= sqrt_clk)
                    begin
                        count1_2 <= 0;
                        clk_temp <= clk_temp ^ 1;
                    end
                end
            end
        end
    end
end

assign clk_o = (~trm || state != state_prev) ? clk_temp : 0;

endmodule