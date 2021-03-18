// Quartus Prime Verilog Template
// Single Port ROM

module mem_instr
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.

	initial
	begin //memoria particionada em 4 partes iguais
		$readmemb("SObin.txt", rom, 0, 255);
		$readmemb("SOa.txt", rom, 256, 511);
		$readmemb("SOb.txt", rom, 512, 766);
		$readmemb("SOc.txt", rom, 768, 1023);
	end

	always @(*)
	begin	
		q <= rom[addr];
	end
		
endmodule