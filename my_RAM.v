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
					output [32:0] del2,
					output [32:0] dur2,
					output [32:0] del3,
					output [32:0] dur3,
					output [32:0] del4,
					output [32:0] dur4,
					output [32:0] del5,
					output [32:0] dur5,
					output [32:0] del6,
					output [32:0] dur6,
					output [32:0] del7,
					output [32:0] dur7,
					output [32:0] del8,
					output [32:0] dur8,
					
					output [7:0] res_value_1,
					output [7:0] res_value_2,
					output [7:0] res_value_3,
					output [7:0] res_value_4,
					output [7:0] res_value_5,
					output [7:0] res_value_6,
					output [7:0] res_value_7,
					output [7:0] res_value_8,
					
					output [7:0] thhv
					
					);


reg [7:0] data [128:0];

assign del1 = {data[0],data[1],data[2],data[3]};
assign dur1 = {data[4],data[5],data[6],data[7]};

assign del2 = {data[8],data[9],data[10],data[11]};
assign dur2 = {data[12],data[13],data[14],data[15]};

assign del3 = {data[16],data[17],data[18],data[19]};
assign dur3 = {data[20],data[21],data[22],data[23]};

assign del4 = {data[24],data[25],data[26],data[27]};
assign dur4 = {data[28],data[29],data[30],data[31]};

assign del5 = {data[32],data[33],data[34],data[35]};
assign dur5 = {data[36],data[37],data[38],data[39]};

assign del6 = {data[40],data[41],data[42],data[43]};
assign dur6 = {data[44],data[45],data[46],data[47]};

assign del7 = {data[48],data[49],data[50],data[51]};
assign dur7 = {data[52],data[53],data[54],data[55]};

assign del8 = {data[56],data[57],data[58],data[59]};
assign dur8 = {data[60],data[61],data[62],data[63]};

assign res_value_1 = data[64];
assign res_value_2 = data[65];
assign res_value_3 = data[66];
assign res_value_4 = data[67];
assign res_value_5 = data[68];
assign res_value_6 = data[69];
assign res_value_7 = data[70];
assign res_value_8 = data[71];

assign thhv = data[72];





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
