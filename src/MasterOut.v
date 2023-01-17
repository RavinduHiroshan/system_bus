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
    input [1:0]instruction,                     //Donot know the reason to use this
    input approval_grant,                       //From arbitor
    input busy,                                 //From arbitor
    input [1:0]slave_select,                    //From arbitor
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
    output reg read_en,
    
 );  
 
    reg [4:0]state = 0; 
    parameter IDLE = 0,
    
    
    
    always @ (posedge clk or posedge reset) 
    begin
        if(reset)
        begin
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
        end
        else
        begin
            case (state)
            IDLE
        end
    end
       

endmodule
