`include"r_peak.v"
`include "parameters.v"


module qrs (
    input clk,rst,
    input [`data_input-1:0] d_in,
    output reg [`data_output-1:0] qrs,
    output reg[`data_output-1:0] r_r_int,
    output reg[`data_input:0] diff_,
    output reg slope_
);
    reg[`counter_size-1:0] counter;
    // reg[data_output-1:0] qrs_counter;
    reg [2:0] slope_counter;
    wire [`data_input:0] diff;
    wire slope;
    wire r_peak;
    
    // reg r_r0;
    // reg r_r1;

    r_peak uut(
        .clk(clk),
        .rst(rst),
        .d_in(d_in),
        .r_peak(r_peak),
        .slope_(slope),
        .diff(diff)
    );
    
    always @(posedge clk) begin
        if(rst == 1) begin
            counter <=0;
            r_r_int <=0;
        end

        else begin

            if(r_peak ==1) begin
                r_r_int <= counter;
                counter <=0;
            end

            else begin
                counter <= counter +1;
            end
        end

        diff_ <= diff;
        slope_ <= slope;

    end

    always @(posedge r_peak or negedge slope) begin

        if (rst == 1 | r_peak ==1) begin
            slope_counter <= 1;
        end

        else begin
      
            slope_counter <= slope_counter + 1;

            if (slope_counter == 2) begin
                if(counter <= `qrs_limit) begin
                    qrs <= counter;
                    slope_counter <= 0;              
                end 

                slope_counter <= 0;

            end
        end
    end
   

endmodule