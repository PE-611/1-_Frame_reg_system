///////////////////////////////////////////////////////////
// Name File : Project 1-frame reg system.v					//
// Author : Dyomkin Pavel Mikhailovich 						//
// Company : GSC RF TRINITI										//
// Description : 													  	//
// Start design : 12.10.2021 										//
// Last revision : 22.10.2021 									//
///////////////////////////////////////////////////////////

module main (input CLK, UART_RX_IN, launch_5kV, launch_ex,
				 output reg OUT_SPI_CLK, SDI,
				 output reg [3:0] CS_SPI_RES,
				 output UART_TX_OUT,
				 output EX_OUT1,
				 output EX_OUT2,
				 output EX_OUT3,
				 output EX_OUT4,
				 output EX_OUT5,
				 output EX_OUT6,
				 output EX_OUT7,
				 output EX_OUT8,
				 output OUT_5kv
				 
				);

		

wire [9:0] data_out_for_r_1;												//
wire [9:0] data_out_for_r_2;												//
wire [9:0] data_out_for_r_3;												//
wire [9:0] data_out_for_r_4;												//
wire [9:0] data_out_for_r_5;												//
wire [9:0] data_out_for_r_6;												//
wire [9:0] data_out_for_r_7;												//
wire [9:0] data_out_for_r_8;												//

reg [7:0] code_of_resistance_1;										//
reg [7:0] code_of_resistance_2;										//
reg [7:0] code_of_resistance_3;										//
reg [7:0] code_of_resistance_4;										//
reg [7:0] code_of_resistance_5;										//
reg [7:0] code_of_resistance_6;										//
reg [7:0] code_of_resistance_7;										//
reg [7:0] code_of_resistance_8;										//

reg [1:0] choice_res_00;												//
reg [1:0] choice_res_01;												//
initial choice_res_00 <= 1'b00;										//
initial choice_res_01 <= 1'b01;										//

assign data_out_for_r_1 = {choice_res_00, code_of_resistance_1};//		it is for SPI module
assign data_out_for_r_2 = {choice_res_01, code_of_resistance_2};
assign data_out_for_r_3 = {choice_res_00, code_of_resistance_3};
assign data_out_for_r_4 = {choice_res_01, code_of_resistance_4};
assign data_out_for_r_5 = {choice_res_00, code_of_resistance_5};
assign data_out_for_r_6 = {choice_res_01, code_of_resistance_6};
assign data_out_for_r_7 = {choice_res_00, code_of_resistance_7};
assign data_out_for_r_8 = {choice_res_01, code_of_resistance_8};

reg [9:0] buffer_data_out_for_r;
initial buffer_data_out_for_r <= 1'b0;
																				//
reg START_TRANSMIT;														//
initial START_TRANSMIT <= 1'b0;										//
reg RESET_SPI;																//
initial RESET_SPI <= 1'b1;												//
reg [2:0] SELECTOR_CS;													//
initial SELECTOR_CS <= 3'd0;





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
wire [32:0] DEL2;
wire [32:0] DUR2;
wire [32:0] DEL3;
wire [32:0] DUR3;
wire [32:0] DEL4;
wire [32:0] DUR4;
wire [32:0] DEL5;
wire [32:0] DUR5;
wire [32:0] DEL6;
wire [32:0] DUR6;
wire [32:0] DEL7;
wire [32:0] DUR7;
wire [32:0] DEL8;
wire [32:0] DUR8;
wire [7:0] DL_THHV;



reg TX_LAUNCH;																//
initial TX_LAUNCH <= 1'b0;												//		it is for UART TX module 
reg RESET;																	//
initial RESET <= 1'b1;													//


Exposition EX1 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT1), .delay(DEL1), .duration(DUR1)); 
Exposition EX2 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT2), .delay(DEL2), .duration(DUR2)); 
Exposition EX3 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT3), .delay(DEL3), .duration(DUR3)); 
Exposition EX4 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT4), .delay(DEL4), .duration(DUR4)); 
Exposition EX5 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT5), .delay(DEL5), .duration(DUR5)); 
Exposition EX6 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT6), .delay(DEL6), .duration(DUR6)); 
Exposition EX7 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT7), .delay(DEL7), .duration(DUR7)); 
Exposition EX8 (.clk_Ex(CLK), .Ex_launch(launch_ex), .Ex_out(EX_OUT8), .delay(DEL8), .duration(DUR8)); 


time_of_hold_HV TH1(.clk_thhv(CLK), .thhv_launch(launch_5kV), .thhv_out(OUT_5kv), .delay(DL_THHV)); 

SPI_TX s1 (.clk(CLK), .data(buffer_data_out_for_r), .start_transmit(START_TRANSMIT), .reset(RESET_SPI), .sep_cs(CS_SPI_RES), .sdi(SDI), .out_spi_clk(OUT_SPI_CLK), 
.selector_cs(SELECTOR_CS));


UART_Rx u1 (.clk_Rx(CLK), .Rx_in(UART_RX_IN), .data_out(DATA_FROM_UART), .Readiness_byte(READINESS_BYTE));	


UART_Tx t1 (.clk_Tx(CLK), .tx_launch(TX_LAUNCH), .reset(RESET), .Tx_out(UART_TX_OUT));

my_RAM  r1 (.rw(RW), .cs(CS), .data_in(DATA_FROM_UART_reverse), .addr(ADDR), .thhv(DL_THHV),
.del1(DEL1) , .dur1(DUR1), .del2(DEL2) , .dur2(DUR2), .del3(DEL3) , .dur3(DUR3), .del4(DEL4) , .dur4(DUR4), .del5(DEL5) , .dur5(DUR5),
.del6(DEL6) , .dur6(DUR6), .del7(DEL7) , .dur7(DUR7), .del8(DEL8) , .dur8(DUR8), 
.res_value_1(code_of_resistance_1), .res_value_2(code_of_resistance_2), .res_value_3(code_of_resistance_3), .res_value_4(code_of_resistance_4),
.res_value_5(code_of_resistance_5), .res_value_6(code_of_resistance_6), .res_value_7(code_of_resistance_7), .res_value_8(code_of_resistance_8)
); 









////////////////////////////////////////////////////////Echo test////////////////////////////////////////////////////////


reg del_1_tick_flag;
reg rst_uart_tx;


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

reg RAM_data_readiness_flag;
initial RAM_data_readiness_flag <= 1'b0;


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
	
	if (ADDR == 8'd73) begin  // количество байт для приема
		ADDR <= 1'b0;
		RAM_data_readiness_flag <= 1'b1;
	end
	
	if (RAM_data_readiness_flag == 1'b1) begin
		RAM_data_readiness_flag <= 1'b0;
	end	

end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////Trnsmit data SPI resistor/////////////////////////////////////////////

reg df;
initial df <= 1'b0;


always @(posedge CLK) begin

	choice_res_00 <= 1'b00;										
   choice_res_01 <= 1'b01;
	RESET_SPI <= 1'b1;
	SELECTOR_CS <= 3'd0;
	
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