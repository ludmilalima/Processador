//modulo contador de ciclos de clock para preempcao do processo
module contador (clk, pc_out, ultimo_pc, swap_SO, idProc, contagem, pausa_PC);

input clk; //para contar quantas instruçoes foram executadas				-> processador
input [31:0] pc_out; //recebe instruçao atual em execuçao					-> mem instr
output reg [31:0] ultimo_pc; //armazena a ultima instruçao executada			-> processo
output reg [6:0] contagem; //armazenar a quantidade de instruçoes executadas		-> local
output reg swap_SO; //sinal de controle de troca de contexto						-> mux prox instr / processo
input [4:0] idProc;
input pausa_PC;

initial
begin
	contagem = 7'd0; //inicia contagem com 0 ciclos
	ultimo_pc = 32'd0; //inicia ultima posicao como 0
end

always@(negedge clk)//na borda de descida do sinal de clock
begin
	if(pausa_PC == 1) //somar somente se o pc nao estiver pausado
	begin
		if(contagem < 7'd14) //nao trocar contexto
	begin
		if(idProc != 5'd0) //nao esta no SO
		begin
			contagem = contagem + 7'd1;
		end
		swap_SO = 1'd0;
		
	end
	else if(contagem >= 7'd14) //trocar contexto
	begin
		if(idProc != 5'd0) //nao esta no SO
		begin
			ultimo_pc = pc_out + 32'd1;
			if(pausa_PC == 1) //pc nao esta pausado
			begin
				contagem = 7'd0;
				swap_SO = 1'd1;
			end
		end
	end
	end
end
endmodule
