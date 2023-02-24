module slave_in_port (
    parameter DATA_LEN=8,
    parameter BURST_LEN=12
) (
	input clk, 
	input reset,
	input rx_address,
	input rx_data,
	input master_valid,
	input read_en,
	input write_en,
	output slave_ready,
	output rx_done,
	output reg[BURST_LEN-1:0]address,
	output reg[DATA_LEN-1:0]data
    );
	

reg [3:0]addr_state = 0;
reg [3:0]data_state = 0;
reg addr_idle = 1;
reg data_idle = 1;
reg addr_done = 0;
reg data_done = 0;

assign slave_ready = data_idle & addr_idle;
assign rx_done = addr_done;

wire handshake = master_valid & slave_ready;

parameter 
IDLE = 0, 
ABIT1 = 1, 
ABIT2 = 2, 
ABIT3 = 3, 
ABIT4 = 4,
ABIT5 = 5, 
ABIT6 = 6, 
ABIT7 = 7, 
ABIT8 = 8, 
ABIT9 = 9, 
ABIT10 = 10, 
ABIT11 = 11,
ABIT12 = 12;



always @ (posedge clk or posedge reset) 
begin
	if (reset)
		addr_state <= IDLE;
	else
		case (addr_state)
			IDLE:
				if (handshake == 1)
				begin
					addr_state <= ABIT1;
				end
				else
					addr_state <= IDLE;
			ABIT1:
				addr_state <= ABIT2;
			ABIT2:
				addr_state <= ABIT3;
			ABIT3:
				addr_state <= ABIT4;
			ABIT4:
				addr_state <= ABIT5;
			ABIT5:
				addr_state <= ABIT6;
			ABIT6:
				addr_state <= ABIT7;
			ABIT7:
				addr_state <= ABIT8;
			ABIT8:
				addr_state <= ABIT9;
			ABIT9:
				addr_state <= ABIT10;
			ABIT10:
				addr_state <= ABIT11;
			ABIT11:
				addr_state <= ABIT12;
			ABIT12:
				addr_state <= IDLE;
				
		endcase
end

parameter 
DBIT1 = 1, 
DBIT2 = 2, 
DBIT3 = 3, 
DBIT4 = 4,
DBIT5 = 5, 
DBIT6 = 6, 
DBIT7 = 7, 
DBIT8 = 8;


always @ (posedge clk or posedge reset) 
begin
	if (reset)
		data_state <= IDLE;
	else
		case (data_state)
			IDLE:
				if (handshake == 1)
				begin
					data_state <= DBIT1;
				end
				else
					data_state <= IDLE;
			DBIT1:
				data_state <= DBIT2;
			DBIT2:
				data_state <= DBIT3;
			DBIT3:
				data_state <= DBIT4;
			DBIT4:
				data_state <= DBIT5;
			DBIT5:
				data_state <= DBIT6;
			DBIT6:
				data_state <= DBIT7;
			DBIT7:
				data_state <= DBIT8;	
			DBIT8:
				data_state <= IDLE;
		endcase
end

always @ (addr_state) 
begin
	case (addr_state)
	IDLE:
	begin
		addr_idle = 1;
		addr_done = 0;
	end
	ABIT1:
	begin
		address[0] = rx_address;
		addr_idle = 0;
	end
	ABIT2:
		address[1] = rx_address;
	ABIT3:
		address[2] = rx_address;
	ABIT4:
		address[3] = rx_address;
	ABIT5:
		address[4] = rx_address;
	ABIT6:
		address[5] = rx_address;
	ABIT7:
		address[6] = rx_address;
	ABIT8:
		address[7] = rx_address;
	ABIT9:
		address[8] = rx_address;
	ABIT10:
		address[9] = rx_address;
	ABIT11:
		address[10] = rx_address;
	ABIT12:
	begin
		address[11] = rx_address;
		addr_done = 1;
	end
	default:
		address[0] = rx_address;
	endcase
end



always @ (data_state) 
begin
	case (data_state)
	IDLE:
	begin
		data_idle = 1;
		data_done = 0;
	end
	DBIT1:
	begin
		data[0] = rx_data;
		data_idle = 0;
	end
	DBIT2:
		data[1] = rx_data;
	DBIT3:
		data[2] = rx_data;
	DBIT4:
		data[3] = rx_data;
	DBIT5:
		data[4] = rx_data;
	DBIT6:
		data[5] = rx_data;
	DBIT7:
		data[6] = rx_data;
	DATA8:
	begin
		data[7] = rx_data;
		data_done = 1;
	end
	default:
		data[0] = rx_data;
	endcase
end


endmodule
