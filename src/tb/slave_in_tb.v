`timescale 1ns / 1ps

module slave_in_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset, rx_address, rx_data, master_valid,
master_ready, read_en, write_en, rx_burst;

wire slave_ready, rx_done;
wire [11:0]address;
wire [7:0]data;

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
    reset = 0;
    #(CLOCK_PERIOD)
    rx_data = 1;
    rx_burst = 0;
    rx_address = 1;
    write_en = 1;
    master_valid = 1;

end


endmodule
