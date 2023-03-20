`timescale 1ns / 1ps
module master_out#(parameter SLAVE_LEN=2, parameter ADDR_LEN=12, parameter DATA_LEN=8, parameter BURST_LEN=12)(

    input clk,
    input reset,
    input [ADDR_LEN-1:0]address,                //From switches
    input [DATA_LEN-1:0]data,                   //From switches
    input [BURST_LEN-1:0]burst_num,             //From switches
    input [SLAVE_LEN-1:0]slave_select,          //From switches
    input [1:0]instruction,                     //For initialize the transaction
    input approval_grant,                       //From arbitor
    input busy,                                 //From arbitor (If other master is occupied busy == 1)    
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

    reg [3:0]state = 0;                          //unsigned number = 0; size = 4 bit (0000)
    reg [3:0]addr_state = 0;
    reg [3:0]burst_state = 0;
    parameter IDLE = 4'd0, 
    WAIT_ARBITOR = 4'd1 , 
    WAIT_SLAVE = 4'd2, 
    WRITE_DATA = 4'd3, 
    READ_DATA = 4'd4,
    READ_DATA_WAITING=4'd5,
    WRITE_DATA_BURST = 4'd6,
    ADDR_SENT = 4'd7, 
    BURST_SENT = 4'd8 ;


    integer count_slave = 0;
    integer count_slave_wait_time = 0;
    integer count_address = 0;
    integer count_data = 0;
    integer count_burst = 11'd0;
    integer burst_count = 0;
    integer count = 0;


    always @ (posedge clk) 
    begin
        if(reset==1)
        begin
            state <= IDLE;
            approval_request <= 0 ;
            tx_slave_select <=0 ;
            master_ready <= 1 ;
            master_valid <= 0 ;
            tx_data <=0;
            tx_done <=0;
            write_en <=0;
            read_en <=0;
            count_slave <= 0;
            count_slave_wait_time <= 0;
            count_data <= 0 ;
            count_burst <= 0;
        end
        else
        begin
            case (state)
                IDLE:
                begin
                   if ((instruction[1]==1)&&(busy==0))            //Moving to Wait_arbitor state after sending approval request sent
                   begin
                        approval_request<= 1;
                        state <= WAIT_ARBITOR;               
                   end
                   else
                   begin
                        state <=IDLE;
                        approval_request<=0;
                   end
                   tx_slave_select <= 0;
                   master_ready <= 1;
                   master_valid <= 0;
                   tx_data <= 0;
                   tx_done <=0;
                   write_en <=0;
                   read_en <=0;
                   count_slave <= 0;
                   count_slave_wait_time <= 0;
                   count_data <= 0;
                   count_burst <= 0;

                end
                
                WAIT_ARBITOR:                                               //Wait until arbitor ready signal 
                begin
                    if(approval_grant==1)
                    begin
                        if(count>0)                                         //Send the address of the slave after one cycle of getting access to the bus
                        begin
                            if (count==1)
                            begin
                                tx_slave_select<= 1 ;
                                count <= count+1 ;
                            end
                            else if (count<4)
                            begin
                                tx_slave_select <= slave_select[count_slave];   //Send the address of the slave
                                count_slave <= count_slave + 1;
                                count<=count+1;
                            end
                            else if (count==4)
                            begin
                                tx_slave_select<= 0 ;
                                count <= 0;
                                count_slave <= 0; 
                                state <=  WAIT_SLAVE;
                            end
                        end
                        else
                        begin
                            count<=count+1;
                        end
                    end 
                    else 
                    begin
                        state <= WAIT_ARBITOR;
                    end
                end
                
                WAIT_SLAVE:
                begin
                    if (approval_grant==1)
                    begin
                        if(busy==0)
                            begin
                                count_slave_wait_time <= 0;
                                master_ready <= 1;                          //Bcz master is occupied by a slave for transaction
                                if (instruction[0]==0)
                                begin
                                    state<=WRITE_DATA;
                                    addr_state<=ADDR_SENT;
                                    burst_state<=BURST_SENT;
                                    write_en <= 1 ;
                                end
                                else if(instruction[0]==1)
                                begin
                                    state<=READ_DATA;
                                    addr_state<=ADDR_SENT;
                                    burst_state<=BURST_SENT;
                                    read_en <= 1 ;
                                end
                            end
                        else if (count_slave_wait_time>10)                  //Wait 10 clk cycles until slave ready. Otherwise stop transaction move to IDEAL state
                            begin
                                state <=IDLE;
                                count_slave_wait_time<=0;
                            end
                        else
                            begin
                                count_slave_wait_time = count_slave_wait_time+1; 
                            end
                    end
                    else
                    begin
                        state <= IDLE;
                    end
                end

                READ_DATA:
                begin
                    if(approval_grant==1)
                    begin
                        if (rx_done==1)
                        begin
                            state<=IDLE;
                        end
                        else
                        begin
                        state<= READ_DATA; 
                        end
                    end
                    else
                    begin
                        state <= IDLE;
                    end
                end

                WRITE_DATA:
                begin
                    if (approval_grant==1)
                    begin
                        if(count_data<DATA_LEN) 
                            begin                        
                                if((count_data==0)&&(slave_ready==1))
                                begin
                                    master_valid <= 1 ;                  //Data transfer after the master valid signal
                                    tx_data<= data[count_data] ;
                                    count_data<= count_data+1;
                                end
                                else if((count_data!=0)&&(count_data<DATA_LEN))
                                begin
                                    master_valid <= 1 ;
                                    tx_data<= data[count_data] ;
                                    count_data<= count_data+1;
                                end                                   
                            end   
                        else
                            begin
                                if((burst_num==11'd0)&&(slave_ready==1))
                                    begin
                                        tx_done<=1;                                 //Over the writing transmission when no burst 
                                        state<=IDLE;
                                        count_data<=0;
                                    end
                                else if((burst_num!=11'd0))
                                    begin
                                        count_data<=0;
                                        state<=WRITE_DATA_BURST;
                                        tx_done<=1;  
                                        count_burst<=1;
                                    end
                                else 
                                begin
                                    tx_data <= 0;                               
                                end
                            end                         
                    end
                    else
                    begin
                        state <= IDLE;
                    end
                end 

                WRITE_DATA_BURST:
                begin
                    if (approval_grant==1)
                    begin
                        if (count_burst<burst_num)
                        begin
                            if((count_data==0)&&(slave_ready==1))
                            begin
                                master_valid <= 1 ;                  //Data transfer after the master valid signal
                                tx_data<= data[count_data] ;
                                count_data<= count_data+1;                 
                            end
                            else if((count_data!=0)&&(count_data<DATA_LEN-1))
                                begin
                                    master_valid <= 1 ;
                                    tx_data<= data[count_data] ;
                                    count_data<= count_data+1;
                                end
                            else if((count_data==DATA_LEN-1))
                            begin
                                tx_done<=1;
                                master_valid <= 1 ;
                                tx_data<= data[count_data] ;
                                count_data<= 0;
                                count_burst<=count_burst+1;
                            end                                            
                        end
                        else
                        begin
                            tx_done<=1;                                 
                            state<=IDLE;
                            count_data<=0;
                            count_burst<=0;
                        end
                    end
                    else
                    begin
                        state <= IDLE;
                    end
                end
                default
                begin
                    state <= IDLE;
                end               
            endcase 
        end
    end


    always @(posedge clk) 
    begin
        if(reset==1)
            begin
                count_address<=0;
                tx_address<=0;
                addr_state <= IDLE;
            end
        else
        case (addr_state)
            IDLE:
            begin
                count_address<=0;
                tx_address<=0;
            end

            ADDR_SENT:
            begin
                if (approval_grant==1)
                begin
                    if(count_address<ADDR_LEN)
                        begin
                            if((count_address==0)&&(slave_ready==1))
                                begin                  
                                    tx_address <= address[count_address];
                                    count_address <= count_address + 1;
                                end
                            else if(count_address>0)
                                begin
                                    tx_address <= address[count_address];
                                    count_address <= count_address + 1;
                                end
                        end
                    else
                        begin
                            count_address<=0;
                            addr_state<=IDLE;
                        end
                end
                else
                begin
                    addr_state <= IDLE;
                end
            end

            default:
            begin
                addr_state <= IDLE;
            end
        endcase
    end

    always @(posedge clk) 
    begin
        if(reset==1)
            begin
                burst_state <= IDLE;
                tx_burst_number<=0;
                burst_count<=0;
            end
        else
        case (burst_state)
            IDLE:
            begin
                tx_burst_number<=0;
                burst_count<=0;
            end

            BURST_SENT:
            begin
                if (approval_grant==1)
                begin
                    if ((burst_num==11'd0)&&(slave_ready==1))
                        begin
                            tx_burst_number<=0;
                            burst_state<=IDLE;
                        end
                    else if (burst_num!=11'd0)
                        begin
                            if((burst_count==0)&&(slave_ready==1))
                            begin
                                tx_burst_number <= 0;
                                burst_count<=burst_count+1;
                            end
                            else if ((burst_count>0)&&(burst_count<BURST_LEN+1))
                                begin
                                    tx_burst_number<=burst_num[burst_count-1];
                                    burst_count<=burst_count+1;
                                end
                            else if (burst_count==BURST_LEN+1)
                                begin
                                    tx_burst_number<=0;
                                    burst_state<=IDLE;
                                    burst_count<=0;
                                end
                        end
                end
                else
                begin
                    burst_state<=IDLE;
                end

            end
            default:
            begin
                burst_state <= IDLE;
            end
        endcase
    end
    
 endmodule