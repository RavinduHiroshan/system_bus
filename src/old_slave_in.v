`timescale 1ns / 1ps
module slave_in #(
    parameter DATA_LEN=8,
    parameter BURST_LEN=12
) (

    input clk,
    input reset,
    input rx_data,
    input rx_address,
    input rx_burst,
    input master_valid,
    input master_ready,
    input read_enable,
    input write_enable,
    
    input slave_busy,
    input slave_read_done,

    output reg[11:0]address,
    output reg[7:0]data,
    output reg[11:0]burst_count,
    output reg new_data,
    output reg slave_ready
);

    parameter[2:0] IDLE_STATE           = 3'd0;
    parameter[2:0] DATA_COLLECT_STATE   = 3'd1;
    parameter[2:0] DATA_BURST_STATE     = 3'd2;
    parameter[2:0] DATA_TRANSFER_STATE  = 3'd3;

    reg [2:0] state = IDLE_STATE;

    integer data_read = 0;
    integer address_read = 0;
    integer burst_read = 0;

    wire handshake = master_valid & slave_ready;

    reg [7:0] data_reg;
    reg [7:0] address_reg;
    reg transaction_ready = 0;
    reg burst_read = 0;

    always @(posedged clk or posedged reset)
    begin
        if(reset == 1'b1)
        begin
            data_read           <= 0;
            address_read        <= 0;
            burst_read          <= 0;
            transaction_ready   <= 0;
            burst_read          <= 0;
            burst_num           <= 0;    
        end
        else
        begin
            if((write_enable == 1'b1) && ((state != DATA_COLLECT_STATE)||(state != DATA_BURST_STATE)))
            begin
                if(slave_busy == 0)
                begin
                    state <= DATA_COLLECT_STATE;
                end
                else
                    state <= IDLE_STATE;
                begin
                    
                end
            end
            else if((read_enable == 1'b1) && (state != DATA_TRANSFER_STATE))
            begin
                if(master_valid == 1)
                begin
                    state <= DATA_TRANSFER_STATE;
                end
                else
                    state <= IDLE_STATE;
                begin
                    
                end
            end
            else if ((read_enable == 1'b0) && (write_enable == 1'b0)) 
            begin
                state <= IDLE_STATE;
            end
        end
    end


    //Data reading function
    always @(posedged clk)
    begin
        case (state)
        IDLE_STATE :begin
            data_read           = 0;
            address_read        = 0;
            burst_read          = 0;
            transaction_ready   = 0;
            burst_read          = 0;
        end
        DATA_COLLECT_STATE :begin
            if(data_read < 8)
            begin
                slave_ready         <= 1'b1;
                data_reg[data_read] <= rx_data;
                data_read <= data_read + 1;
            end
            else if(data_read == 8)
            begin
                if(burst_read == 1)
                begin
                    state <= DATA_BURST_STATE
                end
                else begin
                    state <= IDLE_STATE
                end
            end
        end
        DATA_BURST_STATE :begin
            slave_ready <= 1'b1;
            if(data_read < 8)
            begin
                data_reg[data_read] <= rx_data;
                data_read <= data_read + 1;
            end
            else if(data_read == 8)
            begin
                // burst_num   <= burst_num + 1;
                //burst count shoud set 
                
            end

        end
        DATA_TRANSFER_STATE :begin
            if(slave_read_done == 1)
            begin
                state <= IDLE_STATE;
            end
        end
        endcase
    end
    
    //Addresses reading 
    always @(posedged clk)
    begin
        case(state)
        DATA_COLLECT_STATE :begin
            slave_ready <= 1'b1;
            if((address_read < 12) && (handshake == 1'b1))
            begin
                data_reg[address_read] <= rx_data;
                data_read <= data_read + 1;
            end
            else if(address_read == 12)
            begin
                data_read   <= 0;
                new_data    <= 1;
                
            end 
            end
        endcase
    end
    //Burst reading
    always @(posedged clk)
    begin
        case (state)
        DATA_COLLECT_STATE :begin
            slave_ready <= 1'b1;
            if((data_read < 8) && (handshake == 1'b1))
            begin
                data_reg[slave_read] <= rx_data;
                data_read <= data_read + 1;
            end
            else if(data_read == 8)
            begin
                
                if(burst_num == burst_count)
                begin
                    state <= IDLE_STATE;
                end
            end
        end
        DATA_BURST_STATE :begin
            slave_ready <= 1'b1;
            if((data_read < 8) && (handshake == 1'b1))
            begin
                data_reg[data_read] <= rx_data;
                data_read <= data_read + 1;
            end
            else if(data_read == 8)
            begin
                
            end
        end
        DATA_TRANSFER_STATE :begin
            slave_ready <= 1'b0;  
        end
        endcase
    end

    always @(posedge clk)
    begin
        case (state)
            IDLE_STATE :begin
                
            end
            DATA_COLLECT_STATE:begin
                
            end
            DATA_BURST_STATE :begin
                
            end
            DATA_TRANSFER_STATE :begin
                
            end
        endcase
    end

endmodule