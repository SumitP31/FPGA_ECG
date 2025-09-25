`include "diff.v"
`include "limit_counter.v"

module r_peak(
    input clk,rst,
    input [7:0] d_in,
    output reg r_peak,
    output reg slope_,
    output reg[8:0] diff 
);

wire[8:0] d_out;

reg rst_cnt;
wire limit;

diff uut(
    .clk(clk), 
    .rst(rst), 
    .d_in(d_in), 
    .d_out(d_out)
    );

limit_counter llt(
    .clk(clk), 
    .rst(rst_cnt), 
    .limit(limit)
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
        rst_cnt <= 1;
    end

    else begin
        rst_cnt <=0;
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

    diff<=d_out;
    slope_ <= slope;
    r_peak<=0;

end

always @(posedge slope) begin
    if (limit == 1) begin
    r_peak <= slope;       
    rst_cnt<=1;
    end    
end

endmodule