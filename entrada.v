//modulo de leitura da entrada do processador
module entrada (chaves, controle, dado, sup, inf, ch0);

input ch0; // chave que determina a fase em que se encontra a entrada de dados
input [15:0] chaves; // chaves que contém os 16 bits parciais de cada entrada
input controle; // sinal que determina se o processador está aguardando uma entrada de dados
output reg [31:0] dado; // vetor que armazena o dado recebido na entrada
output sup, inf; // leitura dos bits superiores ou inferiores

initial
begin
	dado = 32'd0; //inicia a leitura do valor 0
end

assign sup = (controle && !ch0);
assign inf = (controle && ch0);

always@(posedge ch0) //borda de subida do sinal de ch0 le os bits mais significativos
begin
	dado[31:16]=chaves;
end

always@(negedge ch0) //borda de descidaa do sinal de ch0 le os bits menos significativos
begin
	dado[15:0]=chaves;
end

endmodule
