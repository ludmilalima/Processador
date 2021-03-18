// multiplexador determina registrador de escrita para o banco de registradores
module mux_reg_escr (instrucao, reg_destino, RegDst);
input [31:0] instrucao; // contém a instrução sendo executada
input [1:0] RegDst; // sinal que determina qual registrador receberá dados
output reg [4:0] reg_destino; // contém a posição do registrador de destino

initial reg_destino = 2'd0;

always @(instrucao or reg_destino or RegDst)
begin
	case (RegDst) // sinal de controle do multiplexador
		2'd0:
			reg_destino = instrucao[20:16]; // determina rt como registrador destino
		2'd1:
			reg_destino = instrucao[15:11]; // determina rd como registrador destino
		2'd2:
			reg_destino = 5'd31; // determina ra como registrador destino
	endcase
end
endmodule