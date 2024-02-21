.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
	save_context
	move $s0, $a0 # argumento board
	move $s1, $a1 # argumento row
	move $s2, $a2 # argumento column
	li $s3, 0     # count = 0
	
  addi $s4, $s1, -1   # i = row - 1
  begin_for_i_it:
  addi $t0, $s1, 1
  bgt $s4,$t0,end_for_i_it 

  addi $s5, $s2, -1   # j = column - 1
  begin_for_j_it:
  addi $t0, $s2, 1
  bgt $s5,$t0,end_for_j_it
  
  sll $t0, $s4, 5     # i*32 para saber quantas linhas foram iteradas(antes da linha atual)
  sll $t1, $s5, 2     # j*4 para saber quantas casas forma iteradas (na linha atual)
  add $t0, $t0, $t1   # soma para saber qual 'casa' da matriz está sendo analizada
  add $t0, $t0, $s0   # soma do número da casa atual mais o endereço do board
  
  li $t2, SIZE        # carregando valor de SIZE em $t2
  
  bge $s4, $zero, check_i_size   # se i >= 0, pula para check_i_size
  j end_if                       # senão, pula para o fim do if
  
  check_i_size:
  blt $s4, $t2, check_j          # se i < SIZE, pula para check_j
  j end_if                       # senão, pula para o fim do if
  
  check_j:
  bge $s5, $zero, check_j_size   # se j >= 0, pula para check_j_size
  j end_if 			 # senão, pula para o fim do if
  
  check_j_size:
  blt $s5, $t2, check_board      # se j < SIZE, pula para check_board
  j end_if 			 # senão, pula para o fim do if
  
  check_board:
  lw $t3, 0($t0) 		 # carregando o que tem no endereço board[i][j] para $t3
  li $t4, -1 			 # carregando -1 para $t4
  beq $t3, $t4, increment_count  # se $t3 = -1, pula para increment_count
  j end_if			 # senão, pula para o fim do if
  
  increment_count:
  addi $s3, $s3, 1   # incrementa o count (faz count += 1)
  
  end_if:
  addi $s5, $s5, 1   # incrementa o j
  j begin_for_j_it
   
  end_for_j_it:
  addi $s4, $s4, 1   # incrementa o i
  j begin_for_i_it
  
  end_for_i_it:
  move $v0, $s3	     # salva em $v0 o valor de $s3
  restore_context
  jr $ra	     # retorno para endereço de chamada de countAdjacentBombs
