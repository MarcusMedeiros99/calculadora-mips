# calculadora-mips
Calculadora em assembly para mips

Programa para simular uma calculadora com as seguintes operações:
# op        Descricao                                     Retorno

soma: 		Soma de dois inteiros	 			                  # $v0 = $a0 + $a1

subtrai: 	Subtração de dois inteiros			              # $v0 = $a0 - $a1

multiplica:	Multiplicação de dois inteiros			        # $v0 = $a0 * $a1

divide:		Divisão de dois números em ponto flutuante	  # $v0 = $a0 / $a1

potencia:	Potência de dois inteiros			                # $v0 = $a0 ^ $a1

calc_imc:	IMC a partir de massa e altura			          # $v0 = IMC($a0, $a1) = IMC(massa,altura)

raiz_q:		Raiz quadrada de um ponto flutuante		        # $v0 = sqrt($a0)

tabuada:	Impressão da tabuada de 1 inteiro		          # sem retorno

fatorial:	Fatorial de um inteiro				                # $v0 = $a0 !

fibonacci:	Impressão da seq de fibonnacci até n-ésimo termo# sem retorno

quit:		Fim do programa					                        # sem retorno

op_1:	soma

op_2:	subtrai

op_3:	multiplica

op_4: divide

op_5:	potencia

op_6:	calc_imc

op_7:	raiz_q

op_9: tabuada

op_0:	quit
