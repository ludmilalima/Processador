// extensor de 16 para 32 bits
module extensor_16 (entrada, saida);
input [15:0] entrada; // contém o valor do imediato
output reg [31:0] saida; // contém o imediato extendido

initial saida = 32'd0;

always @(*)
begin
	saida = {16'b0000000000000000,entrada}; // concatena 16 bits contendo 0 à esquerda da entrada
end
endmodule