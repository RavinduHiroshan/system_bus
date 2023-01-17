module arbiter(
    input clk,
    input reset,
    input m1_request,
    input m2_request,
    input transaction_done,

    output reg m1_grant,
    output reg m2_grant,
    output reg busy,
    output reg [1:0]slave_grant,
    output reg [1:0]bus_grant
);
    
    parameter[2:0] IDLE_STATE = 3'd0;
    parameter[2:0] MASTER1_OCCUPPIED_STATE = 3'd1;
    parameter[2:0] MASTER2_OCCUPPIED_STATE = 3'd2;

    reg [2:0] state;

    always @(posedge clk)
    begin
        if(reset == 1'b1)
        begin
            state <= IDLE_STATE;
            m1_grant <= 0;
            m2_grant <= 0;
            busy     <= 0;
            bus_grant<= 2'b0; 
        end
        else
        begin
            if(transaction_done == 1'b1)
            begin
                state <= IDLE_STATE; 
            end
            else if(m1_request == 1'b1 )
            begin
                state <= MASTER1_OCCUPPIED_STATE;
            end
            else if (m2_request == 1'b1 && state == IDLE_STATE)
            begin
                state <= MASTER2_OCCUPPIED_STATE;
            end
            else
            begin
                state <= state;
            end
        end
    end

    always @(posedge clk) 
    begin
        if(reset == 1'b1)
        begin
            state <= IDLE_STATE;
            m1_grant <= 0;
            m2_grant <= 0;
            busy     <= 0;
            bus_grant <= 2'b0;
        end
        else
        begin
            case(state)
            IDLE_STATE :begin
                m1_grant <= 0;
                m2_grant <= 0;
                busy     <= 0;
                bus_grant<= 2'b00;
                end
            MASTER1_OCCUPPIED_STATE :begin
                m1_grant <= 1;
                m2_grant <= 0;
                busy     <= 1;
                bus_grant<= 2'b01;
                end
            MASTER2_OCCUPPIED_STATE :begin
                m1_grant <= 0;
                m2_grant <= 1;
                busy     <= 1;
                bus_grant<= 2'b10;
                end
            endcase
        end
    end
endmodule