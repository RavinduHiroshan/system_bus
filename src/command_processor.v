module command_processor #(parameter SLAVE_LEN=2, parameter ADDR_LEN=12, parameter DATA_LEN=8, parameter BURST_LEN=12)(
    input clk,
    input reset,

    //Inputs from FPGA Board
    input [7:0]switch1,
    input button1,
    input button2,
    input button3,

    // //Input from the system bus
    // input new_rx,
    // input [7:0]new_data,
    // input tx_done,
    // input rx_done,
    
    // //Outputs to the system bus
    //output reg[ADDR_LEN-1:0]address,
    output reg[1:0]data_read_m1,
    output reg[1:0]data_read_m2,
    output reg[1:0]data_write,                     
    //output reg[BURST_LEN-1:0]burst_num,             
    //output reg[SLAVE_LEN-1:0]slave_select,          
    //output reg[1:0]instruction, 

    //Outputs to the FPGA Board
   // output reg [DATA_LEN-1:0]data

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
assign instructionint  = switch1[6];
assign master_select = switch1[7];


reg [11:0]address_m1 = 0;
reg [7:0]data_m1 = 0;
reg [12:0]burst_num_m1 = 0;
reg [1:0]slave_select_input_m1 = 0;
reg [1:0]instruction_m1 = 0;

reg [11:0]address_m2 = 0;
reg [7:0]data_m2 = 0;
reg [12:0]burst_num_m2 = 0;
reg [1:0]instruction_m2 = 0;

wire
tx_done_m1,
new_rx_m1,
rx_done_m1;
reg [7:0]new_data_m1;

wire
tx_done_m2,
new_rx_m2,
rx_done_m2;
reg [7:0]new_data_m2;

assign data_read_m1 = new_data_m1[1:0];
assign data_read_m2 = new_data_m2[1:0];


bus bus(
    .clk(clk),
    .reset(reset),

    .address_m1(address_m1),
    .data_m1(data_m1),
    .burst_num_m1(burst_num_m1),
    .slave_select_input_m1(slave_select_input_m1),
    .instruction_m1(instruction_m1),

    .address_m2(address_m2),
    .data_m2(data_m2),
    .burst_num_m2(burst_num_m2),
    .slave_select_input_m2(slave_select_input_m2),
    .instruction_m2(instruction_m2),

    
    // Output
    .tx_done_m1(tx_done_m1),
    .new_rx_m1(new_rx_m1),
    .rx_done_m1(rx_done_m1),
    .new_data_m1(new_data_m1),

    .new_rx_m2(new_rx_m2),
    .tx_done_m2(tx_done_m2),
    .rx_done_m2(rx_done_m2),
    .new_data_m2(new_data_m2)
)

             

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
    getbutton3<=1'b1;
end

always @(posedge clk)
begin
    if(reset)
    begin
        addressint <= 12'b0;
        dataint <= 8'b0;
        burst_numint <= 12'b0;
        slave_selectint <= 2'b0;
        instructionint <= 2'b0;
        address_m1 <= 12'b0;
        address_m2<=12'b0;
        data_m1 <=8'b0;
        data_m2<=8'b0;
        burst_num_m1 <= 12'b0;
        burst_num_m2 <= 12'b0;
        slave_select_input_m1 <=2'b0;
        slave_select_input_m2 <=2'b0;       
        instruction_m1<= 2'b0;
        instruction_m2<= 2'b0;
        master_select<= 1'b0;
        getbutton1 <= 1'b0;
        getbutton2 <= 1'b0;
        getbutton3 <= 1'b0;
        new_data_m1 <= new_data_m1;
        new_data_m2<=new_data_m2;
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
                address_m1 <= 12'b0;
                address_m2<=12'b0;
                data_m1 <=8'b0;
                data_m2<=8'b0;
                burst_num_m1 <= 12'b0;
                burst_num_m2 <= 12'b0;
                slave_select_input_m1 <=2'b0;
                slave_select_input_m2 <=2'b0;       
                instruction_m1<= 2'b0;
                instruction_m2<= 2'b0;
                master_select<= 1'b0;
                getbutton2 <= 1'b0;
                getbutton3 <= 1'b0;
                new_data_m1 <= new_data_m1;
                new_data_m2 <= new_data_m2;
            end

            DATASENT:
            begin
                if (getbutton1==2)
                begin
                    if (master_select==1)
                    begin
                         if (instructionint[0]==1)
                         begin
                            state <= WAITFINISHREAD;
                            data_m1 <= 0 ;
                         end
                         else if (instructionint[0]==0)
                         begin
                            state <= WAITFINISHWRITE;
                            data_m1 <= dataint ;
                         end
                        address_m1 <= addressint ;
                        burst_num_m1 <= burst_numint ;
                        slave_select_input_m1 <= slave_selectint;
                        instruction_m1[0] <= instructionint;
                        instruction_m1[1] <= 1;
                    end
                    else if(master_select==0)
                    begin
                        if (instructionint[0]==1)
                        begin
                            state <= WAITFINISHREAD;
                            data_m2 <= 0 ;
                         end
                         else if (instructionint[0]==0)
                         begin
                            state <= WAITFINISHWRITE;
                            data_m2 <= dataint ;
                         end
                        address_m2 <= addressint ;
                        burst_num_m2 <= burst_numint ;
                        slave_select_input_m2 <= slave_selectint;
                        instruction_m2[0] <= instructionint;
                        instruction_m2[1] <= 1;
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
                if((tx_done_m2==1)||(tx_done_m1==1))
                begin
                    state <= IDLE;
                    address_m1 <= 12'b0;
                    address_m2<=12'b0;
                    data_m1 <=8'b0;
                    data_m2<=8'b0;
                    burst_num_m1 <= 12'b0;
                    burst_num_m2 <= 12'b0;
                    slave_select_input_m1 <=2'b0;
                    slave_select_input_m2 <=2'b0;       
                    instruction_m1<= 2'b0;
                    instruction_m2<= 2'b0;
                    master_select<= 1'b0;
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
                if((rx_done_m1==1)||(rx_done_m2==1))
                begin
                    state <= IDLE;
                    new_data<= data;
                    address_m1 <= 12'b0;
                    address_m2<=12'b0;
                    data_m1 <=8'b0;
                    data_m2<=8'b0;
                    burst_num_m1 <= 12'b0;
                    burst_num_m2 <= 12'b0;
                    slave_select_input_m1 <=2'b0;
                    slave_select_input_m2 <=2'b0;       
                    instruction_m1<= 2'b0;
                    instruction_m2<= 2'b0;
                    master_select<= 1'b0;
                end
                else:
                begin
                   state <= WAITFINISHREAD; 
                end
                getbutton1 <= 1'b0;
                getbutton2 <= 1'b0;
                getbutton3 <= 1'b0;
            end 
            default
            begin
                state<= IDLE;
            end
        endcase
    end
end

endmodule