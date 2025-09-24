module diff (
    input clk,rst,
    input [7:0] d_in,
    output reg [8:0] d_out
);
    
    reg[7:0] d_in_prev;
    reg[8:0] v_diff;

    always @(posedge clk) begin
        if (rst ==1) begin  
            d_in_prev <= 0;
            v_diff <= 256;
        end
        else begin
           v_diff <= d_in + 256 - d_in_prev;
            d_in_prev <= d_in;
        end
        d_out <= v_diff;
    end

endmodule 