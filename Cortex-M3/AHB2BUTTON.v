module AHB2BUTTON(
	//AHBLITE INTERFACE
		//Slave Select Signals
			input wire HSEL,
		//Global Signal
			input wire HCLK,
			input wire HRESETn,
		//Address, Control & Write Data
			input wire HREADY,
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			
			input wire [31:0] HWDATA,
		// Transfer Response & Read Data
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
		//BUTTON input
			input wire [7:0] BUTTON
);

//Address Phase Sampling Registers
  reg rHSEL;
  reg [31:0] rHADDR;
  reg [1:0] rHTRANS;
  reg rHWRITE;
  reg [2:0] rHSIZE;
  reg [31:0] read_mux;
  reg [7:0] rBUTTON;
  reg [7:0] reg_buttons_sync;
//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
  begin
	 if(!HRESETn)
	 begin
		rHSEL		<= 1'b0;
		rHADDR	<= 32'h0;
		rHTRANS	<= 2'b00;
		rHWRITE	<= 1'b0;
		rHSIZE	<= 3'b000;
	 end
    else if(HREADY)
    begin
      rHSEL		<= HSEL;
		rHADDR	<= HADDR;
		rHTRANS	<= HTRANS;
		rHWRITE	<= HWRITE;
		rHSIZE	<= HSIZE;
    end
  end

wire read_enable;
assign  read_enable = rHSEL & ~rHWRITE & rHTRANS[1];

//read
always @(read_enable or rHADDR or rBUTTON)
begin
	if(read_enable)
		begin
			read_mux <= {24'h0000_00,rBUTTON[7:0]};
		end
	else begin
		read_mux <= {32'b0};
	end
end  

assign HRDATA = read_mux;
  
//Transfer Response
  assign HREADYOUT = 1'b1; //Single cycle Write & Read. Zero Wait state operations

  
 //BUTTON
 always @ (posedge HCLK,negedge HRESETn)
 begin
	if(~HRESETn)
		reg_buttons_sync <= 8'b0000_0000;
	else
		reg_buttons_sync <= BUTTON;
 end
 
 always @(posedge HCLK or negedge HRESETn)
 begin
 if(~HRESETn)
	rBUTTON <= 8'b0000_0000;
 else
	rBUTTON <= reg_buttons_sync;
 end
 /*
//Read Data  
  assign HRDATA = {24'h0000_00,rBUTTON};

  assign BUTTON = rBUTTON;
*/
endmodule

