`timescale 1ns / 1ps
module slave_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset, rx_address, rx_data, rx_burst, master_valid,
master_ready, read_en, write_en;
wire rx_done, tx_data;
wire slave_valid;

wire slave_ready, slave_tx_done;

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
        
        .slave_valid(slave_valid),
        .slave_ready(slave_ready),

        .rx_address(rx_address),
        .rx_data(rx_data),
        .rx_burst(rx_burst),

        .slave_tx_done(slave_tx_done),
		.rx_done(rx_done),
		.tx_data(tx_data)        
);

initial begin
    clk <= 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end


// // send burst steram
// initial begin
//     rx_burst <= 0;
//     #(CLOCK_PERIOD*5)
//     for (reg i=0; i<13; i=i+1)
//     begin
//         #(CLOCK_PERIOD)
//         master_valid <= 1;
//         rx_burst <= burst_stream[i];
//     end
// end
// data stream 
integer num = 0;

initial begin
    rx_data <= 0;
    master_valid <= 0;
    #(CLOCK_PERIOD*2)
    forever begin
        #(CLOCK_PERIOD)
        if(num < 8)begin
            master_valid <= 1;
            rx_data <= data_stream[num];
            num <= num + 1;
        end
        else if (num == 8) begin
            master_valid <= 0;
        end
    end
end

// address stream

integer numa = 0;
initial begin
    rx_address <= 0;
    #(CLOCK_PERIOD*2)
    forever begin
        #(CLOCK_PERIOD)
        if(numa < 12)begin
            if(numa < 8)begin
                master_valid <= 1; 
            end
            else begin
                 master_valid <= 0;
            end
            rx_address <= address_stream[numa];
            numa <= numa + 1;
        end
    end
end



initial begin
    reset <= 1;
    master_ready <= 0;
    rx_burst <= 0;
    #(CLOCK_PERIOD);
    reset <= 0;
    read_en <= 0;
    write_en <= 1;
    #(CLOCK_PERIOD);
    master_ready <= 0;
    #(CLOCK_PERIOD*17);
    master_ready <= 1;
    read_en <= 1;
    write_en <= 0;
    numa <= 0;   
end




endmodule