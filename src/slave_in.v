module slave_in_port(
	input clk, 
	input reset,
	input rx_address,  // rx_address bring address to module seraliy
	input rx_data,  // rx_data bring data to module seraliy
	input master_valid, // check validity of master
    input master_ready,
	input read_en,
	input write_en,
    input rx_burst,

	output slave_ready,
	output reg rx_done,

	output reg[11:0]address, // output to the module
	output reg[7:0]data // output to the module
    );

parameter 
IDLE                = 0, 
ADDR_RECIEVE        = 1,
ADDR_INC_BURST      = 2,
WAIT_HANDSHAKE      = 3, 
DATA_RECIEVE 	    = 4,
DATA_BURST_GAP      = 5,
DATA_RECIEVE_BURST  = 6,
READ_BURST_WAIT_HANDSHAKE = 7,
BURST_BIT_RECIEVE = 8,
NO_BURST = 9;
 
reg [3:0]addr_counter = 4'd0;
reg [3:0]addr_state = IDLE;

reg [3:0]data_state = IDLE;
reg [2:0]data_counter = 3'd0;

reg [3:0]burst_state = IDLE;
reg [3:0]burst_bit_counter = 4'd0;


reg[11:0]burst_counter = 12'd0;
reg[12:0]burst_num = 13'd0;

reg addr_idle = 1;
reg data_idle = 1;
reg addr_done = 0;
reg data_done = 0;

assign slave_ready = data_idle & addr_idle;

wire handshake = master_valid & slave_ready;

// Read 12 bit address data from serial bus 
always @(posedge clk or posedge reset) 
begin
    if(reset) 
    begin
        addr_state <= IDLE;
        addr_counter <= 4'd0;
        addr_idle <= 1;
    end
    else 
    begin
    case (addr_state)
        IDLE:
        begin
            if ((handshake == 1'd1)) 
					begin
						addr_state            <= ADDR_RECIEVE;
						addr_counter          <= addr_counter + 4'd1;
						address[addr_counter] <= rx_address;
						addr_idle             <= 0;
						rx_done 			  <= 0;
					end
				else
					begin
						addr_state    <= IDLE;
					    addr_counter  <= 4'd0;
						addr_idle     <= 1;
						rx_done 	  <= 0;
					end
        end
        ADDR_RECIEVE:
        begin
            if(addr_counter < 4'd11)
            begin
                addr_state            <= addr_state; // no need
                addr_counter          <= addr_counter + 4'd1;
                address[addr_counter] <= rx_address;
                addr_idle             <= 0; // no need
                rx_done 			  <= 0; // no need
			end
            else
            begin
                if ((burst_num[0] == 1) && handshake == 1)       
                begin
                    addr_state <= ADDR_INC_BURST;
                    address[addr_counter] <= rx_address;
                    rx_done 			  <= 1;
                    addr_counter          <= 0;
                    burst_counter 		  <= burst_counter + 1;
                end
                else
                begin
                    addr_state <= IDLE;
                    addr_counter          <= 0;
					address[addr_counter] <= rx_address;
					addr_idle             <= 1;
					rx_done 			  <= 1;
					burst_counter 		  <= burst_counter + 1;
                end
            end
        end
        ADDR_INC_BURST:
        begin
            if(burst_counter < burst_num)
            begin
                if(addr_counter < 4'd11)
                begin
                    addr_counter          <= addr_counter + 4'd1;
                end
                else
                begin
                    rx_done <= 1;
                    addr_counter <= 0;
                    burst_counter <= burst_counter + 1;
                    address <= address + 1;
                    if(handshake == 0) 
                    begin
                        addr_state <= IDLE;
                    end
                end
            end
            else 
            begin
                if(addr_counter < 4'd11)
                begin
                    addr_counter          <= addr_counter + 4'd1;
                end
                else
                begin
                    addr_state <= IDLE;
                    rx_done <= 1;
                    addr_counter <= 0;
                    burst_counter <= burst_counter + 1;
                    address <= address + 1;
                end
            end
        end
        default:
        begin
            addr_state   <= IDLE;
            addr_counter <= 4'd0;
            addr_idle    <= 1;
        end
    endcase
    end
end

// Read 8 bit  data from serial bus 
always @(posedge clk or posedge reset) 
begin
    if(reset) 
    begin
        data_state <= IDLE;
		data_counter <= 0;
		data_idle <= 1;
    end
    else 
    begin
        case (data_state)
            IDLE: 
            begin
                if(handshake == 1'd1 && (write_en == 1))
                begin
                    data_state         <= DATA_RECIEVE;
					data_counter       <= data_counter + 4'd1;
					data[data_counter] <= rx_data;
					data_idle          <= 0;
                end
                else 
                begin
					data_counter  <= 0;
					data_idle     <= 1;
                end
            end
            DATA_RECIEVE:
            begin
                if (data_counter < 4'd7)
				begin
					data_counter       <= data_counter + 4'd1;
					data[data_counter] <= rx_data;
					data_idle <= 0;
				end
				else 
				begin
					if ((burst_num[0] == 1)) 
                    begin
                        data_state <= DATA_BURST_GAP;
                        data_counter  <= 0;
					    data_idle     <= 1;
                    end
					else 		
					begin
						data_state <= IDLE;
						data_idle <= 1;
					end			
					data_counter <= 0;
					data[data_counter] <= rx_data;
				end
                
            end
            DATA_BURST_GAP:
            begin
                if(addr_state == ADDR_RECIEVE) 
                begin
                    data_state <= DATA_BURST_GAP;
                end
                else if (burst_counter < burst_num) 
                begin
                    data_state <= DATA_RECIEVE;
                    data_counter       <= data_counter + 4'd1;
					data[data_counter] <= rx_data;
					data_idle          <= 0;
                end
            end
            default: 
            begin
                data_state <= IDLE;
                data_counter <= 0;
                data_idle <= 1;  
            end
        endcase
    end
end


//13 bit burst from rx_burst
always @ (posedge clk or posedge reset) 
begin
	if (reset)
	begin
		burst_state <= IDLE;
		burst_bit_counter <= 0;
	end
	else
	begin
		case (burst_state)
			IDLE:
			begin
				if ((handshake) && (read_en || write_en))
				begin
                    if(rx_burst == 1)
                    begin
                        burst_num[burst_bit_counter] <= rx_burst;
					    burst_state <= BURST_BIT_RECIEVE;
					    burst_bit_counter <= burst_bit_counter + 1;
                    end
                    else
                    begin
                        burst_state <= NO_BURST;
                    end
					
				end
				else
				begin
					burst_state <= burst_state;
					burst_bit_counter <= 0;
				end
			end
			BURST_BIT_RECIEVE:
			begin
				if (burst_bit_counter < 4'd12)    // change to 13 ?
				begin
					burst_num[burst_bit_counter] <= rx_burst;
					burst_bit_counter <= burst_bit_counter + 1;
					burst_state <= burst_state;
				end
				else 
				begin
					burst_state <= IDLE;
                    burst_num[burst_bit_counter] <= rx_burst;
					burst_bit_counter <= 0;
				end
			end
            NO_BURST:
            begin
                if(read_en == 0 || write_en == 0)
                begin
                    burst_state <= IDLE;
                end   
                else
                begin
                    burst_state <= NO_BURST;
                end
            end
			default:
			begin
				burst_state <= IDLE;
			end
		endcase
	end
end
endmodule
