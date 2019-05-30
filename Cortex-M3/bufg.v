module BUFG(
	input  CLK,
	input  reset_n,
	output reg fclk

);

   reg     [1:0] clk_div;
   always @(posedge CLK or negedge reset_n)
   begin
      if (!reset_n)
			begin
         clk_div <= 0;
         fclk<=0;
			end
      else
      begin
         if (clk_div == 3)
         	begin
            clk_div <= 0;
            fclk <= ~fclk;
				end
         else
            clk_div <= clk_div + 1;
      end  	
   end

endmodule
