`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2023 09:59:12 AM
// Design Name: 
// Module Name: MasterOut
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MasterOut#(parameter SLAVE_LEN=2, parameter ADDR_LEN=12, parameter DATA_LEN=8, parameter BURST_LEN=12)(

    input clk,
    input reset,
    input [ADDR_LEN-1:0]address,                //From switches
    input [DATA_LEN-1:0]data,                   //From switches
    input [BURST_LEN-1:0]burst_num,             //From switches
    input [SLAVE_LEN-1:0]slave_select,          //From switches
    input [1:0]instruction,                     //For initialize the transaction
    input approval_grant,                       //From arbitor
    input busy,                                 //From arbitor    
    input slave_ready,                          //From Slave
    input rx_done,                              //From Master In
    
    output reg approval_request,
    output reg tx_slave_select,
    output reg master_ready,
    output reg master_valid,
    output reg tx_address,
    output reg tx_data,
    output reg tx_burst_number,
    output reg tx_done,
    output reg write_en,
    output reg read_en
    
 );  
 
    reg [2:0]state = 0;                          //unsigned number = 0; size = 4 bit (0000)
    parameter IDLE = 3'd0, WAIT_ARBITOR = 3'd1 , WAIT_SLAVE = 3'd2, WRITE_DATA = 3'd3, READ_DATA = 3'd4,READ_DATA_WAITING=3'd5 ,WRITE_DATA_BURST = 3'd6;
    
    integer count_slave = 0;
    integer count_slave_wait_time = 0;
    integer count_address = 0;
    integer count_data = 0;
    integer count_burst = 0;
    integer burst_count = 0;
    integer count = 0;
            
    always@(posedge clk or posedge reset) 
    begin
        if(reset)
        begin
            state <=IDLE;
            approval_request<=0;
            tx_slave_select <=0;
            master_ready <= 1;
            master_valid <= 0;
            tx_address <=0;
            tx_data <=0;
            tx_burst_number<=0;
            tx_done <=0;
            write_en <=0;
            read_en <=0;
            count_slave = 0;
            count_slave_wait_time = 0;
            count_address = 0;
            count_data = 0;
            count_burst = 0;
            burst_count = 0;
        end
        else
        begin
            case (state)
                IDLE:
                begin
                   if ((instruction[1]==1)&&(busy==0))            //Moving to Wait_arbitor state after sending approval request sent
                   begin
                        approval_request<= 1;
                        state <=WAIT_ARBITOR;               
                   end
                   else
                   begin
                        state <=IDLE;
                        approval_request<=0;
                   end
                   tx_slave_select <=0;
                   master_ready <= 1;
                   master_valid <= 0;
                   tx_address <=0;
                   tx_data <=0;
                   tx_burst_number<=0;
                   tx_done <=0;
                   write_en <=0;
                   read_en <=0;
                   count_slave = 0;
                   count_slave_wait_time = 0;
                   count_address = 0;
                   count_data = 0;
                   count_burst = 0;
                   burst_count = 0;
                end
                
                WAIT_ARBITOR:                                  //Wait until arbitor ready signal 
                begin
                    if(approval_grant==1)
                    begin
                        if(count>0)
                        begin
                            tx_slave_select <= slave_select[count_slave];
                            count_slave <= count_slave+1;
                            if  (count_slave>SLAVE_LEN)
                            begin
                                count<=0;
                                count_slave<=0; 
                                state<=  WAIT_SLAVE;   
                            end  
                        end
                        else
                        begin
                            count<=count+1;
                        end
                    end 
                    else if (busy==1)
                    begin
                        state <=WAIT_ARBITOR;
                    end
                end
                
                WAIT_SLAVE:
                begin
                    if(slave_ready==1)
                        count_slave_wait_time<=0;
                        master_ready <= 0;                           //Bcz master is occupied by a slave for transaction
                        if (instruction[0]==0)
                        begin
                            state<=WRITE_DATA;
                            write_en <= 1 ;
                        end
                        else if(instruction[0]==1)
                        begin
                            state<=READ_DATA;
                            read_en <= 1 ;
                        end
                    else if (count_slave_wait_time>10)                //Wait 10 clk cycles until slave ready. Otherwise stop transaction move to IDEAL state
                        begin
                            state <=IDLE;
                            count_slave_wait_time<=0;
                        end
                    else
                        begin
                            count_slave_wait_time = count_slave_wait_time+1; 
                        end
                end
                
                READ_DATA:
                begin
                    if(count_address<ADDR_LEN)
                    begin
                        tx_address <=address[count_address];
                        count_address<=count_address+1;
                    end
                    else
                    begin
                        count_address<=ADDR_LEN+2;
                    end
                    
                    if (burst_num==11'd0)
                    begin
                        tx_burst_number<=0;
                    end
                    else if (count_burst<BURST_LEN)
                    begin
                        count_burst<=count_burst+1;
                        if (count_burst==1)
                        begin
                            tx_burst_number<=1;
                        end
                        else 
                        begin
                           tx_burst_number <= burst_num[count_burst-1]; 
                        end
                    end
                    else
                    begin
                        count_burst<=BURST_LEN+2;
                    end
                    
                    if((count_address>ADDR_LEN)&&(count_burst>BURST_LEN))
                    begin
                        state<=READ_DATA_WAITING;
                    end
                end
               
                READ_DATA_WAITING:              //Data read by masterIn port.  Waiting until masterIn port response
                begin
                    if (rx_done==1)
                    begin
                        state<=IDLE;
                    end
                    else
                    begin
                      state<= READ_DATA_WAITING; 
                    end
                end
                
                WRITE_DATA:
                begin
                    if(count_address<ADDR_LEN)
                    begin
                        tx_address <= address[count_address];
                        count_address <= count_address+1;
                    end
                    else
                    begin
                        count_address<=ADDR_LEN+3;
                    end
                    
                    if (burst_num==11'd0)
                    begin
                        tx_burst_number<=0;
                    end
                    else if (count_burst<BURST_LEN+1)
                    begin
                        count_burst<=count_burst+1;
                        if (count_burst==1)
                        begin
                            tx_burst_number<=1;
                        end
                        else 
                        begin
                           tx_burst_number <= burst_num[count_burst-2]; 
                        end
                    end
                    else
                    begin
                        count_burst<=BURST_LEN+3;
                    end
                    
                    if(count_data<DATA_LEN+1) 
                    begin                        
                        if(count_data==0)
                        begin
                            master_valid<=1;
                        end
                        else
                        begin
                            tx_data<= data[count_data-1] ;
                        end                      
                        count_data<= count_data+1;
                    end  
                    else
                    begin
                        count_data<= DATA_LEN+3;
                    end 
                    
                    if((count_address>ADDR_LEN)&&(count_burst>BURST_LEN)&&(count_data>DATA_LEN))
                    begin
                        if(burst_num==11'd0)
                        begin
                           tx_done<=1;                                 //Over the writing transmission when no burst 
                           state<=IDLE;
                        end
                        else
                        begin
                           burst_count <= burst_num;                  
                           count_data<=0;
                           state<=WRITE_DATA_BURST;                            
                        end
                    end                                                                          
                end
                
                WRITE_DATA_BURST:
                begin
                    if(burst_count>1)
                    begin
                        if(count_data<DATA_LEN) 
                        begin
                            // master_valid<=1;
                            tx_data<= data[count_data] ;
                            count_data<= count_data+1;
                        end  
                        else
                        begin
                            count_data<= 0;
                            burst_count <=burst_count-1;
                        end
                    end
                    else
                    begin
                        tx_done<=1;                                 //Over the writing transmission when no burst 
                        state<=IDLE;
                    end
                end
                
                default:
                begin
                  state<=IDLE;  
                end
            endcase
        end
    end
       
endmodule