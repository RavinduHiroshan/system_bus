`timescale 1ns/10ps
// 10MHz clk
// 19200 baud rate
//10000000/19200 = 521 clks per bit
// 10000000 / 115200 = 87 per bit


module uart_tb();

    parameter clk_period_ns = 100; 
    parameter clk_per_bit = 87;
    parameter bit_period_ns = 8600;

    reg r_clk = 0;
    reg reset;
    reg r_send_sig = 0;
    
    reg r_rx_serial =1;
    wire w_rx_sig;
    wire [7:0] w_rx_byte;
    

    reg [7:0] r_tx_byte =0;
    wire w_tx_done;

    task uart_write_byte;
        input [7:0] i_data;
        integer ii;
        begin
            //send start bit [0]
            r_rx_serial <= 1'b0;
            #(bit_period_ns);

            //send data byte
            for (ii = 0; ii < 8; ii=ii+1 )
            begin
                r_rx_serial <= i_data[ii];
                #(bit_period_ns);
            end

            //send stop bit [1]
            r_rx_serial <= 1'b1;
            #(bit_period_ns);
        end
    endtask

    always
    #(clk_period_ns/2) r_clk <= ! r_clk; // clock 

    uart_rx #(.clk_per_bit(clk_per_bit)) UART_RX_INST(
        .clk(r_clk),
        .rx_data(r_rx_serial),
        .reset(reset),
        .receive_sig(w_rx_sig),
        .data(w_rx_byte)
        );

    uart_tx #(.clk_per_bit(clk_per_bit)) uart_tx_inst(
        .clk(clk),
        .reset(reset),
        .send_sig(r_send_sig),
        .data(r_tx_byte),
        .tx_busy(w_tx_busy),
        .tx_data(),
        .tx_done(w_tx_done)
    );

    initial begin
        reset<=0;
        #30
        reset<=1;

        // tx test
        @(posedge clk);
        @(posedge clk);
        r_send_sig <= 1'b1;
        r_tx_byte <= 8'hAB;

        @(posedge clk);
        r_send_sig <= 1'b0;
        @(posedge w_tx_done);

        //rx test
        @(posedge clk);
        uart_write_byte('8'h3F');

        @(posedge clk);

        if (w_rx_byte == 8'h3F)
        $display("Test Passed - Correct Byte Received");
        else
        $display("Test Failed - Incorrect Byte Received");

    end

    


endmodule