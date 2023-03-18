module master_mux_sside(
    input [2:0]slave_grant,

    input to_slave_master_ready, 
    input to_slave_master_valid,
    input to_slave_read_en,
    input to_slave_write_en,
    input to_slave_tx_address,
    input to_slave_tx_data,
    input to_slave_tx_burst,

   output to_slave_master_ready_1,
   output to_slave_master_valid_1,
   output to_slave_read_en_1,
   output to_slave_write_en_1,
   output to_slave_tx_address_1,
   output to_slave_tx_data_1,
   output to_slave_tx_burst_1,

   output to_slave_master_ready_2,
   output to_slave_master_valid_2,
   output to_slave_read_en_2,
   output to_slave_write_en_2,
   output to_slave_tx_address_2,
   output to_slave_tx_data_2,
   output to_slave_tx_burst_2,

   output to_slave_master_ready_3,
   output to_slave_master_valid_3,
   output to_slave_read_en_3,
   output to_slave_write_en_3,
   output to_slave_tx_address_3,
   output to_slave_tx_data_3,
   output to_slave_tx_burst_3

);


assign to_slave_master_ready =  (slave_grant == 3'b011) ? to_slave_master_ready_1:
                                (slave_grant == 3'b101) ? to_slave_master_ready_2:
                                (slave_grant == 3'b111) ? to_slave_master_ready_3: 1'b0;

assign to_slave_master_valid =  (slave_grant == 3'b011) ? to_slave_master_valid_1:
                                (slave_grant == 3'b101) ? to_slave_master_valid_2:
                                (slave_grant == 3'b111) ? to_slave_master_valid_3: 1'b0;

assign to_slave_read_en     =   (slave_grant == 3'b011) ? to_slave_read_en_1:
                                (slave_grant == 3'b101) ? to_slave_read_en_2:
                                (slave_grant == 3'b111) ? to_slave_read_en_3: 1'b0;
                
assign to_slave_write_en =  (slave_grant == 3'b011) ? to_slave_write_en_1:
                            (slave_grant == 3'b101) ? to_slave_write_en_2:
                            (slave_grant == 3'b111) ? to_slave_write_en_3: 1'b0;

assign to_slave_tx_address =    (slave_grant == 3'b011) ? to_slave_tx_address_1:
                                (slave_grant == 3'b101) ? to_slave_tx_address_2:
                                (slave_grant == 3'b111) ? to_slave_tx_address_3: 1'b0;

assign to_slave_tx_data =       (slave_grant == 3'b011) ? to_slave_tx_data_1:
                                (slave_grant == 3'b101) ? to_slave_tx_data_2:
                                (slave_grant == 3'b111) ? to_slave_tx_data_3: 1'b0;
            
assign to_slave_tx_burst =  (slave_grant == 3'b011) ? to_slave_tx_burst_1:
                            (slave_grant == 3'b101) ? to_slave_tx_burst_2:
                            (slave_grant == 3'b111) ? to_slave_tx_burst_3: 1'b0;
                

    
endmodule