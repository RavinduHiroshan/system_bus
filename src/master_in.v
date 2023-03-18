`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
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


module MasterIn#(parameter DATA_LEN=8, parameter BURST_LEN=12)(
    input clk,
    input reset,
    //input tx_done,                                            //Signal from slave after finish a transaction
    input slave_valid,                                          //Validate the data transmit by slave
    input rx_data,                                              //Data from the slave
    input [BURST_LEN-1:0]burst_num,                             //Burst number when reading burst data
    input [1:0]instruction,                                     //To initialize the transaction
    input approval_grant,                                       //From arbitor
    
    output reg rx_done,                                         //Output signal to master out when after the rx done
    output reg master_ready,                                    //Master ready signal to slave
    output reg new_rx,                                          //Output signal about new data 
    output reg [DATA_LEN-1:0]data                               //Output data received from slave
    );
    
    parameter IDLE = 0, HANDSHAKE = 1, DATARECEIVE = 2 ;        //States in the state diagram
    integer count_data = 0, count_burst = 0 ;                    
    
    reg [1:0]state = 0;
    reg [DATA_LEN-1:0]data_store_tem;

    integer count = 0;
    integer burst_count = 0;
   
    always @ (posedge clk or posedge reset)
    begin 
        if(reset)
        begin
            state <= IDLE ;
            new_rx <= 0 ;
            master_ready <= 1 ;
            data <= 0 ;
            rx_done <= 0 ;
            count_data <= 0 ;
            count_burst <= 0 ;
            data_store_tem <= 0 ;
            burst_count<=0;
            count<=0;
        end
                
        else
        begin
            case(state)
                IDLE:
                begin
                    if(instruction==2'b11)
                    begin
                        state <= HANDSHAKE;
                    end
                    else
                    begin
                        state <= IDLE;         
                    end
                    new_rx<=0 ;
                    master_ready <=1 ;
                    data <= data;               
                    rx_done <= 0; 
                    count_data <= 0 ;
                    count_burst <= 0;           
                    data_store_tem <= data_store_tem ;
                end
                
                HANDSHAKE:
                  begin
                    if(approval_grant==1)
                        begin
                            if(master_ready==1 && slave_valid==1)
                            begin
                                state <= DATARECEIVE ;
                                master_ready <= 1 ;  
                                data_store_tem[count_data] <= rx_data ;  
                                count_data <= count_data + 1 ; 
                                count_burst <= count_burst + 1 ;  
                            end
                            
                            else
                            begin
                                state <= HANDSHAKE;           
                            end
                        end 
                    else
                    begin
                        state <= IDLE;
                    end               
                  end

                DATARECEIVE:
                    begin
                        if(approval_grant==1)
                            begin
                            if (count_data >DATA_LEN-1)
                            begin 
                                count_data <= 1 ;  
                                if (count_burst>burst_num)
                                begin
                                    state <= IDLE ;
                                    rx_done <= 1;
                                    count_burst <=0; 
                                    data <= data_store_tem; 
                                    data_store_tem[7:0] <= 0;      
                                end

                                else
                                begin
                                    if (slave_valid==1)
                                    begin
                                        state <= DATARECEIVE ;
                                        rx_done <= 0;
                                        count_burst <= count_burst+1;
                                        new_rx <= 1;
                                        data <= data_store_tem;
                                        data_store_tem[count_data-1] <= rx_data;
                                        data_store_tem[7:1] <= 0;
                                    end
                                end  
                                                        
                            end
                            else
                            begin
                                data_store_tem[count_data] <= rx_data;
                                count_data <= count_data + 1;
                                state <= DATARECEIVE;                            	
                                rx_done <= 0;                 
                                new_rx <= 0;          
                                master_ready <= 1;                         
                            end
                        end
                        else
                        begin
                            state <= IDLE;
                        end

                    end
                    default:
                        begin 
                            state <= IDLE;
                        end
            endcase
            
        end           
   end
endmodule