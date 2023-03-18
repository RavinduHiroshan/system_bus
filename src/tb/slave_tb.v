`timescale 1ns / 1ps
module slave_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset, rx_address, rx_data, rx_burst, master_valid,
master_ready, read_en, write_en;
wire slave_valid;

wire slave_ready;

reg [7:0]data_stream = 8'b10111101;
reg [11:0]address_stream = 12'b101011011101;
reg [12:0]burst_stream = 13'b1010110101101;

slave slave(
        .clk(clk),
        .reset(reset),

        .read_en(read_en),
        .write_en(write_en),

        .master_ready(master_ready),
        .master_valid(master_valid),
        
        .rx_address(rx_address),
        .rx_data(rx_data),
        .rx_burst(rx_burst),

        .slave_valid(slave_valid),
        .slave_ready(slave_ready)
);

initial begin
    clk <= 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end


// send burst steram
initial begin
    rx_burst <= 0;
    #(CLOCK_PERIOD*5)
    for (reg i=0; i<13; i=i+1)
    begin
        #(CLOCK_PERIOD)
        master_valid <= 1;
        rx_burst <= burst_stream[i];
    end
end

//Send address steam 
initial begin
    rx_address <= 0;
    #(CLOCK_PERIOD*5)
    for (reg k=0; k<12; k=k+1)
    begin
        #(CLOCK_PERIOD)
        master_valid <= 1;
        rx_address <= address_stream[k];
    end

end


// send data steram
initial begin
    rx_data <= 0;
    #(CLOCK_PERIOD*5)
    for (reg j=0; j<8; j=j+1) begin
        #(CLOCK_PERIOD)
        master_valid <= 1;
        rx_data <= data_stream[j];
    end
end

initial begin
    reset <= 1;
    #(CLOCK_PERIOD);
    reset <= 1;
    read_en <= 0;
    write_en <= 1;
    master_ready <= 1;

end




endmodule