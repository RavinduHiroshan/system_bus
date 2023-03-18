//UART RX STATE MACHINE
    //idle
    //start but [0]
    //data n bits
    //stop bit [1]
    //finish >> idle


//baudrate  19200 baud UART
//no parity bits
//clks_per_bit = (50000000)/(19200) = 2604

module uart_rx #(parameter clks_per_bit =2604)(

input clk,
input reset,
input rx_data,

output reg receive_sig = 0,
output reg [7:0] data = 0; )

//States
parameter idle =0, start_bit=1, data_bits=2, stop=3, finish=4;

reg [2:0] state = idle;


integer clk_count = 0;
integer bit_count = 0;

reg rx_data_1 = 1;
reg rx_data_2 = 1;


// Purpose: Double-register the incoming data.
// This allows it to be used in the UART RX Clock Domain.
// (It removes problems caused by metastability)
always @(posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		rx_data_1 <= 1;
		rx_data_2 <= 1;
	end
	else
	begin
		rx_data_1 <= rx_data;
		rx_data_2 <= rx_data_1;
	end
end

   

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		state <= idle;
		clk_count <= 0;
		bit_count <= 0;
		data <= 0;
		receive_sig <= 0;
	end
	else
		case (state)
		
		idle:
		begin
			if (rx_data_2 == 0)
			begin
				state <= start_bit;
				clk_count <= 0;
			end	
			else
			begin
				state <= idle;
				clk_count <= clk_count;
			end
			bit_count <= bit_count;
			data <= data;
			receive_sig <= 0;	
		end
		
		
		//uart start bit [0] , check in the middle
		start_bit :
		begin
			if (clk_count < ((clks_per_bit-1)/2))
			begin
				state <= start_bit;
				clk_count <= clk_count+1;
				bit_count <= bit_count;
			end	
			else
			begin
				if (rx_data_2 == 0)
                begin
					state <= data_bits;
                end

				else 
                begin
					state <= idle;
                    clk_count <= 0;
                    bit_count <= 0;
                end

			end
			data <= data;
			receive_sig <= 0;	
		end		
		
		       
		data_bits :
		begin
			if (clk_count < clks_per_bit-1)
			begin
				state <= data_bits;
				clk_count <= clk_count+1;
				bit_count <= bit_count;
				data <= data;
			end	
			else
			begin
				if (bit_count < 7)
				begin
					state <= data_bits;
					bit_count <= bit_count+1;
				end
                
				else
				begin
					state <= stop_bits;;
					bit_count <= 0;
				end
				clk_count <= 0;
				data[bit_count] <= rx_data_2;
			end
			receive_sig <= 0;	
		end			
		
		//uart stop bit [1]
		stop :
		begin
			if (clk_count < clks_per_bit-1)
			begin
				state <= stop;
				clk_count <= clk_count+1;
				receive_sig <= 0;	
			end	
			else
			begin
				if (rx_data_2 == 1)
				begin
					state <= finish;
					receive_sig <= 1;
				end
				else
				begin
					state <= idle;
					receive_sig <= 0;
				end
				clk_count <= 0;
			end
			bit_count <= bit_count;
			data <= data;
		end	
				
		
		finish :
		begin
			state <= idle;
			clk_count <= clk_count;
			bit_count <= bit_count;
			data <= data;
			receive_sig <= 0;
		end
		
		
		default :
		begin
			state <= idle;
			clk_count <= 0;
			bit_count <= 0;
			data <= data;
			receive_sig <= 0;
		end
		
		endcase
end
   
endmodule 