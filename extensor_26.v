// extensor de 26 para 32 bits
module extensor_26 (entrada, saida);
input [25:0] entrada; // contém o valor que representa a posição na memória da próxima instrução a ser executada com 26 bits
output reg [31:0] saida; // contém o vaor de entrada extendido para 32 bits

initial saida = 32'd0;

always @(*)
begin
	saida = {6'b000000,entrada}; // concatena 6 bits com 0's à esquerda da entrada
end
endmodule