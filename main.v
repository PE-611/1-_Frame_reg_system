///////////////////////////////////////////////////////////
// Name File : Project 1-frame reg system.v					//
// Author : Dyomkin Pavel Mikhailovich 						//
// Company : GSC RF TRINITI										//
// Description : 													  	//
// Start design : 12.10.2021 										//
// Last revision : 22.10.2021 									//
///////////////////////////////////////////////////////////

module main (input CLK, UART_RX_IN, launch_5kV, launch_ex,
				 output reg CS_SPI_RES, OUT_SPI_CLK, SDI,
				 output [7:0] led,
				 output UART_TX_OUT,
				 output EX_OUT,
				 output OUT_5kv
				 
				);

		

wire [9:0] data_out_for_r;												//
reg [7:0] code_of_resistance;											//
initial code_of_resistance <= 1'b0;									// 
reg [1:0] choice_res;													//
initial choice_res <= 1'b00;											//
assign data_out_for_r = {choice_res, code_of_resistance}; 	//		it is for SPI module
																				//
reg START_TRANSMIT;														//
initial START_TRANSMIT <= 1'b0;										//
reg RESET_SPI;																//
initial RESET_SPI <= 1'b1;												//
wire [2:0] SELECTOR_CS;													//

wire READINESS_BYTE;														//		it is for UART RX module            
wire [7:0] DATA_FROM_UART;												//
wire [7:0] DATA_FROM_UART_reverse;
assign DATA_FROM_UART_reverse = {DATA_FROM_UART[0],DATA_FROM_UART[1],DATA_FROM_UART[2],DATA_FROM_UART[3],DATA_FROM_UART[4],DATA_FROM_UART[5],DATA_FROM_UART[6],DATA_FROM_UART[7]}; // Разворот бит в шине

reg RW;																		//
initial RW <= 1'b0;														//
reg CS;																		//
initial CS <= 1'b1;														//		it is for RAM
reg [7:0] ADDR;															//
initial ADDR <= 1'b0;													//
wire [7:0] DATA_FROM_RAM;												//
wire [7:0] data_in;														//
reg res_addr_cnt;															//
initial res_addr_cnt <= 1'b0; 										//
reg restart_cs;															//
initial restart_cs <= 1'b0;											//
wire [32:0] DEL1;
wire [32:0] DUR1;
wire [7:0] DL_THHV;



reg TX_LAUNCH;																//
initial TX_LAUNCH <= 1'b0;												//		it is for UART TX module 
reg RESET;																	//
initial RESET <= 1'b1;													//


Exposition EX1 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT), .delay(DEL1), .duration(DUR1)); 

time_of_hold_HV TH1(.clk_thhv(CLK), .thhv_launch(launch_5kV), .thhv_out(OUT_5kv), .delay(DL_THHV)); 

SPI_TX s1 (.clk(CLK), .data(data_out_for_r), .start_transmit(START_TRANSMIT), .reset(RESET_SPI), .cs(CS_SPI_RES), .sdi(SDI), .out_spi_clk(OUT_SPI_CLK), 
.selector_cs(SELECTOR_CS));


UART_Rx u1 (.clk_Rx(CLK), .Rx_in(UART_RX_IN), .data_out(DATA_FROM_UART), .Readiness_byte(READINESS_BYTE));	


UART_Tx t1 (.clk_Tx(CLK), .tx_launch(TX_LAUNCH), .reset(RESET), .Tx_out(UART_TX_OUT));

my_RAM  r1 (.rw(RW), .cs(CS), .data_in(DATA_FROM_UART_reverse), .addr(ADDR), .del1(DEL1) , .dur1(DUR1), .thhv(DL_THHV), .res_value(code_of_resistance)); 





reg [30:0] cnt;
reg del_1_tick_flag;
reg rst_uart_tx;
reg RAM_data_readiness_flag;
initial RAM_data_readiness_flag <= 1'b0;




////////////////////////////////////////////////////////Echo test////////////////////////////////////////////////////////

always @(posedge READINESS_BYTE or posedge rst_uart_tx) begin
	
	RESET <= 1'b1;
	TX_LAUNCH <= 1'b0;
	
	if (READINESS_BYTE)	begin
		if (DATA_FROM_UART_reverse == 8'b01110010) begin 			// check symbol "r"? ASII? 
		
			TX_LAUNCH <= 1'b1;
																					
		end
	end
	
	else begin
		TX_LAUNCH <= 1'b0;
	end

end


always @(posedge CLK) begin
	
	if (TX_LAUNCH <= 1'b1) begin
		del_1_tick_flag <= 1'b1;
	end
	
	if (del_1_tick_flag == 1'b1) begin
		rst_uart_tx <= 1'b1;
	end
	
	
	if (rst_uart_tx == 1'b1) begin
		rst_uart_tx <= 1'b0;
	end
	
end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////Save or "write" data from UART_rx in RAM////////////////////////////////


always @(posedge CLK) begin

	if (DATA_FROM_UART_reverse != 8'b01110010) begin
		
		if (READINESS_BYTE == 1'b1) begin
		
			CS <= 1'b0;
			RW <= 1'b1;
			
		end
		
	end
	
	
	if (CS == 1'b0) begin
		CS <= 1'b1;
		RW <= 1'bz;
		ADDR <= ADDR + 1'b1;

	end
	
	if (ADDR == 8'd10) begin
		ADDR <= 1'b0;
		RAM_data_readiness_flag <= 1'b1;
	end

end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////Trnsmit data SPI resistor/////////////////////////////////////////////

reg df;
initial df <= 1'b0;
always @(posedge CLK) begin

	choice_res <= 1'b00;
	RESET_SPI <= 1'b1;
	
	if (launch_5kV == 1'b1) begin
		START_TRANSMIT <= 1'b1;
	end
	
	if (START_TRANSMIT == 1'b1) begin
		df <= 1'b1;
	end
	
	if (df == 1'b1) begin
		df <= 1'b0;
		START_TRANSMIT <= 1'b0;
	end

end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











	


	
				

endmodule
/*

always @(posedge CLK) begin

	if (DATA_FROM_UART_reverse != 8'b01110010) begin
		
		if (READINESS_BYTE == 1'b1) begin
		
			CS <= 1'b0;
			RW <= 1'b1;
			
		end
		
	end
	
	
	if (CS == 1'b0) begin
		CS <= 1'b1;
		RW <= 1'bz;
		ADDR <= ADDR + 1'b1;

	end
	
	if (ADDR == 8'd10) begin											// To check the reception of data and their recording in memory, the output of the received data from memory to the LEDs
		f <= 1'b1;
	end
	
	if (f == 1'b1) begin
		cnt <= cnt + 1'b1;
	end

	if (cnt == 30'd10000000) begin
		cnt <= 1'b0;
		ff <= 1'b1;
	end
	
	if (ff == 1'b1) begin
		ff <= 1'b0;
		CS <= 1'b0;
		RW <= 1'b0;
	end
	
	

end


*/



/*

	if (DATA_FROM_UART_reverse == 8'b01110010) begin 			// check symbol "r"? ASII? 
	
		led <= 8'b01110010;
																				// To check reaction on receive chek symbol, UART RX check
	end

	else begin
		led <= 8'b11111111;
	end
	
	
*/





/*


always @(posedge CLK) begin
	
	cnt <= cnt + 1'b1;
	
	
	if (cnt == 30'd100000000) begin
		cnt <= 1'b0;
		if (READINESS_BYTE == 1'b0) begin
			CS <= 1'b0;
			ADDR <= ADDR + 1'b1;
			RW <= 1'b0;
			
		end
	end
																				// To check RAM
	if (READINESS_BYTE == 1'b1) begin
		CS <= 1'b0;
		RW <= 1'b1;
		ADDR <= ADDR + 1'b1;
	end
													

	
	if (CS == 1'b0) begin
		CS <= 1'b1;
	end	
	
	if (RW == 1'b1) begin
		RW <= 1'b0;
	end
	
	if (ADDR >= 7'd15) begin
		ADDR <= 1'b0;
	end
	
end

*/






















/*
reg [30:0] cnt;



always @(posedge CLK) begin
	cnt <= cnt + 1'b1;
	if (cnt == 30'd100000000) begin
		cnt <= 1'b0;
		START_TRANSMIT <= 1'b1;
		code_of_resistance <= code_of_resistance + 1'b1; 		// To check SPI resistor
		RESET_SPI <= 1'b1;		
	end	
	
	if (START_TRANSMIT == 1'b1) begin
		START_TRANSMIT <= 1'b0;
	end

end







*/