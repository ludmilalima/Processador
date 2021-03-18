//modulo do program counter que fornece a posicao da proxima instrucao
module PC (entrada, saida, clk, reset);

input [31:0] entrada; // endereco da instrucao
input clk; // clock do kit FPGA
input reset; // sinal que reinicia a execucao do codigo
output reg [31:0]saida; // endereco da instrucao

initial
begin
 saida = 32'd0;
end

always @(negedge clk)
begin
	if (reset==1) // o sinal de reset esta setado
	begin
		saida = 32'd0; // a saida do PC eh a primeira instrucao do codigo
	end
	else
	begin
		saida = entrada; // a saida do PC corresponde a entrada do PC
	end
end

endmodule