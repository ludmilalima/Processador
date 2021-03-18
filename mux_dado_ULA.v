// multiplexador determina o segundo operando da ULA
module mux_dado_ULA (dado, imediato, origALU, saida);
input [31:0] dado; // contém o valor do registrador rt em instruções tipo R
input [31:0] imediato; // contém o valor do imediato em instruções tipo I
input origALU; //sinal que determina qual será o valor entregue à ULA
output reg [31:0] saida; // contém o valor a ser entregue à ULA

initial saida = 32'd0;

always @(*)
begin
	if(!origALU) 
	begin
		saida = dado; // determina que a ULA receba o valor do registrador rt
	end
	if(origALU)
	begin
		saida = imediato; // determina que a ULA receba o valor do imediato
	end
end
endmodule