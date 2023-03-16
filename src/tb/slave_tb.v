`timescale 1ns / 1ps
module slave_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset, rx_address, rx_data, master_valid,
master_ready, read_en, write_en, slave_valid;

wire slave_ready;

reg [11:0]address_stream = 12'b101011011101;

slave slave(
        .clk(clk),
        .reset(reset),

        .read_en(read_en),
        .write_en(write_en),

        .master_ready(master_ready),
        .master_valid(master_valid),

        .slave_valid(slave_valid),
        .slave_ready(slave_ready),
        .rx_address(rx_address),
        .rx_data(rx_data)
);

initial begin
    clk <= 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end

initial begin
    rx_address <= 0;
    #(CLOCK_PERIOD*5)
    for (reg i=0; i<12; i=i+1)
    begin
        #(CLOCK_PERIOD)
        rx_address <= address_stream[i];
    end

end

initial begin
    reset <= 0;
    #(CLOCK_PERIOD);

end




endmodule