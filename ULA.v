//unidade logica e aritmetica do processador
module ULA (dado1, dado2, zero, saida, OpALU, shamt);

input [31:0] dado1; // contem o valor do primeiro operando
input [31:0] dado2; // contem o valor do segundo operando
input [4:0] shamt; // contem o numero de bits a serem deslocados em operacoes do tipo shift
input [5:0] OpALU; // contem o sinal que determina a operacao a ser realizada com origem na Unidade de Controle

output reg zero; // flag de controle para desvios e operacoes logicas
output reg [31:0] saida; // contem o valor resultante da operacao

reg resto;
reg diferenca;

initial
begin
	zero = 0; //inicia a flag zero com nivel baixo
	saida = 32'd0; //inicia a saida com valor nulo
end

always @(*)
begin
	case(OpALU) // monitora o sinal de controle da ULA
		6'd2: // verifica se o sinal de controle vale 2
		begin
			saida = $signed(dado1)+$signed(dado2); //soma // atribui valor dado1+dado2 a saida
			zero = 0; // atribui valor nulo a flag zero
		end
		6'd3:
		begin
			saida = $signed(dado1)-$signed(dado2); //subtração
			zero = 0;
		end
		6'd4:
		begin
			saida = $signed(dado1)*$signed(dado2); //multiplica com valores signed
			zero = 0;
		end
		6'd5:
		begin
			if(dado2==32'd0) //trata divisão por 0
			begin
				saida = 32'd0;
			end
			else
			begin
				saida = (dado1)/(dado2); //divisao
			end
			zero = 0;
		end
		6'd6: //menor
		begin
			if(dado1 < dado2)
				begin
					saida = 32'd1;
					zero = 1;
				end
			else if( dado1 >= dado2)
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd7: //maior que
		begin
			if(dado1 > dado2)
				begin
					saida = 32'd1;
					zero = 1;
				end
			else if(dado1 <= dado2)
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd8: //igual a
		begin
			if($signed(dado1)==$signed(dado2))
				begin
					saida = 32'd1;
					zero = 1;
				end
			else
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd10://and
		begin
			if(dado1==dado2 && dado1!=32'd0)
				begin
					saida=32'd1;
					zero=1;
				end
				else
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd11://or
		begin
			if(dado1!=32'd0 || dado2!=32'd0)
				begin
					saida=32'd1;
					zero=1;
				end
				else
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd12://resto
		begin
			saida = ($signed(dado1) % dado2); //resto
			zero = 0;
		end
		6'd13://xor
		begin
			if((dado1!=32'd0 && dado2==32'd0) || (dado2!=32'd0 && dado1==32'd0))
				begin
					saida=32'd1;
					zero=1;
				end
				else
				begin
					saida=32'd0;
					zero=0;
				end
		end
		6'd14:
		begin
			saida = ~dado1; //negação
			zero = 0;
		end
		6'd15:
		begin
			saida = dado1; //move
			zero = 0;
		end
		6'd16:
		begin
			saida = (dado1 <<< shamt); //desloca a esquerda
			zero = 0;
		end
		6'd17:
		begin
			saida = (dado1 >>> shamt); //desloca a direita
			zero = 0;
		end
		6'd21:
		begin
			saida = $signed(dado1)+$signed(dado2); //load
			zero = 0;
		end
		6'd22:
		begin
			saida = $signed(dado1)+$signed(dado2); //store
			zero = 0;
		end
		6'd23:
		begin
			saida = ($signed(dado1)+$signed(dado2)); //addi
			zero = 0;
		end
		6'd24:
		begin
			saida = ($signed(dado1)-$signed(dado2)); //subi
			zero = 0;
		end
		6'd25: //desvia se igual
		begin
			if(dado1 == dado2)
				begin
					zero = 1;
				end
			else
				begin
					zero = 0;
				end
		end
		6'd26: //desvia se diferente
		begin
			if(dado1 != dado2)
				begin
					zero = 1;
				end
			else
				begin
					zero = 0;
				end
		end
		6'd27:
		begin 
			saida = dado2; //carregar imediato
			zero = 0;
		end
		6'd28:
		begin
			saida = (dado2 <<< 16); //carregar superior imediato
			zero = 0;
		end
		6'd29: //sao diferentes
		begin
			if($signed(dado1)!=$signed(dado2))
				begin
					zero = 1;
				end
			else
				begin
					zero=0;
				end
		end
		default:
		begin
			saida = 32'd0;
			zero = 0;
		end
	endcase
end
	
endmodule