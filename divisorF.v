//modulo que divide a frequencia de 50MHz do kit FPGA
module divisorF (clk,s);

input clk; //clock do kit FPGA
output reg s; //clock reduzido na saida

reg [31:0] out; //contador de ciclos de clock

initial 
begin
s = 0; //inicia sinal de saida em nivel baixo
out = 32'd0; //inicia o contador com contagem 0
end
	
always @(posedge clk)
begin
	if (out >= 32'd1) //se contagem excedeu o limte
		begin
			out = 32'd0; //reinicia contagem
			if(s) //inverte sinal do clock
			begin
				s = 0; 
			end
			else
			begin
				s = 1;
			end
		end
	else //senao acrescenta 1 na contagem
		begin
			out = out+1;
		end
end

endmodule