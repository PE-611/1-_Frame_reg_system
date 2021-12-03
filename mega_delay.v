/////////////////////////////////////////////////////////////////
// Name File : time_of_hold_HV.v 												//
// Autor : Dyomkin Pavel Mikhailovich 									//
// Company : GSC RF TRINITI												//
// Description : 																//
// Start design : 26.11.2021 												//
// Last revision : 26.11.2021 											//
/////////////////////////////////////////////////////////////////

module time_of_hold_HV (input clk_Delay, DL_launch,
				  input [7:0] delay,
				  output reg DL_out, launch_exp, End_Flg 
				 );
				
reg [32:0] cnt;
initial cnt <= 1'b0;

reg [7:0] cnt1;
initial cnt1 <= 1'b0;

initial DL_out <= 1'b0;
initial launch_exp <= 1'b0;
initial End_Flg <= 1'b0;   
reg dl_flg;
initial dl_flg <= 1'b0;   


always @(posedge clk_Delay) begin
	
	
	if (DL_launch == 1'b1) begin
		dl_flg <= 1'b1;
	end
	
	
	if (dl_flg == 1'b1) begin
		cnt <= cnt + 1'b1;
		DL_out <= 1'b1;
	end
	
	if (cnt == 32'd100000000) begin
		cnt <= 1'b0;
		cnt1 <= cnt1 + 1'b1;
	end
	
	if (cnt1 == delay) begin
		DL_out <= 1'b0;
		cnt <= 1'b0;
		cnt1 <= 1'b0;
		dl_flg <= 1'b0;
	end

end



		
	



endmodule





