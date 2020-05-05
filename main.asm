#Autores:
#	Marcus Vinícius Medeiros Pará - 11031663
#	Leonardo Chieppe - 9368730
#	André Niero Setti - 10883901

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
	
error:	.asciiz "Opcao invalida!!\n"
error2: .asciiz "Numero invalido!!\n"
error3: .asciiz "Raiz de numero negativo!!\n"
error4: .asciiz "Altura ou massa negativa!!\n"

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
	
	la $a0, op_10
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
	
	addi $t8, $zero, 11
	ble $t8, $t9, invalid_op   #op maior que 10
	
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
	
	j exec_op

ler_float:
	addi $v0, $zero, 6
	syscall
	
exec_op:#preparação para chamada das funções do menu
	#argumentos dos procedimentos
	add $a1, $v0, $zero
	add $a0, $t0, $zero
	
	addi $t8, $zero, 1
	beq  $t8, $t9, exec_soma # se operação for 1, soma
	
	addi $t8, $zero, 2
	beq  $t8, $t9, exec_subtr #se operação for 2, subtração
	
	addi $t8, $zero,3
	beq $t8, $t9, exec_multi #se operação for 3, multiplica
	
	addi $t8, $zero,4
	beq $t8, $t9, exec_divi #se operação for 4, divide
	
	addi $t8, $zero, 5
	beq $t8, $t9, exec_expo #se operação for 5, potencia
 	
 	addi $t8, $zero, 6
 	beq $t8, $t9, exec_calc_imc #se operacao for 6, calc_imc
	
	addi $t8, $zero, 7
	beq  $t8, $t9, exec_raiz # se operação for 7, raiz
	
	addi $t8, $zero, 8
	beq  $t8, $t9, exec_tabuada # se operação for 8, tabuada
	
	addi $t8, $zero, 9
	beq $t8, $t9, exec_fatorial # se operação for 9, fatorial
	
	addi $t8, $zero, 10
	beq, $t8, $t9, exec_fibonacci
	 
	
exec_soma:
	jal soma
	
	j print_result

soma: #soma dois valores
	add $v0, $a0, $a1
	
	jr $ra
	
#------------------------------------------------------------------------------------------
# FATORIAL
# $v0 = $a0!
#
# Retorna o fatorial de um número inteiro
#
# Argumento:
#	$a0 - Inteiro positivo para calcular o fatorial.
#
# Resultado:
#	$v0 - O fatorial de $a0
#
# Registradores locais:
#	$t0: Variável auxiliar que é utilizada para fazer as multiplicações necessárias no fatorial
#	

exec_fatorial:
	blt $a0, $zero, invalid_op2
	
	jal fatorial

	j print_result

fatorial:
	#copiamos o argumento para $t0
	#$t0 vai sendo decrementado a cada iteração
	#quanto $t0 = 0, finalizamos o loop
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
	
#------------------------------------------------------------------------------------------
# CÁLCULO DO FIBONACCI
# fibonacci($a0)
#
# Printa os valores da sequência de fibonacci até o $a0-ésimo termo
#
# Argumento:
#	$a0
#------------------------------------------------------------------------------------------

exec_fibonacci:
	#fibonacci não é calculado para valores negativos
	ble $a0, $zero, invalid_op2
	
	jal fibonacci
	j main

fibonacci:
	#armazenamos $a0 em $t0, e vamos decrementando até chegar a 0
	#fibonacci(1) == 1
	#fibonacci(2) == 1
	#fibonacci(n) == fibonacci(n-1) + fibonacci(n-2) para n > 2
	add $t0, $a0, $zero
	addi $t0, $t0, -1
	
	add $s0, $zero, $ra #guardamos o valor de $ra, para usarmos em fim_fibonacci
	
	addi $t8, $zero, 0
	addi $t9, $zero, 1
	
	#print de fibonacci(1)
	addi $a0, $zero 1
	addi $v0, $zero, 1
	syscall
	
	jal print_newline
	
	
	addi $v0, $zero, 1
	
fibonacci_loop:
	beq $t0, $zero, fim_fibonacci
	
	#print de fibonacci para n > 1
	add $t1, $zero, $t9
	add $t9, $t9, $t8
	add $t8, $zero, $t1
	
	addi $v0, $zero, 1
	add $a0, $zero, $t9
	syscall
	
	jal print_newline
	
	addi $t0, $t0, -1
	
	j fibonacci_loop
	
fim_fibonacci:
	add $ra, $zero, $s0
	
	j print_continue
	
#------------------------------------------------------------------------------------------
# CÁLCULO DO IMC
# f1 = calc_imc($a0, $f1)
#
# Retorna o valor IMC a partir de uma massa $a0 e altura $f1 dados
#
# Argumento:
#	$a0 - Massa em kg
#	$f0 - Altura em metros
# Resultado:
#	$f1 - Resultado do IMC em ponto flutuante simples

#------------------------------------------------------------------------------------------

exec_calc_imc:
	blt $a0,$zero, invalid_op4
	blt $a1,$zero, invalid_op4
	
	jal calc_imc
	
	j print_float
calc_imc:
	mtc1 $a0, $f1
	cvt.s.w $f1,$f1
	
	mul.s $f0, $f0, $f0
	div.s $f1, $f1, $f0
	
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
	blt $a0,$zero, invalid_op3

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
	jal subtr

	j print_result

subtr: #subtrai 2 valores
	sub $v0, $a0, $a1

	jr $ra
	
exec_multi:
	addi $t8, $zero, 32768
	ble $t8, $a0, invalid_op2   #a0 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a0, invalid_op2   #a0 menor que 16bits-
	addi $t8, $zero, 32768
	ble $t8, $a1, invalid_op2   #a1 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a1, invalid_op2   #a1 menor que 16bits-

	jal multi

	j print_result

multi: #multiplica 2 valores de 16bits
	mult $a0, $a1
	mflo $v0

	jr $ra


exec_divi:
	addi $t8, $zero, 32768
	ble $t8, $a0, invalid_op2   #a0 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a0, invalid_op2   #a0 menor que 16bits-
	addi $t8, $zero, 32768
	ble $t8, $a1, invalid_op2   #a1 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a1, invalid_op2   #a1 menor que 16bits-

	jal divi

	j print_result

divi: #divide 2 valores de 16bits
	div $a0, $a1
	mflo $v0

	jr $ra


exec_expo:
	add $v0, $a0, $zero
	addi $v0, $zero, 1
	addi $s0, $zero, 1
	bge $a1, $zero, invalid_op2   #a1 menor que zero
	jal expo_for

	j print_result

expo_for:
	ble $a1, $zero, expo

	mul $v0, $v0, $a0
	sub $a1, $a1, $s0

	j expo_for

expo:
	jr $ra


print_float:
	add.s $f12, $f30, $f1
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
	syscall
	
	j print_continue
	
invalid_op2:
	#tratamento de input inválidos
	la $a0, error2
	addi $v0, $zero, 4
	syscall
	
	j print_continue

invalid_op3:
	#tratamento de raiz negativa
	la $a0, error3
	addi $v0, $zero, 4
	syscall
	
	j print_continue
	
invalid_op4:
	#tratamento de altura ou massa negativa
	la $a0, error4
	addi $v0, $zero, 4
	syscall
	
	j print_continue
	
print_newline:
	la $a0, newline
	addi $v0, $zero, 4
	syscall
	
	jr $ra

quit:
	#fim do programa
	addi $v0, $zero, 10
	syscall
