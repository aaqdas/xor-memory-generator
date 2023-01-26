
module test;
reg clk;
reg [9:0] wa1,wa2;//addresses
reg [9:0] ra1,ra2,ra3,ra4;//addresses
reg [7:0] w1,w2;//data to write
reg [3:0] enW;

wire [7:0] r1,r2,r3,r4;//data to read


xor_memory sram1(clk,enW,ra1,ra2,ra3,ra4,r1,r2,r3,r4,wa1,wa2,w1,w2);
initial clk = 0;
initial forever #10 clk = ~clk; 

initial 
begin
#10;
wa1 = 10'd10;
wa2 = 10'd20;
w1 = 8'd10;
w2 = 8'd20;
enW = 4'b11;
#20;
wa1 = 10'd30;
wa2 = 10'd40;
w1 = 8'd30;
w2 = 8'd40;
#20;
ra1 = 10'd10;
ra2 = 10'd20;
ra3 = 10'd30;
ra4 = 10'd40;

end
endmodule 