/////////////////////////////////////////////////////////////////
// Name File : mega_Delay.v 												//
// Autor : Dyomkin Pavel Mikhailovich 									//
// Company : GSC RF TRINITI												//
// Description : 																//
// Start design : 26.11.2021 												//
// Last revision : 26.11.2021 											//
/////////////////////////////////////////////////////////////////

module time_of_hold_HV (input clk_thhv, thhv_launch,
							   input [7:0] delay,
							   output reg thhv_out
							  );
				
reg [32:0] cnt;
initial cnt <= 1'b0;

reg [7:0] cnt1;
initial cnt1 <= 1'b0;

initial thhv_out <= 1'b0;

  
reg thhv_flg;
initial thhv_flg <= 1'b0;   


always @(posedge clk_thhv) begin
	
	
	if (thhv_launch == 1'b1) begin
		thhv_flg <= 1'b1;
	end
	
	
	if (thhv_flg == 1'b1) begin
		cnt <= cnt + 1'b1;
		thhv_out <= 1'b1;
	end
	
	if (cnt == 32'd100000000) begin
		cnt <= 1'b0;
		cnt1 <= cnt1 + 1'b1;
	end
	
	if (cnt1 == delay) begin
		thhv_out <= 1'b0;
		cnt <= 1'b0;
		cnt1 <= 1'b0;
		thhv_flg <= 1'b0;
	end

end



		
	



endmodule





