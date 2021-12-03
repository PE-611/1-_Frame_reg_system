///////////////////////////////////////////////////////////
// Name File : my_RAM.v 											//
// Autor : Dyomkin Pavel Mikhailovich 							//
// Company : GSC RF TRINITI										//
// Description : RAM												  	//
// Start design : 14.10.2020 										//
// Last revision : 15.11.2021 									//
///////////////////////////////////////////////////////////

module my_RAM (input rw, cs, clr,
					input [7:0] data_in,
					input [7:0] addr,
					output reg [7:0] data_out,
					output [32:0] del1,
					output [32:0] dur1,
					output [7:0] thhv,
					output [7:0] res_value
					
					);


reg [7:0] data[15:0];

assign del1 = {data[0],data[1],data[2],data[3]};
assign dur1 = {data[4],data[5],data[6],data[7]};
assign thhv = data[8];
assign res_value = data[9];



always @(negedge cs) begin

	
	if (rw == 1'b0) begin 					//READ
			
		data_out = data[addr];
	end
	
	else if (rw == 1'b1) begin 			//WRITE
		
		data[addr] = data_in;
	
	end
	
	else begin
		
		data_out = 8'bz;
	
	end	
end
endmodule
