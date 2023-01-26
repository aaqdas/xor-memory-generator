# XOR-Memory Generator
XOR-Memory is a high-bandwidth memory, designed by [[1]](https://dl.acm.org/doi/10.1145/2145694.2145730). It can be used in Field Programmable Gate Arrays (FPGAs) to create a multi-ported memory using multiple banks of dual port memory (BRAMs). It increases memory throughput while maintaining coherency between multiple banks, thus data written on one port can be read from another port.

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

# Running the Script in Linux
To run the script, use the following command
```
python3 $(SRC)/make_bram.py
```
When prompted, enter the read ports and write ports.


# References
1. Charles Eric Laforest, Ming G. Liu, Emma Rae Rapati, and J. Gregory Steffan. 2012. Multi-ported memories for FPGAs via XOR. In Proceedings of the ACM/SIGDA international symposium on Field Programmable Gate Arrays (FPGA '12). Association for Computing Machinery, New York, NY, USA, 209–218. https://doi.org/10.1145/2145694.2145730
