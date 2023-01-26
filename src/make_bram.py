import numpy as np
import two_port_sram


read_ports =  int(input("Enter Number of Read Ports: "))
write_ports = int(input("Enter Number of Write Ports: "))

assert write_ports > 1, f"number greater than 1 expected, got: {write_ports}"
assert read_ports  > 1, f"number greater than 1 expected, got: {read_ports}"


intermediate_order = np.zeros(write_ports-1,dtype=int)
for i in range(0,write_ports-1):
    intermediate_order[i]=int(i+2)
read_order =np.array([],dtype=int)
for i in range(0,int(write_ports)):
    temp_order = intermediate_order
    if i > 0:
        temp_order = temp_order
        temp_order[i-1] = temp_order[i-1]-1
    read_order = np.append(read_order,temp_order,axis=0)
read_order = np.reshape(read_order,(write_ports,write_ports-1))

write_order = np.flip(np.arange(read_ports+1),axis=0)
write_order = np.tile(write_order[0:-1],(write_ports,1))

order = np.concatenate((read_order,write_order),axis=1)
dIn_order = np.concatenate((read_order,write_order*-1),axis=1).flatten()

r_top_ports = str('')
ra_top_ports = str('')
for i in range(0,read_ports):
    r_top_ports = r_top_ports + 'r' + str((i+1)) + ','
    ra_top_ports = ra_top_ports + 'ra' + str((i + 1)) + ','

w_top_ports = str('')
w_regd_top_ports = str('')
wa_top_ports = str('')
wa_regd_top_ports = str('')

for i in range(0,read_ports):
    w_top_ports = w_top_ports + 'w' + str((i+1)) + ','
    w_regd_top_ports = w_regd_top_ports + f'w{str((i+1))}_regd' + ','
    wa_top_ports = wa_top_ports + 'wa' + str((i + 1)) + ','
    wa_regd_top_ports = wa_regd_top_ports + f'wa{str((i+1))}_regd' + ','

# print(w_top_ports.split(sep=','))
with open('xor_memory.v','w') as file:
    # file.write(f"module xor_memory(clk,enW,{ra_top_ports}{r_top_ports}{wa_top_ports}{w_top_ports[0:-1]});")
    file.write(f"module xor_memory(clk,enW,{ra_top_ports}{r_top_ports}{wa_top_ports}{w_top_ports[0:-1]});\n")
    file.write( "parameter ADDR_WIDTH = 10;\n"
                "parameter DATA_WIDTH = 8;\n"
                "input clk;\n"
                f"input [{write_ports-1}:0] enW;                                      // Write Enable\n"
                f"input [(ADDR_WIDTH-1):0] {ra_top_ports[0:-1]};                      // read addresses\n"
                f"input [(ADDR_WIDTH-1):0] {wa_top_ports[0:-1]};                      // read addresses\n"
                f"input [DATA_WIDTH-1:0]    {w_top_ports[0:-1]};                      // data to write\n"
                f"output reg [DATA_WIDTH-1:0] {r_top_ports[0:-1]};                    // data read from memory\n"
                f"reg [ADDR_WIDTH-1:0] {wa_regd_top_ports[0:-1]};                     // registered wa\n"
                f"reg [DATA_WIDTH-1:0]   {w_regd_top_ports[0:-1]};                    // registered wa\n"
                f"reg [{write_ports-1}:0] enW_regd;                                   // registered enW\n"
                f"//reg [(ADDR_WIDTH-1):0] addr[3:0];\n"
                f"reg [DATA_WIDTH:0] dIn[{write_ports-1}:0];                          // Data to Write in Mem Banks\n")

    #dOut from all memory banks (Port Definition)
    num_mem_banks = write_ports*(write_ports-1) + (read_ports)**2
    banks_iter = np.arange(num_mem_banks).tolist()
    dOut_iter = ["dOut" + str(s) for s in banks_iter]

    file.write(f"wire [DATA_WIDTH-1:0] {','.join(dOut_iter)};\n")
    file.write("always@(posedge clk)\n"
               "begin\n")
    #always block before BRAM instantiation
    split_w_top_ports = w_top_ports.split(sep=',')
    split_w_regd_top_ports = w_regd_top_ports.split(sep=',')
    split_wa_top_ports = wa_top_ports.split(sep=',')
    split_wa_regd_top_ports = wa_regd_top_ports.split(sep=',')

    split_r_top_ports = r_top_ports.split(sep=',')
    split_ra_top_ports = ra_top_ports.split(sep=',')

    for i in range(0,len(split_w_top_ports)-1):
        file.write(f"{split_wa_regd_top_ports[i]}<={split_wa_top_ports[i]};\n")
        file.write(f"{split_w_regd_top_ports[i]}<={split_w_top_ports[i]};\n")
    file.write("enW_regd <= enW;\n"
               "end\n")
    for i in range(0,read_ports):
        print(''),
        for j in range(0,read_ports+write_ports-1):
            file.write(f'''simple_dual_port_ram #(.ADDR_WIDTH(ADDR_WIDTH)) stage{i*7+j}(.data(dIn[{i}]),
                .write_addr(wa{i+1}_regd),.read_addr({"wa" if j < write_ports-1 else "ra"}{order.flatten()[i*7+j]}),.we(enW_regd[{i}]),.clk(clk),.q(dOut{i*7+j}));\n''')

    file.write("always @ (*)\n"
                "begin\n")

    for i in range(1, write_ports+1):
        where_dIn = np.where(dIn_order == i)
        where_dIn = ["dOut" + str(s) for s in where_dIn[0]]
        file.write(f"dIn[{i-1}] = w{i}_regd ^ {' ^ '.join(where_dIn)};\n")

    for i in range(1, write_ports+1):
        where_dIn = np.where(dIn_order == -i)
        where_dIn = ["dOut" + str(s) for s in where_dIn[0]]
        file.write(f"r{i} = {' ^ '.join(where_dIn)};\n")

    file.write("end\n"
               "endmodule\n")
    file.write(two_port_sram.simple_dual_port_ram)

