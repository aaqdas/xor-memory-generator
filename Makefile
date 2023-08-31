MODEL_SIM = /mnt/c/intelFPGA/20.1/modelsim_ase/win32aloem
READ_PORTS  = 2
WRITE_PORTS = 2
WORD_SIZE  = 32
SIZE 	   = 4096
OUTPUT	   = xor_$(READ_PORTS)r_$(WRITE_PORTS)w

.PHONY: all
all: xor test

xor:
	python3 ./src/make_bram.py 		\
		-r $(READ_PORTS)		   	\
		-w $(WRITE_PORTS)			\
		-d $(WORD_SIZE)				\
		-s $(SIZE) 					\
		-o $(OUTPUT)
	python3 ./src/make_testbench.py \
		-r $(READ_PORTS)		   	\
		-w $(WRITE_PORTS)			\
		-d $(WORD_SIZE)				\
		-s $(SIZE) 					\
		-o $(OUTPUT)

.PHONY: test
test: clean sim

	
clean: 
	if [ -d "./sim/" ]; then \
		rm -r ./sim/;		\
	fi
#	else 
#		mkdir ./sim/ 
#	fi

sim:
	echo $(OUTPUT)
	mkdir ./sim/
	$(MODEL_SIM)/vlib.exe ./sim/work/
	$(MODEL_SIM)/vmap.exe work ./sim/work/
	$(MODEL_SIM)/vlog.exe -work work ./generate/$(OUTPUT).v
	$(MODEL_SIM)/vlog.exe -work work ./generate/tb/$(OUTPUT)_tb.v
	$(MODEL_SIM)/vsim.exe -do wave.do $(OUTPUT)_tb
	