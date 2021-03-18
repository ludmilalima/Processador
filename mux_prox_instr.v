// multiplexador determina a fonte da proxima instrucao
module mux_prox_instr (clk, endRetRS, entrada0, entrada1, entrada2, entrada3, saida, controle, swap_SO, status);

input clk;
input [31:0] entrada0; // contem o endereco de PC + 1
input [31:0] entrada1; // contem o endereco da instrucao PC + desvio imediato
input [31:0] entrada2; // contem o endereco da instrucao como imediato
input [31:0] entrada3; // contem o endereco da instrucao do registrador
input swap_SO; //identifica quando o SO deve ser retomado
output reg [31:0] saida; // endereco da proxima instrucao entregue ao PC
input [2:0] controle; // armazena os sinais de controle
input [31:0] endRetRS;
input status;

initial saida = 32'd0;

always @(*)
begin
	if(swap_SO == 1 || status == 0)
	begin
		saida = 32'd96;
	end
	else
	begin
		
			case(controle)
				3'd0: saida = entrada0; // PC + 1
				3'd1: saida = entrada1; // Salto com endereco em registrador
				3'd2: saida = entrada2; // Salto com endereco no valor imediato
				3'd3: saida = entrada3; // Desvio com posicao calculada
				3'd4:	saida = endRetRS; // posicao da ultima instrucao do proc
			endcase
		
	end
end
endmodule