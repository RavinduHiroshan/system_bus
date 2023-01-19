module arbiter(
    input clk, // system clock
    input reset, // system reset
    input m1_request,   // Mster 1 request, it should be high during master 1 transactions.
    input m2_request,   // Mster 2 request, it should be low during master 2 transactions.
    input m1_slave_select, //After m1_grant, slave address transmits from master
    input m2_slave_select, //After m2_grant, slave address transmits from master

    output reg m1_grant,
    output reg m2_grant,
    output reg busy,
    output reg [1:0]slave_grant, //Signal gose to slave select mux
    output reg [1:0]bus_grant   //signal gose to master select mux
);
    
    parameter[2:0] IDLE_STATE = 3'd0;
    parameter[2:0] MASTER1_OCCUPPIED_STATE = 3'd1;
    parameter[2:0] MASTER2_OCCUPPIED_STATE = 3'd2;
    //parameter[2:0] SLAVE_SELECT = 3'd3;

    reg [2:0] state = IDLE_STATE;
    integer slave_read = 0;


    always @(posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            state <= IDLE_STATE;
            m1_grant   <= 0;
            m2_grant   <= 0;
            busy       <= 1;
            bus_grant  <= 2'b0;
            slave_grant<= 2'b0;  
        end
        else
        begin
            if(m1_request == 1'b1)
            begin
                state <= MASTER1_OCCUPPIED_STATE;
                m1_grant   <= 1;
                bus_grant  <= 2'b01;
            end
            else if (m2_request == 1'b1)
            begin
                state <= MASTER2_OCCUPPIED_STATE;
                m2_grant   <= 1;
                bus_grant  <= 2'b10;
            end
            else
            begin 
                state <= IDLE_STATE;
                m2_grant   <= 0;
                busy       <= 1;
                slave_read <= 0;
                bus_grant  <= 2'b00;
            end
        end
    end

    always @(posedge clk) 
    begin
        case(state)
        IDLE_STATE :begin
            m1_grant <= 0;
            m2_grant <= 0;
            busy     <= 0;
            bus_grant<= 2'b00;
            slave_read <= 0;
            end
        MASTER1_OCCUPPIED_STATE :begin
            if(slave_read < 2)
            begin
                slave_grant[slave_read] <= m1_slave_select;
                slave_read <= slave_read + 1;
            end
            else
            begin
                busy     <= 0;
            end
            end
        MASTER2_OCCUPPIED_STATE :begin
            if(slave_read < 2)
            begin
                slave_grant[slave_read] <= m2_slave_select;
                slave_read <= slave_read + 1;
            end
            else
            begin
                busy     <= 0;
            end
            end
        endcase
end
endmodule