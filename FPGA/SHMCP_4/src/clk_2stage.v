module clk_2stage   // Clock generator
#(
    parameter clk_freq = 100_000_000    // Frequency of on-board clk
)(
    input clk_i,    // On-board CLK
    input rst,      // CLK
    input state,    // State of the processor
    input trm,      // Termination flag
    output clk_o    // Output CLK
);

reg state_prev; // Previous state
reg trm_state;  // Termination flag state

localparam cycles0_l = $clog2((clk_freq / 2) + 1);  // Bit count for the CLK1(state == 0) counter

localparam integer sqrt_clk = $sqrt(clk_freq);  // New CLK frequency (reduced the input CLK to its square root)
localparam cycles1_l = $clog2(sqrt_clk + 1);    // Bit count for the CLK2 counter

reg clk_temp;   // Output CLK register
reg [(cycles0_l - 1):0] count0;     // Counter for CLK1(state == 0)
reg [(cycles1_l - 1):0] count1_1;   // First layer counter for CLK2(state == 1)
reg [(cycles1_l - 1):0] count1_2;   // Second layer counter for CLK2(state == 1)

always @(posedge clk_i or posedge rst)
begin
    if(rst)
    begin
        count0 <= 0;
        count1_1 <= 0;
        count1_2 <= 0;
        clk_temp <= 0;
        state_prev <= 0;
        trm_state <= 0;
    end
    else
    begin
        if(state != state_prev) // Reset CLK generation when state has changed
        begin
            state_prev <= state;
            count0 <= 0;
            count1_1 <= 0;
            count1_2 <= 0;
            trm_state <= (trm) ? 1 : 0; // update TRM state
        end
        else
        begin
            if(~state)  // CLK1 generation for programming
            begin
                count0 <= count0 + 1;
                if(count0 >= (clk_freq / 2))
                begin
                    count0 <= 0;
                    clk_temp <= clk_temp ^ 1;
                end
            end
            else        // CLK2 generation for execution
            begin
                count1_1 <= count1_1 + 1;   // First stage counting
                if(count1_1 >= sqrt_clk)
                begin
                    count1_1 <= 0;
                    count1_2 <= count1_2 + 1;   // Second stage counting
                    if(count1_2 >= sqrt_clk)
                    begin
                        count1_2 <= 0;
                        clk_temp <= clk_temp ^ 1;   // CLK toggling
                    end
                end
            end

            if(~trm) trm_state <= 0;    // TRM flag state crearing if flag is cleared
        end
    end
end

assign clk_o = (~trm || trm_state) ? clk_temp : 0;  // CLK output only if TRM is not set or state has changed

endmodule