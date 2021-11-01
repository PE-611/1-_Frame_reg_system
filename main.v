///////////////////////////////////////////////////////////
// Name File : Project 1-frame reg system.v					//
// Author : Dyomkin Pavel Mikhailovich 						//
// Company : GSC RF TRINITI										//
// Description : 													  	//
// Start design : 12.10.2021 										//
// Last revision : 22.10.2021 									//
///////////////////////////////////////////////////////////

module main (input CLK, UART_RX_IN, UART_TX_OUT,
			    output reg CS_SPI_RES, OUT_SPI_CLK, SDI,
				 output reg [7:0] led,
				 output UACLK,
				 output reg flg
				 
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

wire READINESS_BYTE;														//		it is for UART module
wire [7:0] DATA_FROM_UART;												//
wire [7:0] DATA_FROM_UART_reverse;
assign DATA_FROM_UART_reverse = {DATA_FROM_UART[0],DATA_FROM_UART[1],DATA_FROM_UART[2],DATA_FROM_UART[3],DATA_FROM_UART[4],DATA_FROM_UART[5],DATA_FROM_UART[6],DATA_FROM_UART[7]}; // Разворот бит в шине

reg RW;																		//
initial RW <= 1'b0;														//
reg CS;																		//
initial CS <= 1'b1;														//
reg [7:0] ADDR;															//
initial ADDR <= 1'b0;													//
wire DATA_FROM_RAM;														//

reg [30:0] cnt;
initial cnt <= 1'b0;

SPI_TX s1 (.clk(CLK), .data(data_out_for_r), .start_transmit(START_TRANSMIT), .reset(RESET_SPI), .cs(CS_SPI_RES), .sdi(SDI), .out_spi_clk(OUT_SPI_CLK), 
.selector_cs(SELECTOR_CS));


UART_Rx u1 (.clk_Rx(CLK), .Rx_in(UART_RX_IN), .data_out(DATA_FROM_UART), .Readiness_byte(READINESS_BYTE));		 

my_RAM  r1 (.rw(RW), .cs(CS), .data_in(DATA_FROM_UART_reverse), .addr(ADDR), .data_out(DATA_FROM_RAM));





// Пора писать логику общения с ком портом, и логику работы системы.


	
				

endmodule









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








	if (READINESS_BYTE == 1'b1) begin
		CS <= 1'b0;
		RW <= 1'b1;
		ADDR <= 1'b0;
	end
	
	if (READINESS_BYTE == 1'b0) begin
		CS <= 1'b0;
		RW <= 1'b0;
		ADDR <= 1'b0;
	end
	
	if (CS == 1'b0) begin
		CS <= 1'b1;
	end	
	
end




*/