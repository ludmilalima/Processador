# Processador
\
\
O arquivo ProcessadorFinal.qar apresenta o projeto completo.\
O arquivo ProcessadorMIPSmonociclo.pdf apresenta informações adicionais sobre o projeto, com exceção de informações sobre os módulos de contagem de ciclos e processos que foram implementados posteriormente.
\
\
O arquivo SObin.txt contém o código de máquina de um módulo de gerenciamento de processos com preempção e deve ser carregado na primeira posição da memória de instruções através do arquivo mem_instr.v.\
Atualmente a memória possui 1024 posições e está dividida em 4 partes, podendo ser ampliada através da modificação do arquivo mem_intr.v e do código de máquina SObin.txt.\
Os arquivos SOa.txt,SOb.txt, SOc.txt são códigos de teste para a verificação do módulo de preempção do SO.
\
\
Como executar o processador:\
1ª possibilidade\
Carregar o arquivo .sof gerado após a compilação do projeto em um kit AlteraDE2-115 com FPGA\
2ª possibilidade \
Executar uma simulação de formas de onda utilizando o software Quartus.
