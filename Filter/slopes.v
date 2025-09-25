`include "diff.v"

module r_peak(
    input clk,rst,
    input [7:0] d_in,
    output reg r_peak,
    output reg[8:0] diff 
);

wire[8:0] d_out;

diff uut(
    .clk(clk), 
    .rst(rst), 
    .d_in(d_in), 
    .d_out(d_out)
    );

parameter vth_p = 265;
parameter vth_n = 250;

reg [3:0] counter;

reg high;
reg low;
reg slope;

always @(posedge clk) begin
    if (rst == 1) begin
        high <= 0;
        low <= 0;
        slope <= 0;
        counter <= 0;
    end

    else begin
        if(d_out>=vth_p) begin
            slope<=1;
        end

        else if(d_out<=vth_n) begin
            slope<=1;
        end
        
        else if (d_out<=vth_p | d_out>=vth_n) begin
            slope <=0;
        end
        else begin
            slope <= 0;
        end
    end

    r_peak <= slope;
    diff<=d_out;

end

endmodule