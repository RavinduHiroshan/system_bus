`timescale 1ns / 1ps
module arbiter_tb;
parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset,  m1_request, m2_request, slave_select;
wire [1:0]bus_grant;
wire [2:0]slave_grant;
wire m1_grant, m2_grant;
arbiter arbiter(
    .clk(clk),
    .reset(reset),
    .m1_request(m1_request),
    .m2_request(m2_request),
    .slave_select(slave_select),

    .m1_grant(m1_grant),
    .m2_grant(m2_grant),
    .busy(busy),
    .bus_grant(bus_grant),
    .slave_grant(slave_grant)
);

reg [2:0]slave_bits = 3'b101;
initial begin
    clk = 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end
initial begin
    reset <= 1;
    slave_select <= 0;
    m1_request <= 0;
    m2_request <= 0;
    #(CLOCK_PERIOD)
    reset <= 0;
    #(CLOCK_PERIOD)
    m1_request <= 1;
    m2_request <= 0;
    #(CLOCK_PERIOD*5)
    m1_request <= 0;
    m2_request <= 1;
    #(CLOCK_PERIOD*5)
    slave_bits <= 3'b111;
    counterr <= 0;
    m1_request <= 1;
    m2_request <= 1;
end
integer counterr = 0;
initial begin
    #(CLOCK_PERIOD*5)
    forever begin
        #CLOCK_PERIOD
        if(m1_grant==1 && counterr  < 3) begin
            slave_select <= slave_bits[counterr];
            counterr <= counterr + 1;
        end
        else begin
            slave_select <= 0;
        end
    end
end
endmodule