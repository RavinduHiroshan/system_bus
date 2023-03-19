`timescale 1ns / 1ps
module master_port_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;
reg reset;
//burst_num;
//address,
//data,

//reg [2:0]slave_select;
reg [1:0]instruction;
reg approval_grant,
busy,
slave_ready;

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
wire [0:7]data_input;

reg [7:0]data_stream = 8'b10101010;
reg [11:0]address_stream = 12'b101011011101;
reg [12:0]burst_stream = 13'b0;
reg [1:0]instruction_stream = 2'b10;
reg [2:0]slave_select_stream = 3'b101;


master_port master_port(
     .clk(clk),
     .reset(reset),
     .address(address_stream),              
     .data (data_stream),                  
     .burst_num(burst_stream),          
     .slave_select(slave_select_stream),          
     .instruction(instruction),                
     .approval_grant(approval_grant),                    
     .busy(busy),                                 
     .slave_ready(slave_ready),                                                      
    
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
     .new_rx(new_rx),
     .data_input(data_input)                                      
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
    #(CLOCK_PERIOD*60)
    forever begin
        #(CLOCK_PERIOD)
        if((instruction == 2'b11) && (num < 8))begin
            slave_valid <= 1;
            rx_data <= data_stream[num];
            num <= num + 1;
        end
        else begin
            slave_ready <= 0;
            slave_valid <= 0;
        end
    end
end


initial begin
    reset <= 1;
    busy <= 0;
    rx_data <= 0;
    slave_ready <= 0;
    approval_grant <= 0;
    busy <= 0;
    slave_valid <= 0;
    slave_ready <= 0;
    #(CLOCK_PERIOD)
    reset <= 0;
    instruction <= instruction_stream;
    slave_ready <= 1;
    #(CLOCK_PERIOD*3)
    approval_grant <= 1;
    busy <=1;
    #(CLOCK_PERIOD*3)
    busy <=0;
    #(CLOCK_PERIOD*40)
    slave_ready <= 0;
    reset <= 0;
    busy <= 0;
    slave_ready <= 0;
    approval_grant <= 0;
    busy <= 0;
    instruction <= 2'b11;
    #(CLOCK_PERIOD*4)
    approval_grant <= 1;
    busy <=1;
    #(CLOCK_PERIOD*4)
    busy <= 0;


end
endmodule