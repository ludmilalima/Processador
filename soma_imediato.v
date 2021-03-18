//modulo de somar imediato do processador
module soma_imediato (entrada, imediato, saida);
input [31:0] entrada; // contém o valor de PC + 1
input [31:0] imediato; // contém o valor do imediato
output reg [31:0] saida; // contém a soma de PC + 1 + imediato

initial saida = 32'd0;

always @(*)
begin
	saida = 32'd0 + imediato; // soma PC + 1 + imediato e armazena na saida
end
endmodule