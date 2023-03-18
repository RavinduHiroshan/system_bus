module slave_out_port (
	input clk, 
	input reset,
	input master_ready,
	input [7:0]datain,
	input data_ready,
	//input slave_valid,

	output reg slave_tx_done,
	output reg slave_valid,
	output reg tx_data);


reg [3:0]data_state = 0;
reg data_idle;

wire handshake = data_ready & master_ready;


parameter 
IDLE  = 4'd13,
DATA_TRANSMIT = 4'd1,
DATA_TRANSMIT_BURST = 4'd2;

reg [3:0]data_counter = 4'd0;


always @ (posedge clk or posedge reset) 
begin
	if (reset)
	begin
		data_state <= IDLE;
		slave_valid <= 0;
	end
	else
	begin 
		case (data_state)
			IDLE:
			begin
				if (handshake == 1)
				begin
					data_state <= DATA_TRANSMIT;
					tx_data <= datain[0];
					data_counter <= data_counter + 4'd1;
					slave_valid <= 1;
					data_idle <= 0;
					slave_tx_done <= 0;
				end
				else
				begin 
					data_state <= IDLE;
					tx_data <= datain[data_counter];
					data_counter <= 0;
					data_idle <= 1;
					slave_tx_done <= 0;
					slave_valid <= 1;
				end
			end
			DATA_TRANSMIT:
			begin 
				if (data_counter < 4'd7)
					begin
						data_state <= data_state;
						tx_data <= datain[data_counter];
						data_counter <= data_counter + 4'd1;
						data_idle <= 0;
						slave_tx_done <= 0;
					end
				else 
					begin
						data_state <= IDLE;
						tx_data <= datain[data_counter];
						data_counter <= 0;
						data_idle <= 0;	
						slave_tx_done <= 1;				
					end
			end 
			default:
				begin
					tx_data <= 0;
					data_state <= IDLE;
					slave_valid <= 0;
				end
		endcase
	end
end
endmodule