// Filter to Account for Bouncing State of Switch Input

module debounce_filter
#(
    parameter DEBOUNCE_MAX = 250000                               // 10ms of time to account for any debouncing occuring from switch input. 10ms/40ns (clock period) = 250,000 clock cycles
)
(
    input  i_clk,
    input  i_rst,
    input  i_switch_1,
    output o_switch_debounced
);

    reg [$clog2(DEBOUNCE_MAX)-1:0] r_debounce_cnt;
    reg r_switch_state;

    always @(posedge i_clk) begin   
        if(i_rst) begin
            r_debounce_cnt     <= 0;
            r_switch_state     <= 0;
        end else begin
            // If switch input differs from switch state, start incrementing counter until stable enough time
            if (i_switch_1 !== r_switch_state && (r_debounce_cnt < (DEBOUNCE_MAX-1))) begin
                r_debounce_cnt <= r_debounce_cnt + 1;  
            // If counter reaches max time, then register switch state
            end else if (r_debounce_cnt == (DEBOUNCE_MAX-1)) begin
                r_switch_state <= i_switch_1;
                r_debounce_cnt <= 0;
            // If switch input is the same as switch state, reset counter to 0
            end else begin
                r_debounce_cnt <= 0;
            end
        end
    end

    assign o_switch_debounced = r_switch_state;

endmodule