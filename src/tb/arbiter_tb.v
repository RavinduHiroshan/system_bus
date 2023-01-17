`timescale 1ns / 1ps
module arbiter_tb;
parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset,  m1_request, m2_request, transaction_done;
wire [1:0]bus_grant;
wire m1_grant, m2_grant;
arbiter arbiter(
    .clk(clk),
    .reset(reset),
    .m1_request(m1_request),
    .m2_request(m2_request),
    .transaction_done(transaction_done),
    .m1_grant(m1_grant),
    .m2_grant(m2_grant),
    .busy(busy),
    .bus_grant(bus_grant)
);
initial begin
    clk = 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end
initial begin
    #30
    m1_request <= 1;

    #30
    m2_request <= 1;

    #30
    transaction_done <= 1;
    #30
    m2_request <= 1;
    m1_request <= 0;
    transaction_done <= 0;


    #30
    m1_request <= 1;

    #30
    reset <= 1;

end
endmodule