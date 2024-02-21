.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0   # argumento board
	move $s1, $a1   # argumento row
	move $s2, $a2   # argumento column
	
  addi $s3, $s1, -1		# i = row - 1
  begin_for_i_it:
  addi $t0, $s1, 1		# salvando em $t0 o valor row + 1
  bgt  $s3, $t0, end_for_i_it   # fim da iteração se i > row + 1
 
  addi $s4, $s2, -1 		# j = column - 1
  begin_for_j_it:
  addi $t0, $s2, 1 		# salvando em $t0 o valor de column + 1
  bgt $s4, $t0, end_for_j_it 	# fim da iteração se j > column + 1
 
  sll $t0, $s3, 5 		# $t0 = i * 32
  sll $t1, $s4, 2 		# $t1 = j * 4
  add $t0, $t0, $t1 		# $t0 = $t0 + $t1
  add $s7, $t0, $s0 		# $s7 = $t0 + $s0 (quarda em $s7 o endereço board[i][j])
  li $t1, SIZE 			# $t1 = SIZE ( SIZE vale 8)
 
  bge $s3, $zero, check_i_size  # se i >= 0, vá para check_i_size
  j end_if  			# senão, vá para end_if
 
  check_i_size:			
  blt $s3, $t1, check_j		# se i < SIZE, vá para check_j
  j end_if			# senão, vá para end_if
 
  check_j:
  bge $s4, $zero, check_j_size  # se j >= 0, vá para check_j_size
  j end_if			# senão, vá para end_if
 
  check_j_size:
  blt $s4, $t1, check_board     # se j < SIZE, vá para check_board
  j end_if			# senão, vá para o end_if

  check_board:
  li $t2, -2		# carrega -2 em $t2
  lw $t3, 0($s7)	# carrega em $t3 o que tem em board[i][j]
  beq $t2, $t3, count_adjacent_bombs   # se $t3 = -2, vá para count_adjacent_bombs
  j end_if			       # senão, vá para end_if
 
  count_adjacent_bombs:
  move $a0, $s0			# carregando endereço board em $a0
  move $a1, $s3			# carregando i em $a1 
  move $a2, $s4			# carregando j em $a2
  jal countAdjacentBombs	# chamada da função countAdjacentBombs
  move $s5, $v0			# carregando retorno de countAdjacentBombs
  sw $s5, 0($s7)		# salvando valor de $s5 em board[i][j]
  bnez $s5, end_if		# se valor de $s5 != 0, vá para end_if
  move $a0, $s0			# carregando endereço de board em $a0
  move $a1, $s3			# carregando i em $a1
  move $a2, $s4			# carregando j em $a2
  jal revealNeighboringCells	# chamada da função revealNeighboringCells
 
  end_if:
  addi $s4, $s4, 1		# j++
  j begin_for_j_it
  
  end_for_j_it:
  addi $s3, $s3, 1		# i++
  j begin_for_i_it
  
  end_for_i_it:
  restore_context
  jr $ra			# retorno ao endereço de chamada de revealNeighboringCells
 
 
 
 
 
 
