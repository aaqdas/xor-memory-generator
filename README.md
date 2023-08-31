# XOR-Memory Generator
XOR-Memory is a high-bandwidth memory, designed by [[1]](https://dl.acm.org/doi/10.1145/2145694.2145730). It can be used in Field Programmable Gate Arrays (FPGAs) to create a multi-ported memory using multiple banks of dual port memory (BRAMs). It increases memory throughput while maintaining coherency between multiple banks, thus data written on one port can be read from another port.

XOR-Memory take two cycles to write and one cycle to read. However, it can be pipelined, so no stalls are required between consequent reads. Forwarding(not implemented yet) allows consequent reads after write to be accessed in a single cycle as well.

This tool prompts the user to enter the number of read and write ports and generates Verilog HDL for XOR-Memory using Two-Port BRAM available in many FPGAs.

# Pre-requisites
To create a verilog module of the XOR-Memory, following must be installed before hand.
1. Python 
2. Numpy (Python Library)

To install the pre-requisites use the following commands
```
sudo apt-get install python3
sudo apt-get install python3-pip
pip install numpy
```

# Running the Verilog Generator and Verification in Linux
To run everything including script generation and ModelSim Simulation, use the following command
```
make all READ_PORTS=<NUMBER_OF_READ_PORTS> WRITE_PORTS=<NUMBER_OF_WRITE_PORTS> WORD_SIZE=<WORD_SIZE_IN_BITS> SIZE=<MEMORY_SIZE>
```

# Running the Verilog Generator in Linux
To run the Verilog Generator, use the following command
```
make xor READ_PORTS=<NUMBER_OF_READ_PORTS> WRITE_PORTS=<NUMBER_OF_WRITE_PORTS> WORD_SIZE=<WORD_SIZE_IN_BITS> SIZE=<MEMORY_SIZE>
```
The verilog file will be generated in ```./generated/``` directory and test bench will be inside```./generated/tb```.

# Running the Verification Simulation in Linux
To run the simulation, enter the ModelSim directory in the ```MODEL_SIM``` field and then use the following command
```
make test READ_PORTS=<NUMBER_OF_READ_PORTS> WRITE_PORTS=<NUMBER_OF_WRITE_PORTS> WORD_SIZE=<WORD_SIZE_IN_BITS> SIZE=<MEMORY_SIZE>
```


# References
1. Charles Eric Laforest, Ming G. Liu, Emma Rae Rapati, and J. Gregory Steffan. 2012. Multi-ported memories for FPGAs via XOR. In Proceedings of the ACM/SIGDA international symposium on Field Programmable Gate Arrays (FPGA '12). Association for Computing Machinery, New York, NY, USA, 209–218. https://doi.org/10.1145/2145694.2145730
