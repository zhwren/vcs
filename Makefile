target := simv

.PHONY : all clean

all : $(target)

UVM_SRCS := $(UVM_HOME)/src/dpi/uvm_dpi.cc $(UVM_HOME)/src/uvm_pkg.sv
SOURCES  := test.sv src/*.sv
INCDIRS  := +incdir+$(UVM_HOME)/src +incdir+. +incdir+src
$(target) : $(SOURCES)
	vcs -full64 -sverilog  -CFLAGS -DVCS $(UVM_SRCS) $(INCDIRS) -timescale=1ns/1ps $<
