//banco de registradores do processador
module banco_reg (EscreveReg, clk, reg_leit1, reg_leit2, reg_esc, dado_esc, dado_leit1, dado_leit2,
rv);


input EscreveReg; // contem o sinal que determina se havera gravacao no registrador destino
input clk; // contem o clock do kit
input [4:0] reg_leit1; // contem o endereco do registrador fonte rs
input [4:0] reg_leit2; // contem o endereco do registrador fonte rt
input [4:0] reg_esc; // contem o endereco do registrador destino rd
input [31:0] dado_esc; // contem o dado a ser gravado no registrador destino
output [31:0] dado_leit1; // contem o valor armazenado no registrador rs
output [31:0] dado_leit2; // contem o valor armazenado no registrador rt

reg [31:0] banco [31:0]; //cria uma matriz 32x32 que forma o banco de registradores

reg [4:0] reg_esc_anterior; // armazena o endereco do registrador destino na instrucao anterior
reg EscreveReg_anterior; // armazena o estado do sinal de gravacao na instrucao anterior

initial
begin
EscreveReg_anterior = 0; // inicial o sinal de escrita como 0;
reg_esc_anterior = -1;
banco[0]=32'd0;
end

always @(negedge clk)
begin
	if(EscreveReg_anterior) // verifica se a instrucao anterior inclui uma gravacao no registrador destino
	begin
		banco[reg_esc_anterior] = dado_esc; // grava dados no registrador destino
	end
end

always @(posedge clk)
begin
	reg_esc_anterior = reg_esc; // armazena o endereco de escrita da instrucao anterior
	EscreveReg_anterior = EscreveReg; // armazena o sinal de escrita da instrucao anterior
end

assign dado_leit1 = banco[reg_leit1]; // atualiza o dado de leitura 1 do banco
assign dado_leit2 = banco[reg_leit2]; // atualiza o dado de leitura 2 do banco


output [31:0] rv;
assign rv = banco[27];


endmodule