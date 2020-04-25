#Autores:
#	Marcus Vinícius Medeiros Pará
#	Fulano
#	Cicrano

#Programa para simular uma calculadora com as seguintes operações:
#	soma: 		Soma de dois inteiros	 			# $v0 = $a0 + $a1
#	subtrai: 	Subtração de dois inteiros			# $v0 = $a0 - $a1
#	multiplica:	Multiplicação de dois inteiros			# $v0 = $a0 * $a1
#	divide:		Divisão de dois números em ponto flutuante	# $v0 = $a0 / $a1
#	potencia:	Potência de dois inteiros			# $v0 = $a0 ^ $a1
#	calc_imc:	IMC a partir de massa e altura			# $v0 = IMC($a0, $a1) = IMC(massa,altura)
#	raiz_q:		Raiz quadrada de um ponto flutuante		# $v0 = sqrt($a0)
#	tabuada:	Impressão da tabuada de 1 inteiro		# sem retorno
#	fatorial:	Fatorial de um inteiro				# $v0 = $a0 !
#	fibonacci:	Impressão da seq de fibonnacci até n-ésimo termo# sem retorno
#	quit:		Fim do programa					# sem retorno

	.data
	.align 0
	
title:	.asciiz	"\nEscolha a opção\n"
op_1:	.asciiz " 1 - soma\n"
op_2:	.asciiz " 2 - subtrai\n"
op_3:	.asciiz " 3 - multiplica\n"
op_4: 	.asciiz " 4 - divide\n"
op_5:	.asciiz	" 5 - potencia\n"
op_6:	.asciiz " 6 - calc_imc\n"
op_7:	.asciiz " 7 - raiz_q\n"
op_8:	.asciiz " 8 - tabuada\n"
op_9:	.asciiz	" 9 - fatorial\n"
op_10:	.asciiz "10 - fibonacci\n"
op_0:	.asciiz " 0 - quit\n"
	
error:	.asciiz "Opcao invalida\n"

	.text
	.globl main

main:
	#impressão do menu
	addi $v0, $zero, 4#código da syscall (impressão de string)
	
	la $a0, title
	syscall
	
	la $a0, op_1
	syscall
	
	la $a0, op_2
	syscall
	
	la $a0, op_3
	syscall
	
	la $a0, op_4
	syscall
	
	la $a0, op_5
	syscall
	
	la $a0, op_6
	syscall
	
	la $a0, op_7
	syscall
	
	la $a0, op_8
	syscall
	
	la $a0, op_9
	syscall
	
	la $a0, op_0
	syscall
	
ler_op:
	#código p/ ler inteiro
	addi $v0, $zero, 5
	syscall
	
	add $t9, $v0, $zero #armazenar op
	
	bltz $t9, invalid_op #op negativa
	
	addi $t8, $zero, 10
	ble $t8, $t9, invalid_op   #op maior que 9
	
ler_arg:#leitura do primeiro argumento
	#código para ler inteiro
	addi $v0, $zero, 5
	syscall
	add $t0, $v0, $zero #armazenar primeio argumento
	
	#verificação se a opção eh maior que 6
	#opções maiores que 6 só exigem 1 (um) argumento
	addi $t8, $zero, 6
	blt $t8, $t9, exec_op  
	
ler_arg2: #leitura do segundo argumento, se necessário
	addi $v0, $zero, 5 
	syscall
	
exec_op:#preparação para chamada das funções do menu
	#argumentos dos procedimentos
	add $a1, $v0, $zero
	add $a0, $t0, $zero
	
	addi $t8, $zero, 1
	beq  $t8, $t9, exec_soma
	
exec_soma:
	jal soma
	
	j print_result

soma:
	add $v0, $a0, $a1
	
	jr $ra
	
exec_subtr:
	#TODO
subtr:
	#TODO
	
#TODO - outras opções

print_result:
	#impressão do resultado de uma função
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall

invalid_op:
	#tratamento de opções inválidas
	la $a0, error
	addi $v0, $zero, 4
	
	j main

	

quit:
	#fim do programa
	addi $v0, $zero, 10
	syscall