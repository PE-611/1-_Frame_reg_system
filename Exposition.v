///////////////////////////////////////////////////////////
// Name File : Exposition.v 										//
// Autor : Dyomkin Pavel Mikhailovich 							//
// Company : GSC RF TRINITI										//
// Description : 		  												//
// Start design : 26.11.2021 										//
// Last revision : 26.11.2021 									//
///////////////////////////////////////////////////////////


module Exposition (input clk_Ex, Ex_launch,
					    input [32:0] delay, 
						 input [32:0] duration,
					    output reg Ex_out
						);
				
reg [32:0] cnt;
initial cnt <= 1'b0;
initial Ex_out <= 1'b0;
reg Ex_flg;
initial Ex_flg <= 1'b0;
reg del_flg;
initial del_flg <= 1'b0;


always @(posedge clk_Ex) begin

		if (Ex_launch == 1'b1 && Ex_flg == 1'b0) begin
			Ex_flg <= 1'b1;
		end
		
		if (Ex_flg == 1'b1) begin
			Ex_out <= 1'b0;
			cnt <= cnt + 1'b1;
		end
		
		if (cnt >= delay && Ex_flg == 1'b1 && Ex_out == 1'b0) begin
			Ex_out <= 1'b1;
		end
		
		if (cnt >= delay && Ex_flg == 1'b1 && Ex_out == 1'b1) begin
			cnt <= 1'b0;
			Ex_flg <= 1'b0;
			del_flg <= 1'b1;
		end
		
		if (del_flg == 1'b1) begin
			cnt <= cnt + 1'b1;
			Ex_out <= 1'b1;
		end
		
		if (cnt >= duration && del_flg == 1'b1) begin 
			Ex_out <= 1'b0;
		end
		
		if (cnt >= duration && Ex_launch == 1'b0 && del_flg == 1'b1) begin
			Ex_out <= 1'b0;
			cnt <= 1'b0;
			Ex_flg <= 1'b0;
			del_flg <= 1'b0;
		end
		
	
	
	
			
end

		
endmodule




