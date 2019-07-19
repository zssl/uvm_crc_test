module crc7(clk,
	rst,
	data,
	crc);
input wire clk;
input wire rst;
input wire data;
output reg[6:0] crc;

reg g0, g3;

assign g0 = data ^ crc[6];
assign g3 = crc[2] ^ g0;

always @(posedge rst or negedge clk)
if (rst)
begin
	crc <= 7'b0000000;
end
else
begin
	crc[6] <= crc[5];
	crc[5] <= crc[4];
	crc[4] <= crc[3];
	crc[3] <= crc[2] ^ g0;
	crc[2] <= crc[1];
	crc[1] <= crc[0];
	crc[0] <= g0;
end

	
endmodule
