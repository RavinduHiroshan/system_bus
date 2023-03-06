`timescale 1ns / 1ps

module slave_in_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset, rx_address, rx_data, master_valid,
master_ready, read_en, write_en, rx_burst;

wire slave_ready, rx_done;
wire [11:0]address;
wire [7:0]data;

reg [7:0]data_stream = 8'b10111101;
reg [11:0]address_stream = 12'b101011011101;
reg [12:0]burst_stream = 13'b1010110101101;

slave_in_port slave_in (
.clk(clk), 
.reset(reset),
.rx_address(rx_address),
.rx_data(rx_data),
.master_valid(master_valid),
.master_ready(master_ready),
.read_en(read_en),
.write_en(write_en),
.rx_burst(rx_burst),

.slave_ready(slave_ready),
.rx_done(rx_done),

.address(address),
.data(data));

initial begin
    clk = 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end


initial begin
    rx_data <= 0;
    for (reg i=0; i<8; i=i+1)
    begin
        rx_data <= data_stream[i];
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
    reset = 0;
    #(CLOCK_PERIOD)
    rx_burst <= 0;
    write_en <= 1;
    master_valid <= 1;

end


endmodule
