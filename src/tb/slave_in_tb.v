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

integer num = 0;

initial begin
    rx_data <= 0;
    master_valid <= 0;
    #(CLOCK_PERIOD*5)
    forever begin
        #(CLOCK_PERIOD)
        if(num < 8)begin
            master_valid <= 1;
            rx_data <= data_stream[num];
            num <= num + 1;
        end
        else begin
            master_valid <= 0;
        end
    end
end

integer numa = 0;
initial begin
    rx_address <= 0;
    #(CLOCK_PERIOD*5)
    forever begin
        #(CLOCK_PERIOD)
        if(numa < 12)begin
            rx_address <= address_stream[numa];
            numa <= numa + 1;
        end
    end
end


initial begin
    reset = 1;
    #(CLOCK_PERIOD)
    reset = 0;
    rx_burst <= 0;
    write_en <= 1;
    read_en <= 0;
    
    rx_burst <= 0;

end


endmodule
