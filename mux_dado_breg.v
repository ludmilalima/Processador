// multiplexador determina a fonte do dado de escrita para o banco de registradores
module mux_dado_breg (statusRS, entrada0, entrada1, entrada2, entrada3, saida, controle, clk);

input clk;
input [31:0] entrada0; // contém a saída da ULA
input [31:0] entrada1; // contém a saída da memória de dados
input [31:0] entrada2; // contém PC + 1
input [31:0] entrada3; // contém o valor da entrada externa
input statusRS; // contem o status do processo rs
input [2:0] controle; // determina qual a entrada correta em função do opcode
output reg [31:0] saida; // contém o dado a ser armazenado no registrador destino

initial saida = 32'd0;

always @(*)
begin
	case(controle)
		3'd0: saida = entrada0; // registrador de escrita recebe o resultado da ULA
		3'd1: saida = entrada1; // registrador de escrita recebe dado da memória de dados
		3'd2: saida = entrada2; // registrador de escrita recebe PC + 1
		3'd3: saida = entrada3; // registrador de escrita recebe entrada externa
		3'd4: saida = statusRS; // registrador de escrita recebe status do processo idProc
	endcase
end
endmodule