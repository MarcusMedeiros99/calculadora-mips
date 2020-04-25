# calculadora-mips
Calculadora em assembly para mips

Programa para simular uma calculadora com as seguintes operações:

|OP    |Código |    Descricao                  |                   Retorno|
|------|-| -------------------------------|--------------------------|
|soma: |1 |	Soma de dois inteiros	 			 |                 $v0 = $a0 + $a1|
|      |                               |                          |
|subtrai: |2|	Subtração de dois inteiros			    |           $v0 = $a0 - $a1|
|      |   |                            |                          |
|multiplica: |3|	Multiplicação de dois inteiros			 |        $v0 = $a0 * $a1|
|      |    |                           |                          |
|divide:	|4|	Divisão de dois números em ponto flutuante	|   $v0 = $a0 / $a1|
|      |     |                          |                          |
|potencia:|5|	Potência de dois inteiros			            |     $v0 = $a0 ^ $a1|
|      |      |                         |                          |
|calc_imc:	|6|IMC a partir de massa e altura			   |        $v0 = IMC($a0, $a1) = IMC(massa,altura)|
|      |       |                        |                          |
|raiz_q:	|7|	Raiz quadrada de um ponto flutuante		  |       $v0 = sqrt($a0)|
|      |        |                       |                          |
|tabuada: |8|	Impressão da tabuada de 1 inteiro		  |         sem retorno|
|      |         |                      |                          |
|fatorial:	|9|Fatorial de um inteiro				           |      $v0 = $a0 !|
|      |          |                     |                          |
|fibonacci: |10|	Impressão da seq de fibonnacci até n-ésimo termo | sem retorno|
|      |           |                    |                          |
|quit:	|0|	Fim do programa					                        | sem retorno|
|      |                               |                          |
