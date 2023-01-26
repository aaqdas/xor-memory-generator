module xor_memory(clk,enW,ra1,ra2,ra3,ra4,r1,r2,r3,r4,wa1,wa2,w1,w2);
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 8;
input clk;
input [1:0] enW;                                      // Write Enable
input [(ADDR_WIDTH-1):0] ra1,ra2,ra3,ra4;                      // read addresses
input [(ADDR_WIDTH-1):0] wa1,wa2;                      // read addresses
input [DATA_WIDTH-1:0]    w1,w2;                      // data to write
output reg [DATA_WIDTH-1:0] r1,r2,r3,r4;                    // data read from memory
reg [ADDR_WIDTH-1:0] wa1_regd,wa2_regd;                     // registered wa
reg [DATA_WIDTH-1:0]   w1_regd,w2_regd;                    // registered wa
reg [1:0] enW_regd;                                   // registered enW
//reg [(ADDR_WIDTH-1):0] addr[3:0];
reg [DATA_WIDTH:0] dIn[1:0];                          // Data to Write in Mem Banks
wire [DATA_WIDTH-1:0] dOut0,dOut1,dOut2,dOut3,dOut4,dOut5,dOut6,dOut7,dOut8,dOut9;
always@(posedge clk)
begin
wa1_regd<=wa1;
w1_regd<=w1;
wa2_regd<=wa2;
w2_regd<=w2;
enW_regd <= enW;
end
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage0(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(wa2),.we(enW_regd[0]),.clk(clk),.q(dOut0));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage1(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra4),.we(enW_regd[0]),.clk(clk),.q(dOut1));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage2(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra3),.we(enW_regd[0]),.clk(clk),.q(dOut2));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage3(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra2),.we(enW_regd[0]),.clk(clk),.q(dOut3));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage4(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra1),.we(enW_regd[0]),.clk(clk),.q(dOut4));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage5(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(wa1),.we(enW_regd[1]),.clk(clk),.q(dOut5));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage6(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra4),.we(enW_regd[1]),.clk(clk),.q(dOut6));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage7(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra3),.we(enW_regd[1]),.clk(clk),.q(dOut7));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage8(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra2),.we(enW_regd[1]),.clk(clk),.q(dOut8));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage9(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra1),.we(enW_regd[1]),.clk(clk),.q(dOut9));
always @ (*)
begin
dIn[0] = w1_regd ^ dOut5;
dIn[1] = w2_regd ^ dOut0;
r1 = dOut4 ^ dOut9;
r2 = dOut3 ^ dOut8;
r3 = dOut2 ^ dOut7;
r4 = dOut1 ^ dOut6;
end
endmodule
module simple_dual_port_ram
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	initial 
	begin : INIT
		integer i;
		for(i = 0; i < 2**ADDR_WIDTH; i = i + 1)
			ram[i] = {DATA_WIDTH{1'b1}};
	end 
		
	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[write_addr] <= data;

		// Read (if read_addr == write_addr, return OLD data).	To return
		// NEW data, use = (blocking write) rather than <= (non-blocking write)
		// in the write assignment.	 NOTE: NEW data may require extra bypass
		// logic around the RAM.
		q <= ram[read_addr];
	end
	
endmodule

