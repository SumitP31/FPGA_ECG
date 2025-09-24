module limit_counter(
    input clk, rst,
    output reg limit
);
reg[31:0] counter;

    always @(posedge clk) begin
        if(rst==1) begin
            counter <=0;
            limit <=0;
        end
        else if(counter >= 20) begin
            limit<=1;
        end
        else begin
            counter <= counter+1;
            limit <=0;
        end
    end

endmodule