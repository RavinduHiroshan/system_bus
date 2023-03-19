`timescale 1ns / 1ps
module master_port_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset,
address,
data,
burst_num,
slave_select,
instruction,
approval_grant,
busy,
slave_ready,
rx_done;

wire approval_request,
tx_slave_select,
master_ready,
master_valid,
tx_address,
tx_data,
tx_burst_number,
tx_done,
write_en,
read_en;

reg slave_valid,
rx_data;

wire new_rx;
wire slave_tx_done;

reg [7:0]data_stream = 8'b10111101;
reg [11:0]address_stream = 12'b101011011101;
reg [12:0]burst_stream = 13'b1010110101101;
reg [1:0]instruction_stream = 2'b10;
reg [2:0]slave_select_stream = 3'b101;


master_port master_port(
     .clk(clk),
     .reset(reset),
     .address(address),              
     .data(data),                  
     .burst_num(burst_num),          
     .slave_select(slave_select),          
     .instruction(instruction),                
     .approval_grant(approval_grant),                    
     .busy(busy),                                 
     .slave_ready(slave_ready),                          
     .rx_done(rx_done),                              
    
     .approval_request(approval_request),
     .tx_slave_select(tx_slave_select),
     .master_ready(master_ready),
     .master_valid(master_valid),
     .tx_address(tx_address),
     .tx_data(tx_data),
     .tx_burst_number(tx_burst_number),
     .tx_done(tx_done),
     .write_en(write_en),
     .read_en(read_en),

     .slave_valid(slave_valid),                                   
     .rx_data(rx_data),                                            
     .new_rx(new_rx)                                      
);


initial begin
    clk <= 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end


integer num = 0;

initial begin
    #(CLOCK_PERIOD*5)
    forever begin
        #(CLOCK_PERIOD)
        if((num < 3) && approval_grant ==1 )begin
            slave_select <= slave_select_stream[num];
            num <= num + 1;
        end
        else begin
            busy <= 0;
            slave_valid <= 1;
        end
    end
end


initial begin
    reset <= 1;
    busy <= 1;
    #(CLOCK_PERIOD)
    reset <= 0;
    #(CLOCK_PERIOD)
    address <= address_stream;
    data <= data_stream;
    burst_num <= 0;
    instruction <= instruction_stream;
    #(CLOCK_PERIOD*2)
    approval_grant <= 1;



end




endmodule