module UC (instr, zero, controle_out, RegDst, EscreveReg, 
OrigALU, OpALU, EscreveMem, controle_dbr, controle_in, 
controle_pi, pausaPC, CH0, clk, status, swap_P, setRB, swap_SO);

input [31:0] instr;
input zero;
input CH0;
input clk;
output reg controle_out;
output reg [1:0]RegDst;
output reg EscreveReg;
output reg OrigALU;
output reg [5:0] OpALU;
output reg EscreveMem;
output reg [2:0] controle_dbr;
output reg controle_in;
output reg [2:0] controle_pi;
output reg pausaPC;
output reg status;
output reg swap_P;
output reg setRB;
input swap_SO;

reg ch0subiu;
reg ch0desceu;
wire controle;

initial
begin
	status = 1'd1;
	swap_P = 1'd0;
	setRB = 1'd0;
	controle_out = 1'd0;
	RegDst = 2'd0;
	EscreveReg = 1'd0;
	OrigALU = 1'd0;
	OpALU = 6'd0;
	EscreveMem = 1'd0;
	controle_dbr = 3'd0;
	controle_in = 1'd0;
	controle_pi = 3'd0;
	pausaPC = 1'd1;
	ch0subiu = 1'd0;
	ch0desceu = 1'd0;
end

assign controle = (controle_in || controle_out);

always@(posedge clk)
begin

	if(swap_SO == 0)
	begin
		if(controle == 1)
		begin
			
			if(ch0desceu == 0)
			begin
				
				if(ch0subiu == 0)
				begin
				
					if(CH0 == 0)
					begin
						pausaPC = 0;
					end
					else
					begin
						ch0subiu = 1;
					end
					
				end
				else
				begin
					if(CH0 == 0)
					begin
						ch0desceu = 1;
					end
				end
				
			end
			else
			begin
			
				if(ch0subiu == 1)
				begin
					
					if(CH0 == 0)
					begin
						pausaPC = 1;
						ch0subiu = 0;
						ch0desceu = 0;
					end
					
				end
			
			end
			
		end

	end
	
end

always@(instr)
begin

	if(instr[31:26]==6'd0 && instr[5:0]==6'd0)
		controle_in=1;
	else
		controle_in=0;
end

always@(instr)
begin
	if(instr[31:26]==6'd0 && instr[5:0]==6'd1)
		controle_out=1;
	else
		controle_out=0;
end

always @(instr or zero)
begin
	case(instr[31:26])
		6'd0:
		begin
			case(instr[5:0]) 
				6'd0:
				begin
					
					RegDst = 0;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 0;
					EscreveMem = 0;
					controle_dbr = 3;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd1:
				begin
				
					RegDst = 0;
					EscreveReg = 0;
					OrigALU = 0;
					OpALU = 1;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd2:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 2;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd3:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 3;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd4:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 4;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd5:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 5;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd6:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 6;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd7:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 7;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd8:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 8;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd9:
				begin
					
					RegDst = 1;
					EscreveReg = 0;
					OrigALU = 0;
					OpALU = 9;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 3;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd10:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 10;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd11:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 11;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd12:
				begin
					
					RegDst = 1;
					EscreveReg = 1; 
					OrigALU = 0;
					OpALU = 12;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd13:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 13;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd14:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 14;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd15:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 15;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd16:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 16;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd17:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 17;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				6'd18:
				begin
					
					RegDst = 1;
					EscreveReg = 1;
					OrigALU = 0;
					OpALU = 29;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
				default:
				begin
					
					RegDst = 0;
					EscreveReg = 0;
					OrigALU = 0;
					OpALU = 0;
					EscreveMem = 0;
					controle_dbr = 0;
					controle_pi = 0;
					status = 1;
					swap_P = 0; 
					setRB = 0;
				end
			endcase
		end
		6'b000001: //1 nop
		begin
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 18;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000010: //2
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 19;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 2;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000011: //3
		begin
			
			RegDst = 2;
			EscreveReg = 1;
			OrigALU = 0;
			OpALU = 20;
			EscreveMem = 0;
			controle_dbr = 2;
			controle_pi = 1;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000100: //4
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 1;
			OpALU = 21;
			EscreveMem = 0;
			controle_dbr = 1;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000101: //5
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 1;
			OpALU = 22;
			EscreveMem = 1;
			controle_dbr = 1;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000110: //6
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 1;
			OpALU = 23;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b000111: //7
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 1;
			OpALU = 24;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b001000: //8
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 25;
			EscreveMem = 0;
			controle_dbr = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
			if(zero == 1)
				begin
					controle_pi = 1;
				end
			else if (zero == 0)
				begin
					controle_pi = 0;
				end
		end
		6'b001001: //9
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 26;
			EscreveMem = 0;
			controle_dbr = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
			if(zero == 1)
				begin
					controle_pi = 1;
				end
			else if (zero == 0)
				begin
					controle_pi = 0;
				end
		end
		6'b001010: //10
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 1;
			OpALU = 27;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'b001011: //11
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 1;
			OpALU = 28;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		6'd12: //12 finaliza processo statusProc[rs]=0
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 29;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 0;
			swap_P = 0; 
			setRB = 0;
		end
		6'd13: //13 retoma processo PC <= endRet[rs]
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 30;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 4;
			status = 1;
			swap_P = 1; 
			setRB = 1;
		end
		6'd14: //14 retorna status processo R[rt] = statusRS
		begin
			
			RegDst = 0;
			EscreveReg = 1;
			OrigALU = 0;
			OpALU = 31;
			EscreveMem = 0;
			controle_dbr = 4;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
		
		default:
		begin
			
			RegDst = 0;
			EscreveReg = 0;
			OrigALU = 0;
			OpALU = 0;
			EscreveMem = 0;
			controle_dbr = 0;
			controle_pi = 0;
			status = 1;
			swap_P = 0; 
			setRB = 0;
		end
	endcase

end
endmodule