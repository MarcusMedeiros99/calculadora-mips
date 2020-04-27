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
	
continue: .asciiz "\nPressione <ENTER> para continuar\n"
	
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

newline:	.asciiz "\n"

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
	
	beq $t9, $zero, quit
	
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
	beq $t9, $t8, ler_float #no calculo do imc, lemos a altura em ponto flutuante
	
	addi $v0, $zero, 5 
	syscall

ler_float:
	addi $v0, $zero, 6
	syscall
	
exec_op:#preparação para chamada das funções do menu
	#argumentos dos procedimentos
	add $a1, $v0, $zero
	add $a0, $t0, $zero
	
	addi $t8, $zero, 1
	beq  $t8, $t9, exec_soma # se operação for 1, soma
 	
 	addi $t8, $zero, 6
 	beq $t8, $t9, exec_calc_imc
	
	addi $t8, $zero, 7
	beq  $t8, $t9, exec_raiz # se operação for 7, raiz
	
	addi $t8, $zero, 9
	beq $t8, $t9, exec_fatorial
	
	addi $t8, $zero, 8
	beq  $t8, $t9, exec_tabuada # se operação for 8, tabuada
	
exec_soma:
	jal soma
	
	j print_result

soma:
	add $v0, $a0, $a1
	
	jr $ra
exec_fatorial:
	jal fatorial

	j print_result

fatorial:
	add $t0, $zero, $a0 	
	
	addi $v0, $zero, 1
fat_loop:
	beq $t0, $zero, end_fat
	
	mult $v0, $t0
	mflo $v0
	
	addi $t0, $t0, -1
	
	j fat_loop
end_fat:
	jr $ra
	
exec_calc_imc:
	jal calc_imc
	
	j print_float
calc_imc:
	mtc1 $a0, $f1
	cvt.s.w $f1,$f1
	
	mul.s $f0, $f0, $f0
	div.s $f0, $f1, $f0
	
	jr $ra

#------------------------------------------------------------------------------------------
# RAIZ
# v0 = raiz(a0)
#
# Retorna a raiz quadrada do inteiro positivo em $a0
#
# Argumento:
#	$a0 - Inteiro positivo para tirar a raiz quadrada.
#
# Resultado:
#	$v0 - O piso da raiz quadrada calculada, como um inteiro.
#
# Registradores locais:
#	$v0: Número x sendo testado para ver se é a raiz quadrada de n.
#	$t0: Raiz de x.
#------------------------------------------------------------------------------------------
exec_raiz:
	jal raiz
	j print_result

raiz:	
	li	$v0, 0			# x = 0

raiz_loop:	
	mul	$t0, $v0, $v0		# t0 = x*x
	bgt	$t0, $a0, raiz_end	# if (x*x > n) vai para raiz_end
	addi	$v0, $v0, 1		# x = x + 1
	j	raiz_loop		# vai para raiz_loop
	
raiz_end:
	addi	$v0, $v0, -1		# x = x - 1
	jr	$ra

#------------------------------------------------------------------------------------------
# TABUADA
#
# Printa a tabuada do inteiro $a0
#
# Argumento:
#	$a0 - Inteiro positivo.
#
# Resultado:
#	Nenhum.
#
# Registradores locais:
#	$t0: Número (x) para imprimir a tabuada.
#	$t1: Contador (i) até 10.
#	$t2: Auxiliar com o valor de 10.
#	
#	$a0: n = i * x.
#------------------------------------------------------------------------------------------
exec_tabuada:
	jal tabuada
	j print_continue

tabuada:
	move	$t0, $a0	# salva x em t0
	li	$t1, 1		# i = 1
	li 	$t2, 10		# maxValue = 10
	
	# imprime uma nova linha
	la	$a0, newline
	li	$v0, 4
	syscall

tabuada_loop:
	
	bgt	$t1, $t2, tabuada_end	# se contador for maior que 10, vai para end
	
	mul	$a0, $t0, $t1	# n = i * x
	addi	$t1, $t1, 1 	# i = i + 1
	
	li	$v0, 1		# imprime n
	syscall
	
	# imprime uma nova linha
	la	$a0, newline
	li	$v0, 4
	syscall
	
	j	tabuada_loop	# vai para tabuada_loop
	
tabuada_end:
	jr	$ra


exec_subtr:
	#TODO
subtr:
	#TODO
	
#TODO - outras opções

print_float:
	add.s $f12, $f30, $f0
	addi $v0, $zero, 2
	syscall
	
	j print_continue

print_result:
	#impressão do resultado de uma função
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall

print_continue:
	la $a0, continue
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 12
	syscall
	
	j main
invalid_op:
	#tratamento de opções inválidas
	la $a0, error
	addi $v0, $zero, 4
	
	j main

	

quit:
	#fim do programa
	addi $v0, $zero, 10
	syscall
