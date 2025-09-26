`include "parameters.v"

module limit_counter(
    input clk, rst,
    output reg limit
);
reg[`counter_size-1:0] counter;

    always @(posedge clk) begin
        if(rst==1) begin
            counter <=0;
            limit <=0;
        end
        else if(counter >= `r_r_limit) begin
            limit<=1;
        end
        else begin
            counter <= counter+1;
            limit <=0;
        end
    end

endmodule