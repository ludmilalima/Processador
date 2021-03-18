//modulo que interconeta todos os demais modulos para constituir o processador em si
module processador (RESET, CLOCK, CHAVES, CH0, D0, D4, D5, D6, NEG, in_s, in_i, controle_out, clk_out,
 swap_SO, ultimo_PC, endRetRS, statusRS, idProc, RegBase, instr,pausa_PC, contagem,
 status, swap_P, setBR, dado_rs, dado_rt, n_instr, rv, dado_mem);

 
input CLOCK, RESET; //sinal de clock base do sistema e botao que reinicia o programa
input [15:0] CHAVES; //chavez utilizadas para entrada de dados
input CH0; //chave utilizada na leitura e impressao de dados
output [6:0] D0, D4, D5, D6; //displays de 7 segmentos utilizados na impressao de daods
output NEG; //sinal que indica valor negativo
output in_s, in_i; //sinais que indicam entrada de dados -> bits superiores e inferiores

wire [31:0]pc_out;
wire [31:0] pc_in;
PC IM_0(.entrada(pc_in), .saida(pc_out), .clk(clk_out), .reset(~RESET)); //debounce reset

output wire [9:0]n_instr = pc_out[9:0] + RegBase[9:0];
output wire [31:0] instr;
mem_instr IM_1(.addr(pc_out[9:0] + RegBase[9:0]),.clk(~clk_out),.q(instr)); 


wire [4:0]rd;
wire [1:0]RegDst;
mux_reg_escr IM_2(.instrucao(instr),.reg_destino(rd),.RegDst(RegDst));

output wire pausa_PC;
wire [31:0] pc_incr;
incrementa_PC IM_3(.entrada(pc_out),.saida(pc_incr),.pausaPC(pausa_PC));

wire [31:0] ext_26;
extensor_26 IM_4(.entrada(instr[25:0]),.saida(ext_26));

wire [31:0] ext_16;
extensor_16 IM_5(.entrada(instr[15:0]),.saida(ext_16));

wire [31:0] desvio;
soma_imediato IM_6(.entrada(pc_incr),.imediato(ext_16),.saida(desvio));

wire [2:0] controle_pi;
mux_prox_instr IM_7(.clk(clk_out), .endRetRS(endRetRS),.swap_SO(swap_SO),.status(status),.entrada0(pc_incr),.entrada1(desvio),.entrada2(ext_26),
.entrada3(dado_rs),.saida(pc_in),.controle(controle_pi));

wire [31:0] dado2_ULA;
wire OrigALU;
mux_dado_ULA IM_8(.dado(dado_rt),.imediato(ext_16),.origALU(OrigALU),.saida(dado2_ULA));

wire [31:0] result_ula;
wire zero;
wire [5:0] OpALU;
ULA IM_9(.dado1(dado_rs),.dado2(dado2_ULA),.zero(zero),.saida(result_ula),.OpALU(OpALU),.shamt(instr[10:6]));

wire EscreveMem;
output wire [31:0] dado_mem;
mem_dados IM_10(.data(dado_rt),.read_addr(result_ula + RegBase),.write_addr(result_ula + RegBase),
.we(EscreveMem),.clk(clk_out),.q(dado_mem));

wire [31:0] dado_in;
wire controle_in;
entrada IM_11(.ch0(CH0),.chaves(CHAVES),.controle(controle_in),.dado(dado_in),
.sup(in_s),.inf(in_i)); // debounce CH0

wire [31:0] dado_breg;
wire [2:0] controle_dbr;
mux_dado_breg IM_12(.statusRS(statusRS),.clk(clk_out),.entrada0(result_ula),.entrada1(dado_mem),
.entrada2(pc_incr),.entrada3(dado_in),.saida(dado_breg),.controle(controle_dbr));

wire EscreveReg;
output wire [31:0] dado_rs;
output wire [31:0] dado_rt;
output wire [31:0] rv;
banco_reg IM_13(.EscreveReg(EscreveReg),.clk(clk_out),
.reg_leit1(instr[25:21]),.reg_leit2(instr[20:16]),.reg_esc(rd),
.dado_esc(dado_breg),.dado_leit1(dado_rs),.dado_leit2(dado_rt),
.rv(rv));

wire [31:0]entr;
output wire controle_out;
saida IM_14(.clk(clk_out),.dado(dado_rs),.controle(controle_out),
.d0(D0),.d1(),.d2(),.d3(),.d4(),.d5(),.d6(),.d7(),.neg(NEG)); // debounce CH0


output wire status;
output wire swap_P;
output wire setBR;
UC IM_15(.swap_SO(swap_SO),.status(status), .swap_P(swap_P), .setRB(setBR),.clk(clk_out),.CH0(CH0), 
.pausaPC(pausa_PC), .instr(instr),.zero(zero),.controle_in(controle_in),
.controle_out(controle_out),.RegDst(RegDst),.EscreveReg(EscreveReg),.OrigALU(OrigALU),
.OpALU(OpALU),.EscreveMem(EscreveMem),.controle_dbr(controle_dbr),.controle_pi(controle_pi));

output wire clk_out;
divisorF IM_16(.clk(CLOCK),.s(clk_out));

wire CH0o;
DeBounce IM_17(.clk(CLOCK),.n_reset(1'd1),.button_in(CH0),.DB_out(CH0o));

wire RESETo;
DeBounce IM_18(.clk(CLOCK),.n_reset(1'd1),.button_in(RESET),.DB_out(RESETo));

seg IM_19(.in(pc_out[15:12]),.out());
seg IM_20(.in(pc_out[11:8]),.out(D6));
seg IM_21(.in(pc_out[7:4]),.out(D5));
seg IM_22(.in(pc_out[3:0]),.out(D4));


//seg IM_19(.in(pc_out[7:4]),.out(D7));
//seg IM_20(.in(pc_out[3:0]),.out(D6));
//seg IM_21(.in(CHAVES[7:4]),.out(D5));
//seg IM_22(.in(CHAVES[3:0]),.out(D4));

output wire [6:0] contagem;
output wire swap_SO;
output wire [31:0]ultimo_PC;
contador IM_23(.pausa_PC(pausa_PC),.contagem(contagem),.idProc(idProc), .clk(clk_out), .pc_out(pc_out), .ultimo_pc(ultimo_PC), .swap_SO(swap_SO));

output wire [31:0]endRetRS;
output wire statusRS;
output wire [4:0]idProc;
output wire [31:0]RegBase;
processo IM_24(.clk(clk_out), .dadoRS(dado_rs), .dadoRD(dado_rt), .idProc(idProc), .RB(RegBase), .ultimo_pc(ultimo_PC), .endRetRS(endRetRS), 
.swap_SO(swap_SO), .swap_P(swap_P), .statusRS(statusRS), .instr(instr), .setRB(setBR), .status(status));

endmodule