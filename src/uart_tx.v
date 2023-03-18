
//UART TX STATE MACHINE
    //idle
    //start but [0]
    //data n bits
    //stop bit [1]
    //finish >> idle


//baudrate  19200 baud UART
//no parity bits
//clks_per_bit = (50000000)/(19200) = 2604


module uart_tx #(parameter CLKS_PER_BIT =2604, parameter data_len =8)(
    //input signals
    input clk,
    input reset,
    input send_sig,

    input [data_len-1:0] data,

    //output
    output reg tx_busy = 0,
    output reg tx_data = 1,
    output reg tx_done = 0
);

//States
parameter idle =0, start_bit=1, data_bits=2, stop_bit=3, finish=4;

reg [2:0] state = idle;
reg [data_len-1:0] temp_data = 0;

integer clk_count = 0;
integer bit_count = 0;

always @(posedge clk or posedge reset)
begin
    if (reset)
        begin
            state <= idle; 

            clk_count <= 0;
            bit_count <= 0;
            temp_data <= 0;

            tx_data <= 1;
            tx_busy <= 0;
            tx_done <= 0;

        end
    else 
        case (state)

        //idle state
        idle:
        begin
            if(send_sig==1) //send request
            begin
                state <= start_bit;
                temp_data <= data;
                tx_busy <= 1; // tx is busy
                clk_count <= 0; // reset clk count
            end

            else
            begin
                state <= idle;
                temp_data <= data;
                tx_busy <= 0; 
                clk_count <= clk_count;
            end

            bit_count <= bit_count;
            tx_done <= 0;
            tx_data <= 1;   // uart default 

        end
        
        //uart start bit [0]
        start_bit:    
        begin
            if(clk_count<CLKS_PER_BIT-1) // wait CLKS_PER_BIT
            begin
                state <= start_bit;
                clk_count <= clk_count+1;
                bit_count <= bit_count;
            end

            else
            begin
                state <= data_bits;
                clk_count <= 0; //reset clk count
                bit_count <= 0; //reset bit count
            end
        temp_data <= temp_data; 
        tx_busy <= tx_busy; 
        tx_done <= tx_done;
        tx_data <= 0; // start bit

        end

        data_bits:        
        begin
            if (clk_count<CLKS_PER_BIT-1) 
            begin
                state <= data_bits;
                clk_count <= clk_count+1;
                bit_count <= bit_count; 
            end

            else
            begin
                clk_count <= 0; // reset clk count

                if (bit_count<data_len-1)    //take 8 bits
                begin
                    state <= data_bits;
                    bit_count <= bit_count+1;
                end
                
                else
                begin
                    state <= stop_bit;
                    bit_count <= 0; //reset bit count
                end

            end
            temp_data <= temp_data;
            tx_busy <= tx_busy;
            tx_data <= tx_done;
            tx_data <= temp_data[bit_count]; //tx data

        end

        //uart stop bit [1]
        stop_bit:
        begin
            if (clk_count<data_len-1)
            begin
                state <= stop_bit;
                clk_count <= clk_count+1;
                tx_busy <= 1;
                tx_done <= 0;
            end

            else
            begin
                state <= finish;
                clk_count <= 0;  //reset clk count
                tx_busy <= 0;   //tx is not busy
                tx_done <= 1; //tx is done
                            
            end

            bit_count <= bit_count;
            temp_data <= temp_data;
            tx_data <= 1;  //stop bit
            
        end

        finish:
        begin
            state <= idle;
            clk_count <= clk_count;
            bit_count <= bit_count;
            temp_data <= temp_data;
            tx_data <= 1;   //uart default
            tx_busy <= 0;   // tx is not busy
            tx_done <= 0;   
            
        end

        //default state
        default :
        begin
            state <= idle;
            clk_count <= 0;
            bit_count <= 0;
            temp_data <= temp_data;
            tx_data <= 1;
            tx_busy <= 0;
            tx_done <= 0;
        end      
    
    endcase

end



endmodule