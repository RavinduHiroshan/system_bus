module command_processor #(parameter SLAVE_LEN=2, parameter ADDR_LEN=12, parameter DATA_LEN=8, parameter BURST_LEN=12)(
    input clk,
    input reset,

    //Inputs from FPGA Board
    input [7:0]switch1,
    input button1,
    input button2,
    input button3,

    //Input from the system bus
    input new_rx,
    input [7:0]new_data,
    input tx_done,
    input rx_done,
    
    //Outputs to the system bus
    output reg[ADDR_LEN-1:0]address,
    output reg[DATA_LEN-1:0]data,                   
    output reg[BURST_LEN-1:0]burst_num,             
    output reg[SLAVE_LEN-1:0]slave_select,          
    output reg[1:0]instruction, 

    //Outputs to the FPGA Board
    output reg [DATA_LEN-1:0]data

);

reg [ADDR_LEN-1:0]addressint= 12'b0;
reg [DATA_LEN-1:0]dataint = 8'b0;
reg [BURST_LEN-1:0]burst_numint = 12'b0;
reg [SLAVE_LEN-1:0]slave_selectint = 2'b0;
reg [1:0]instructionint = 2'b0; 

reg [1:0]state = 0;
parameter IDLE = 4'b0, DATASENT = 4'b1 , WAITFINISHWRITE = 4'b2, WAITFINISHREAD = 4'b3; 

reg getbutton1 = 1'b0;
reg getbutton2 = 1'b0;
reg getbutton3 = 1'b0;

assign [1:0]addressint   = switch1[1:0];
assign [1:0]dataint      = switch1[3:2];
assign [1:0]slave_selectint = switch1[5:4];
assign [1:0]instructionint  = switch1[7:6];                

always @(posedge button1)
begin
    getbutton1 <= 1'b1;
end

always @(posedge button2)
begin
    getbutton2 <= 1'b1;
end

always @(posedge button3)
begin
    getbutton3 <= 1'b1;
end

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        addressint <= 12'b0;
        dataint <= 8'b0;
        burst_numint <= 12'b0;
        slave_selectint <= 2'b0;
        instructionint <= 2'b0;
        address <= 12'b0;
        data <=8'b0;
        burst_num <= 12'b0;
        slave_selectint <=2'b0;
        instruction<= 2'b0;
        getbutton1 <= 1'b0;
        getbutton2 <= 1'b0;
        getbutton3 <= 1'b0;
        new_data<=0;
        state <= IDLE;
    end
    else
    begin
        case(state)
            IDLE :
            begin
                if (getbutton1==1)
                begin
                    state <= DATASENT;
                    getbutton1 <= 1'b0;
                end
                else
                begin
                    state <= IDLE;
                    getbutton1 <= 1'b0;
                end
                addressint <= 12'b0;
                dataint <= 8'b0;
                burst_numint <= 12'b0;
                slave_selectint <= 2'b0;
                instructionint <= 2'b0;
                address <= 12'b0;
                data <=8'b0;
                burst_num <= 12'b0;
                slave_selectint <=2'b0;
                instruction<= 2'b0;
                getbutton2 <= 1'b0;
                getbutton3 <= 1'b0;
                new_data <= new_data;
            end

            DATASENT:
            begin
                if (getbutton1==2)
                begin
                    if (instructionint[1]==1)
                    begin
                         if (instructionint[0]==1)
                         begin
                            state <= WAITFINISHREAD;
                            data <= 0 ;
                         end
                         else if (instructionint[0]==0)
                         begin
                            state <= WAITFINISHWRITE;
                            data <= dataint ;
                         end
                        address <= addressint ;
                        burst_num <= burst_numint ;
                        slave_select <= slave_selectint;
                        instruction <= instructionint;
                    end
                    getbutton1 <= 1'b0;
                    getbutton2 <= 1'b0;
                    getbutton3 <= 1'b0;
                end
                else
                begin
                    state <= DATASENT;
                    getbutton1 <= 1'b0;
                    getbutton2 <= 1'b0;
                    getbutton3 <= 1'b0;
                end
            end

            WAITFINISHWRITE:
            begin 
                if(tx_done)
                begin
                    state <= IDLE;
                    address <= 0 ;
                    burst_num <= 0 ;
                    slave_select <= 0 ;
                    instruction <= 0 ;
                end
                else
                begin
                    state <= WAITFINISHWRITE;
                end
                getbutton1 <= 1'b0;
                getbutton2 <= 1'b0;
                getbutton3 <= 1'b0;
            end

            WAITFINISHREAD:
            begin 
                if(rx_done)
                begin
                    state <= IDLE;
                    new_data<= data;
                    address <= 0 ;
                    burst_num <= 0 ;
                    slave_select <= 0 ;
                    instruction <= 0 ;
                end
                else:
                begin
                   state <= WAITFINISHREAD; 
                end
                getbutton1 <= 1'b0;
                getbutton2 <= 1'b0;
                getbutton3 <= 1'b0;
            end            
        endcase
    end
end




endmodule