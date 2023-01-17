`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2023 01:57:45 PM
// Design Name: 
// Module Name: MasterIn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This MasterInput port module is for the reading the data from slave and display in the LCD display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MasterIn(
    input clk,
    input reset,
    input tx_done,                                              //Signal from slave after finish a transaction
    input slave_valid,                                          //Validate the data transmit by slave
    input rx_data,                                              //Data from the slave
    input [11:0]burst_num,                                      //Burst number when reading burst data
    input [1:0]instruction,                                     //No idea about this
    
    output reg rx_done,                                         //Output signal to master out when after the rx done
    output reg master_ready,                                    //Master ready signal to slave
    output reg new_rx,                                          //Output signal about new data 
    output reg [7:0]data                                        //Output data received from slave
    );
    
    parameter IDLE = 0, HANDSHAKE = 1, DATARECEIVE = 2 ;         //States in the state diagram
    integer count_data = 0, count_burst = 0 ;                    
    
    reg [1:0]state = 0;
    reg [7:0]data_store_tem;

    integer count = 0;
    integer burst_count = 0;
   
    always @ (posedge clk or posedge reset)
    begin 
        if(reset)
        begin
            state <= IDLE;
            new_rx <=0 ;
            master_ready <=1 ;
            data <= 0;
            rx_done <= 0;
            count_data <= 0 ;
            count_burst <= 0;
            data_store_tem <=0;
        end
                
        else
        begin
            case(state)
                IDLE:
                begin
                    if(tx_done==1 && instruction==2'b11)
                    begin
                        state <= HANDSHAKE;
                    end
                    else
                    begin
                        state <= IDLE;         
                    end
                    new_rx<=0 ;
                    master_ready <=1 ;
                    data <= data;               //Last data received in early transaction
                    rx_done <= 0; 
                    count_data <= 0 ;
                    count_burst <= 0;           //Change bcz ideal state after the end of data receive
                    data_store_tem <= data_store_tem;
                end
                HANDSHAKE:
                  begin
                    if(master_ready==1 && slave_valid==1)
                    begin
                        state <= DATARECEIVE;
                        master_ready <=0 ;
                        count_data <=  1;                         //Change Bcz at handshake state get the initial bit of data;
                        data_store_tem[0] <= rx_data;        //Change bcz handshake after the receive data
                    end
                    
                    else
                    begin
                        state <= HANDSHAKE;
                        master_ready <=1; 
                        count_data <=  0;                         //Change Bcz if no handshake then no data 
                        data_store_tem <= data_store_tem;            
                    end
                        new_rx<=0 ;
                        data <= data;
                        rx_done <= 0;                        //Change bcz rx_done after finishes  the data receive  
                        count_burst <= count_burst;                    
                  end
                DATARECEIVE:
                    begin
                        if (count_data >= 7)
                        begin 
                            count_data <= 0 ;
                            if (count_burst>=burst_num)
                            begin
                                state <= IDLE ;
                                rx_done <= 1;
                                count_burst <=0;            //Change Bcz burst count tend to 0 when go to idle. 
                            end
                            else
                            begin
                               state <= HANDSHAKE ;
                               rx_done <= 0;
                               count_burst <= count_burst+1;
                            end 
                            new_rx <=1;
                            master_ready <=1 ; 
                            data <= data_store_tem;        //Change Bcz after every data packet update data output
                            data_store_tem[7] <= rx_data; 
                                                      
                        end
                        else
                        begin
                            count_data <= count_data + 1;
                            state <= DATARECEIVE;
                            data_store_tem[count_data] <= rx_data;
                            data <= data;	
                            rx_done <= 0;                 //Change Bcz this do after one data packet receive
                            new_rx <= 0;                  //Change Bcz this update when output new data from master in port          
                            master_ready <= 0;
                            count_burst <= count_burst;
                         
                        end
                    end
                    default:
                        begin 
                            count_data <= count_data;
                            state <= IDLE;
                            data	<= data;
                            count_data <= count_data;	
                            rx_done <= 0;
                            new_rx <= 0;
                            master_ready <= 1;
                            count_burst <= count_burst;
                        end
            endcase
            
        end

            
   end
endmodule
