// modulo de incrementar posicao da proxima instrucao
module incrementa_PC (entrada, saida, pausaPC);

input [31:0] entrada; // contem o endereço atual do PC
input pausaPC; // determina se o processador deve aguardar o recebimento da entrada externa
output reg [31:0] saida; // contem o endereço  de PC + 1

initial saida = 32'd0;

always @(*)
begin
	if(pausaPC == 1) // não está recebendo entrada ou saida
	begin
		saida = entrada + 1; // acrescenta 1 em PC
	end
	else
	begin
		saida = entrada; //mantem a saida atual
	end
end
endmodule