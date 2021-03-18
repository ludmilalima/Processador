// modulo que armazena info dos processos em execucao
module processo(dadoRS, dadoRD, idProc, RB, ultimo_pc, endRetRS, swap_SO, swap_P, statusRS, instr, setRB, status, clk);

input clk; //clock do processador
input [31:0] ultimo_pc;//ultimo pc do processo atual								-> contador
input [31:0] instr; // instrucao atual 												-> mem. instr
input status;//status do ultimo processso executado -> UC						-> UC
input swap_SO;//sinaliza volta para o SO												-> contador
input swap_P;//sinaliza retomada de processo											-> UC
input setRB;//sinal que determina valor atual de RB								-> UC
input [31:0] dadoRS, dadoRD;

output reg [4:0] idProc;//rs da instrucao													-> contador
output reg [31:0] RB;//valor do registrador base										-> mem inst e mem dados
output statusRS;//valor do status do processo rs								-> MUX dado breg
output [31:0] endRetRS;//															-> MUX dado breg


reg [3:0] statusProc;//estado dos processos em execucao						-> MUX dado breg
reg [31:0] endRet [3:0];//ultima instrucao executada em cada processo		-> MUX dado breg

initial
begin
	RB = 32'd0; //setar registrador base em 0
	statusProc = 4'b1111; //status de todos os processos como ativos
	endRet[0] = 32'd96; //endereco inicial de retorno do processo 0
	endRet[1] = 32'd0; //endereco inicial de retorno do processo 1
	endRet[2] = 32'd0; //endereco inicial de retorno do processo 2
	endRet[3] = 32'd0; //endereco inicial de retorno do processo 3
	idProc = 5'd0;
end

always@(negedge clk) //na borda de descida do clock
begin
	if(swap_SO == 1) //na troca de contexto armazenar o ultimo endereco
		endRet[idProc] = ultimo_pc;
end

always@(negedge clk) //na borda de descida do clock
begin
	if(status == 0) //na finalizacao do processo atualizar o status
	begin
		statusProc[idProc] = status;
	end
end

always@(negedge clk) //na borda de descida do clock
begin
	if(swap_P==1) //na troca para um processo setar qual o processo
	begin
		idProc = dadoRS;
	end
	else if(swap_SO==1) //na troca para o SO setar processo 0
	begin
		idProc = 5'd0;
	end
end

always@(negedge clk) //na borda de descida do clock
begin
	if (swap_SO == 1) //na troca para o SO 
	begin
		RB = 32'd0; //registrador base 0
	end
	else if(status == 0) //na finalizacao de processo
	begin
		RB = 32'd0; //registrador base 0
	end
	else if(setRB == 1) //na chamada de processo
	begin
		RB = dadoRD; //registrador base correspondente
	end
end

assign statusRS = statusProc[dadoRS]; //status do processo em rs
assign endRetRS = endRet[dadoRS]; //endereco de retorno do processo em rs

endmodule