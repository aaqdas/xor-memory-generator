//Generated by XOR-Memory Generator
//LICENSED for use by https://github.com/aaqdas
module xor_2r_2w_tb;
reg clk;
reg [1:0] i_enW;
reg [(10-1):0] i_ra1;
wire [(32-1):0] o_r1;
reg [(10-1):0] i_ra2;
wire [(32-1):0] o_r2;
reg [(10-1):0] i_wa1;
reg [(32-1):0]    i_w1;
reg [(10-1):0] i_wa2;
reg [(32-1):0]    i_w2;
xor_2r_2w uut(
.clk(clk)
,.i_enW(i_enW)
,.i_ra1(i_ra1)
,.o_r1(o_r1)
,.i_ra2(i_ra2)
,.o_r2(o_r2)
,.i_wa1(i_wa1)
,.i_w1(i_w1)
,.i_wa2(i_wa2)
,.i_w2(i_w2)
);
initial clk = 0;
always #10 clk = ~clk;

initial
begin
i_wa1 = 356;
i_w1  = 2572296104;
#20;
i_wa2 = 33;
i_w2  = 515637979;
#20;
i_ra1 = 356;
i_ra2 = 33;
end
endmodule