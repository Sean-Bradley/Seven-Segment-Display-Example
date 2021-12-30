module sevenSegmentDisplayExample (
	input clk,
	output a, b, c, d, e, f, g, dp, D1, D2, D3, D4
);

reg [3:0] dig;
reg [7:0] ssd; //seven seg display
reg [31:0] cnt;
reg [31:0] cnt2;
reg [1:0] i;
reg [3:0] j;

assign {D4, D3, D2, D1} = dig[3:0];
assign {a, b, c, d, e, f, g, dp} = ssd[7:0];

function [7:0] next;
	input [3:0] v;
	begin
		case (v % 12)
			4'h0 : next = 8'b01111111;
			4'h1 : next = 8'b10111111;
			4'h2 : next = 8'b11011111;
			4'h3 : next = 8'b11101111;
			4'h4 : next = 8'b11110111;
			4'h5 : next = 8'b11111011;
			4'h6 : next = 8'b11111111;			
			4'h7 : next = 8'b11110011; // 1			
			4'h8 : next = 8'b00100101; // 2
			4'h9 : next = 8'b00001101; // 3
			4'ha : next = 8'b10011001; // 4
			4'hb : next = 8'b11111111;
		endcase		
	end
endfunction
	
always @ (posedge clk) begin
   cnt <= cnt+1;
	if(cnt > 100000) begin
		cnt <= 0;
		i <= i+1;
		case(i)
			2'b00 :	begin
							dig = 4'b0111; 
							ssd <= next(j);
						end
			2'b01 : 	begin
							dig = 4'b1011;
							ssd <= next(j+1);
						end
			2'b10 : 	begin
							dig = 4'b1101;
							ssd <= next(j+2);
						end
			2'b11 : 	begin
							dig = 4'b1110;
							ssd <= next(j+3);
							cnt2 <= cnt2 + 1;
							if (cnt2 == 30)
								begin
									cnt2 <= 0;
									j <= j+1;
									if (j==11)
										j <= 0;
								end
						end
		endcase		
	end
end

endmodule

