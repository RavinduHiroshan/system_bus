module master_mux(
    input bus_grant,

    input m1_master_ready,
    input m1_master_valid,
    input m1_read_en,
    input m1_write_en,
    input m1_tx_address,
    input m1_tx_data,
    input m1_tx_burst,

    input m2_master_ready,
    input m2_master_valid,
    input m2_read_en,
    input m2_write_en,
    input m2_tx_address,
    input m2_tx_data,
    input m2_tx_burst,

    output to_slave_master_ready,
    output to_slave_master_valid,
    output to_slave_read_en,
    output to_slave_write_en,
    output to_slave_tx_address,
    output to_slave_tx_data,
    output to_slave_tx_burst

);

assign to_slave_master_ready =  (bus_grant == 2'b01) ? m1_master_ready:
                                (bus_grant == 2'b10) ? m2_master_ready: 1'b0;

assign to_slave_master_valid =  (bus_grant == 2'b01) ? m1_master_valid:
                                (bus_grant == 2'b10) ? m2_master_valid: 1'b0;

assign to_slave_read_en     =   (bus_grant == 2'b01) ? m1_read_en:
                                (bus_grant == 2'b10) ? m2_read_en: 1'b0;
                
assign to_slave_write_en =  (bus_grant == 2'b01) ? m1_write_en:
                            (bus_grant == 2'b10) ? m2_write_en: 1'b0;

assign to_slave_tx_address =    (bus_grant == 2'b01) ? m1_tx_address:
                                (bus_grant == 2'b10) ? m2_tx_address: 1'b0;

assign to_slave_tx_data =       (bus_grant == 2'b01) ? m1_tx_data:
                                (bus_grant == 2'b10) ? m2_tx_data: 1'b0;
            
assign to_slave_tx_burst =  (bus_grant == 2'b01) ? m1_tx_burst:
                            (bus_grant == 2'b10) ? m2_tx_burst: 1'b0;

                

    
endmodule