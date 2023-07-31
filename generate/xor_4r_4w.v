module xor_memory(clk,enW,ra1,ra2,ra3,ra4,r1,r2,r3,r4,wa1,wa2,wa3,wa4,w1,w2,w3,w4);
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 8;
input clk;
input [3:0] enW;                                      // Write Enable
input [(ADDR_WIDTH-1):0] ra1,ra2,ra3,ra4;                      // read addresses
input [(ADDR_WIDTH-1):0] wa1,wa2,wa3,wa4;                      // read addresses
input [DATA_WIDTH-1:0]    w1,w2,w3,w4;                      // data to write
output reg [DATA_WIDTH-1:0] r1,r2,r3,r4;                    // data read from memory
reg [ADDR_WIDTH-1:0] wa1_regd,wa2_regd,wa3_regd,wa4_regd;                     // registered wa
reg [DATA_WIDTH-1:0]   w1_regd,w2_regd,w3_regd,w4_regd;                    // registered wa
reg [3:0] enW_regd;                                   // registered enW
//reg [(ADDR_WIDTH-1):0] addr[3:0];
reg [DATA_WIDTH:0] dIn[3:0];                          // Data to Write in Mem Banks
wire [DATA_WIDTH-1:0] dOut0,dOut1,dOut2,dOut3,dOut4,dOut5,dOut6,dOut7,dOut8,dOut9,dOut10,dOut11,dOut12,dOut13,dOut14,dOut15,dOut16,dOut17,dOut18,dOut19,dOut20,dOut21,dOut22,dOut23,dOut24,dOut25,dOut26,dOut27;
always@(posedge clk)
begin
wa1_regd<=wa1;
w1_regd<=w1;
wa2_regd<=wa2;
w2_regd<=w2;
wa3_regd<=wa3;
w3_regd<=w3;
wa4_regd<=wa4;
w4_regd<=w4;
enW_regd <= enW;
end
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage0(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(wa2),.we(enW_regd[0]),.clk(clk),.q(dOut0));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage1(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(wa3),.we(enW_regd[0]),.clk(clk),.q(dOut1));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage2(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(wa4),.we(enW_regd[0]),.clk(clk),.q(dOut2));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage3(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra4),.we(enW_regd[0]),.clk(clk),.q(dOut3));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage4(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra3),.we(enW_regd[0]),.clk(clk),.q(dOut4));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage5(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra2),.we(enW_regd[0]),.clk(clk),.q(dOut5));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage6(.data(dIn[0]),
                .write_addr(wa1_regd),.read_addr(ra1),.we(enW_regd[0]),.clk(clk),.q(dOut6));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage7(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(wa1),.we(enW_regd[1]),.clk(clk),.q(dOut7));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage8(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(wa3),.we(enW_regd[1]),.clk(clk),.q(dOut8));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage9(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(wa4),.we(enW_regd[1]),.clk(clk),.q(dOut9));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage10(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra4),.we(enW_regd[1]),.clk(clk),.q(dOut10));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage11(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra3),.we(enW_regd[1]),.clk(clk),.q(dOut11));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage12(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra2),.we(enW_regd[1]),.clk(clk),.q(dOut12));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage13(.data(dIn[1]),
                .write_addr(wa2_regd),.read_addr(ra1),.we(enW_regd[1]),.clk(clk),.q(dOut13));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage14(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(wa1),.we(enW_regd[2]),.clk(clk),.q(dOut14));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage15(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(wa2),.we(enW_regd[2]),.clk(clk),.q(dOut15));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage16(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(wa4),.we(enW_regd[2]),.clk(clk),.q(dOut16));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage17(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(ra4),.we(enW_regd[2]),.clk(clk),.q(dOut17));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage18(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(ra3),.we(enW_regd[2]),.clk(clk),.q(dOut18));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage19(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(ra2),.we(enW_regd[2]),.clk(clk),.q(dOut19));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage20(.data(dIn[2]),
                .write_addr(wa3_regd),.read_addr(ra1),.we(enW_regd[2]),.clk(clk),.q(dOut20));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage21(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(wa1),.we(enW_regd[3]),.clk(clk),.q(dOut21));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage22(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(wa2),.we(enW_regd[3]),.clk(clk),.q(dOut22));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage23(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(wa3),.we(enW_regd[3]),.clk(clk),.q(dOut23));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage24(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(ra4),.we(enW_regd[3]),.clk(clk),.q(dOut24));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage25(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(ra3),.we(enW_regd[3]),.clk(clk),.q(dOut25));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage26(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(ra2),.we(enW_regd[3]),.clk(clk),.q(dOut26));
simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage27(.data(dIn[3]),
                .write_addr(wa4_regd),.read_addr(ra1),.we(enW_regd[3]),.clk(clk),.q(dOut27));
always @ (*)
begin
dIn[0] = w1_regd ^ dOut7 ^ dOut14 ^ dOut21;
dIn[1] = w2_regd ^ dOut0 ^ dOut15 ^ dOut22;
dIn[2] = w3_regd ^ dOut1 ^ dOut8 ^ dOut23;
dIn[3] = w4_regd ^ dOut2 ^ dOut9 ^ dOut16;
r1 = dOut6 ^ dOut13 ^ dOut20 ^ dOut27;
r2 = dOut5 ^ dOut12 ^ dOut19 ^ dOut26;
r3 = dOut4 ^ dOut11 ^ dOut18 ^ dOut25;
r4 = dOut3 ^ dOut10 ^ dOut17 ^ dOut24;
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
